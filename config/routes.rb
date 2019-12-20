Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'upload#index'

  resources :upload, only: [:index] do
    get '/:code', to: 'upload#show', on: :collection
  end
  resources :live, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :upload, only: [:create]
      # do
      #   put '/:code/progress', to: 'upload#progress', on: :collection
      # end
    end
  end
end
