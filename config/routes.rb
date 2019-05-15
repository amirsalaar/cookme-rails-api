Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      resources :users, only: [:create, :update] do
        member do
          patch :update_password
        end
      end
      resource :session, only: [:create, :destroy]
      resource :foods, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
