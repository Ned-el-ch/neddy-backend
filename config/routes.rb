Rails.application.routes.draw do
	# resources :user_posts
	# resources :post_categories
	# resources :categories
	# resources :comments
	# resources :post_favorites
	# resources :post_likes
	# resources :posts
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	namespace :api do
		namespace :v1 do
			resources :users, only: [:create]
				post '/login', to: 'auth#create'
				get '/profile', to: 'users#profile'
				get "/posts/:username", to: 'users#posts'
		end
	end
	resources :posts, only: [:index]
		post '/submit_post', to: 'posts#create'
end