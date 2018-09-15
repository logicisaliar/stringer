Rails.application.routes.draw do
  root to: 'phrases#index'
  resources :phrases, only: [:new, :create, :show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
