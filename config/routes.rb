# frozen_string_literal: true

Rails.application.routes.draw do
  namespace "api" do
    post "login", to: "login#login"
    resources :users, only: [:create] do
      collection do
        get    :show
        put    :update
        patch  :update
        delete :destroy
      end
    end
    resources :items
    resources :order_histories, except: [:update, :destroy]
  end
end
