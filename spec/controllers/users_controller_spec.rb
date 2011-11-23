require 'spec_helper'

describe UsersController do
  render_views
  
 # user = FactoryGirl.create(:user)
=begin
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
      get 'show', :id => @user.id
      response.should be_success
    end
    it "edit" do
      get 'edit', :id => @user.id
      response.should be_success
    end
    
    describe "correct title for" do
      
      before(:each) do
        @base_title = "Ruin_Rails"
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
        get :show, :id => @user.id
        response.should have_selector("title", :content => "#{@base_title}/#{@user.name.downcase}") 
      end
    end
  end
  
  describe "show" do
    
    it "should have an edit button for current user" do
      session[:user_id] = @user.id
      get :show, id => @user.id
      response.should have_selector("a", :content => "Edit Details")
    end
=end
end
