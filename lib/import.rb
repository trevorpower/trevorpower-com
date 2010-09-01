require 'rss/content'
require 'open-uri'
require 'uri'
require 'nokogiri'
require 'wordpress'

class Import

  def self.get_body(content)
    html = Nokogiri::HTML(content)
    html.xpath("//img").each do |img|
      src = img['src']
      puts "\tProcessing image: #{src}"
      url = URI.parse(src)
      image = Image.new(File.basename(url.path))
      image.store(open(src))
      img.set_attribute('src', image.url)
    end
    body = html.xpath("/html/body").first
    body.nil? ? '' : body.inner_html
  end
  
  def self.create_post(item)
    return nil unless item.wp_post_type == 'post'
    post = Post.new
    post.title = item.title
    post.body = get_body(item.content_encoded)
    post.tags = item.categories.select{|cat| cat.domain == 'tag'}.map{|tag| tag.content} 
    post
  end
  
  def self.import_posts_from_rss(data)
    rss = RSS::Parser.parse(data, false)
    rss.items.each do |item|
      puts "Importing '#{item.title}'"
      post = Import.create_post(item)
      if post.nil?
        puts "Not a valid post"
      elsif (post.save())
        puts "Import successful"
      else
        puts "Import failed"
      end
    end
  end

end
