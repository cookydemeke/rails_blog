Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/" => "users#home"
  get "/home" => "users#home"
  get "/login_form" => "users#login_form"
  post "/login" => "users#login"
  get "/all_posts" => "posts#index"
  get "/logout" => "users#logout"
  get "/current_user_menu" => "users#current_user_menu"
  get "/my_posts" => "posts#my_posts"
  # post "/show/:id" => "posts#show"
  get "/edit_user_post_path/:post_id/:user_id" => "posts#edit"
  resources :users do
      resources :posts
  end
  get "/new_comment/:post_id/:user_id" => "comments#new"
  resources :comments
end
