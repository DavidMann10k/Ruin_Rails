require 'spec_helper'

describe PostsController do
  render_views
  
  before(:each) do
    @user = FactoryGirl.create :user
    @division = FactoryGirl.create :division
    @forum = FactoryGirl.create :forum, :division_id => @division.id
    @topic = FactoryGirl.create :topic, :forum_id => @forum.id, :user_id => @user.id
    @post = FactoryGirl.create :post, :topic_id => @topic.id, :user_id => @user.id
  end
  
  describe "GET 'new'" do
    
    before(:each) do
      get :new, :id => @division.id, :topic_id => @topic.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@division.title}/#{@forum.title}/#{@topic.title}/Posts/new")
    end
  end

  describe "GET 'edit'" do
    
    before(:each) do
      get :edit, :id => @post.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@division.title}/#{@forum.title}/#{@topic.title}/Post:#{@post.created_at}/edit")
    end
  end

end
