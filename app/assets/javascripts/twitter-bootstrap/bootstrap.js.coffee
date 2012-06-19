jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.dropdown-toggle').dropdown()

  $(document).scroll( () ->
    if $('.subnav').length > 0
      if !$('.subnav').data('top')
        return if ($('.subnav').hasClass('subnav-fixed'))
        offset = $('.subnav').offset()
        $('.subnav').data('top', offset.top)
      if $('.subnav').data('top') - $('.subnav').outerHeight() <= $(this).scrollTop()
        $('.subnav').addClass('subnav-fixed')
      else
        $('.subnav').removeClass('subnav-fixed')
  )
