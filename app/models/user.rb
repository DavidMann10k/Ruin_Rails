class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :topics
  has_many :posts
  has_many :availabilities, :dependent => :destroy
  
  belongs_to :rank
  
  attr_accessible :name, :email, :time_zone
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  user_regex = /^\w+$/
  
  validates :name, :presence => true,
                   :format   => { :with => user_regex, :message => "Only letters, numbers and underscores allowed." },
                   :length   => { :maximum => 50 }
           
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
                    
  validates :time_zone, :presence   => true

  def fake_name
    Faker::Name.name
  end
end