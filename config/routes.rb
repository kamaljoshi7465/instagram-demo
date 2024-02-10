Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  namespace :api do 
    namespace :v1 do 
      post '/signup', to: 'accounts#create'
      post '/login', to: 'sessions#create'
      resources :accounts
      resources :posts do 
        resources :comments 
      end
      resources :profiles do 
        collection do 
          post '/update_profile', to: 'profiles#update_profile'
          post '/update_profile_photo', to: 'profiles#update_profile_photo'
        end
      end
    end
  end
end