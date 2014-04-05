Bloccit::Application.routes.draw do

  get "comments/new"
  devise_for :users
  resources :users, only: [:update]
  #By calling resources :posts in the resources :topics block, you
  #are instructing Rails to create nested routes.
  # ex topics/1/posts
  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
  end

  root to: 'welcome#index'
  
  match '/about', to: 'welcome#about', via: 'get'
end
