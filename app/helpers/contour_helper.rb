module ContourHelper

  def cancel
    link_to 'Cancel', URI.parse(request.referer.to_s).path.blank? ? root_path : (URI.parse(request.referer.to_s).path), class: 'btn btn-default'
  end

  def sort_field_helper(order, sort_field, display_name, search_form_id  = 'search_form')
    sort_field_order = (order == sort_field) ? "#{sort_field} DESC" : sort_field
    symbol = (order == sort_field) ? '&raquo;' : (order == sort_field + ' DESC' ? '&laquo;' : '&laquo;&raquo;')
    selected_class = (order == sort_field) ? 'selected' : (order == sort_field + ' DESC' ? 'selected' : '')
    content_tag(:span, class: selected_class) do
      display_name.to_s.html_safe + ' ' + link_to(raw(symbol), '#', data: { object: 'order', order: sort_field_order, form: "##{search_form_id}" }, style: 'text-decoration:none')
    end.html_safe
  end

  # From Twitter-Bootstrap-Rails
  def flash_block
    output = ''
    flash.each do |type, message|
      unless session["user_return_to"] == root_path and I18n.t("devise.failure.unauthenticated") == message
        output += flash_container(type, message) if ['alert', 'notice', 'error', 'warning', 'success', 'info'].include?(type.to_s)
      end
    end

    raw(output)
  end

  # From Twitter-Bootstrap-Rails
  def flash_container(type, message)
    type = 'success' if type.to_s == 'notice'
    type = 'warning' if type.to_s == 'alert'
    type = 'danger' if type.to_s == 'error'
    content_tag(:div, class: "navbar-alert alert alert-#{type}") do
      content_tag(:a, raw("&times;"), href: '#', class: 'close', data: { dismiss: 'alert' }) + message
    end.html_safe
  end

end
