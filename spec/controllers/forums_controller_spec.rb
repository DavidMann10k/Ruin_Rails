require 'spec_helper'

describe ForumsController do

  before(:each) do
    @user = FactoryGirl.create :user
    @division = FactoryGirl.create :division
    @forum = FactoryGirl.create :forum, :division_id => @division.id
    @topic = FactoryGirl.create :topic, :forum_id => @forum.id, :user_id => @user.id
  end
  
  describe "GET 'new'" do
    it "returns http success" do
      get 'new', :division_id => @division.id
      response.should be_success
    end
    
    it "should have the right title"
  end

  describe "GET 'create'" do
    
    it "should redirect if creation success" do
      get 'create', :forum => {:title => "title"}, :division_id => 1
      response.should be_redirect
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, :id => @forum.id
      response.should be_success
    end
    
    it "should have the right title"
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', :id => @forum.id
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    
    before(:each) do
      get 'destroy', :id => @forum.id
    end
    
    it "returns http success" do
      response.should be_redirect
    end
    
    it "should refactor forum dex values"
    
  end

end
