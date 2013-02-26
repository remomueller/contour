Rails.application.routes.draw do

  get '/auth/failure' => 'contour/authentications#failure'
  post '/auth/:provider/callback' => 'contour/authentications#create'
  get '/auth/:provider' => 'contour/authentications#passthru'
  get '/contour' => 'contour/samples#index'

  resources :authentications, controller: 'contour/authentications'

  # devise_for :users, controllers: { registrations:  'contour/registrations',
  #                                   sessions:       'contour/sessions',
  #                                   passwords:      'contour/passwords',
  #                                   confirmations:  'contour/confirmations',
  #                                   unlocks:        'contour/unlocks' },
  #                    path_names:  { sign_up:        'register',
  #                                   sign_in:        'login' }

end
