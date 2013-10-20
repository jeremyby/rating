$(document).ready ->
  input_change_checker()
  
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

  
  $('.auth').click (e) ->
    auth_popup($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "auth_popup");
    e.preventDefault()
  
  $('.wrapper input').focus (e) ->
    aac.reset_field($(this))
    $(this).next().addClass('light')
    
  $('.wrapper input').blur (e) ->
    $(this).next().removeClass('light')
  
  $('#login .submit input').click (e) ->
    a = check_email($('#user_session_email'))
    b = check_password($('#user_session_password'))
    e.preventDefault() unless a && b
  
  $('#signup .submit input').click (e) ->
    a = check_email($('#user_email'))
    b = check_name($('#user_first_name'))
    c = check_password($('#user_password'))
    
    e.preventDefault() unless a && b && c
    
  $('#forgot .submit input').click (e) ->
    e.preventDefault() unless check_email($('#forgot #email'))

  $('#reset .submit input').click (e) ->
    a = check_password($('#user_password'))
    b = check_password_again($('#user_password_confirmation'))
  
    e.preventDefault() unless a && b
          
auth_popup = (url, width, height, name) ->
  left = (screen.width / 2) - (width / 2)
  top = (screen.height / 2) - (height / 2)
  
  return window.open(url, name, "menubar=no,toolbar=no,status=no,width=#{width},height=#{height},toolbar=no,left=#{left},top=#{top}")    


input_change_checker = ->
  input_on_change($('.wrapper input'))
  
  setTimeout(input_change_checker, 30)

input_on_change = (array) ->
  array.each(->
    if $(this).val()
      $(this).next().hide()
    else
      $(this).next().show()
    )
    

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
    aac.mark_error(f, 'We need at least 6 charaters here.', 'right')
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
  
aac.toggle_login_form = ->
  input_on_change($('.wrapper input'))
  $('.form').toggle('blind', {}, 400)