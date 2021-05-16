Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'sign_up', action: :create, controller: 'users'
      post 'sign_in', action: :login, controller: 'users'

      resources :profile, only: %i[], controller: 'users' do
        collection do
          delete 'destroy'
          put 'update'
          get 'show'
        end
      end
    end
  end
end
