require 'contour/engine' if defined?(Rails)
require 'contour/version'

module Contour
  # Default Application Name
  mattr_accessor :application_name
  @@application_name = nil
  
  def self.setup
    yield self
  end
end