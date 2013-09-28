class User < ActiveRecord::Base
  include Sluggable

  alias_attribute :sluggable, :username
  has_many :posts
  has_many :comments

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def admin?
    role == 'admin'
  end

  def to_param
    self.slug
  end

end