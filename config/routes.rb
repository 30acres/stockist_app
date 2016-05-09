Rails.application.routes.draw do
  resources :locations

  devise_for :admins
  devise_for :retailers
  resources 'stockists'
  get 'countries/:id' => 'country#show', as: 'country'
  get 'media-center' => 'stockists#media_center'
  get 'become-a-stockist' => 'stockists#become_a_stockist'
  get '/dropbox_download' => 'stockists#dropbox_download', as: 'dropbox_download'
  root 'stockists#index'
end
