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
    @post = Post.find(params[:id])
    @comments = @post.comments.all(:published => true)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

end
