Gem::Specification.new do |s|
  
  s.name     = "active_resource_associations"
  s.version  = "0.1.0"
  s.date     = "2008-11-20"
  
  s.summary  = "An extension to Rails' ActiveResource library that attempts to add an ActiveRecord-style associations DSL. (has_many, belongs_to etc...)"
  s.email    = "ryan@yfactorial.com"
  s.homepage = "http://github.com/yfactorial/active_resource_associations"
  s.description = "An extension to Rails' ActiveResource library that attempts to add an ActiveRecord-style associations DSL. (has_many, belongs_to etc...)"
  
  
  s.authors  = ["Ryan Daigle"]
  s.has_rdoc = true
  s.rdoc_options = ['--main', 'README.textile']
  s.rdoc_options << '--inline-source' << '--charset=UTF-8'
  s.extra_rdoc_files = ['README.textile', 'Rakefile', 'LICENSE', 'CHANGELOG']
  
  s.files = %w(README.textile Rakefile LICENSE CHANGELOG init.rb lib lib/roxy lib/roxy.rb lib/roxy/moxie.rb lib/roxy/proxy.rb spec spec/abstract_spec.rb spec/proxy_spec.rb spec/roxy_spec.rb spec/family_person_spec.rb spec/fixtures spec/fixtures/person.rb spec/fixtures/family_person.rb)
end
