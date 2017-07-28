module ApplicationHelper

  def full_title(active_title="")
    base_title = "Ruby On Rails"

    if active_title.empty?
      base_title
    else
      active_title + " | " + base_title
    end 
  end
  
end
