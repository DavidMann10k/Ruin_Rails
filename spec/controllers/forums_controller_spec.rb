require 'spec_helper'

describe ForumsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    
    it "should redirect if creation success" do
      get 'create', :forum => {:title => "title"}, :division_id => 1
      response.should be_redirect
    end
  end

  before(:each) do
    @forum = FactoryGirl.create(:forum)
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', :id => @forum.id
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit', :id => @forum.id
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "should redirect" do
      get 'update', :id => @forum.id
      response.should be_redirect
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
