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
  
end
