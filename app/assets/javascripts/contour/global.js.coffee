# Global functions referenced from HTML
@showWaiting = (element_id, text, centered) ->
  element = $(element_id)
  if element && centered
    element.html('<br /><center><img width=\"13\" height=\"13\" src=\"' + root_url + 'assets/ajax-loader.gif\" align=\"absmiddle\" alt=\"...\" />' + text + '</center><br />')
  else if element
    element.html('<img width=\"13\" height=\"13\" src=\"' + root_url + 'assets/ajax-loader.gif\" align=\"absmiddle\" alt=\"...\" />' + text)

jQuery ->
  $(".collapse").collapse()
