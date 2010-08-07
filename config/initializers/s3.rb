AWS::S3::Base.establish_connection!(
  :access_key_id => ENV['S3_KEY'],
  :secret_access_key => ENV['S3_SECRET']
)
S3BucketName = "trevorpower-com-#{Rails.env}"
unless AWS::S3::Service.buckets.any? {|b| b.name == S3BucketName}
  AWS::S3::Bucket.create(S3BucketName, :access => :public_read) 
end
