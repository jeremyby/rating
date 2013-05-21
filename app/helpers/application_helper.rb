module ApplicationHelper
  def parse_flash(flash)
    key = flash.keys[0]
    message = flash[:notice] || flash[:alert]
    
    messages = message.is_a?(Array) ? message : [message]
    
    return key, messages
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
    def askable_coverage_info(coverage, country)
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
