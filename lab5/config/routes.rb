Rails.application.routes.draw do
  resources :expenses
  resources :categories
  resources :payment_methods
end
