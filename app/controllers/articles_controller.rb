class ArticlesController < ApplicationController
	#before_action :authenticate_user!, only: [:show,:index]
	before_action :set_article, except: [:index,:new,:create]
	before_action :authenticate_editor!, only: [:new, :create, :update]
	before_action :authenticate_admin!, only: [:destroy, :publish]


	#GET /articles
	def index	
	@articles = Article.paginate(page: params[:page],per_page:6).publicados.ultimos
	end

	#GET /articles/:index
	def show
		#Where
		#Article.where("cuerpo LIKE ?", "%hola%")
		@article.update_visits_count
		@comment = Comment.new
	end

	#GET /articles/new
	def new
		@article = Article.new
		@categories = Category.all
	end

	#POST /articles
	def create
		@article = current_user.articles.new(article_params)	
		@article.categories = params[:categories]	
		#@article.invalid? valid?
		if	@article.save						
			redirect_to @article		
		else
			render :new
		end
	end

	def edit
	end

	#PUT /articles/:id
	def update
		
		@article.newcategories = params[:categories]
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	#PUT /articles/:id
	def publish
		@article.publish!
		redirect_to @article		
	end

	#POST /articles
	def destroy
		
		@article.destroy #Elimina de BBDD
		redirect_to articles_path
	end
	
	private

	def set_article
		@article = Article.find(params[:id])
	end


	def article_params
			params.require(:article).permit(:titulo,:cuerpo,:cover,:categories,:markup_body)
	end

end
