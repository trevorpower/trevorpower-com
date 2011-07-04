class PostsController < AdminController  
  before_filter :authenticate

  def index
    @posts = Post.all :order => 'published_on DESC'
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html { render :layout => 'edit' }
      format.xml  { render :xml => @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :layout => 'edit'
  end

  def create
    @post = Post.new(params[:post])
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to :action => 'index' }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to :action => 'index' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  def publish
    @post = Post.find(params[:id])
    @post.published = true
    @post.save

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end

  def hide
    @post = Post.find(params[:id])
    @post.published = false
    @post.save

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
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
