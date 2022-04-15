Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "static_pages/home"
    get "static_pages/help"

    get "signup", to: "users#new"
    post "signup", to: "users#create"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
  end
end
