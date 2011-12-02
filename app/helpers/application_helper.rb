module ApplicationHelper
  
  def logo
    RR::Application::GLOBAL_TITLE
  end
  
  def title
    if @title.nil?
      RR::Application::GLOBAL_TITLE
    else
      "#{RR::Application::GLOBAL_TITLE}/#{@title}"
    end
  end
  
  def current_user?(user)
    user == current_user
  end
end
