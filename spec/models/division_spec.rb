require 'spec_helper'

describe Division do
  
  before(:each) do
    @division = FactoryGirl.build(:division)
  end
  
  it "should create an instance with the right attributes" do
    @division.save!
  end
  
  describe "should require a value for " do
    it "dex" do
      @division.dex = ""
      @division.should_not be_valid
    end
    
    it "title" do
      @division.title = ""
      @division.should_not be_valid
    end
  end
  
  describe "title" do
    
    it "should be shorter than the maximum" do
      @division.title = "A"*101
      @division.should_not be_valid
    end
  end
  
  it "should swap dex with another division" do
    division1 = @division
    division2 = @division
    division2.dex = 1
    division1.swap_dex_with(division2)
    division2.dex.should eq(1)
  end
end
