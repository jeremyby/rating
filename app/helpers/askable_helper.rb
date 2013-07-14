module AskableHelper
  def new_askable_validation_error
    error_messages = []
    
    if @askable.errors[:country_code].present?
      error_messages << 'Please select a country to ask the question. ' 
    else
      @askable.errors.messages.each do |e|
        if e[1].present?
          if (e[0] == 'yes' || e[0] == 'no')
            error_messages << "#{e[0].to_s.capitalize} #{e[1][0]}." 
          else
            error_messages << "Question #{e[0].to_s} #{e[1][0]}."
          end
        end
      end
    end

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
