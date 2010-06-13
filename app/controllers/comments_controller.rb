class CommentsController < ApplicationController
  def index
    @comments = Comment.all()
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @post.save()
    redirect_to @post
  end
end
