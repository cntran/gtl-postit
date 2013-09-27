module Voteable

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do 
      create_polymorphic_relationship
    end
  end

  module InstanceMethods

    def total_votes
      self.votes.where(vote: true).size - self.votes.where(vote: false).size
    end

  end

  module ClassMethods

    def create_polymorphic_relationship
      has_many :votes, as: :voteable
    end

  end

end
