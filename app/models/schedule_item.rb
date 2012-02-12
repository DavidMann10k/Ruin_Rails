class ScheduleItem < ActiveRecord::Base
  
  belongs_to :user
  
  duration_regex = /^\d+$/
  
  validates :day, :presence => true,
                  :inclusion => { :in => -1..6 }
  
  validates :start_hour, :presence => true,
                         :inclusion => { :in => -1..23 }
  
  
  validates :duration, :presence => true,
                       :inclusion => { :in => -1..23 },
                       :format   => { :with => duration_regex, :message => "Integer values only" }
end