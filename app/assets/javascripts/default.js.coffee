
$.fn.select_range = (start, end) ->
   return this.each(->
      if (this.setSelectionRange)
        this.focus()
        this.setSelectionRange(start, end)
      else if (this.createTextRange)
        range = this.createTextRange()
        range.collapse(true)
        range.moveEnd('character', end)
        range.moveStart('character', start)
        range.select()
    )

$.fn.poof = (speed) ->
  poofer = $(this)
  i = switch speed
    when 'slow' then 10000
    when 'fast' then 4000
    else 7000
  
  setTimeout(->
    poofer.fadeOut('slow')
   , i)

Array.prototype.find_slug = (code) ->
  return c.slug for c in countries when c.code is code

aac.notify = (type, message) ->
  $('#notice').html("<span class='#{type}'>#{message}</span>").poof('fast')

# cts = call to search
aac.load_search = (searcher, cts_string, select_function) ->
  $construct_regex_string = (s) ->
    "^" + s + "| " + s + "|^" + s.charAt(0) + "([a-z]*( | and |, )[" + s.charAt(1) + "])+"
  
  country_array = []
  country_array.push(countries[key]) for key in Object.keys(countries)
  
  $(searcher).each( ->
    $(this).val(cts_string)
    
    $(this).autocomplete({
      open: ->
        $('.ui-autocomplete').prepend($("<li class='hint'>#{ I18n.search_hint }</li>"))
      ,
      autoFocus: true,
      delay: 0,
      minLength: 0,
      source: (req, response) ->
        re = $.ui.autocomplete.escapeRegex(req.term)

        if re.length < 2
          matcher = new RegExp("^" + re, "i")
        else
          matcher = new RegExp($construct_regex_string(re), "i")

        response($.grep(country_array, (item) ->
          return matcher.test(item.lookup)
          )
        )
      ,
      select: select_function
    })
    .data("autocomplete")._renderItem = (ul, item) ->
      unless item.code
        $(document.createElement('li'))
          .addClass("ui-autocomplete-category")
          .append(I18n.search_all)
          .appendTo(ul)
      else
        re = this.term

        if re.length == 0
          t = item.name
        else
          if re.length == 1
            matcher = new RegExp("^" + re, "i")
          else
            matcher = new RegExp($construct_regex_string(re), "i")

          t = item.name.replace(matcher, "<span>" + "$&" + "</span>")
          
        return $(document.createElement('li'))
                .data("item.autocomplete", item)
                .append("<a>" + t + "</a>")
                .appendTo(ul)
  )
  
  $(searcher).focus ->
    if this.value == cts_string
      this.value = ''
    
    $(this).autocomplete("search", this.value)

  $(searcher).focusout ->
    unless this.value.length
      this.value = cts_string


aac.reset_field = (f) ->
  if f.hasClass('error') # when user focus the field to correct the error
    f.removeClass('error').attr('title', '').tooltip('destroy')
  else
    f.attr('title', '') # user corrected the error and focus out

aac.mark_error = (f, msg, type, klass='') ->
  pos = switch
    when type is 'below' then { my: "left top", at: "left bottom+4px" }
    when type is 'right' then { my: "left center", at: "right+15px center" }
  
  f.tooltip({
    position: pos,
    tooltipClass: klass
  })

  f.addClass('error').attr('title', msg).tooltip('open')
  
aac.action_slider = (pos) ->
  $(window).scroll ->
    if ($(this).scrollTop() > pos)
      $('.actioner').addClass('expand').animate({'top':'40px'}, 'fast') if !$('.actioner').hasClass('expand')
    else
      $('.actioner').css('top', '').removeClass('expand') if $('.actioner').hasClass('expand')


$(document).ready ->
  $('.validation-error input').each ->
    $(this).focus ->
      $(this).parent().removeClass('validation-error')
  
  if $('#notice').children().length > 0
    $('#notice').poof('slow')
    
  aac.load_search('.actioner .slider .search input', ' ', # invisible placeholder to load search
    (event, ui) ->
      this.value = ui.item.name
      window.location.href = '/' + ui.item.slug
      return false
  )
