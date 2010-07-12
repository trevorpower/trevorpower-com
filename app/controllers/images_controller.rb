class ImagesController < ApplicationController
  
  ImageDirectory = "public\\uploaded_images\\#{Rails.env}"

  def index
    @images = Dir.entries(ImageDirectory).map{|filename| Image.new(filename)}
  end

  def create
    name = params['picture'].original_filename
    path = File.join(ImageDirectory, name)
    File.open(path, "wb") { |f| f.write(params['picture'].read) }
    
    redirect_to :action => 'index'
  end
 
  def destroy
    redirect_to :action => 'index'
  end

end

  
