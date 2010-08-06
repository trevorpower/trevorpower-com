include AWS::S3

class ImagesController < AdminController
  
  before_filter :authenticate

  ImageDirectory = "public/uploaded_images/#{Rails.env}"

  def index
    @images = Image.all
  end

  def create
    image = Image.new(params['picture'].original_filename)
    image.store(params['picture'])
    
    redirect_to :action => 'index'
  end
 
  def destroy
    image = Image.find(params['id'])
    image.destroy
    
    redirect_to :action => 'index'
  end

end

  
