Surepack::Application.routes.draw do
  devise_for :users
  resources :lists do
    resources :items, except: [:index]
  end
  root to: "lists#index"

  get '/items', to: 'items#index'
  match '/items/packed' => 'items#packed', :via => :patch # For saving a list after some items have been checked off
  match '/lists/:id/unpack' => 'lists#unpack', :via => :patch # For clearing a list to reuse it later
end
