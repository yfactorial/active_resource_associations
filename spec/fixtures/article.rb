class Article < ActiveResource::Base
  
  self.site = 'http://test.host/'
  has_many :comments
end