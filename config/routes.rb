# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :users, only: [:show]
  resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: :create
  end
end
