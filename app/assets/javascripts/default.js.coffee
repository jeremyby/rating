$(document).ready ->
  # $('.validation-error input').each ->
  #   $(this).focus ->
  #     $(this).parent().removeClass('validation-error')
  
  # $('#user_last_name').each ->
  #   $(this).focus ->
  #     if $(this).val() == 'optional'
  #       $(this).parent().removeClass('note')
  #       $(this).val('')
  #       
  #   $(this).focusout ->
  #     if $(this).val() == ''
  #       $(this).parent().addClass('note')
  #       $(this).val('optional')
  
  if $('#notification').children().length > 0
     setTimeout(->
        $('#notification').fadeOut(1000)
       , 5000)