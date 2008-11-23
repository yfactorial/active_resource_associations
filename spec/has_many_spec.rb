require File.join(File.dirname(__FILE__), *%w[abstract_spec])

describe "has_many" do
  
  describe "on an article" do

    before(:each) do
      
      uses_fixtures(:article, :comment)
      
      @article = Article.new(:id => 1)
      @comments = [ Comment.new({ :id => 1, :body => 'comment 1', :article_id => 1 }),
                    Comment.new({ :id => 2, :body => 'comment 2', :article_id => 1 }) ]
      
      ActiveResource::HttpMock.respond_to do |mock|
        mock.get    "/articles/1/comments.xml",                {}, @comments.to_xml
        mock.get    "/articles/1/comments/1.xml",              {}, @comments.first.to_xml
        mock.post   "/articles/1/comments.xml",                {}, Comment.new(:body => 'new comment').to_xml, 201, 'Location' => '/articles/1/comments/3.xml'
        mock.delete "/articles/1/comments/1.xml",    {}, nil, 200
        mock.delete "/articles/1/comments/2.xml",    {}, nil, 200
      end
    end
    
    it "should know how to query for all comments" do
      @article.comments.should == @comments
    end
    
    it "should know how to add a comment to the collection using the shift operator" do
      lambda { @article.comments << Comment.new(:body => 'new comment') }.should change { @article.comments.size }.by(1)
      c = @article.comments.last
      c.id.should == '3'
      c.body.should == 'new comment'
    end
    
    it "should know how to delete one or more objects from the collection" do
      lambda { @article.comments.delete(*@comments) }.should change {@article.comments.size}.from(2).to(0)
    end
    
    it "should know how to clear the child collection" do
      lambda { @article.comments.clear }.should change {@article.comments.size}.from(2).to(0)
    end
    
    it "should know if the child collection has any members" do
      @article.comments.should_not be_empty
      @article.comments.clear
      @article.comments.should be_empty
    end
    
    it "should know the child collection size" do
      @article.comments.size.should == 2
    end
    
    it "should be able to find child elements" do
      @article.comments.find(1).should == @comments.first
    end
    
    after :each do
      unuses_fixtures(:article, :comment)
    end
      
  end
end