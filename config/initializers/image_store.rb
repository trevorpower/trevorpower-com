IMAGE_STORE_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/image_store.yml")[RAILS_ENV]

if IMAGE_STORE_CONFIG['use_s3']

  class Image
    include S3ImageStore
  end

else
  ImageDirectory = "public/uploaded_images/#{Rails.env}/" 
  Dir.mkdir(ImageDirectory) unless File.exists?(ImageDirectory)

  class Image
    include FileImageStore
  end
end
