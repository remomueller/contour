require "contour"
require "rails"
require 'contour/engine/routes'

module Contour
  class Engine < Rails::Engine
    engine_name :contour
  end
end