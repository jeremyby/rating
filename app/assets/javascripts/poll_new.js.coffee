$(document).ready ->  
  $.getScript("/search", ->
    aac.load_search('#search', 'a country',
      (event, ui) ->
        this.value = ui.item.name
        $('#poll_country_code').attr("value", ui.item.code)
        
        this.className = 'dark'
        $('#poll_question').focus()
        return false
    )
  ) 
  
  $('#search').focus ->
    if this.value == 'a country'
      this.value = ''
    
    this.className = ''
    
    $(this).autocomplete("search", this.value)