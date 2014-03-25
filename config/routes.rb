Surepack::Application.routes.draw do
  devise_for :users
  resources :lists do
    resources :items
  end
  root to: "lists#index"

  get '/items', to: 'items#all'
end
