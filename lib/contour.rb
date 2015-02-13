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

  # Default Header Background Image (Logo)
  mattr_accessor :header_background_image
  @@header_background_image = 'rails.png'

  # Default Application Version
  mattr_accessor :header_title_image
  @@header_title_image = nil

  # Default Menu Items
  mattr_accessor :menu_items
  @@menu_items = [
    {
      name: 'Login', display: 'not_signed_in', path: 'new_user_session_path', position: 'right', condition: 'true',
      links: [{ name: 'Sign Up', path: 'new_user_registration_path' }]
    },
    {
      name: 'current_user.email', eval: true, display: 'signed_in', position: 'right', condition: 'true',
      links: [{ name: 'Logout', path: 'destroy_user_session_path' }]
    },
    {
      name: 'Home', display: 'always', path: 'root_path', position: 'left', condition: 'true', image: '', image_options: {},
      links: []
    }
  ]

  # Default search bar (none)
  # Options
  # display: always|not_signed_in|signed_in
  # id: input field id, the form around the search box is 'id'-form
  # position: left|right
  # path: the path for the form to submit to
  # placeholder: defaults to 'Search'
  mattr_accessor :search_bar
  @@search_bar = {}

  # A string or array of strings that represent a CSS color code for generic link color
  mattr_accessor :link_color
  @@link_color = nil

  # A string or array of strings that represent a CSS color code for the body background
  mattr_accessor :body_background_color
  @@body_background_color = nil

  # A string or array of strings that represent an image url for the body background image
  mattr_accessor :body_background_image
  @@body_background_image = nil

  # A hash where the key is a string in "month-day" format where values are a hash of the link_color, body_background_color and/or body_background_image
  # An example might be (April 1st), { "4-1" => { body_background_image: 'aprilfools.jpg' } }
  # Note the lack of leading zeros!
  # Special days take precendence over the rotating options given above
  mattr_accessor :month_day
  @@month_day = {}

  # An array of fields to add to the sign up form
  # An example might be [ { attribute: 'first_name', type: 'text_field' }, { attribute: 'last_name', type: 'text_field' } ]
  mattr_accessor :sign_up_fields
  @@sign_up_fields = []

  # An array of text fields used to trick spam bots using the honeypot approach. These text fields will not be displayed to the user.
  # An example might be [ :url, :address, :contact, :comment ]
  mattr_accessor :spam_fields
  @@spam_fields = []

  def self.setup
    yield self
  end

  def self.link_color_select
    retrieve_option(:link_color) || mod_year(link_color)
  end

  def self.body_background_color_select
    retrieve_option(:body_background_color) || mod_year(body_background_color)
  end

  def self.body_background_image_select()
    retrieve_option(:body_background_image) || mod_year(body_background_image)
  end

  def self.retrieve_option(option_name)
    key = Date.today.month.to_s + "-" + Date.today.day.to_s
    if month_day.kind_of?(Hash) and month_day[key] and not month_day[key][option_name.to_sym].blank?
      month_day[key][option_name.to_sym]
    else
      nil
    end
  end

  # Takes a string or array as input and returns element from location (YearDay % ArraySize)
  def self.mod_year(element)
    array = [element].flatten
    array.size > 0 ? array[Date.today.yday % array.size] : nil
  end
end
