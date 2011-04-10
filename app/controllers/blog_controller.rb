class BlogController < ApplicationController

  def index
    @posts = Post.all(:published => true, :order => 'published_on DESC')

    respond_to do |format|
      format.html # blog.html.erb
      format.xml  { render :xml => @posts }
      format.atom
    end
  end

  def post
    @post = Post.find_by_slug(params[:slug])

    @allow_comments = ! ENV['commenting_active'].nil?

    if @allow_comments and ! params[:comment].nil?
      @comment = @post.comments.build(params[:comment])
      @comment_saved = @comment.save()
    else
      @comment = @post.comments.build
    end
    
    @comments = @post.comments.all(:published => true).sort_by(&:published_on)

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @post }
    end
  end

end
