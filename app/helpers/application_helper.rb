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
  
  def translate_time(time)
    if (time >= 12)
      "#{time - 12} pm"
    else
      if (time == 0)
        "12 am"
      else
        "#{time} am"
      end
    end
  end
  
end
