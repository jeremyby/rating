$(document).ready ->  
  $.current_category = ""
  
  $.getScript("/search", ->
    aac.load_search(
      (event, ui) ->
        this.value = ui.item.name
        window.location.href = ui.item.slug
        return false
    )
  ) 
  
  $('.search input').focus ->    
    $(this).autocomplete("search", this.value)
    
  $(document).scroll ->
    if ($(this).scrollTop() > 50)
      if !$('.actioner').hasClass('expand')
        $('#csheader').css('visibility', 'hidden')
        $('#csside .search').css('visibility', 'hidden')
        $('.actioner').addClass('expand')
    else
      if $('.actioner').hasClass('expand')
        $('.actioner').removeClass('expand')
        $('#csheader').css('visibility', 'visible')
        $('#csside .search').css('visibility', 'visible')
      