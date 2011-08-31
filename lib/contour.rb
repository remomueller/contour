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
  
  # Default Menu Items
  mattr_accessor :menu_items
  @@menu_items = [
    {
      :name => 'Login', :id => 'auth', :display => 'not_signed_in', :position => 'right', :position_class => 'right',
      :links => [{:name => 'Login', :path => 'new_user_session_path'}, {:html => "<hr>"}, {:name => 'Sign Up', :path => 'new_user_registration_path'}]
    },
    {
      :name => 'current_user.name', :eval => true, :id => 'auth', :display => 'signed_in', :position => 'right', :position_class => 'right',
      :links => [{:html => '"<div style=\"white-space:nowrap\">"+current_user.name+"</div>"', :eval => true}, {:html => '"<div class=\"small quiet\">"+current_user.email+"</div>"', :eval => true}, {:name => 'Authentications', :path => 'authentications_path'}, {:html => "<hr>"}, {:name => 'Logout', :path => 'destroy_user_session_path'}]
    },
    {
      :name => 'Home', :id => 'home', :display => 'always', :position => 'left', :position_class => 'left',
      :links => [{:name => 'Home', :path => 'root_path'}, {:html => "<hr>"}, {:name => 'About', :path => 'about_path'}]
    }
  ]
    
  def self.setup
    yield self
  end
end