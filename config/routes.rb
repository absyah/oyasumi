Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get 'sleep_records', action: :index, controller: 'sleep_records'
      post 'clock_in', action: :clock_in, controller: 'sleep_records'
      post 'clock_out', action: :clock_out, controller: 'sleep_records'

      namespace :users do
        match ':id/follow' => 'follows#follow', as: :follow, via: [:post]
        match ':id/unfollow' => 'follows#unfollow', as: :unfollow, via: [:post]
        match 'sleep_records' => 'sleep_records#index', as: :sleep_records, via: [:get]
      end
    end
  end
end
