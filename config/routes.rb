Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, path: '', path_names: {
    sign_in: 'api/user/login',
    sign_out: 'api/user/logout',
    registration: 'api/user/signup'
  },
  controllers: {
    sessions: 'api/user/sessions',
    registrations: 'api/user/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    resources :countries, only: [:index]
    resources :cities, only: [:index]
    resources :clubs, only: [:index]

  end
end
