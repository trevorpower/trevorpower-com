class CommentsController < AdminController
  before_filter :authenticate
  
  def index
    @comments = Comment.all :order => 'published_on DESC'
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
