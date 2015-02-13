Rails.application.routes.draw do

  get '/contour' => 'contour/samples#index'

  # devise_for :users, controllers: { registrations:  'contour/registrations',
  #                                   sessions:       'contour/sessions',
  #                                   passwords:      'contour/passwords',
  #                                   confirmations:  'contour/confirmations',
  #                                   unlocks:        'contour/unlocks' },
  #                    path_names:  { sign_up:        'register',
  #                                   sign_in:        'login' }

end
