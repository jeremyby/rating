class TranslationJob < Struct.new(:askable, :from, :to)
  def perform
    I18n.with_locale(from) do
      askable.translate(from, to)
    end
  end
end