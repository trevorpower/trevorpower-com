class CommentsController < AdminController
  before_filter :authenticate
  
  def index
    page = (params[:page] || '0').to_i
    @comments = Comment.all(
      :order => 'published_on DESC', 
      :skip => page * 10, 
      :limit => 10
    )

    @prev_page = (page - 1).to_s unless page == 0
    @next_page = (page + 1).to_s unless @comments.count < 10

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

  def similar
    @comment = Comment.find(params[:id])
    @countWithSameName = Comment.where(:name => @comment.name).count
    @countWithSameEmail = Comment.where(:email => @comment.email).count
    @countWithSameUrl = Comment.where(:url => @comment.url).count
    render :layout => 'edit'
  end

  def destroy_similar
    comment = Comment.find(params[:id])
    
    delete_with_same_attribute comment, :name unless params[:deleteWithName].nil?
    delete_with_same_attribute comment, :email unless params[:deleteWithEmail].nil?
    delete_with_same_attribute comment, :url unless params[:deleteWithUrl].nil?
    comment.destroy
    redirect_to :comments
  end

  private

  def delete_with_same_attribute(base, attribute)
    Comment.where(attribute => base.read_attribute(attribute)).each do |comment|
      comment.destroy
    end
  end
end
