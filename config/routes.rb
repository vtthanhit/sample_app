Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "static_pages/home"
    get "static_pages/help"

    get "signup", to: "users#new"
    post "signup", to: "users#create"
    resources :users
    resources :account_activations, only: :edit

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
  end
end
