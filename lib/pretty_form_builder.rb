class PrettyFormBuilder < ActionView::Helpers::FormBuilder  
  def check_box(field, label_text, options = {})
    checkbox = super(field, options) + label(field, label_text)
    @template.content_tag(:div, checkbox, :class => "wrapper")
  end
  
  def label_text_field(field, label_text, options = {})
    textfield = label(field, label_text) + text_field(field, options)
    @template.content_tag(:div, textfield, :class => "wrapper")
  end

  def password_field(field, label_text, options = {})
    password_field = label(field, label_text) + super(field, options)
    @template.content_tag(:div, password_field, :class => "wrapper")
  end
end