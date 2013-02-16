module UserHelper
  def signup_validation_error
    form_error = []
    msgs = @user.errors.messages

    msgs.each do |e|
      form_error << {e[0].to_s => "#{e[0].capitalize.to_s.sub('_', ' ')} #{e[1][0]}."} if e[1].present?
    end

    form_error.map {|f| "#{f.values.first}"}.join('<br/>')
  end

  def user_country_flag_link(u, options = {})
    link_to "#{u}#{user_country_image(u, options)}".html_safe, user_path(u)
  end

  def user_country_image(u, options = {})
    image_tag "/assets/flags/#{u.country_code}.png", options
  end
  
  def user_avatar_link(u, options = {})
    link_to image_tag(u.avatar_url(:thumb)), user_path(u)
  end
  
  def user_small_avatar_link(u, options = {})
    link_to image_tag(u.avatar_url(:thumb), :size => '24x24'), user_path(u)
  end
  
  def ballot_user_info(u, vote, voter)
    user_link_text = (voter == u) ? 'You' : u.to_s 
    
    if vote > 0 #positive vote
      "#{user_small_avatar_link(u)} #{link_to user_link_text, user_path(u)}".html_safe
    else
      "#{link_to user_link_text, user_path(u)} #{user_small_avatar_link(u)}".html_safe
    end
  end
end
