module CountryHelper
  def country_m_flag_link(c, options = {})
    link_to "#{c}#{country_image(c, 'm', options)}".html_safe, country_path(c)
  end

  def country_flag_link(c, options = {})
    link_to "#{c}#{country_image(c, options)}".html_safe, country_path(c)
  end

  def country_image(c, size = '', options = {})
    size = "-#{ size }" unless size.blank?
    image_tag "/assets/flags/#{c.code}#{size}.png", options
  end
  
  def home_country_flag(c, not_available = false)
    title = not_available ? "Activate #{ c.to_s }" : "Ask #{ c.to_s }"
    
    "<a href='#{ country_path(c) }'>
      <div class='c #{ not_available ? "na" : "" }' title='#{title}'>#{ country_image c, 'o' }</div>
    </a>".html_safe
  end
  
  def sort_builder(active, sort, str)    
    if sort == active
      content_tag 'li', str, :class => "#{sort} active"
    else
      content_tag 'li', link_to(str, {:sort => sort}), :class => "#{sort} inactive"
    end
  end
end
