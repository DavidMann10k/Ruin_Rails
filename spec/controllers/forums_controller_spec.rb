require 'spec_helper'

describe ForumsController do
  render_views

  before(:each) do
    @user = FactoryGirl.create :user
    @division = FactoryGirl.create :division
    @forum = FactoryGirl.create :forum, :division_id => @division.id
    @topic = FactoryGirl.create :topic, :forum_id => @forum.id, :user_id => @user.id
  end
  
  describe "GET 'new'" do
    
    before(:each) do
      get 'new', :division_id => @division.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@forum.division.title}/Forums/new")
    end
  end

  describe "GET 'create'" do
    
    it "should redirect if creation success" do
      get 'create', :forum => {:title => "title"}, :division_id => 1
      response.should be_redirect
    end
  end

  describe "GET 'show'" do
    
    before(:each) do
      get :show, :id => @forum.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@forum.division.title}/#{@forum.title}")
    end
  end

  describe "GET 'edit'" do
    
    before(:each) do
      get 'edit', :id => @forum.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@forum.division.title}/#{@forum.title}/edit")
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
