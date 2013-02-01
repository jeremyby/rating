class SimpleRender < Redcarpet::Render::HTML
  def initialize(options={})
    super options.merge(
      :filter_html => true,
      :no_styles => true,
      :hard_wrap => true,
      :safe_links_only => true,
      :link_attributes => {:target => '_blank'}
    )
  end

  [
    # block-level calls
    :block_code, :block_quote,
    :block_html, :header,

    # span-level calls
    :codespan, :triple_emphasis,
    :strikethrough, :superscript,

    # low level rendering
    :entity, :normal_text
  ].each do |method|
    define_method method do |*args|
      args.first
    end
  end

  def list(contents, list_type)
    case list_type
    when :ordered
      "<ol>#{contents}</ol>"
    when :unordered
      "<ul>#{contents}</ul>"
    end
  end

  def list_item(text, list_type)
    "<li>#{text}</li>"
  end


  def emphasis(text)
    "<em>#{text}</em>"
  end

  def double_emphasis(text)
    "<strong>#{text}</strong>"
  end

  def image(link, title, alt_text)
    %{<img src="#{link}" title="#{title}" alt="alt_text"/>}
  end
  
  def link(link, title, content)
    %{<a href="link" title="title">#{content}</a>}
  end
  
  def hrule()
    nil
  end
end
