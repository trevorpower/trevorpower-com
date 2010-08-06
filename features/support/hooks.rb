Before do
  Comment.delete_all
  Post.delete_all
end

Before('@image_upload') do
  Image.delete_all
end

After('@image_upload') do
end

After do
  Comment.delete_all
  Post.delete_all
end
