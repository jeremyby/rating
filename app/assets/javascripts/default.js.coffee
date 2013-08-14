
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
  $('#notice').html("<span class='#{type}'>#{message}</span>").show().poof('fast')

aac.disable_submit = (e)->
  $(e + ' a').css('visibility', 'hidden')
  $(e + ' input:submit').prop('disabled', true)
  $(e).addClass('loading_l').parents('form').submit()

aac.enable_submit = (e) ->
  $(e).removeClass('loading_l')
  $(e + ' input:submit').prop('disabled', false)
  $(e + ' a').css('visibility', 'visible')

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
  
aac.clear_desc = (e) ->
  unless e.val() && e.val().length && e.val() isnt I18n.empty_desc_msg # nothing in the textarea
    e.addClass('vague').val(I18n.empty_desc_msg).autosize()

aac.set_desc = (id) ->
  e = $(id)
  
  aac.clear_desc(e)
  
  e.click ->
    if $(this).hasClass('vague') # focus on empty textarea
      $(this).removeClass('vague').select_range(0, 0)
  
  e.keydown ->
    if $(this).val() is I18n.empty_desc_msg # empty textarea
      $(this).val('')
  
  e.focusout ->
    aac.clear_desc($(this))

aac.check_askable_body = (id) ->
  f = $(id)

  if f.val().length < 5 || f.val().length > 300
    aac.mark_error(f, I18n.notice.askable_body_size, 'below')
    return false
  else if f.val().indexOf("\u003f") < 0 && f.val().indexOf("\uff1f") < 0
    aac.mark_error(f, I18n.notice.askable_body_format, 'below')
    return false
  else
    aac.reset_field(f)
    return true

aac.check_askable_yes_no = (yes_id, no_id)->
  f_yes = $(yes_id)
  f_no = $(no_id)

  result = true

  if f_yes.length && f_no.length
    if f_yes.val().length < 1 || f_yes.val().length > 80
      aac.mark_error(f_yes, I18n.notice.askable_answer_size, 'below')
      result = false

    if f_no.val().length < 1 || f_no.val().length > 80
      aac.mark_error(f_no, I18n.notice.askable_answer_size, 'below')
      result = false

    if result
      aac.reset_field(f_yes)
      aac.reset_field(f_no)

  return result

aac.check_askable_desc = (id) ->
  $(id).val('') if $(id).val() is I18n.empty_desc_msg
          
aac.action_slider = (pos) ->
  $(window).scroll ->
    if ($(this).scrollTop() > pos)
      $('.actioner').addClass('expand').animate({'top':'40px'}, 'fast') if !$('.actioner').hasClass('expand')
    else
      $('.actioner').css('top', '').removeClass('expand') if $('.actioner').hasClass('expand')

aac.eclipsis_init = (el) ->
    if el.find('.html').height() > el.height()
      el.css('cursor', 'pointer').click ->
        aac.eclipsis_expand($(this))
    else
      #for those answers that not 200px tall, downsize the ellipsis div to fit the inner html div
      el.height(el.find('.html').height())
  
  
aac.eclipsis_expand = (el) ->
  el.css('cursor', '').removeClass('ellips').removeClass('ellipsis', 600, ->
    el.closest('.answerable_body').find('.ans_clps').show()
  )
  
aac.eclipsis_collapse = (el) ->
  el.parent().hide()
  
  eclipsis = el.closest('.answerable_body').children().first()
  eclipsis.addClass('ellipsis', 400, ->
    $(this).addClass('ellips').css('cursor', 'pointer').click ->
      aac.eclipsis_expand($(this))
  )

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
