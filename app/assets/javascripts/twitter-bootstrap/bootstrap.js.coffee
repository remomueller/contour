jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.dropdown-toggle').dropdown()

  $(document).scroll( () ->
    if !$('.subnav').attr('data-top')
      return if ($('.subnav').hasClass('subnav-fixed'))
      offset = $('.subnav').offset()
      $('.subnav').attr('data-top', offset.top)
    if $('.subnav').attr('data-top') - $('.subnav').outerHeight() <= $(this).scrollTop()
      $('.subnav').addClass('subnav-fixed')
    else
      $('.subnav').removeClass('subnav-fixed')
  )
