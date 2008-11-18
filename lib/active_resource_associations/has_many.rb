module ActiveResource
  module Associations
    
    module HasMany
      
      def self.included(within)
        within.class_eval { extend ClassMethods }
      end
      
      module ClassMethods
        
        def has_many(name)
          target_class = name.to_s.singularize.capitalize.constantize
          foreign_key = "#{self.to_s.downcase}_id".intern
          proxy name, :to => lambda {|owner| target_class.find(:all, :params => { foreign_key => owner.id }) } do
          end
        end
      end
    end

  end
end