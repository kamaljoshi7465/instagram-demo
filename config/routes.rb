Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  namespace :api do 
    namespace :v1 do 
      post '/signup', to: 'accounts#create'
      post '/login', to: 'sessions#create'
    end
  end
end