$(document).ready ->
  $('.validation-error input').each ->
    $(this).focus ->
      $(this).parent().removeClass('validation-error')
  
  if $('#notification').children().length > 0
     setTimeout(->
        $('#notification').fadeOut(1000)
       , 10000)