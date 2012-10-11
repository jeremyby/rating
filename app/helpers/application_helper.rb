module ApplicationHelper
  def poll_category_image(poll)
    name = Poll_Cats[poll.category]
    image_tag "/assets/#{poll.category}.png", :alt => name, :title => "The question is in the #{name} category"
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
  
  def words_truncate(str, wordcount) 
    str.split[0..(wordcount-1)].join(" ") + (str.split.size > wordcount ? "..." : "") 
  end
end
