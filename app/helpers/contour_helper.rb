# From Twitter-Bootstrap-Rails
module ContourHelper
  def flash_block
    output = ''
    flash.each do |type, message|
      output += flash_container(type, message) if ['alert', 'notice', 'error', 'warning', 'success', 'info'].include?(type.to_s)
    end

    raw(output)
  end

  def flash_container(type, message)
    type = 'success' if type.to_s == 'notice'
    type = 'error' if type.to_s == 'alert'
    content_tag(:div, class: "alert alert-#{type}") do
      content_tag(:a, raw("&times;"), href: '#', class: 'close', data: { dismiss: 'alert' }) + message
    end.html_safe
  end
end
