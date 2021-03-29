Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :promotions, only: %i[index new create show edit update] do
    post 'approve', on: :member, to: 'promotions#approve'
    post 'generate_coupons', on: :member, to: 'promotions#generate_coupons'
    resources :coupons, only: %i[index create show destroy] do
      get 'discard', on: :member, to: 'coupons#discard'
    end
  end
end
