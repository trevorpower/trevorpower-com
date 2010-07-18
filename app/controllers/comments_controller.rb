class CommentsController < ApplicationController
  
  before_filter :authenticate, :except => [ :create ]

  def index
    @comments = Comment.all()
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @post.save()
    redirect_to @post
  end

  def spam
    @comment = Comment.find(params[:id])
    @comment.spam = true
    @comment.save

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  
  protected
  
  def authenticate
    redirect_to (login_url) unless session[:authenticated]
  end
end
