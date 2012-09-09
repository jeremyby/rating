$(document).ready ->
  $set_bottom_pos()

  
$(window).resize ->
  $set_bottom_pos()

$set_bottom_pos = ->
  h = window.innerHeight - 75
  h = 140 if h < 140
  
  $('#bottom').offset({top: h, left: 0})
  $('#page_footer').offset({top: h + $('#bottom').outerHeight(), left: $('#page_footer').offset().x})