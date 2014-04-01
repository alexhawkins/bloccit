Bloccit::Application.routes.draw do

  devise_for :users
  #By calling resources :posts in the resources :topics block, you
  #are instructing Rails to create nested routes.
  # ex topics/1/posts
  resources :topics do
    resources :posts, except: [:index]
  end

  root to: 'welcome#index'
  
  match '/about', to: 'welcome#about', via: 'get'
end
