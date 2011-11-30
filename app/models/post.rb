class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id
  
  validates :topic_id, :numericality => { :only_integer => true },
                       :presence => true
  validates :content, :length => { :maximum => 1000 },
                      :presence => true
  validates :user_id, :numericality => { :only_integer => true },
                      :presence => true
  belongs_to :topic
  belongs_to :user
end
