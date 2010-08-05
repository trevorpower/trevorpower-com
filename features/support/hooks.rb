Before do
  Comment.delete_all
  Post.delete_all
end

Before('@image_upload') do
  image_bucket = AWS::S3::Bucket.find(S3BucketName) 
  image_bucket.objects.each do |object|
    AWS::S3::S3Object.delete object.key, S3BucketName
  end
end

After('@image_upload') do
  File.delete( *Dir[ImageDirectory + "*.*"] )
end

After do
  Comment.delete_all
  Post.delete_all
end
