Rails.application.routes.draw do

  devise_for :users

  root to: 'books#top'
  get '/books/about'

  resources :books, only: [:create, :index, :show, :edit, :destroy, :update]
  resources :users, only: [:show, :edit, :update, :index]
end
