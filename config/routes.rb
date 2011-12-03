Rails.application.routes.draw do
  
  match '/auth/failure' => 'contour/authentications#failure'
  match '/auth/:provider/callback' => 'contour/authentications#create'
  match '/auth/:provider' => 'contour/authentications#passthru'
  match '/contour' => 'contour/samples#index'

  resources :authentications, controller: 'contour/authentications'
  
  devise_for :users, controllers: { registrations:  'contour/registrations',
                                    sessions:       'contour/sessions',
                                    passwords:      'contour/passwords' },
                     path_names:  { sign_up:        'register',
                                    sign_in:        'login' }
  
end
