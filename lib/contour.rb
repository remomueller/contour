require 'contour/engine' if defined?(Rails)
require 'contour/fixes'
require 'contour/version'

module Contour
  # Default Application Name
  mattr_accessor :application_name
  @@application_name = 'Application Name'
  
  mattr_accessor :application_name_html
  @@application_name_html = nil

  # Default Application Version
  mattr_accessor :application_version
  @@application_version = nil

  # # Default Application Site URL
  # mattr_accessor :application_site_url
  # @@application_site_url = 'http://localhost'

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
      :name => 'Login', :id => 'auth', :display => 'not_signed_in', :path => 'new_user_session_path', :position => 'right',
      :links => [{:name => 'Sign Up', :path => 'new_user_registration_path'}]
    },
    {
      :name => 'current_user.name', :eval => true, :id => 'auth', :display => 'signed_in', :path => 'user_path(current_user)', :position => 'right', :condition => 'true',
      links: [{ :html => '"<div class=\"small\" style=\"color:#bbb\">"+current_user.email+"</div>"', :eval => true },
              { :name => 'Settings', :path => 'settings_path' },
              { :name => 'Authentications', :path => 'authentications_path', :condition => 'not PROVIDERS.blank?' },
              { :html => "<br />" },
              { :name => 'Logout', :path => 'destroy_user_session_path' }]
    },
    {
      :name => 'Home', :id => 'home', :display => 'always', :path => 'root_path', :position => 'left',
      :links => []
    }
  ]
   
  # Default news feed
  mattr_accessor :news_feed
  @@news_feed = nil
  
  # Default max number of items displayed in the news feed
  mattr_accessor :news_feed_items
  @@news_feed_items = 5
  
  def self.setup
    yield self
  end
end
