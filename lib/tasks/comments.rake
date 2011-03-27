desc "Manually moderate comments"
task :comments => :environment do 
  puts "Moderate comments in #{Rails.env}"
  Comment.all(:order => 'published_on DESC').each do |comment|
    puts "===================================================================="
    puts "Post: #{comment.post_title}"
    puts "Name: #{comment.name}"
    puts "Email: #{comment.email}"
    puts "URL: #{comment.url}"
    puts "Published: #{comment.published}"
    puts "Date: #{comment.published_on}"
    puts " = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ="
    puts comment.body
    if comment.published
      puts "Skip, Hide, Delete [Shd]"
    else
      puts "Skip, Publish, Delete [Spd]"
    end
    input = STDIN.gets.strip
    if input == 'h'
      comment.published = false
      comment.save
      puts "hidden"
    elsif input == 'p'
      comment.published = true
      comment.save
      puts "published"
    elsif input == 'd'
      puts "Delete: Are you sure? [Ny]"
      comment.delete if STDIN.gets.strip == 'y'
    end 
  end
end
