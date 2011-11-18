require 'spec_helper'

describe Post do
  
  before(:each) do
    @post = Post.new
    @post.content = Faker::Lorem.paragraphs(3)
    @post.topic_id = 1
    @post.user_id = 1
  end
  
  it "should create a new instance with attributes" do
    @post.save!
  end
  
  describe "should require" do
    
    it "content" do
      @post.content = ""
      @post.should_not be_valid
    end
    
    it "user_id" do
      @post.user_id = ""
      @post.should_not be_valid
    end
    
    it "topic_id" do
      @post.topic_id = ""
      @post.should_not be_valid
    end
  end
  
  describe "content" do
    
    it "should be < maximum" do
      @post.content = ("A"*1001)
      @post.should_not be_valid
    end
  end
  
  describe "should reject non-integer values for" do
    
    it "topic_id" do
      @post.topic_id = "A"
      @post.should_not be_valid
    end
    
    it "user_id" do
      @post.user_id = "A"
      @post.should_not be_valid
    end
  end
end