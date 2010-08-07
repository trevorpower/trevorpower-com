class ImagesController < AdminController
  
  before_filter :authenticate

  def index
    @images = Image.all
  end

  def create
    original_name = params['picture'].original_filename
    key = Image.create_slug(original_name)

    image = Image.new(key)
    image.store(params['picture'])
    
    redirect_to :action => 'index'
  end
 
  def destroy
    image = Image.find(params['id'])
    image.destroy
    
    redirect_to :action => 'index'
  end

end

  
