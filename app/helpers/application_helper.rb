module ApplicationHelper
  
  def logo
    "Ruin_Rails"
  end
  
  def title
    if @title.nil?
      base_title
    else
      "#{base_title}/#{@title}"
    end
  end
  
  def base_title
    "Ruin_Rails"
  end
end
