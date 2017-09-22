Rails.application.routes.draw do
  	resources :users
  	resources :sessions, only: [:new, :create, :destroy]
	root 'static_pages#home'
	match '/signup',  to: 'users#new',            via: 'get'
	match '/signin',  to: 'sessions#new',         via: 'get'
	match '/signout', to: 'sessions#destroy',     via: 'delete'
  	match '/home', to: 'static_pages#home', via: 'get'
  	match '/help', to: 'static_pages#help', via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
