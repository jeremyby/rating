module AutoTranslation
  def acts_as_translateable
    after_create :translate_on_create, unless: 'self.body.blank?'

    include InstanceMethods
  end
  
  module InstanceMethods
    def translate_on_create
      orig = I18n.locale
      
      I18n.available_locales.each do |l|
        Delayed::Job.enqueue TranslationJob.new(self, orig, l) unless l == orig
      end
    end

    def translate_on_update
      orig = self.translations.first.locale
      
      I18n.available_locales.each do |l|
        unless l == orig        
          t = self.translation_for(l)
          
          if t.body.blank? || t.auto_translated.to_i > 0
            Delayed::Job.enqueue TranslationJob.new(self, orig, l, true)
          end
        end
      end
    end
    
    def add_locale_to_event(locale)
      # when translating a poll, add the new locale to its event log
      # so that we can show it for users of that locale
      e = self.events.first
      e.update_attributes!({:locales => "#{ e.locales } #{ locale }"})
    end
    
    def available_langs
      locales = self.translations.collect {|t| t.locale}
      return locales.shift, locales
    end
  end
end

ActiveRecord::Base.extend AutoTranslation
