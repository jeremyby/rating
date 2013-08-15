module AutoTranslation
  def acts_as_translateable
    after_create :translate_on_create, unless: 'self.body.blank?'
    
    # # only translate the original object that has a body
    # after_update :translate_on_update, if: Proc.new { |a| a.auto_translated.nil? && a.body.present? }

    include InstanceMethods
  end
  
  module InstanceMethods
    def translate_on_create
      country = self.country

      # default language is English, therefore:
      # => if the country has not language setting, it speaks English,
      # => so when being asked in another language, the translation target is also English
      if country.language.blank?
        country.language = target = 'en'
      else
        target = country.language.split(' ').first
      end

      if country.language.include?(I18n.locale.to_s)
        # when anwsering a translated question, if the language is not same as the one 
        # the original question's language, the answer will be translated
        if self.is_a?(Answerable)
          target = self.askable.translations.first.locale.to_s
          
          Delayed::Job.enqueue TranslationJob.new(self, I18n.locale.to_s, target) unless I18n.locale.to_s == target
        end
        
      # if the asked country does not speak the language being used in the new askable,
      # and assuming asking language is the same as the current locale
      # then send the new askable to translation queue
      else
        Delayed::Job.enqueue TranslationJob.new(self, I18n.locale.to_s, target)
      end
    end

    def translate_on_update
      event = self.events.first

      # get the locales from the create event( alwasy the first event)
      locales = event.locales.split(' ')

      # get the original locale( always the first as well)
      # and locales translated to
      source = locales.shift
      targets = locales

      unless targets.blank?
        targets.each do |t|
          flag = self.translation_for(t).auto_translated
          
          # transalte the updated askable if the translation is auto-translated (original one has it nil and user-translated has it ==0)
          Delayed::Job.enqueue TranslationJob.new(self, source, t, true) if flag.present? && flag.to_i > 0
        end
      end
    end
    
    def add_locale_to_event(locale)
      # when translating a poll, add the new locale to its event log
      # so that we can show it for users of that locale
      e = self.events.first
      e.update_attributes!({:locales => "#{ e.locales } #{ locale }"})
    end
  end
end

ActiveRecord::Base.extend AutoTranslation
