Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  get "signup" , to:"users#new"

  resources :users,only: [:index,:destroy,:show]
  resources :books
  # get "add", to: "users#add_book"

  # resources :books do
  #   member do
  #     get "add", to: "books#add_book"
  #     get "remove", to: "books#remove_book"
  #   end
  #   end

  resources :user_books ,only: [:index, :create, :destroy,:new]
  resources :categories
end
