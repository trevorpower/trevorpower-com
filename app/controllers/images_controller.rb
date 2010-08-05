include AWS::S3

class ImagesController < AdminController
  
  before_filter :authenticate

  ImageDirectory = "public/uploaded_images/#{Rails.env}"

  def index
    Dir.chdir(ImageDirectory) do
      files = Dir.glob('*')
      @images = files.collect{|filename| Image.new(filename)}
    end

    image_bucket = Bucket.find S3BucketName    
    @images = image_bucket.objects.collect{|object| Image.new(object.key)}
  end

  def create
    name = params['picture'].original_filename
    path = File.join(ImageDirectory, name)
    File.open(path, "wb") do |file| 
      file.write(params['picture'].read) 
      S3Object.store(name, params['picture'], S3BucketName)
    end
    
    redirect_to :action => 'index'
  end
 
  def destroy
    slug = [ params['id'], params['format'] ].compact.join '.' 
    id = CGI::unescape slug

    object = S3Object.find(id, S3BucketName)   
    object.delete

    Dir.chdir(ImageDirectory) do
      images = Dir.glob('*').collect{|filename| Image.new(filename)}
      to_delete = images.select{|image| image.slug == id}
     
      to_delete.each do |image|
        File.delete(image.name)
      end
    end

    redirect_to :action => 'index'
  end

end

  
