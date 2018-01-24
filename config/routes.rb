Rails.application.routes.draw do

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
  post "/users/:id/follow" => "users#follow"
  post "/users/:id/unfollow" => "users#unfollow"


  resources :users do
    resources :events
  end


  post "/events/:id/join" => "events#join"
  post "/events/:id/leave" => "events#leave"

  root "static#homedash"


  get "feed" => "static#feed"


  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "sessions#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :events
  resources :locations #May remove or restrict these later

  post "/sign_up" => "users#create"
  get "/my_blog" => "blogs#myBlog"
  get "/following_blog" => "blogs#following"
  get "/browse_blog" => "blogs#browse"
  get "/event_location" => "locations#new"

  post "/blog_post" => "blogs#post"

  get "/search" => "events#search_page"
end
