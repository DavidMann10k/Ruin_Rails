module ApplicationHelper
  
  def logo
    "Ruin_Rails"
  end
  
  def title
    base_title = "Ruin_Rails"
    if @title.nil?
      base_title
    else
      "#{base_title}/#{@title}"
    end
  end
end
