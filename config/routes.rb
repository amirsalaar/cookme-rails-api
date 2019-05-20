Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :foods, except: [:new, :edit]
      resources :users, shallow: true, only: [:create, :update] do
        collection do
          patch :update_password
          get :current
        end
        resources :orders, only: [:index, :show, :create]
        resource :cart, only: [:show]
      end
      resource :session, only: [:create, :destroy] do
        post :add_to_cart
      end
    end
  end
end
