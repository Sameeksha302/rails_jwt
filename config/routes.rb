Rails.application.routes.draw do
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
  post 'auth/signup', to: 'authentication#signup'
  delete 'auth/logout', to: 'authentication#logout'
  get '/*a', to: 'application#not_found'
end
