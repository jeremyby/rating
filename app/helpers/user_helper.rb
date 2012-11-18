module UserHelper
  def signup_validation_error
    form_error = []
    msgs = @user.errors.messages
     
    msgs.each do |e|
      form_error << {e[0].to_s => "#{e[0].capitalize.to_s.sub('_', ' ')} #{e[1][0]}."} if e[1].present?
    end
    
    form_error.map {|f| "#{f.values.first}"}.join('<br/>')    
  end  
end