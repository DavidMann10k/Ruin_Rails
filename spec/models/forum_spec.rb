require 'spec_helper'

describe Forum do
  
  before(:each) do
    @forum = Forum.new
    @forum.title = "Sample Title"
    @forum.dex = 1
    @forum.division_id = 1
  end
  
  it "should create a new instance with attributes" do
    @forum.save!
  end
  
  describe "should require" do
    
    it "title" do
      @forum.title = ""
      @forum.should_not be_valid
    end
    
    it "dex" do
      @forum.dex = ""
      @forum.should_not be_valid
    end
    
    it "division_id" do
      @forum.division_id = ""
      @forum.should_not be_valid
    end
  end
  
  describe "should reject non-integer values for" do
    
    it "dex" do
      @forum.dex = "A"
      @forum.should_not be_valid
    end
    
    it "division_id" do
      @forum.division_id = "A"
      @forum.should_not be_valid
    end
  end
  
  it "title length should be < maximum" do
    @forum.title = "A"*101
    @forum.should_not be_valid
  end
  
  it "should swap dex with another division" do
    forum1 = @forum
    forum2 = @forum
    forum2.dex = 1
    forum1.swap_dex_with(forum2)
    forum2.dex.should eq(1)
  end
end
