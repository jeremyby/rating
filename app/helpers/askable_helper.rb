module AskableHelper
  def new_poll_validation_error
    error_messages = ''

    error_messages << 'Please select a country to ask the question. ' if @askable.errors[:country_code].present?
    error_messages << "The question #{@askable.errors[:body][0]}." if @askable.errors[:body].present?

    return error_messages
  end

  def askable_coverage_data(coverage, country)
    array = []

    (0..2).each do |c|
      item = [c, askable_coverage_info(c, country)]
      # item << 'selected' if c == coverage
      array << item
    end

    return array
  end

  def bip_body
    best_in_place_if @is_owner, @askable, :body,
      :type => :textarea,
      :ok_button => 'OK',
      :path => country_askable_path(@country, @askable),
      :classes => 'update_question_success',
      :data => { :country => @country.slug }
  end

  def bip_desc
    best_in_place @askable, :description,
      :type => :textarea,
      :ok_button => 'OK',
      :path => country_askable_path(@country, @askable),
      :nil => 'add description...',
      :classes => 'update_desc_success'
  end

  def bip_coverage
    best_in_place_if @is_owner, @askable, :coverage,
      :display_with => :askable_coverage_info,
      :helper_options => { :country => @country },
      :type => :select,
      :collection => askable_coverage_data(@askable.coverage, @country),
      :path => country_askable_path(@country, @askable)
  end
end
