module UserHelper
  def signup_validation_error
    error_messages = []

    @user.errors.messages.each do |e|
      error_messages << "#{e[0].to_s.capitalize.sub('_', ' ')} #{e[1][0]}." if e[1].present?
    end

    return error_messages
  end

  def user_country_flag_link(user, cur = nil, options = {})
    u, i = (cur == user) ? ['You', ''] : [user.to_s, user_country_image(user, options)]
    
    link_to "#{u}#{i}".html_safe, user_path(user)
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
  
  def answerable_user_info(answerer, vote, u)
    user_link_text = (answerer == u) ? 'You' : answerer.to_s 
    
    if vote.blank? || vote > 0 #no vote(it's a Q&A) or positive vote
      "#{user_small_avatar_link(answerer)} #{link_to user_link_text, user_path(answerer)}".html_safe
    else
      "#{link_to user_link_text, user_path(answerer)} #{user_small_avatar_link(answerer)}".html_safe
    end
  end
end
