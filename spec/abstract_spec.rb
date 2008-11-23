require File.join(File.dirname(__FILE__), *%w[spec_helper])
require 'activeresource'
require 'active_resource/http_mock'

$:.unshift "#{File.dirname(__FILE__)}/../lib"
require 'active_resource_associations'

# Load a test class
def uses_fixtures(*fixture_names)
  fixture_names.flatten.each do |fixture_name|
    load File.join(File.dirname(__FILE__), 'fixtures', "#{fixture_name.to_s}.rb")
  end
end

def unuses_fixtures(*fixture_names)
  fixture_names.flatten.each do |fixture_name|
    Object.send(:remove_const, fixture_name.to_s.capitalize.intern)
  end
end