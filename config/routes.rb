Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'upload#index'

  resources :upload, only: [:index, :edit]
  resources :live, only: [:index]
end
