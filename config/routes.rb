Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'projects#index'

  devise_for :users, controllers: {
      registrations: 'auth/registrations',
      sessions: 'auth/sessions',
      passwords: 'auth/passwords'
  }

  resource :profile, only: [:edit, :update]

  resources :projects do
    resources :issues, shallow: true do
      resources :time_entries, shallow: true
    end
  end

  scope 'admin', module: 'admin' do
    resources :enumerators, only: :index
    resources :users
    resources :roles
    resources :permissions
    resources :issue_statuses, except: :show do
      member do
        put 'move_up'
        put 'move_down'
        put 'set_default'
        put 'set_closing'
      end
    end
    resources :activities, except: :show do
      member do
        put 'move_up'
        put 'move_down'
        put 'set_default'
      end
    end
    resources :issue_priorities, except: :show do
      member do
        put 'move_up'
        put 'move_down'
        put 'set_default'
      end
    end
    resource :settings, only: [:edit, :update]
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
