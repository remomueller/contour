jQuery ->
  $(".field_with_errors input, .field_with_errors_cleared input, .field_with_errors textarea, .field_with_errors_cleared textarea, .field_with_errors select, .field_with_errors_cleared select").change( () ->
    el = $(this)
    if el.val() != '' && el.val() != null
      $(el).parent().removeClass('field_with_errors')
      $(el).parent().addClass('field_with_errors_cleared')
    else
      $(el).parent().removeClass('field_with_errors_cleared')
      $(el).parent().addClass('field_with_errors')
  )
