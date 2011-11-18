module ApplicationHelper
  
  def logo
    "ruin_rails"
  end
  
  def signed_in?
    #TEMPORARY
  end
  
  def title
    base_title = "ruin_rails"
    if @title.nil?
      base_title
    else
      "#{base_title}/#{@title}"
    end
  end
end
