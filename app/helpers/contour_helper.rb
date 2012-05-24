module ContourHelper

  def cancel
    link_to 'Cancel', URI.parse(request.referer.to_s).path.blank? ? root_path : (URI.parse(request.referer.to_s).path), class: 'btn btn-danger'
  end

  def sort_field_helper(order, sort_field, display_name, search_form_id  = 'search_form')
    result = ''
    if order == sort_field
      result = "<span class='selected'>#{display_name} #{ link_to_function('&raquo;'.html_safe, "$('#order').val('#{sort_field} DESC');$('##{search_form_id}').submit();", style: 'text-decoration:none')}</span>"
    elsif order == sort_field + ' DESC' or order.split(' ').first != sort_field
      result = "<span #{'class="selected"' if order == sort_field + ' DESC'}>#{display_name} #{link_to_function((order == sort_field + ' DESC' ? '&laquo;'.html_safe : '&laquo;&raquo;'.html_safe), "$('#order').val('#{sort_field}');$('##{search_form_id}').submit();", style: 'text-decoration:none')}</span>"
    end
    result
  end

  # From Twitter-Bootstrap-Rails
  def flash_block
    output = ''
    flash.each do |type, message|
      output += flash_container(type, message) if ['alert', 'notice', 'error', 'warning', 'success', 'info'].include?(type.to_s)
    end

    raw(output)
  end

  # From Twitter-Bootstrap-Rails
  def flash_container(type, message)
    type = 'success' if type.to_s == 'notice'
    type = 'error' if type.to_s == 'alert'
    content_tag(:div, class: "alert alert-#{type}") do
      content_tag(:a, raw("&times;"), href: '#', class: 'close', data: { dismiss: 'alert' }) + message
    end.html_safe
  end

end
