Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants do
        get '/items', to: 'merchants#items'
      end
      resources :items do
        get '/merchants', to: 'items#merchants'
      end
    end
  end
end
