Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get 'sleep_records', action: :index, controller: 'sleep_records'
      post 'clock_in', action: :clock_in, controller: 'sleep_records'
      post 'clock_out', action: :clock_out, controller: 'sleep_records'
    end
  end
end
