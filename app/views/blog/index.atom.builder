atom_feed do |feed|
  feed.title("Trevor Power's blog")
  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.body, :type => 'html')
      entry.author("Trevor Power")
    end
  end
end
