@reply_button = (atns) ->
  atns.closest('.comments_holder').find('.reply').hide()
  
  if atns.next('.reply').length
    atns.next('.reply').show()
  
  else
    id = atns.parent().attr('id').split('_').pop()
    
    reply = atns.closest('.detail').children('.reply').clone().css('display', 'block')

    atns.after(reply)

    reply.find('.rcbtn').click (e) ->
      $(this).parent().parent().hide()
      e.preventDefault()
  
    reply.find('#comment_parent_id').val(id)
    
    reply.find('#comment_body').focus()


