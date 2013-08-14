class TranslationJob < Struct.new(:translatable, :from, :to, :is_update)
  def perform
    I18n.with_locale(from) do
      translatable.translate(from, to, is_update)
    end
  end
end