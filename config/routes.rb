Rails.application.routes.draw do

  root to: 'urls#index'

  resources :urls

  get '/users/:id' => 'users#index'
  get '/users' => 'users#friends'

  match 'auth/:provider/callback', to: 'sessions#create', :via => [:post, :get]
  match 'auth/failure', to: redirect('/'), :via => [:post, :get]
  match 'signout', to: 'sessions#destroy', as: 'signout', :via => [:post, :get]

  get  'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
