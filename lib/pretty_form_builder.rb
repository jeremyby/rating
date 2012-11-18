class PrettyFormBuilder < ActionView::Helpers::FormBuilder  
  def label_check_box(field, label_text, options = {})
    checkbox = check_box(field, options) + label(field, label_text)
    @template.content_tag(:div, checkbox, :class => "wrapper")
  end
  
  def label_text_field(field, label_text, options = {})
    textfield = label(field, label_text) + text_field(field, options)
    @template.content_tag(:div, textfield, :class => "wrapper")
  end

  def label_password_field(field, label_text, options = {})
    password_field = label(field, label_text) + password_field(field, options)
    @template.content_tag(:div, password_field, :class => "wrapper")
  end
end