module ApplicationHelper
  def parse_flash(flash)
    key = flash.keys[0]
    message = flash[:notice] || flash[:alert]
    
    messages = message.is_a?(Array) ? message : [message]
    
    return key, messages
  end
  
  def current_translations
    @translations ||= I18n.backend.send(:translations)
    @translations[I18n.locale].with_indifferent_access[:js]
  end
  
  def in_original_lang(obj)
    obj.auto_translated.nil?
  end
end

module ActionView
  class Base
    # Define universal helpers here
  end
end