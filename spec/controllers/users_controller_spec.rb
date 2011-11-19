require 'spec_helper'

describe UsersController do
  render_views

  describe "should find" do
    it "new" do
      get 'new'
      response.should be_success
    end
    it "index" do
      get 'index'
      response.should be_success
    end
    it "show" do
      user = FactoryGirl.build(:user)
      get 'index', :id => 1
      response.should be_success
    end
    
    describe "correct title for" do
      
      before(:each) do
        @base_title = "ruin_rails"
      end
      
      it "new" do
        get :new
        response.should have_selector("title", :content => "#{@base_title}/register") 
      end
      
      it "index" do
        get :index
        response.should have_selector("title", :content => "#{@base_title}/users") 
      end
      
      it "show" do
        user = FactoryGirl.create(:user)
        get :show, :id => 1
        response.should have_selector("title", :content => "#{@base_title}/#{user.name.downcase}") 
      end
    end
  end 
end
