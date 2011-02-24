require 'image'

IMAGE_STORE_CONFIG = YAML.load_file("#{::Rails.root.to_s}/config/image_store.yml")[::Rails.env.to_s]

if IMAGE_STORE_CONFIG['use_s3']

  AWS::S3::Base.establish_connection!(
    :access_key_id => ENV['S3_KEY'],
    :secret_access_key => ENV['S3_SECRET']
  )
  S3BucketName = ENV["S3_BUCKET"] || "trevorpower-com-#{Rails.env}"
  unless AWS::S3::Service.buckets.any? {|b| b.name == S3BucketName}
    AWS::S3::Bucket.create(S3BucketName, :access => :public_read) 
  end

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
