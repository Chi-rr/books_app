# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :books do
    resources :comments, module: :books
  end

  resources :reports do
    resources :comments, module: :reports
  end

  resources :users, only: [:index, :show]
  root to: "books#index"

  resources :users do
    resources :followings, only: :index, controller: "users/followings"
    resources :followers, only: :index, controller: "users/followers"
  end

  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
