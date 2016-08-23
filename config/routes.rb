Rails.application.routes.draw do
  get 'orders/pay_order'
  get 'orders/show/:id' => 'orders#show'
  post 'orders/show/:id' => 'orders#show'
  resources :order_details
  resources :orders
  resources :users
  resources :products
  get 'welcome/index'
  root 'welcome#index'
end
