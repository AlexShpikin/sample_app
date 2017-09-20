Rails.application.routes.draw do
  	resources :users

	root 'static_pages#home'
  	match '/home', to: 'static_pages#home', via: 'get'
  	match '/help', to: 'static_pages#help', via: 'get'
  	match '/signup', to: 'users#new', via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
