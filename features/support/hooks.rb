ImageDirectory = "public/uploaded_images/#{Rails.env}/" 

Before do
  Comment.delete_all
  Post.delete_all

  Dir.mkdir(ImageDirectory) unless File.exists?(ImageDirectory)
end

After do
  File.delete( *Dir[ImageDirectory + "*.*"] )
  Dir.rmdir(ImageDirectory)
end
