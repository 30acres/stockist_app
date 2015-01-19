Rails.application.routes.draw do
  resources 'stockists'
  get 'countries/:id' => 'country#show', as: 'country'
  get 'media-center' => 'stockists#media_center'
  get 'become-a-stockist' => 'stockists#become_a_stockist'
  root 'stockists#index'
end
