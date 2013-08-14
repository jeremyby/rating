module AskableHelper
  def new_askable_validation_error
    error_messages = []
    
    if @askable.errors[:country_code].present?
      error_messages << 'Please select a country to ask the question. ' 
    else
      @askable.errors.messages.each do |e|
        if e[1].present?
          if (e[0] == 'yes' || e[0] == 'no')
            error_messages << "#{e[0].to_s.capitalize} #{e[1][0]}." 
          else
            error_messages << "Question #{e[0].to_s} #{e[1][0]}."
          end
        end
      end
    end

    return error_messages
  end
  
  def askable_coverage_info(coverage, country)
    img =  (t "askable.coverage")[coverage][:img]
    name = (t "askable.coverage")[coverage][:name]
    
    str = "<img src ='/assets/#{ img }' />#{ name }"
    
    title = (t "askable.coverage")[coverage][:title]

    return content_tag(:span, str.html_safe, :title => title)
  end
  
  def can_edit
    @is_owner && @askable.auto_translated.nil?
  end
  
  def can_improve
    current_user && @askable.auto_translated.present?
  end
end
