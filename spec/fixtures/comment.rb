class Comment < ActiveResource::Base
  self.site = 'http://test.host/articles/:article_id'
end