module ApplicationHelper
  include ActionView::Helpers::DateHelper
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
  
  def new_content?(datetime)
    datetime > current_user.last_login
  end
end
