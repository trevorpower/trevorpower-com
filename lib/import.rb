require 'open-uri'
require 'uri'
require 'nokogiri'

class Import
  
  def self.get_body(content)
    html = Nokogiri::HTML(content)
    html.xpath("//img").each do |img|
      src = img['src']
      puts "\tProcessing image: #{src}"
      url = URI.parse(src)
      image = Image.from_original_name(File.basename(url.path))
      image.store(open(src))
      img.set_attribute('src', image.url)
    end
    body = html.xpath("/html/body").first
    body.nil? ? '' : body.inner_html
  end
  
  def self.create_post(item)
    post = Post.new
    post.title = item.xpath('title').first.content
    post.body = get_body(item.xpath('content:encoded').first.content)
    post.published_on = item.xpath('pubDate').first.content
    post.tags = item.xpath("category[@domain='tag']").map{|tag| tag.content}
    item.xpath("wp:comment").each do |comment|
      post.comments.build({
        :body => comment.xpath('wp:comment_content').first.content,
        :name => comment.xpath('wp:comment_author').first.content,
        :email => comment.xpath('wp:comment_author_email').first.content,
        :url => comment.xpath('wp:comment_author_url').first.content,
        :published_on => comment.xpath('wp:comment_date').first.content,
        :published => false
      })
    end
    post
  end
  
  def self.import_posts_from_rss(data)
    rss = Nokogiri::XML(data)
    rss.xpath("//item[wp:post_type='post']").each do |item|
      puts "Importing '#{item.xpath('title').first.content}'"
      post = Import.create_post(item)
      if (post.save())
        puts "Import successful"
      else
        puts "Import failed"
      end
    end
  end

end
