# frozen_string_literal: true

Rails.application.routes.draw do
  namespace "api" do
    post "login", to: "login#login"
    resources :users, except: [:update, :destroy] do
      collection do
        put    :update
        patch  :update
        delete :destroy
      end
    end
  end
end
