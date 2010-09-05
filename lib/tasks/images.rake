namespace :images do
  desc "Reset images collection"
  task :reset => :environment do
    puts "Deleting all images from store"
    Image.delete_all
  end
end 
