$(document).ready ->
  $('.validation-error input').each ->
    $(this).focus ->
      $(this).parent().removeClass('validation-error')
  
  if $('#notification').children().length > 0
     setTimeout(->
        $('#notification').fadeOut(1000)
       , 10000)

  
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
  
  
  aac.load_search = (select_function) ->
   $construct_regex_string = (s) ->
     "^" + s + "| " + s + "|^" + s.charAt(0) + "([a-z]*( | and |, )[" + s.charAt(1) + "])+"

   $('.search input').each( ->
     $(this).autocomplete({
       open: ->
         $('.ui-autocomplete').prepend($("<li class='hint'>type the initials...</li>"))
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
   )
