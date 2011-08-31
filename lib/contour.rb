require 'contour/engine' if defined?(Rails)
require 'contour/version'

module Contour
  # Default Application Name
  mattr_accessor :application_name
  @@application_name = nil

  # Default Application Version
  mattr_accessor :application_version
  @@application_version = nil

  # Default Application Version
  mattr_accessor :header_background_image
  @@header_background_image = 'rails.png'
  
  # Default Application Version
  mattr_accessor :header_title_image
  @@header_title_image = nil
  
  def self.setup
    yield self
  end
end