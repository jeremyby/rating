$(document).ready ->
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
        $('.actioner').addClass('expand').animate({'top':'40px'}, 'fast')
    else
      if $('.actioner').hasClass('expand')
        $('.actioner').css('top', '').removeClass('expand')
        $('#csheader').css('visibility', 'visible')
        $('#csside .search').css('visibility', 'visible')
      