class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :topics, :posts, :availabilities
  
  belongs_to :rank
  
  attr_accessible :name, :email, :timezone
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  user_regex = /^\w+$/
  
  validates :name, :presence => true,
                   :format   => { :with => user_regex, :message => "Only letters, numbers and underscores allowed." },
                   :length   => { :maximum => 50 }
           
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

  def fake_name
    Faker::Name.name
  end
end