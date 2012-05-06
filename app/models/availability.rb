class Availability < ActiveRecord::Base
  belongs_to :user
  
  attr_accessible :begin, :end, :un
  
  validates_presence_of :user_id, :begin, :end
  
  scope :by_begin, order("begin ASC")
  scope :for_user, lambda { |user| where('user_id = ?', user.id)}
  
end
