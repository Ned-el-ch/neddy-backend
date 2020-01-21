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
	get "/categories", to: 'categories#index'
	post "/follow_category", to: 'categories#follow'
	post "/unfollow_category", to: 'categories#unfollow'

	get "/followers/:username", to: 'relationships#followers'
	get "/followed/:username", to: 'relationships#followed'
	post "/follow", to: 'relationships#create'
	post "/unfollow", to: 'relationships#destroy'

	post '/submit_post', to: 'posts#create'
	post '/like_post', to: 'posts#like'
	post '/favorite_post', to: 'posts#favorite'
	post '/comment', to: 'posts#add_comment'
	resources :posts, only: [:index, :show]

end