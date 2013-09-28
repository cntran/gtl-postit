class Post < ActiveRecord::Base
  include Voteable
  include Sluggable

  alias_attribute :sluggable, :title
  BADWORDS = ['fuck', 'ass', 'shit']

  belongs_to :creator, foreign_key: "user_id", class_name: "User"

  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true
  validate :bad_words

  def bad_words
    title.split(' ').each do |word|
      if BADWORDS.include?(word)
        errors.add(:base, "Some bad words were detected.")
        break
      end
    end
  end

  def to_param
    self.slug
  end

end