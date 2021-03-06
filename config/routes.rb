Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/:id/items', to: 'merchants#index'
        get '/find', to: 'search#find_merchant'
        get '/find_all', to: 'search#find_all'
        get '/most_revenue', to: 'search#most_revenue'
        get '/most_items', to: 'search#most_items'
        get '/:id/revenue', to: 'search#merchant_revenue'
      end

      namespace :items do
        get '/:id/merchants', to: 'items#index'
        get '/find', to: 'search#find_item'
        get '/find_all', to: 'search#find_all'
      end

      get 'revenue', to: 'merchants#revenue_accross_dates'


      resources :merchants
      resources :items
    end
  end
end
