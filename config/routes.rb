Rails.application.routes.draw do

  get 'sessions/new'

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'submit'  => 'static_pages#submit'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :microposts, only: [:create, :destroy, :show, :index] do
    member do
      get "like", to: "microposts#upvote"
      get "dislike", to: "microposts#downvote"
    end  
    resources :comments
  end
  resources :relationships,       only: [:create, :destroy]
end
