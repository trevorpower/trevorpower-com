ImageDirectory = "public/uploaded_images/#{Rails.env}/" 
Dir.mkdir(ImageDirectory) unless File.exists?(ImageDirectory)
