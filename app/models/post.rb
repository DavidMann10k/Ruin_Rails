class Post < ActiveRecord::Base
  attr_accessible :content, :topic_id
  
  validates :topic_id, :numericality => { :only_integer => true },
                       :presence => true
  validates :content, :presence => true
  validates :user_id, :numericality => { :only_integer => true },
                      :presence => true
  belongs_to :topic
  belongs_to :user
  
  scope :published, where(:publish => true)
  scope :published_or_belongs_to, lambda { |user| where('publish = true OR user_id = ?', user.id) }
  scope :in_topic, lambda { |topic| where("topic_id = ?", topic.id) }
  scope :by_created, order('created_at ASC')
  scope :by_updated, order('updated_at DESC')
  scope :ordered, order('created_at ASC, updated_at DESC')
  
  def edited?
    !created_at == updated_at
  end
  
  def show(post)
    redirect_to topic_path(post.topic_id, :page => Post.in_topic(post).num_pages)
  end
end
