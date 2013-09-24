# Global functions referenced from HTML
@showWaiting = (element_id, text, centered) ->
  element = $(element_id)
  if element && centered
    element.html("<div class='spinner-centered'><div class='spinner'>#{text}</div></div>")
  else if element
    element.html("<div class='spinner'>#{text}</div>")

@flashMessage = (message, alert_type = 'success', overwrite = true) ->
  div_block = "<div class='navbar-alert alert alert-#{alert_type}'><button type='button' class='close' data-dismiss='alert'>&times;</button>#{message}</div>"
  flash_container = $('[data-object~="flash-container"]')
  if overwrite
    flash_container.html(div_block)
  else
    flash_container.append(div_block)

@nonStandardClick = (event) ->
  event.which > 1 or event.metaKey or event.ctrlKey or event.shiftKey or event.altKey

$(document)
  .on('change', '.datepicker', () ->
    try
      $(this).val($.datepicker.formatDate('mm/dd/yy', $.datepicker.parseDate('mm/dd/yy', $(this).val())))
    catch error
      # Nothing
  )
  .on('click', ".pagination a, .page a, .next a, .prev a", () ->
    return false if $(this).parent().is('.active, .disabled, .per_page')
    $.get(this.href, null, null, "script")
    false
  )
  .on("click", ".per_page a", () ->
    object_class = $(this).data('object')
    $.get($("#"+object_class+"_search").attr("action"), $("#"+object_class+"_search").serialize() + "&"+object_class+"_per_page="+ $(this).data('count'), null, "script")
    false
  )
  .on('click', '[data-object~="order"]', () ->
    $('#order').val($(this).data('order'))
    $($(this).data('form')).submit()
    false
  )

@ready = () ->
  $(".datepicker").datepicker('remove')
  $(".datepicker").datepicker( autoclose: true )

  # Load forms on page load
  $('[data-object~="form-load"]').submit()

$(document).ready(ready)
# $(document).on('page:load', ready)
