Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show, :create]
      resources :items, only: [:index, :show, :create]
    end
  end
end
