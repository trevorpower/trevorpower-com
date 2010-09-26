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

    if (params[:comment].nil?)
      @comment = @post.comments.build
    else
      @comment = @post.comments.build(params[:comment])
      @comment_saved = @comment.save()
    end
    
    @comments = @post.comments.all(:published => true).sort_by(&:published_on)

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @post }
    end
  end

end
