Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :stocks

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'administrators#create'
end
