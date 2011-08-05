class PostsController < AdminController  
  before_filter :authenticate

  def index
    @posts = Post.all :order => 'published_on DESC'
  end

  def new
    @post = Post.new

    render :layout => 'edit'
  end

  def edit
    @post = Post.find(params[:id])
    render :layout => 'edit'
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => "new"
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      flash[:notice] = 'Post was successfully updated.'
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_url
  end

  def publish
    @post = Post.find(params[:id])
    @post.published = true
    @post.save

    redirect_to posts_url
  end

  def hide
    @post = Post.find(params[:id])
    @post.published = false
    @post.save

    redirect_to posts_url
  end

  def open
    @post = Post.find(params[:id])
    @post.open_for_commenting = true
    @post.save
    
    redirect_to posts_url
  end

  def close
    @post = Post.find(params[:id])
    @post.open_for_commenting = false
    @post.save
    
    redirect_to posts_url
  end
end
