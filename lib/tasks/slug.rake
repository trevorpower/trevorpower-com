desc "Recalculate the slugs for Posts"
task :slug => :environment do 
  puts "Recalculating the slug for all posts in #{Rails.env}"
  Post.all.each do |post|
    new_slug = Post.create_slug(post.title)
    if (post.slug != new_slug)
      puts post.title
      puts "#{post.slug} => #{new_slug}"
      
      post.slug = new_slug
      post.save
    end
  end
  puts "Post slugs reset"
end
