require 'spec_helper'

describe DivisionsController do
  render_views

  describe "GET 'index'" do
    
    before(:each) do
      get 'index'
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
      @division = FactoryGirl.create(:division)
    end
    
    before(:each) do
      get 'show', :id => @division.id
    end
    
    it "returns http success" do
      response.should be_success
    end
    
    it "should have the right title" do
      response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/#{@division.title}")
    end
    
    it "should list child forums"
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @div = FactoryGirl.create(:division)
      get :edit, :id => @div.id
    end
    
    it "returns http success" do
      response.should be_success
    end
  end

  describe "GET 'update'" do
    
    before(:each) do
      @div = FactoryGirl.create(:division)
      get :update, :id => @div.id
    end
    
    it "should redirect" do
      response.should be_redirect
    end
  end

  describe "GET 'destroy'" do
    
    before(:each) do
      @div = FactoryGirl.create(:division)
      get :destroy, :id => @div
    end
    
    it "should redirect" do
      response.should be_redirect
    end
    
    it "should refactor division dex values"
  end

end
