module CountryHelper
  def country_m_flag_link(c, options = {})
    link_to "#{c}#{country_m_image(c, options)}".html_safe, country_path(c)
  end

  def country_flag_link(c, options = {})
    link_to "#{c}#{country_image(c, options)}".html_safe, country_path(c)
  end

  def country_o_image(c, options = {})
    image_tag "/assets/flags/#{c.code}-o.png", options
  end

  def country_m_image(c, options = {})
    image_tag "/assets/flags/#{c.code}-m.png", options
  end

  def country_image(c, options = {})
    image_tag "/assets/flags/#{c.code}.png", options
  end
end
