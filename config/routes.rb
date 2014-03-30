Bloccit::Application.routes.draw do
  resources :posts
  root 'welcome#index'
  #get "welcome/about"
  match '/about', to: 'welcome#about', via: 'get'
end
