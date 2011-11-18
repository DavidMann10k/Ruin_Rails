require 'spec_helper'

describe Topic do
  
  before(:each) do
            @topic = Topic.new
            @topic.title = Faker::Company.bs
            @topic.user_id = 1
            @topic.forum_id = 1
            
  end

  it "should create a new instance given valid attributes" do
    @topic.save!
  end
  
  describe "should require" do
    
    it "a title" do
      @topic.title = ""
      @topic.should_not be_valid
    end
    
    it "a user_id" do
      @topic.user_id = ""
      @topic.should_not be_valid
    end
    
    it "a forum_id" do
      @topic.forum_id = ""
      @topic.should_not be_valid
    end
  end
  
  describe "title" do
    
    it "shouldn't exceed maximum length" do
      @topic.title = "A"*101
      @topic.should_not be_valid    
    end    
  end
  
  describe "forum_id" do
    
    it "should be a number" do
      @topic.forum_id = "A"
      @topic.should_not be_valid      
    end
  end
  
  describe "user_id" do
    
    it "should be a number" do
      @topic.user_id = "A"
      @topic.should_not be_valid      
    end
  end
end
