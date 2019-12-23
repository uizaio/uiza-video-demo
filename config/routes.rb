Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'videos#index'

  resources :videos, only: [:index] do
    get '/:code', to: 'videos#show', on: :collection
  end
  resources :lives, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :videos, only: [:create]
    end
  end
end
