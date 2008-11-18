require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "has_many" do
  
  describe "on an article" do

    before(:each) do
      
      uses_fixtures(:comment, :article)
      
      @comments = [{ :id => 1, :body => 'comment 1' }, { :id => 2, :body => 'comment 2' }].to_xml(:root => 'comments')
      
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get    "/articles/1/comments.xml",                {}, @comments
      end
    end
    
    it "should know how to query for all coments" do
      Article.new(:id => 1).comments.to_xml.should == @comments
    end
  end
end