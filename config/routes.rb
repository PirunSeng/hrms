Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  namespace :api do
    mount_devise_token_auth_for 'User', at: '/v1/auth'
    namespace :v1 do
      resources :departments
    end
  end
end
