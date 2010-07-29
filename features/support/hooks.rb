Before do
  Comment.delete_all
  Post.delete_all
  image_bucket = AWS::S3::Bucket.find(S3BucketName) 
  image_bucket.objects.each do |object|
    AWS::S3::S3Object.delete object.name, S3BucketName
  end
end

After do
  File.delete( *Dir[ImageDirectory + "*.*"] )

  Comment.delete_all
  Post.delete_all
end
