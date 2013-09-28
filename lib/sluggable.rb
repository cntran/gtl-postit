module Sluggable

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      attach_slug_method
    end
  end

  module InstanceMethods
    def generate_slug 
      self.slug = self.sluggable.gsub(' ', '-').downcase
    end
  end

  module ClassMethods

    def attach_slug_method
      after_validation :generate_slug
    end

  end

end