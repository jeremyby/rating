$(document).ready ->
  $('.stroke input').focus ->
    reset_field($(this))

  # login validation checkes
  $('#user_session_email').focusout ->
    check_email($(this))

  $('#user_session_password').focusout ->
    check_password($(this))

  $('#login .submit input').click (e) ->
    a = check_email($('#user_session_email'))
    b = check_password($('#user_session_password'))
    e.preventDefault() unless a && b
  
  # sign up validations
  $('#user_email').focusout ->
    check_email($(this))
  
  $('#user_first_name').focusout ->
    check_name($(this))
    
  $('#user_password').focusout ->
    check_password($(this))
    
  $('#user_password_confirmation').focusout ->
    check_password_again($(this))
  
  $('#signup .submit input').click (e) ->
    a = check_email($('#user_email'))
    b = check_name($('#user_first_name'))
    c = check_password($('#user_password'))
    d = check_password_again($('#user_password_confirmation'))
    
    e.preventDefault() unless a && b && c && d
    
    
validate_email = (email) ->
  re = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i
  
  return re.test(email)

reset_field = (f) ->
  if f.hasClass('error')
    f.removeClass('error').tooltip('close')

check_error = (f, msg) ->
  reset_field(f)
  
  f.tooltip({
    position: { my: "left center", at: "right+15px center" }
  })
  
  f.addClass('error')
          .attr('title', msg)
          .tooltip('open')

check_email = (f) ->
  if !validate_email(f.val())
    check_error(f, 'Your email address looks kind of funny.')
    return false
  else
    return true

check_name = (f) ->
  if f.val().length < 1
    check_error(f, 'A name is required for people to know you.')
    return false
  else
    return true

check_password = (f) ->
  if f.val().length < 6
    check_error(f, 'We need 6 charaters here minimal.')
    return false
  else
    return true
    
check_password_again = (f) ->
  if f.val() != $('#user_password').val()
    check_error(f, 'This is not the same as above.')
    return false
  else
    return true