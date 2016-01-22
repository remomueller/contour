# Default dummy controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'contour/layouts/application'
end
