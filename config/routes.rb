Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :promotions, only: %i[index new create edit update]
end
