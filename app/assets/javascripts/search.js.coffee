$(document).ready ->  
  $.current_category = ""
  
  $.getScript("/search", ->
    $load_search()
  )
  
  $load_search = ->
    $construct_regex_string = (s) ->
      "^" + s + "| " + s + "|^" + s.charAt(0) + "([a-z]*( | and |, )[" + s.charAt(1) + "])+"
    
    $('#search').autocomplete({
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
          return matcher.test(item.full)
          )
        )
      ,
      select: (event, ui) ->
        this.value = ui.item.name
        window.location.href = ui.item.slug
        return false
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
      
      if $.current_category != item.category
        $.current_category = item.category

        $(document.createElement('li'))
          .addClass("ui-autocomplete-category")
          .append(item.category)
          .appendTo(ul)
      
      return $(document.createElement('li'))
              .data("item.autocomplete", item)
              .append("<a>" + t + "</a>")
              .appendTo(ul)

        
    $('#search').focus ->
      if this.value == 'your home country' || this.value == 'another country'
        this.value = ''
      
      $(this).autocomplete("search", this.value)
