Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			resources :users, only: [:create]
			post '/login', to: 'auth#create'
			get '/profile', to: 'users#profile'
			get "/posts/:username", to: 'users#posts'
		end
	end
	get "/category/:search_term", to: 'categories#posts'
	get "/categories/", to: 'categories#index'
	resources :posts, only: [:index, :show]
		post '/submit_post', to: 'posts#create'
		post '/like_post', to: 'posts#like'
		post '/favorite_post', to: 'posts#favorite'
		post '/comment', to: 'posts#add_comment'
end