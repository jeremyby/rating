$(document).ready ->
  $set_bottom_pos()
  
  $('#page2').click ->
    $('html, body').animate({
        scrollTop: $('#page2_top').offset().top - 40
      }, 800
    )
    
  $('#page1').click ->
    $('html, body').animate({
        scrollTop: 0
      }, 500
    )  

  
$(window).resize ->
  $set_bottom_pos()

$set_bottom_pos = ->
  viewPortHeight = document.documentElement.clientHeight
  
  h = viewPortHeight - 115 # height of the viewport - height of the "and" banner and the top margin of actioner
  h = 120 if h < 120 # stopping position when there are only space for header and actioner
  
  $('#content').css("min-height", viewPortHeight - 230 + "px")
  
  $('#bottom').offset({top: h, left: 0})
  $('#bottom .inner').css("min-height", viewPortHeight - 265 + "px")
  
  $('#page_footer').offset({top: viewPortHeight * 2 - 100, left: $('#page_footer').offset().left})
  
  