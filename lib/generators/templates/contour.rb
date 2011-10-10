# Use to configure basic appearance of template
Contour.setup do |config|
  
  # Enter your application name here. The name will be displayed in the title of all pages, ex: AppName - PageTitle
  # config.application_name = 'Application Name'

  # If you want to style your name using html you can do so here, ex: <b>App</b>Name
  # config.application_name_html = ''
  
  # Enter your application version here. Do not include a trailing backslash. Recommend using a predefined constant
  # config.application_version = ''
  
  # Enter your application header background image here.
  # config.header_background_image = 'rails.png'

  # Enter your application header title image here.
  # config.header_title_image = ''
  
  # Enter the items you wish to see in the menu
  # config.menu_items = [{
  #   :name => 'Login', :id => 'auth', :display => 'not_signed_in', :position => 'right', :position_class => 'right', :condition => 'true',
  #   :links => [{:name => 'Login', :path => 'new_user_session_path'}, {:html => "<hr>"}, {:name => 'Sign Up', :path => 'new_user_registration_path'}]
  # },
  # {
  #   :name => 'current_user.name', :eval => true, :id => 'auth', :display => 'signed_in', :position => 'right', :position_class => 'right', :condition => 'true',
  #   :links => [{:html => '"<div style=\"white-space:nowrap\">"+(current_user.methods.include?(:name) ? current_user.name.to_s : "")+"</div>"', :eval => true}, {:html => '"<div class=\"small quiet\">"+current_user.email+"</div>"', :eval => true}, {:name => 'Authentications', :path => 'authentications_path'}, {:html => "<hr>"}, {:name => 'Logout', :path => 'destroy_user_session_path'}]
  # },
  # {
  #   :name => 'Home', :id => 'home', :display => 'always', :position => 'left', :position_class => 'left', :condition => 'true', :image => '', :image_options => {},
  #   :links => [{:name => 'Home', :path => 'root_path', :image => '', :image_options => {}}]
  # }]
  
  # Enter an address of a valid RSS Feed if you would like to see news on the sign in page.
  # config.news_feed = ''
  
  # Enter the max number of items you want to see in the news feed.
  # config.news_feed_items = 5
  
end