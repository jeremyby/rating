module ApplicationHelper  
  def poll_category_image(poll)
    cat = Poll_Catogories[poll.category]
    image_tag "/assets/#{cat.code}.png", :alt => cat.name, :title => "The question is in the #{cat.name} category"
  end
  
  def poll_creator_image(poll)
    if poll.owner.country_code == poll.country_code
      image_tag "/assets/one.png", :alt => "Insider question", :title => "Question creator is from #{@country.name}"
    else
      image_tag "/assets/but.png", :alt => "Outside Question", :title => "Question creator is not from #{@country.name}"
    end
  end
  
  def poll_coverage_image(poll)
    case poll.coverage
    when 0 then return image_tag "/assets/all.png", :alt => "All countries", :title => "People from any country can answer this question."
    when 1 then return image_tag "/assets/one.png", :alt => "Only #{@country.name}", :title => "Only people from #{@country.name} can answer this question."
    when 2 then return image_tag "/assets/but.png", :alt => "All countries but #{@country.name}", :title => "Only people who are not from #{@country.name} can answer this question."
    end
  end
  
  def logo_string
    "Ask #{@country.present? ? @country.name : 'a Country'}"
  end
end
