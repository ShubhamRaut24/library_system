Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  get "signup" , to:"users#new"

  resources :users, except: [:new]
  resources :books
  # get "add", to: "users#add_book"

  resources :books do
    member do
      get "add", to: "books#add_book"
      get "remove", to: "books#remove_book"
    end
    end

    resources :categories
end
