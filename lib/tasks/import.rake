require 'rss/2.0'
require 'lib/import'

desc "Import content from previous blog"
task :import_content => :environment do
  puts "Importing original blog content for #{Rails.env}"

  File.open('lib/tasks/oldposts.xml', 'r') do |file|
    Import.import_posts_from_rss file
  end
end

