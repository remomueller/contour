# Global functions referenced from HTML
@showWaiting = (element_id, text, centered) ->
  element = $(element_id)
  if element && centered
    element.html('<br /><center><img width=\"13\" height=\"13\" src=\"' + root_url + 'assets/contour/ajax-loader.gif\" align=\"absmiddle\" alt=\"...\" />' + text + '</center><br />')
  else if element
    element.html('<img width=\"13\" height=\"13\" src=\"' + root_url + 'assets/contour/ajax-loader.gif\" align=\"absmiddle\" alt=\"...\" />' + text)

jQuery ->
  $(".datepicker").datepicker
    showOtherMonths: true
    selectOtherMonths: true
    changeMonth: true
    changeYear: true

  $("#ui-datepicker-div").hide()

  $(document).on('click', ".pagination a, .page a, .next a, .prev a", () ->
    return false if $(this).parent().is('.active, .disabled, .per_page')
    $.get(this.href, null, null, "script")
    false
  )

  $(document).on("click", ".per_page a", () ->
    object_class = $(this).data('object')
    $.get($("#"+object_class+"_search").attr("action"), $("#"+object_class+"_search").serialize() + "&"+object_class+"_per_page="+ $(this).data('count'), null, "script")
    false
  )

  $(document).on('click', '[data-object~="order"]', () ->
    $('#order').val($(this).data('order'))
    $($(this).data('form')).submit()
    false
  )
