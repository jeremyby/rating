module ApplicationHelper
  def parse_flash(flash)
    key = flash.keys[0]
    message = flash[:notice] || flash[:alert]
    
    messages = message.is_a?(Array) ? message : [message]
    
    return key, messages
  end
  
  def current_translations
    @translations ||= I18n.backend.send(:translations)
    @translations[I18n.locale].with_indifferent_access[:js]
  end
end

module ActionView
  class Base
    def askable_coverage_info(coverage, country)
      img =  (t "askable.coverage")[coverage][:img]
      name = (t "askable.coverage")[coverage][:name]
      
      str = "<img src ='/assets/#{ img }' />#{ name }"
      
      title = (t "askable.coverage")[coverage][:title]

      return content_tag(:span, str.html_safe, :title => title)
    end
  end
end