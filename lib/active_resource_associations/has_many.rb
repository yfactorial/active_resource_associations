module ActiveResource
  module Associations
    
    module HasMany
      
      def self.included(within)
        within.class_eval { extend ClassMethods }
      end
      
      module ClassMethods
        
        def has_many(name)

          foreign_key = "#{self.to_s.downcase}_id".intern
          proxy name, :to => lambda { |owner|
            target_class = name.to_s.singularize.capitalize.constantize
            @target ||= target_class.find(:all, :params => { foreign_key => owner.id })
          } do
            
            # TODO: Need access to proxy name to determine child class to invoke find on
            def find(*arguments)
              scope   = arguments.slice!(0)
              options = arguments.slice!(0) || {}
              
              options[:params] ? options[:params].merge({foreign_key => proxy_owner.id}) :
                                 options[:params] = {foreign_key => proxy_owner.id}
            end
            
            def << (child)
              # Set foreign key to parent before saving
              child.prefix_options[foreign_key] = proxy_owner.id
              proxy_target << child
              child.save              
            end
            
            def delete(*children)
              children.flatten.each do |child|
                proxy_target.delete(child)
                child.destroy
              end
            end
            
            def clear
              delete(proxy_target)
            end
            
            def foreign_key
              @foreign_key ||= "#{proxy_owner.class.to_s.downcase}_id".intern
            end
          end
        end
      end
    end

  end
end