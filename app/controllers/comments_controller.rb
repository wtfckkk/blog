class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_article
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.article =  @article     
    respond_to do |format|
        if @comment.save
              format.html { redirect_to @comment.article, notice: "Comentario OK"}
              format.json { render :show, status: :created, location: @comment.article}
        else
              format.html { render :new }
              format.json { render json: @comment.errors, status: :unprocessable_entity }
        end   
     end   
  end

  def update
    @comment.update(comment_params)
    redirect_to @comment.article
  end

  def destroy
    @comment.destroy
    redirect_to @comment.article
  end

  private
    def set_article
      @article = Article.find(params[:article_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :article_id, :cuerpo)
    end
end
