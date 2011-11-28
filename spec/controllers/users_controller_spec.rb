require 'spec_helper'

describe UsersController do
  render_views

  before(:each) do
    @user = FactoryGirl.build(:user)
  end
  
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
      @user.save!
      get 'show', :id => @user.id
      response.should be_success
      @user.destroy
    end
    it "edit" do
      @user.save!
      get 'edit', :id => @user.id
      response.should be_success
      @user.destroy
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
        @user.save!
        get :show, :id => @user.id
        response.should have_selector("title", :content => "#{@base_title}/#{@user.name}")
        @user.destroy
      end
    end
  end
  
  describe "show" do
    
    it "should have an edit button for current user" do
      @user.save!
      session[:user_id] = @user.id
      get :show, :id => @user.id
      response.should have_selector("a", :content => "Edit Details")
      @user.destroy
    end
    
    it "should not have an edit button for non-signed in user" do
      @user.save!
      get :show, :id => @user.id
      response.should_not have_selector("a", :content => "Edit Details")
      @user.destroy
    end
  end
end
