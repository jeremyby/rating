aac.ckeditor = ''

aac.create_editor = ->
	if (aac.ckeditor)
		return false
	
	aac.ckeditor = CKEDITOR.replace('answerable_body', { language: locale })
	
aac.remove_editor = ->
	unless (aac.ckeditor)
		return false

	# Destroy the editor.
	aac.ckeditor.destroy()
	aac.ckeditor = null


$(document).ready ->  
  #enable resize remote image proportionally with CSS  
  $('.html img').css('width', '').css('height', '')
  
  $('.answerable .ellipsis').each( ->
    aac.eclipsis_init($(this))
  )
  
  aac.toggle_edit = ->
    if $('.question .header h1').is(':visible')
      $('.question .header h1, .question .header .desc').hide()
      $('.question .edit').show()
      $('#askable_body').autosize()
      aac.set_desc('#askable_description')
    else
      $('.question .edit').hide()
      $('.question .header h1, .question .header .desc').show()
      
  aac.askable_submit_check = ->
    a = aac.check_askable_body('.question #askable_body')
    b = aac.check_askable_yes_no('.question #askable_yes', '.question #askable_no')
    
    if a && b
      aac.check_askable_desc('.question #askable_description')
      aac.disable_submit('.question .submit')
    else
      return false
    
      
  aac.submit_check = ->
    if $('#answerable  .votes').length and !$('#answerable .table input[name="answerable[vote]"]:radio').is(':checked') # a vote is selected
      aac.notify('alert', I18n.notice.missing_vote)
        
      return false
    
    $('#answerable_body').val(aac.ckeditor.getData())
    
    aac.disable_submit('#answerable .submit')
  
  aac.ballot_cell = (vote) ->
    if vote.length
      element = $('#answerable .votes .' + vote)
      
      checked = element.hasClass('checked')
      
      $('#answerable .table .cell').removeClass('checked')
      $('#answerable .table input[name="answerable[vote]"]:radio').prop('checked', false)
      
      unless checked
        element.addClass('checked')
        element.children().first().prop('checked', true)
  
  aac.toggle_answerable = ->
    aac.toggle_blinder('#answerable')

  aac.toggle_comments = ->
    $('#askable_comments .detail').show()
    aac.toggle_blinder('#askable_comments')
    
  aac.toggle_blinder = (el) ->
    if $('.blinder').is(':visible')
      aac.remove_editor() if el is '#answerable'
      
      same = ('#' + $('.blinder:visible').prop('id') == el)
      
      $('.blinder').hide('blind')
      
      if same #hiding the slide, 
        $('#spb').removeClass('lower', 400)
      else #show the ballot slide
        aac.show_blinder(el)
              
    else
      aac.show_blinder(el)
    
  aac.show_blinder = (el) ->
    $('#spb').addClass('lower', 400)
    
    $(el).show('blind', ->
      aac.create_editor() if el is '#answerable'
    )
  
  aac.ans_comments = (el) ->
    $('#answers').find('.comments .detail').hide('blind') #find the root, close all replies
    $('#answers').find('.comments .actions').show('blind') 
    
    el.parent().next('.detail').show('blind', 'fast')
    el.parent().hide('blind', 'fast')
    
  aac.cancel_comment = (el) ->
    actions = el.closest(".detail").prev()
    
    if (actions.length) #canceling comment for answers
      el.closest(".detail").hide("blind", 'fast')
      
      actions.slideDown('fast')
  
  
  $(document).on('click', '#sph .blocks #unfollower', ->
    $(this).html('').addClass('loading').click ->
      return false
  )
  
  $(document).on('click', '#sph .blocks #follower', ->
    $(this).find('span').addClass('loading_ws')
    $(this).click ->
      return false
  )
  
  $(document).on('click', '#answerable .votes .yes', ->
    aac.ballot_cell('yes')
    return false
  )

  $(document).on('click', '#answerable .votes .no', ->
    aac.ballot_cell('no')
    return false
  )

  $(document).on('click', '#answerable .submit input:submit', ->
    aac.submit_check()
  )
  
  $(document).on('click', '#sph .question .submit input:submit', ->
    aac.askable_submit_check()
  )
  
  $(document).on('click', '#askable_comments .form a', ->
    aac.toggle_comments();
    return false;
  )
  
  $(document).on('focus', '.question #askable_body, .question .yesno input', ->
    aac.reset_field($(this))
  )  
  
  $(document).on('afterShow', '#notice', ->
    aac.enable_submit('.submit')
    return false
  )
  
      
  #*********************
  # comments
  #**********************
  aac.reply_button = (atns) ->
    atns.closest('.comments_holder').find('.reply').slideUp() #find the root, close all replies

    atns.next('.reply').slideDown().find('#comment_body').focus()

      