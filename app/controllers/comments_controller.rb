class CommentsController < AdminController
  before_filter :authenticate
  
  def index
    @comments = Comment.all :order => 'published_on DESC'
    @allow_comments = ! ENV['commenting_active'].nil?
  end

  def activate
    ENV['commenting_active'] = 'true'
    redirect_to comments_url
  end

  def deactivate
    ENV['commenting_active'] = nil
    redirect_to comments_url
  end

  def hide
    @comment = Comment.find(params[:id])
    @comment.published = false
    @comment.save

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

  def publish
    @comment = Comment.find(params[:id])
    @comment.published = true
    @comment.save

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

end
