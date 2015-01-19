Rails.application.routes.draw do
  resources 'stockists'
  get 'countries/:id' => 'country#show', as: 'country'
  get 'stockists/media-center' => 'stockists#media_center'
  root 'stockists#index'
end
