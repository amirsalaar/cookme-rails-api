Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :foods, except: [:new, :edit]
      resources :users, only: [:create, :update] do
        collection do
          patch :update_password
        end
        resources :orders, only: [:index, :show, :create]
      end
      resource :session, only: [:create, :destroy]
    end
  end
end
