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

  def poll_coverage_data(coverage, country)
    array = []

    (0..2).each do |c|
      item = [c, poll_coverage_info(c, country)]
      # item << 'selected' if c == coverage
      array << item
    end

    return array
  end

  def markdown(text)
    Redcarpet::Markdown.new(SimpleRender,
                            :autolink => true,
                            :lax_spacing => true,
                            :no_intra_emphasis => true
                            ).render(text).html_safe
  end
end


module ActionView
  class Base
    def poll_coverage_info(coverage, country)
      case coverage
      when 0
        str = "<img src ='/assets/all.png' class='w' />Open Question"
        title = "The Question is open for everyone to answer."
      when 1
        str = "<img src ='/assets/one.png' />Inside Question"
        title = "ONLY people from the country can answer the question."
      when 2
        str = "<img src ='/assets/but.png' class='w' />Outside Question"
        title = "Only people who are NOT from the country can answer the question."
      end

      return content_tag(:span, str.html_safe, :title => title)
    end
  end
end
