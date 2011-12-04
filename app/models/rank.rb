class Rank < ActiveRecord::Base
  
  attr_protected :title, :clearance
  
  has_many :users
  
end
