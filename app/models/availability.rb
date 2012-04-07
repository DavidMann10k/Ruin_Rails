class Availability < ActiveRecord::Base
  
  belongs_to :user
  
  duration_regex = /^\d+$/
  
  validates_presence_of :day, :begin, :end
  
  validates :day, :inclusion => { :in => -1..6 }
  
end
