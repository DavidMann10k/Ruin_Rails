module PostsHelper
  
  def publish_post(p)
    return true if p.publish
    return true if admin?
    return true if p.user == current_user
    return false
  end
end