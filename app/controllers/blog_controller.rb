class BlogController < ApplicationController

  def index
    @posts = Post.public.all

    respond_to do |format|
      format.html # blog.html.erb
      format.xml  { render :xml => @posts }
      format.atom
    end
  end

  def post
    @post = get_post(params[:slug])
    @allow_comments = get_commenting_status
    @comment = @post.comments.build
    @comments = @post.comments.public.all
  end

  def comment
    @post = get_post(params[:slug])
    @allow_comments = get_commenting_status
    if @allow_comments 
      if ! params[:comment].nil?
        @comment = @post.comments.build(params[:comment])
        @comment_saved = @comment.save()
      else
        @comment = @post.comments.build
      end
      @comments = @post.comments.public.all

      render 'post'
    else
      head :status => :forbidden    
    end
  end

  def get_post(slug)
    Post.find_by_slug(slug)
  end

  def get_commenting_status
    (!ENV['commenting_active'].nil?) && @post.open_for_commenting?
  end

end
