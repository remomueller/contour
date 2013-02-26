Dummy::Application.routes.draw do

  devise_for :users, controllers: { registrations: 'contour/registrations', sessions: 'contour/sessions', passwords: 'contour/passwords', confirmations: 'contour/confirmations', unlocks: 'contour/unlocks' }, path_names: { sign_up: 'register', sign_in: 'login' }

  resources :users

  get "/logged_in_page" => "welcome#logged_in_page", as: :logged_in_page

  root to: 'welcome#index'

end
