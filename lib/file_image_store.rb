module FileImageStore

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

  module ClassMethods
    def all
      Dir.chdir(ImageDirectory) do
        Dir.glob('*').collect{|filename| Image.new(filename)}
      end
    end

    def find (key)
      new(key)      
    end
  end

  def self.included(model)
    model.class_eval do
      extend ClassMethods
    end
    super
  end

end
