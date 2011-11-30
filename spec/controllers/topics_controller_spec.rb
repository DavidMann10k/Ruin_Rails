require 'spec_helper'

describe TopicsController do
  render_views

  before(:each) do
    @user = FactoryGirl.create :user
    @division = FactoryGirl.create :division
    @forum = FactoryGirl.create :forum, :division_id => @division.id
    @topic = FactoryGirl.create :topic, :forum_id => @forum.id, :user_id => @user.id
  end
  
  describe "GET 'new'" do
    
    before(:each) do
      get :new, :forum_id => @forum.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@division.title}/#{@forum.title}/Topics/new")
    end
  end


  describe "GET 'edit'" do
    
    before(:each) do
      get :edit, :id => @topic.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@division.title}/#{@forum.title}/#{@topic.title}/edit")
    end
  end

  describe "GET 'show'" do
    
    before(:each) do
      get :show, :id => @topic.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@division.title}/#{@forum.title}/#{@topic.title}")
    end
  end

end
