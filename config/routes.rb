Rails.application.routes.draw do

	root 'pages#home'
	get 'pages/home', to: 'pages#home'
    
    get 'signup', to: 'chefs#new'

    resources :chefs, except: [:new]
	resources :recipes
end
