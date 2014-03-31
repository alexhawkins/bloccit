Bloccit::Application.routes.draw do
  devise_for :users
  resources :posts
  root to: 'welcome#index'
  #get "welcome/about"
  match '/signin', to: 'devise/sessions#new', via: 'get'
  match '/about', to: 'welcome#about', via: 'get'
end
