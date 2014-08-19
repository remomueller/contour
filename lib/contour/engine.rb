require "contour"
require "rails"

require 'bootstrap-sass'

module Contour
  class Engine < Rails::Engine
    engine_name :contour

    # Overwrite Rails errors to use Twitter/Contour CSS classes
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| "<span class=\"has-error\">#{html_tag}</span>".html_safe }

  end
end
