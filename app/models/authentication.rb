class Authentication < ActiveRecord::Base
  belongs_to :user

  attr_accessible :provider, :uid, :uname, :uemail
  
  validates :uid,       :presence => true
  validates :provider,  :presence => true
  validates :user_id,   :presence => true,
                        :numericality => { :only_integer => true }
end