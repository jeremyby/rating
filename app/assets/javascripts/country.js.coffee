jvm.WorldMap.prototype.init = (code) ->
  try
    this.setFocus(code)
    this.setSelectedRegions(code)
  catch error
    this.setFocus(['bo', 'cn', 'mx'])
    aac.notify('notice', 'Oops, our map is not accurate enough to show this country/region.')


$(document).ready ->
  aac.load_search('#csmap .search input', aac.search_string,
    (event, ui) ->
      this.value = ui.item.name
      window.location.href = ui.item.slug
      return false
  )
  
  
  aac.load_search('#cshead .search input', ' ', # invisible placeholder to load search
    (event, ui) ->
      this.value = ui.item.name
      window.location.href = ui.item.slug
      return false
  )

  
  aac.map = new jvm.WorldMap({
          container: $('#world-map'),
          map: 'world',
          # zoomOnScroll: false,
          zoomMin: 1.5,
          zoomMax: 10,
          regionStyle: {
            initial: {
              fill: 'white',
              "fill-opacity": 1
            },
            hover: {
              "fill-opacity": 0.8
            },
            selected: {
              fill: 'yellow'
            }
          },
          onRegionClick: (e, code) ->
            unless code == aac.country_code
              window.location.href = countries[code].slug
              return false
          ,
          onRegionOver: ->
            $(this).css('cursor', 'pointer')
          ,
          onRegionOut: ->
            $(this).css('cursor', '')
        })
        
  aac.map.init(aac.country_code)
  
    
  $( "#csmap .head" ).draggable({ containment: "parent" })


  $(window).scroll ->
    if ($(this).scrollTop() > 220)
      if !$('.actioner').hasClass('expand')
        $('.actioner').addClass('expand').animate({'top':'40px'}, 'fast')
    else
      if $('.actioner').hasClass('expand')
        $('.actioner').css('top', '').removeClass('expand')

      