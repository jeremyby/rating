
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
    $(this).autocomplete({
      open: ->
        $('.ui-autocomplete').prepend($("<li class='hint'>#{aac.search_hint_string}</li>"))
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
          .append(aac.search_all)
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


$(document).ready ->
  $('.validation-error input').each ->
    $(this).focus ->
      $(this).parent().removeClass('validation-error')
  
  if $('#notice').children().length > 0
    $('#notice').poof('slow')
