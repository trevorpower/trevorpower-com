include AWS::S3

module S3ImageStore

  def store(file)
    S3Object.store(name, file, S3BucketName)
  end

  def destroy
    object = S3Object.find(name, S3BucketName)   
    object.delete
  end

  module ClassMethods
    def all
      image_bucket = Bucket.find S3BucketName    
      image_bucket.objects.collect{|object| new(object.key)}
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
