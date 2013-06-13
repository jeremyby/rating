$(document).ready ->
  $(".best_in_place").best_in_place()
  
  $('.update_desc_success').bind("ajax:success", ->
    if $(this).text() == 'add description...'
      $(this).parent().removeClass('desc').addClass('add_desc')
    else
      $(this).parent().removeClass('add_desc').addClass('desc')
  )
  
  $('.update_question_success').bind("ajax:success", ->
    q = $(this).text().replace('?', '').split(' ', 10).join('-').toLowerCase()
    url = "/#{$(this).data('country')}/#{q}"
    
    if (window.history.pushState) # supports pushState
      window.history.pushState('', 'updated question',  url)
    else
      window.location.href = url
  )
  
  aac.empty_ballot_answer_msg = 'Optional but recommended. Your insights may convince others to vote with you.'
  
  aac.clear_ballot_answer = (e) ->
    unless e.val() && e.val().length # nothing in the textarea
      e.addClass('sub').val(aac.empty_ballot_answer_msg)
  
  aac.set_ballot_answer = ->
    e = $('#answerable_body')
    
    aac.clear_ballot_answer(e)
    
    e.click ->
      if e.hasClass('sub') # focus on empty textarea
        e.select_range(0, 0)
    
    e.keydown ->
      if e.hasClass('sub') # empty textarea
        e.removeClass('sub').val('')
    
    e.focusout ->
      aac.clear_ballot_answer(e)
  
  aac.set_ballot_answer()
  
  
  aac.submit_check = ->
    unless $('#ballot .table input[name="answerable[vote]"]:radio').is(':checked') # a vote is selected
      aac.notify('alert', 'Please cast a vote before submitting.')
        
      return false
    
    $('#answerable_body').val('') if $('#answerable_body').val() == aac.empty_ballot_answer_msg
    
    
  aac.ballot_cell = (vote) ->
    $('#ballot .table .cell').removeClass('checked')
    $('#ballot .table input[name="answerable[vote]"]:radio').prop('checked', false)
    
    if vote.length
      element = $('#ballot .answers .' + vote)
    
      element.addClass('checked')
      element.children().first().prop('checked', true)
    
  
  aac.show_ballot = ->
    $('#ballot_action').hide()
    $('#ballot').slideDown()
    $('#answerable_body').autosize()
    
  aac.hide_ballot = ->
    $("#ballot").slideUp( ->
      $("#ballot_action").fadeIn()
    )

  
  $(document).on('click', '#ballot .answers .yes', ->
    aac.ballot_cell('yes')
    return false
  )

  $(document).on('click', '#ballot .answers .no', ->
    aac.ballot_cell('no')
    return false
  )

  $(document).on('click', '#ballot .submit input:submit', ->
    aac.submit_check()
  )
  
      
  #*********************
  # comments
  #**********************
  
  aac.reply_button = (atns) ->
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
      