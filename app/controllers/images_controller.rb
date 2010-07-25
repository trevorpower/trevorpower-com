class ImagesController < AdminController
  
  before_filter :authenticate

  ImageDirectory = "public/uploaded_images/#{Rails.env}"

  def index
    Dir.chdir(ImageDirectory) do
      files = Dir.glob('*')
      @images = files.collect{|filename| Image.new(filename)}
    end
  end

  def create
    name = params['picture'].original_filename
    path = File.join(ImageDirectory, name)
    File.open(path, "wb") { |f| f.write(params['picture'].read) }
    
    redirect_to :action => 'index'
  end
 
  def destroy
    slug = params['id']
    Dir.chdir(ImageDirectory) do
      images = Dir.glob('*').collect{|filename| Image.new(filename)}
      to_delete = images.select{|image| image.slug == slug}
     
      to_delete.each do |image|
        File.delete(image.name)
      end
    end

    redirect_to :action => 'index'
  end

  protected
  
  def authenticate
    redirect_to (login_url) unless session[:authenticated]
  end

end

  
