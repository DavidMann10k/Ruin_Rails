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
  scope :in_topic, lambda { |post| where("topic_id = ?", @topic.id) }
  
  def edited?
    !created_at == updated_at
  end
  
  def show(post)
    redirect_to topic_path(post.topic_id, :page => Post.in_topic(post).num_pages)
  end
end
