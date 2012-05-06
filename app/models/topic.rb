class Topic < ActiveRecord::Base
  attr_accessible :title, :forum_id
  
  belongs_to :forum
  belongs_to :user
  has_many :posts, :dependent => :destroy

  validates :forum_id, :numericality => { :only_integer => true },
                       :presence => true
  
  validates :user_id, :numericality => { :only_integer => true },
                      :presence => true
  validates :title, :length => { :maximum => 50 },
                    :presence => true
  scope :by_updated, order("updated_at DESC")
end