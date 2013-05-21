window.aac = {}

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

$.fn.poof = ->
  poofer = $(this)
  setTimeout(->
    poofer.fadeOut('slow')
   , 10000)

Array.prototype.find_slug = (code) ->
  return c.slug for c in countries when c.code is code

aac.code_from_db = (code) ->
  switch code
    when 'nc1' then return '_0'
    when 'xk' then return '_1'
    when 'eh' then return '_2'
    when 'so1' then return '_3'
    else return code.toUpperCase()

aac.code_from_map = (code) ->
  switch code
    when '_0' then return 'nc1'
    when '_1' then return 'xk'
    when '_2' then return 'eh'
    when '_3' then return 'so1'
    else return code.toLowerCase()

# cts = call to search
aac.load_search = (searcher, cts_string, select_function) ->
  $construct_regex_string = (s) ->
    "^" + s + "| " + s + "|^" + s.charAt(0) + "([a-z]*( | and |, )[" + s.charAt(1) + "])+"

  $(searcher).each( ->
    $(this).autocomplete({
      open: ->
        $('.ui-autocomplete').prepend($("<li class='hint'>try name/initials/code</li>"))
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

        response($.grep(countries, (item) ->
          return matcher.test(item.name + ' ' + item.code)
          )
        )
      ,
      select: select_function
    })
    .data("autocomplete")._renderItem = (ul, item) ->
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
    $('#notice').poof()
