Dummy::Application.routes.draw do
  
  devise_for :users, :controllers => {:registrations => 'contour/registrations', :sessions => 'contour/sessions', :passwords => 'contour/passwords'}, :path_names => { :sign_up => 'register', :sign_in => 'login' }
  
  resources :users
  
  match "/logged_in_page" => "welcome#logged_in_page", :as => :settings
  
  root :to => 'welcome#index'
  
end
