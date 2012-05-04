require "contour"
require "rails"

module Contour
  class Engine < Rails::Engine
    engine_name :contour

    # Overwrite Rails errors to use Twitter CSS classes
    # config.action_view.field_error_proc = Proc.new{ |html_tag, instance| "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe }
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| "<span class=\"control-group error\">#{html_tag}</span>".html_safe }

  end
end
