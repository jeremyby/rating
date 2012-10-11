ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  errors = html_tag.include?("<label") ? "" : "<span class='validation-error-explaination'>&nbsp;#{Array(instance.error_message).map{|e| e.downcase}.join(', and ')}</span>"
  
  %(<span class="validation-error">#{html_tag}#{errors}</span>).html_safe
end