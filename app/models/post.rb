class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id
  
  validates :topic_id, :numericality => { :only_integer => true },
                       :presence => true
  validates :content, :presence => true
  validates :user_id, :numericality => { :only_integer => true },
                      :presence => true
  belongs_to :topic
  belongs_to :user
  
  scope :publish, where(:publish => true)
  
  def edited?
    !created_at == updated_at
  end
end
