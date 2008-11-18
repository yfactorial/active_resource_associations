require 'rubygems'
require 'roxy'
require 'active_resource_associations/has_many'
  
if defined?(ActiveResource)

  ActiveResource::Base.class_eval do
    include Roxy::Moxie
    include ActiveResource::Associations::HasMany
  end
  
end