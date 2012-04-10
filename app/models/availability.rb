class Availability < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :begin, :end, :un
  
  validate_presence_of :user_id, :begin, :end, :un
end
