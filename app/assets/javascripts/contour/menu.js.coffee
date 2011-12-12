jQuery ->
  $('#menu').waypoint( (event, direction) ->
    $(this).toggleClass('sticky', direction == "down")
    $(this).css( left: $("#header").offset().left )
    event.stopPropagation()
  )
  
  $('#menu').find("li").each( () ->
    if $(this).find("ul").length > 0
      # $("<span>").text("^").appendTo($(this).children(":first"))
      
      # show subnav on hover
      $(this).mouseenter( () ->
        $(this).find("ul").stop(true, true).show() #slideDown()
      )
      
      # hide submenus on exit
      $(this).mouseleave( () ->
        $(this).find("ul").stop(true, true).hide() #slideUp()
      )
  )