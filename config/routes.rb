Rails.application.routes.draw do
  get 'evaluate_assets/show/:id', to: 'evaluate_assets#show'

  patch 'evaluate_assets/update/:id', to: 'evaluate_assets#update'

  resources :assets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
