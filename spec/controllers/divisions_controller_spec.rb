require 'spec_helper'

describe DivisionsController do
  render_views

  before(:each) do
    @user = FactoryGirl.create :user
    @division = FactoryGirl.create :division
    @forum = FactoryGirl.create :forum, :division_id => @division.id
    @topic = FactoryGirl.create :topic, :forum_id => @forum.id, :user_id => @user.id
  end
  
  describe "GET 'index'" do
    
    before(:each) do
      get :index
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/Divisions")
    end
  end

  describe "GET 'new'" do
    
    before(:each) do
      get 'new'
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/Divisions/new")
    end
  end

  describe "GET 'show'" do
        
    before(:each) do
      get 'show', :id => @division.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/Divisions/#{@division.title}")
    end
    
    it "should list child forums"
  end

  describe "GET 'edit'" do
        
    before(:each) do
      get :edit, :id => @division.id          
    end
        
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/Divisions/#{@division.title}/edit")
    end
  end

  describe "GET 'update'" do
    
    it "should redirect" do
      get :update, :id => @division.id
      response.should be_redirect
    end
  end

  describe "GET 'destroy'" do
        
    it "should redirect" do
      get :destroy, :id => @division.id
      response.should be_redirect
    end
    
    it "should refactor division dex values"
  end

end
