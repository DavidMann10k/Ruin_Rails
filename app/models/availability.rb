class Availability < ActiveRecord::Base
  belongs_to :user
  
  validate_presence_of :user_id, :begin, :end, :un
  
  attr_accessible :begin, :end, :un
  
end
