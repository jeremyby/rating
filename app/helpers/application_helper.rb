module ApplicationHelper
  def poll_category_image(poll)
    name = Poll_Cats[poll.category]
    image_tag "/assets/#{poll.category}.png", :alt => name, :title => "The question is in the #{name} category"
  end

  # remove this
  def poll_creator_image(poll)
    if poll.owner.country_code == poll.country_code
      image_tag "/assets/one.png", :alt => "Insider question", :title => "Question creator is from #{@country.name}"
    else
      image_tag "/assets/but.png", :alt => "Outside Question", :title => "Question creator is not from #{@country.name}"
    end
  end

  def poll_coverage_info(poll, country)
    case poll.coverage
    when 0
      str = "<img src ='/assets/all.png' class='w' />Open Question"
      title = "The Question is open for everyone to answer."
    when 1
      str = "<img src ='/assets/one.png' />Inside Question"
      title = "ONLY people from #{country} can answer the question."
    when 2
      str = "<img src ='/assets/but.png' class='w' />Outside Question"
      title = "Only people who are NOT from #{country} can answer the question."
    end

    return content_tag(:span, str.html_safe, :title => title.html_safe)
  end

  def words_truncate(str, wordcount)
    str.split[0..(wordcount-1)].join(" ") + (str.split.size > wordcount ? "..." : "")
  end

  def markdown(text)
    Redcarpet::Markdown.new(SimpleRender,
                                       :autolink => true,
                                       :lax_spacing => true,
                                       :no_intra_emphasis => true
                                       ).render(text).html_safe
  end
end
