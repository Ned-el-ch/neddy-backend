# class Link
# 	attr_reader :configuration

# 	def initialize(configuration = { className: nil })
# 	  @configuration = configuration
# 	end

# 	def call(parent_element, data)
# 	  args = { href: data.fetch(:data, {}).fetch(:url) }
# 	  args[:class] = configuration.fetch(:className) if configuration[:className]

# 	  element = parent_element.document.create_element('a', args)
# 	  parent_element.add_child(element)
# 	  element
# 	  return nil
# 	end
# end
class PostsController < ApplicationController
	skip_before_action :authorized, only: [:index, :create]

	def index
		# # byebug
		# config = {
		# 	entity_decorators: {
		# 		'LINK' => Link.new(className: 'link')
		# 	},
		# 	block_map: {
		# 		'header-one' => { element: 'h1' },
		# 		'header-two' => { element: 'h2' },
		# 		'header-three' => { element: 'h3' },
		# 		'header-four' => { element: 'h4' },
		# 		'header-five' => { element: 'h5' },
		# 		'header-six' => { element: 'h6' },
		# 		'unordered-list-item' => {
		# 			element: 'li',
		# 			wrapper: ['ul', { className: 'public-DraftStyleDefault-ul' }]
		# 		},
		# 		'ordered-list-item' => {
		# 			element: 'li',
		# 			wrapper: ['ol', { className: 'public-DraftStyleDefault-ol' }]
		# 		},
		# 		'code-block' => {
		# 			element: ['code', {className: 'code-block-line'}],
		# 			wrapper: ['pre', { className: 'code-block-container' }]
		# 		},
		# 		'unstyled' => { element: 'div' }
		# 	},
		# 	style_map: {
		# 		'ITALIC' => { fontStyle: 'italic' },
		# 		'BOLD' => { fontWeight: 'bolder' },
		# 		'STRIKETHROUGH' => { textDecoration: 'line-through' },
		# 		'UNDERLINE' => { textDecoration: 'underline' },
		# 		'CODE' => { fontFamily: 'monospace' },
		# 	}
		# }
		
		# # New up the exporter
		# exporter = DraftjsExporter::HTML.new(config)
		# # byebug
		# posts = Post.all.map do |post|
		# 	# byebug
		# 	oof = 
		# 	byebug
		# 	oof = JSON.parse(post.content)
		# 	oof["entityMap"] = {'0'=>{type:'LINK',mutability:'MUTABLE',data:{url:'http://example.com'}}}
		# 	byebug
		# 	exporter.call({entityMap:{'0'=>{type:'LINK',mutability:'MUTABLE',data:{url:'http://example.com'}}},blocks:[{key:'5s7g9',text:'Header',type:'header-one',depth:0,inlineStyleRanges:[],entityRanges:[]},{key:'dem5p',text:'someparagraphtext',type:'unstyled',depth:0,inlineStyleRanges:[{offset:0,length:4,style:'ITALIC'}],entityRanges:[{offset:5,length:9,key:0}]}]})
		# end
		# # byebug

		# render json: posts
		posts = Post.all
		render json: posts.to_json(include: {
			categories: {
				only: [:id, :title]
			},
			comments: {
				only: [:id, :content, :user_id]
			},
			post_likes: {
				only: [:id, :user_id]
			},
			post_favorites: {
				only: [:id, :user_id]
			}
		})
	end

	def create
		post = Post.new
		# byebug
		post_params[:categories].each do |category_id|
			categoryExists = Category.find(category_id)
			if categoryExists
				post.categories << categoryExists
			end
		end
		post.content = post_params[:content]
		post.user = User.find(post_params[:user_id])
		post.save

		if post.valid?
			render json: post.to_json(include: {
				categories: {
					only: [:id, :title]
				},
				comments: {
					only: [:id, :content, :user_id]
				},
				post_likes: {
					only: [:id, :user_id]
				},
				post_favorites: {
					only: [:id, :user_id]
				}
			}), status: :created
		else
			render json: { error: 'failed to create post' }, status: :not_acceptable
		end
	end

	private

	def post_params

		params.require(:post).permit(:content, :user_id, categories: [])

	end

end