Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "urls#new"

  resources :urls, only: [ :new, :create, :show ]

  # This route handles short links like /abc123
  get "/:slug", to: "urls#redirect", as: :short
end
