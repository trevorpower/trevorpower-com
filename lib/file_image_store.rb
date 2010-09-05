module FileImageStore

  attr :directory

  def store(file)
    path = File.join(ImageDirectory, name)
    File.open(path, "wb") do |f| 
      f.write(file.read) 
    end
  end

  def destroy
    path = File.join(ImageDirectory, name)
    File.delete(path)
  end

  def url
    "/uploaded_images/#{Rails.env}/" + name
  end

  module ClassMethods
    def all
      Dir.chdir(ImageDirectory) do
        Dir.glob('*').collect{|filename| Image.new(filename)}
      end
    end

    def find (key)
      new(key)      
    end
    
    def delete_all
      File.delete( *Dir[ImageDirectory + "*"] )
    end  
  end

  def self.included(model)
    model.class_eval do
      extend ClassMethods
    end
    super
  end

end
