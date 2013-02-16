$(document).ready ->
  @reply_button = (atns) ->
    atns.closest('.comments_holder').find('.reply').hide() #find the root, close all replys

    if atns.next('.reply').length # reply form is already copied after
      atns.next('.reply').show()

    else
      #get the id of the comment replying to
      id = atns.parent().attr('id').split('_').pop()

      #copy the reply element, setting it to appear
      reply = atns.closest('.detail').children('.reply').clone().css('display', 'block')

      # attach the copy after atns
      atns.after(reply)

      #setting parent id
      reply.find('#comment_parent_id').val(id)

      reply.find('#comment_body').focus()
      
  @ballot_cell = (element) ->
    $('#ballot .table .cell').removeClass('checked')
    $('#ballot .table input[name="ballot[vote]"]:radio').prop('checked', false)
    
    element.addClass('checked')
    element.children().first().prop('checked', true)
    
