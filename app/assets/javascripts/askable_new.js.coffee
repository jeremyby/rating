$(document).on('click', '#nask .types .inactive .block', ->
  active = $('#nask .types .active').removeClass('active')
  inactive = $('#nask .types .inactive').removeClass('inactive')
  active.addClass('inactive')
  inactive.addClass('active')

  $('#nask .askable .yesno').toggle()

  aac.reset_field($('#nask .yesno input'))
)
    
check_type = ->
  $('#nask #askable_type').val($('#nask .types .active').attr('id'))

$(document).ready ->
  $('#nask #askable_body').focus ->
    aac.reset_field($(this))

  $('#nask .yesno input').focus ->
    aac.reset_field($(this))
  
  $('#nask #askable_body').autosize()
  
  aac.set_desc('#nask #askable_description')
  
  $('#nask .askable .submit input').click (e) ->
    check_type()

    a = aac.check_askable_body('#nask #askable_body')
    b = if $('#nask #askable_type').val() is 'Poll' then aac.check_askable_yes_no('#nask #askable_yes', '#nask #askable_no') else true

    if a && b
      aac.check_askable_desc('#nask #askable_description')
    else
      e.preventDefault()