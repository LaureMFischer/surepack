Surepack::Application.routes.draw do
  devise_for :users
  resources :lists do
    resources :items, except: [:index]
  end
  root to: "lists#index"

  get '/items', to: 'items#index'
  match '/items/packed' => 'items#packed', :via => :patch
end
