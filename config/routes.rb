Rails.application.routes.draw do
  get 'orders/pay_order'
  get 'orders/:tbknormal' => "pages#tbknormal"
  post 'orders/:tbknormal' => "pages#tbknormal"
  resources :order_details
  resources :orders
  resources :users
  resources :products
  get 'welcome/index'
  root 'welcome#index'
end
