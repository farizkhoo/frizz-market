Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  resources :users do
  	resources :orders, controller: "orders", only: [:new, :create]
  end

  resources :orders, controller: "orders", only: [:index]

  get "/login" => "sessions#new", as: "login"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy", as: "logout"
  get "/signup" => "users#new", as: "signup"
end
