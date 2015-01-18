Rails.application.routes.draw do
  resources 'stockists'
  get 'countries/:id' => 'country#show', as: 'country'
  root 'stockists#index'
end
