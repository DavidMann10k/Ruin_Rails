class Forum < ActiveRecord::Base
  attr_accessible :title, :dex, :division_id
  
  belongs_to :division
  has_many :topics, :dependent => :destroy
    
  validates :dex, :presence => true, :numericality => { :only_integer => true }
  validates :division_id, :presence => true, :numericality => { :only_integer => true }
  validates :title, :length => { :maximum => 100 },
                    :presence => true
                    
  def swap_dex_with(forum)
    forum.dex, self.dex = self.dex, forum.dex
    forum.save
    self.save
  end
end
