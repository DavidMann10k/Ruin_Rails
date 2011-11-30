require 'spec_helper'

describe TopicsController do

  before(:each) do
    @user = FactoryGirl.create :user
    @division = FactoryGirl.create :division
    @forum = FactoryGirl.create :forum, :division_id => @division.id
    @topic = FactoryGirl.create :topic, :forum_id => @forum.id, :user_id => @user.id
  end
  
  describe "GET 'new'" do
    it "returns http success" do
      get :new, :forum_id => @forum.id
      response.should be_success
    end
    
    it "should have the right title"
  end


  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, :id => @topic.id
      response.should be_success
    end
    
    it "should have the right title"
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, :id => @topic.id
      response.should be_success
    end
    
    it "should have the right title"
  end

end
