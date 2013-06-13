$(document).on('click', '#nask .types .inactive .block', ->
  active = $('#nask .types .active').removeClass('active')
  inactive = $('#nask .types .inactive').removeClass('inactive')
  active.addClass('inactive')
  inactive.addClass('active')

  $('#nask .askable .yesno').toggle()

  aac.reset_field($('#nask .yesno input'))
)

check_body = ->
  f = $('#nask #askable_body')
  
  if f.val().length < 10 || f.val().length > 300
    aac.mark_error(f, 'Question should be between 10-300 charactors long.', 'below')
    return false
  else if f.val().indexOf('?') < 0
    aac.mark_error(f, 'Question should have at least one question mark.', 'below')
    return false
  else
    aac.reset_field(f)
    return true
    
check_yes_no = ->
  f_yes = $('#nask #askable_yes')
  f_no = $('#nask #askable_no')
  
  result = true
  
  msg = 'A vaild answer should have 1-80 charactors.'
  
  if f_yes.val().length < 1 || f_yes.val().length > 80
    aac.mark_error(f_yes, msg, 'below')
    result = false
  
  if f_no.val().length < 1 || f_no.val().length > 80
    aac.mark_error(f_no, msg, 'below')
    result = false
  
  if result
    aac.reset_field(f_yes)
    aac.reset_field(f_no)
    
  return result
    
check_desc = ->
  $('#nask #askable_description').val('') if $('#nask #askable_description').val() is I18n.new_askable_desc_default
  
check_type = ->
  $('#nask #askable_type').val($('#nask .types .active').attr('id'))


set_desc = ->
  e = $('#nask #askable_description')
  
  e.val(I18n.new_askable_desc_default).autosize()
  
  e.click ->
    $('#nask .desc').removeClass('vague')

    if e.val() == I18n.new_askable_desc_default
      e.select_range(0, 0)
      
  e.keydown ->
    if e.val() == I18n.new_askable_desc_default
      e.removeClass('vague').val('')
  
  e.focusout ->
    unless e.val() && e.val().length && e.val() isnt I18n.new_askable_desc_default
    
      $('#nask .desc').addClass('vague')
      
      unless e.val() is I18n.new_askable_desc_default
        e.addClass('vague')
        $(this).val(I18n.new_askable_desc_default)
    
  
$(document).ready ->
  # aac.load_search('#nask #search', 'a country',
  #   (event, ui) ->
  #     this.value = ui.item.name
  #     $('#askable_country_code').attr("value", ui.item.code)
  #     
  #     this.className = 'dark'
  #     $('#askable_body').focus()
  #     return false
  # )
  
  $('#nask #askable_body').focus ->
    aac.reset_field($(this))

  $('#nask .yesno input').focus ->
    aac.reset_field($(this))
  
  $('#nask #askable_body').autosize()
  
  set_desc()
  
  $('#nask .askable .submit input').click (e) ->
    check_type()

    a = check_body()
    b = if $('#nask #askable_type').val() is 'Poll' then check_yes_no() else true

    if a && b
      check_desc()
    else
      e.preventDefault()