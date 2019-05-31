Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :foods, except: [:new, :edit] do
        resource :schedule, only: [:create, :destroy]
      end
      resources :users, shallow: true, only: [:create, :update] do
        collection do
          patch :update_password
          get :current
        end
        resources :orders, only: [:index, :show, :create] do
          resources :payments, only: [:create]
        end
        resource :cart, only: [:show]
      end
      resource :session, only: [:create, :destroy] do
        collection do
          post :add_to_cart
          delete :destroy_cart
        end
      end
    end
  end
end
