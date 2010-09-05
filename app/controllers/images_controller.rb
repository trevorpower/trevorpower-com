class ImagesController < AdminController
  
  before_filter :authenticate

  def index
    @images = Image.all
  end

  def create
    original_name = params['picture'].original_filename

    image = Image.from_original_name(original_name)
    image.store(params['picture'])
    
    flash[:notice] = "Image successfully uploaded"
    redirect_to :action => 'index'
  end
 
  def destroy
    image = Image.find(params['id'])
    image.destroy
    
    redirect_to :action => 'index'
  end

end

  
