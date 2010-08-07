include AWS::S3

module S3ImageStore

  def store(file)
    S3Object.store(name, file, S3BucketName, :access => :public_read)
  end

  def destroy
    object = S3Object.find(name, S3BucketName)   
    object.delete
  end

  def url
    "http://s3.amazonaws.com/#{S3BucketName}/#{name}"
  end

  module ClassMethods
    def all
      image_bucket = Bucket.find S3BucketName    
      image_bucket.objects.collect{|object| new(object.key)}
    end

    def find (key)
      new(key)      
    end
    
    def delete_all
      image_bucket = Bucket.find S3BucketName 
      image_bucket.objects.each do |object|
        AWS::S3::S3Object.delete object.key, S3BucketName
      end
    end
  end

  def self.included(model)
    model.class_eval do
      extend ClassMethods
    end
    super
  end

end
