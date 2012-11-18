validate_email = (email) ->
  re = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i
  
  return re.test(email)
  

$(document).ready ->
  $('#user_session_email').focusout ->    
    if !validate_email($(this).val())
      $(this).tooltip({
        content: "Your email address looks funny.",
        position: { my: "left top+15", at: "left bottom" }
      })
      
      $(this).parent().addClass('validation-error')