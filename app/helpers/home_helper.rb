module HomeHelper
  def search_list_item(c)
    "'#{c.code}': { 'code': '#{c.code}', 'name': \"#{c.to_s}\", 'lookup': \"#{c.lookup_string}\", 'slug': '#{c.slug}'}".html_safe
  end
end