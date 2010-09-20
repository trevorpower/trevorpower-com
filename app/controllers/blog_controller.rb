class BlogController < ApplicationController
  def index
    @posts = Post.all(:published => true)

    respond_to do |format|
      format.html # blog.html.erb
      format.xml  { render :xml => @posts }
      format.atom
    end
  end

  def post
    @post = Post.find_by_slug(params[:slug])
    @comments = @post.comments.all(:published => true)
    @comment = @post.comments.build

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @post }
    end

  end

  def comment
    @post = Post.find_by_slug(params[:slug])
    @comment = @post.comments.build(params[:comment])
    @comment_saved = @comment.save()
    #@post.save()
    @comments = @post.comments.all(:published => true)
    render :post
  end
end
