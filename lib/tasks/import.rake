require 'rss/1.0'
require 'rss/2.0'
require 'rss/content'

desc "Import content from previous blog"
task :import_content => :environment do
  puts "Importing original blog content for #{Rails.env}"
  File.open('lib/tasks/oldposts.xml', 'r') do |file|
    rss = RSS::Parser.parse(file, false)
    rss.items.each do |item|
      puts "Importing '#{item.title}'"
      post = Post.new
      post.title = item.title
      post.body = item.content_encoded
      if (post.save())
        puts "Import successful"
      else
        puts "Import failed"
      end
    end
  end
  puts Post.all.count
end

