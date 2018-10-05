Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/revenue', to: 'revenue_date#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/transactions', to: 'transactions#index'
      end

      namespace :transactions do
        get '/:id/invoice', to: 'invoice#show'
      end

      namespace :items do
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#show'
      end

      namespace :invoice_items do
        get '/:id/invoice', to: 'invoice#show'
        get '/:id/item', to: 'item#show'
      end

      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end
end
