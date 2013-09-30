aac.ckeditor = ''
aac.answer_editor = ''

$(document).ready ->  
  #enable resize remote image proportionally with CSS  
  $('.html img').css('width', '').css('height', '')
  
  $('.question .edit .text textarea').autosize()
  
  $('.answerable .ellipsis').each( ->
    aac.eclipsis_init($(this))
  )
  
  aac.toggle_edit_askable = ->
    if $('.question .header h1').is(':visible')
      $('.question .header h1, .question .header .desc, #sph .actions').hide()
      $('.question .edit').fadeIn('fast')
      $('#askable_body').autosize().focus()
      aac.set_desc('#askable_description')
    else
      $('.question .edit').hide()
      $('.question .header h1, .question .header .desc, #sph .actions').fadeIn('fast')
      
  aac.toggle_edit_answerable = (id) ->
    if $("#answerable_#{ id } .answerable_body").is(':visible')
      # close all other open edits
      if (aac.answer_editor)
        aac.answer_editor.destroy()
        aac.answer_editor = null
      $("#answers .edit_body").hide()
      $("#answers .answerable_body").show()
      $("#answers .actions").show()
      
      # now open the current one
      $("#comment_#{ id } .actions").hide()
      $("#answerable_#{ id } .answerable_body").hide()
      $("#answerable_#{ id } .edit_body").fadeIn('fast')
      
      aac.answer_editor = CKEDITOR.replace("answerable_body_#{id}", { language: locale })
      return false
    else
      aac.answer_editor.destroy()
      aac.answer_editor = null
      
      $("#answerable_#{ id } .edit_body").hide()
      $("#answerable_#{ id } .answerable_body").fadeIn('fast')
      $("#comment_#{ id } .actions").show()
      return false
    
      
  askable_submit_check = ->
    a = aac.check_askable_body('.question #askable_body')
    b = aac.check_askable_yes_no('.question #askable_yes', '.question #askable_no')
    
    if a && b
      aac.check_askable_desc('.question #askable_description')
      aac.disable_submit('.question .submit')
    else
      return false
      
  answerable_submit_check = ->
    if $('#answerable  .votes').length and !$('#answerable .table input[name="answerable[vote]"]:radio').is(':checked') # a vote is selected
      aac.notify('alert', I18n.notice.missing_vote)
      return false
    
    $('#answerable_body').val(aac.ckeditor.getData())
    
    aac.disable_submit('#answerable .submit')
  
  in_place_answerable_submit_check = (el) ->
    el.find('.answer textarea').val(aac.answer_editor.getData())
    
    aac.disable_submit("##{ el.prop('id') } .edit_body .submit")
    
  
  ballot_cell = (vote) ->
    if vote.length
      element = $('#answerable .votes .' + vote)
      
      checked = element.hasClass('checked')
      
      $('#answerable .table .cell').removeClass('checked')
      $('#answerable .table input[name="answerable[vote]"]:radio').prop('checked', false)
      
      unless checked
        element.addClass('checked')
        element.children().first().prop('checked', true)
  
  aac.toggle_answerable = ->
    toggle_blinder('#answerable')

  aac.toggle_comments = ->
    $('#askable_comments .detail').show()
    toggle_blinder('#askable_comments')
    
  toggle_blinder = (el) ->
    if $('.blinder').is(':visible')
      
      if el is '#answerable'
        if (aac.ckeditor)
          aac.ckeditor.destroy()
          aac.ckeditor = null
        
      same = ('#' + $('.blinder:visible').prop('id') == el)
      
      $('.blinder').hide('blind')
      
      if same #hiding the slide, 
        $('#spb').removeClass('lower', 400)
      else #show the ballot slide
        show_blinder(el)
              
    else
      show_blinder(el)
    
  show_blinder = (el) ->
    $('#spb').addClass('lower', 400)
    
    $(el).show('blind', ->
      aac.ckeditor = CKEDITOR.replace('answerable_body', { language: locale }) if el is '#answerable' && $('answerable_body').length
    )
  
  aac.ans_comments = (el) ->
    $('#answers').find('.comments .detail').hide('blind') #find the root, close all replies
    $('#answers').find('.comments .actions').show('blind') 
    
    el.parent().hide()
    el.parent().next('.detail').fadeIn('fast')
    
    
  aac.cancel_comment = (el) ->
    actions = el.closest(".detail").prev()
    
    if (actions.length) #canceling comment for answers
      el.closest(".detail").hide()
      
      actions.fadeIn('fast')
  
  
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
    ballot_cell('yes')
    return false
  )

  $(document).on('click', '#answerable .votes .no', ->
    ballot_cell('no')
    return false
  )

  $(document).on('click', '#answerable .submit input:submit', ->
    answerable_submit_check()
  )
  
  $(document).on('click', '#answers .edit_body .submit input:submit', ->
    in_place_answerable_submit_check($(this).closest('.answerable'))
  )
  
  $(document).on('click', '#sph .question .submit input:submit', ->
    askable_submit_check()
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

      