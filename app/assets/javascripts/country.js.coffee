$(document).ready ->
  $poll_counter = 0
  
  $.pace = 25  
  
  $follow_link = (e) ->
    url = $('#follow').attr('href')
    
    $('#follow_li').html('<li class="loading"></li>')
    
    $.get(url, (data) ->
        $('#follow_li').hide().html(data).fadeIn('fast')
        $('#follow').click (e) ->
          $follow_link(e)
      )
    
    e.preventDefault()
    
  $('#follow').click (e) ->
    $follow_link(e)
    
  
  $poll_pack = $(document.createElement('div'))
                      .attr('id', 'poll_pack')
                      .html(' 
                              <h3>Starting a Poll Pack</h3>
                              <div>A poll pack has 10 questions. Are you sure you want to answer them all now?</div>
                            ')
                      .dialog({
                                modal: true,
                                autoOpen: false,
                                width: 500,
                                height: 250,
                                buttons: {
                                  OK: -> (
                                    $start_poll_pack()
                                  ),
                                  Cancel: -> (
                                    $(this).dialog( "close" )
                                  )
                                }
                            })
  
  $loading = $('<div id="loading"><img src="/assets/loading.gif" /></div>')
                            
  $start_poll_pack = ->
    $poll_pack.dialog('close')
    
    # remove the button div in the confirm window, which is the next sibling of poll_pack
    $('#poll_pack ~ div').remove()
    
    $poll_pack.html($loading)
              .dialog({
                width: 900,
                height: 550
              })
    
    $poll_pack.dialog('open')
    
    url = window.location.pathname + "/poll_pack/new"

    $.getScript(url, ->
      setTimeout ($load_poll_pack), 500
    )
    
  $load_poll_pack = ->
  
    $q_holder = $(document.createElement('div'))
                        .attr('id', 'q_holder')
                        .html(polls[$poll_counter].html)

    $('.ui-dialog').append('<a id="close" title="Close">X</a>')
    
    $poll_pack.html('<div id="counter"><span>1</span> / 10</div>')
                    .append($q_holder)
                    .append('<div id="bar"></div>')
    
    $('#poll_pack_start').html('Continue...')
    $add_poll_pack_events()
              
    $('#close').click (e) ->
      $poll_pack.dialog('close')
      e.preventDefault()
      
  
  $clear_vote = ->
    $('.vote').remove()
    $('.positive').removeClass('green').unbind('hover')
    $('.negative').removeClass('red').unbind('hover')
    
  $save_vote = (v) ->
    polls[$poll_counter].vote = v
    
    # when needs to navigate through polls, previous button etc.
    # polls[$poll_counter].html = $(q_holder).html()
  
  $process_vote = (e, choice) ->
    vote = ""
    value = 0
    
    $set_positive = ->
      vote = "positive"
      value = 1

    $set_negative = ->
      vote = "negative"
      value = -1
    
    y = 230
    if choice is "yes"
      x = 60
      
      if $(".yes").hasClass("positive")
        $set_positive()
      else
        $set_negative()
    else
      x = 390
      
      if $(".no").hasClass("positive")
        $set_positive()
      else
        $set_negative()
    
    $clear_vote()
    
    $v = $("<img class='vote' src='/assets/#{vote}.png'>").offset({top: e.offsetY + y, left: e.offsetX + x})
    $(q_holder).append($v)
    
    $save_vote(value)
    $start_countdown()   
      
    e.preventDefault()
  
  $add_poll_pack_events = ->
    $('.yes').click (e) ->
      $process_vote(e, 'yes')

    $('.no').click (e) ->
      $process_vote(e, 'no')
    
    
    $('.positive').hover( 
                    ->
                      $(this).addClass('green')
                    , -> 
                      $(this).removeClass('green')
                  )                          
                            
    $('.negative').hover( 
                    ->
                     $(this).addClass('red')
                    , -> 
                      $(this).removeClass('red')
                  )

  $start_countdown = ->
    clearInterval(global.interval)
    $("#bar").show().progressbar({ 
                            value: 10,
                            complete: ->
                              clearInterval(global.interval)
                              
                              $next_poll()
                          })
    
    global.interval = setInterval(->
        $("#bar").progressbar("option", "value", $("#bar").progressbar("option", "value") + 1)
      , global.pace)

  
  $next_poll = ->
    $poll_counter++
   
    if $poll_counter >= 10 # when all polls voted
      $(poll_pack).html($loading)
      
      url = global.path + "/poll_pack"
      
      #TODO: need to add error handling here
      $.post(url, $.param({results: {id: poll.id, vote: poll.vote} for poll in polls}))
        .success( ->
          setTimeout( ->
            $loading.html('<p>Sumit complete. Thank you for your votes.</p> <p>redirecting...</p>')
            setTimeout( ->
              window.location.href = global.path + "/poll_pack"
            , 3000)
          , 500)
        )
      
      return false
 
    $('#counter > span').html($poll_counter + 1)

    $(q_holder).html(polls[$poll_counter].html)
     
    $add_poll_pack_events()
    
    if global.pace >= 15
      global.pace -= 2
    
    $("#bar").hide()
  
  
  $('#poll_pack_start').click (e) ->
    $poll_pack.dialog('open')
    
    e.preventDefault()
    
    
    
