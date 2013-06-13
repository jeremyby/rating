$(document).ready ->
  if $('.search input').length
    aac.load_search('.search input', 'Go to another country',
      (event, ui) ->
        this.value = ui.item.name
        window.location.href = ui.item.slug
        return false
    )

  
  $('#hcs .flags a').click (e) ->
    unless $(this).children('.c').hasClass('active')    
      $('#hcs .flags a').children('.c').removeClass('active')    
      $('#hcs .flags .detail').remove()
    
      id = $(this).parent().attr('id')
      content = $("##{ id } .content").html()
    
      div = $("<div class='detail'>#{ content }</div>")
      
      pos = Math.ceil((parseInt(id.split('_').pop()) + 1) / 5) * 5 - 1 # get the count of country blocks, and find which row it's on
      
      target = $('#hcs .flags').children()[pos]
      $(target).after(div)
    
      $(this).children('.c').addClass('active')
      div.addClass('color')

    e.preventDefault()


  $('.stroke input').focus ->
    aac.reset_field($(this))

  $('#login .submit input').click (e) ->
    a = check_email($('#user_session_email'))
    b = check_password($('#user_session_password'))
    e.preventDefault() unless a && b
  
  $('#signup .submit input').click (e) ->
    a = check_email($('#user_email'))
    b = check_name($('#user_first_name'))
    c = check_password($('#user_password'))
    d = check_password_again($('#user_password_confirmation'))
    
    e.preventDefault() unless a && b && c && d
    
    
validate_email = (email) ->
  re = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i
  
  return re.test(email)

check_email = (f) ->
  if !validate_email(f.val())
    aac.mark_error(f, 'Your email address is looking funny.', 'right')
    return false
  else
    aac.reset_field(f) 
    return true

check_name = (f) ->
  if f.val().length < 1
    aac.mark_error(f, 'A name is required for people to know you.', 'right')
    return false
  else
    aac.reset_field(f) 
    return true

check_password = (f) ->
  if f.val().length < 6
    aac.mark_error(f, 'We need 6 charaters here minimal.', 'right')
    return false
  else
    aac.reset_field(f)
    return true
    
check_password_again = (f) ->
  if f.val() != $('#user_password').val()
    aac.mark_error(f, 'This is not the same as above.', 'right')
    return false
  else
    aac.reset_field(f) 
    return true
  
  