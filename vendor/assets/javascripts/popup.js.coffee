# Popup Code converted to CoffeeScript
# Original Code by:
# /***************************/
# //@Author: Adrian "yEnS" Mato Gondelle
# //@website: www.yensdesign.com
# //@email: yensamg@gmail.com
# //@license: Feel free to use it, but keep this credits please!					
# /***************************/

# SETTING UP OUR POPUP
# 0 means disabled; 1 means enabled;
window.popupStatus = 0

# loading popup with jQuery magic!
@loadPopup = () ->
	# loads popup only if it is disabled
	if window.popupStatus==0
		$("#background_popup").css
			"opacity": "0.7"
		$("#background_popup").fadeIn("slow")
		$("#popup").fadeIn("slow")
		window.popupStatus = 1

# disabling popup with jQuery magic!
@disablePopup = () ->
	# disables popup only if it is enabled
	if window.popupStatus==1
		$("#background_popup").fadeOut("slow")
		$("#popup").fadeOut("slow")
		window.popupStatus = 0

# centering popup
@centerPopup = () ->
	# request data for centering
	windowWidth = document.documentElement.clientWidth
	windowHeight = document.documentElement.clientHeight
	popupHeight = $("#popup").height()
	popupWidth = $("#popup").width()
	# centering
	$("#popup").css(
    "position": "fixed"
    "top": windowHeight/2-popupHeight/2
    "left": windowWidth/2-popupWidth/2
  )
  
	# only need force for IE6
	$("#background_popup").css(
		"height": windowHeight
	)

	$("#popup_content, #popup_content_left, #popup_content_right").css(
    "height": ($("#popup").height() - $("#popup_content").position().top) + "px"
  )

jQuery ->
  # Remove the popup, click the x or click outside of popup event
  $("#popup_close, #background_popup").click(() -> disablePopup())

  # Press Escape event!
  $(document).keypress((e) -> if e.keyCode==27 && window.popupStatus==1 then disablePopup() )

  # Resize the popup window if the window is resized and the popup is open.
  $(window).resize( () ->
    if popupStatus == 1
      centerPopup()
      $('#accordion').accordion( "resize" )
  )