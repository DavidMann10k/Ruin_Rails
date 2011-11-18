class Division < ActiveRecord::Base
  attr_accessible :title, :dex
  
  has_many :forums, :dependent => :destroy
    
  validates :dex, :presence => true
  validates :title, :presence => true,
                    :length => { :maximum => 100 }
  
  def swap_dex_with(div)
    div.dex, self.dex = self.dex, div.dex
    div.save
    self.save
  end
end
