Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'power_outlets#index'

  resources :frequencies
  resources :power_outlets do
    resource :switch, only: [:update], defaults: {format: :json}
  end
  resources :power_outlet_groups do
    resource :switch, only: [:update], defaults: {format: :json}
  end
end
