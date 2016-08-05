require "api_constraints"

Rails.application.routes.draw do
  namespace :api, defaults: {format: "json"} do
    devise_for :users, only: :session

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:update, :index]
    end
  end
end
