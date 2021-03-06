require 'spec_helper'

describe PagesController do
  render_views

  describe "should find" do
    
    it "route for root" do
      get "root"
      response.should be_success
    end
    
    it "route: about" do
      get "about"
      response.should be_success
    end
    
    it "route: about_ruin_rails" do
      get "about_ruin_rails"
      response.should be_success
    end
    
    describe "correct title for" do
      
      it "root" do
        get "root"
        response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/")
      end
        
      it "about" do
        get "about"
        response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/about")
      end
        
      it "about_ruin_rails" do
        get "about_ruin_rails"
        response.should have_selector("title", :content => "#{RR::Application::GLOBAL_TITLE}/about_ruin_rails")
      end
    end
    describe "correct h1 for" do
              
      it "root" do
        get "root"
        response.should have_selector("h1", :content => "/")
      end
        
      it "about" do
        get "about"
        response.should have_selector("h1", :content => "/about")
      end
        
      it "about_ruin_rails" do
        get "about_ruin_rails"
        response.should have_selector("h1", :content => "/about_ruin_rails")
      end
    end
  end
  
  
end