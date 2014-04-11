Bloccit::Application.routes.draw do

  get "posts/index"
  get "comments/new"
  devise_for :users
  resources :users, only: [:show, :update, :index]
  #By calling resources :posts in the resources :topics block, you
  #are instructing Rails to create nested routes.
  # ex topics/1/posts
  resources :posts, only: [:index]
  resources :topics do
    #Because we changed file path of posts_controller to 
    #topics/posts, we need to make sure routes knows where to find 
    #the posts controller:
    resources :posts, except: [:index], controller: 'topics/posts' do
      #need to declare :commetns and :create to declare proper routes 
      #for creation and destruction. An error will be raised without.
      resources :comments, only: [:create, :destroy]
      get '/up-vote' => 'votes#up_vote', as: :up_vote
      get '/down-vote' => 'votes#down_vote', as: :down_vote
      resources :favorites, only: [:create, :destroy]
    end
  end

  root to: 'welcome#index'
  
  match '/about', to: 'welcome#about', via: 'get'
end
