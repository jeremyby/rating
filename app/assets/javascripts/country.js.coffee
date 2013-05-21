jvm.WorldMap.prototype.init = (code) ->
  try
    c = aac.code_from_db(code)

    this.setFocus(c)
    this.setSelectedRegions(c)
  catch error
    this.setFocus(['BO', 'CN', 'MX'])


$(document).ready ->
  $.getScript("/search", ->
    aac.load_search('#csmap .search input', 'Search for a country',
      (event, ui) ->
        this.value = ui.item.name
        window.location.href = ui.item.slug
        return false
    )
  )
  
  aac.map = new jvm.WorldMap({
          container: $('#world-map'),
          map: 'world_mill_en',
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
            code = aac.code_from_map(code)
            
            unless code == aac.country_code
              slug = countries.find_slug(code)
            
              if (slug)
                window.location.href = slug
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

      