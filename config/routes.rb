Bloccit::Application.routes.draw do
  root 'welcome#index'
  #get "welcome/about"
  match '/home', to: 'welcome#index', via: 'get'
  match '/about', to: 'welcome#about', via: 'get'
  
end
