class Post
  include MongoMapper::Document

  scope :public, where(:published => true).sort(:published_on.desc)  

  many :comments

  key :title, String, :required => true
  key :slug, String, :required => true
  key :body, String, :required => true
  key :open_for_commenting, Boolean, :default => true
  key :published, Boolean, :default => false
  key :published_on, Date, :default => Date.today
  key :tags, Array

  after_save :update_comment_titles

  # this dom thing is not nice here in my model, must find a better place for it
  def dom_id
    slug
  end

  def self.create_slug(title)
    title.downcase.delete("'").gsub(/[^a-z0-9]+/, '-').gsub(/\A-|-\Z/, '')
  end

  def open_for_commenting?
    open_for_commenting
  end

  before_validation(:on => :create) do |post|
    post.slug = Post.create_slug(post.title)
  end

  private

  def update_comment_titles
    comments.each do |comment|
      comment.post_title = self.title
      comment.save
    end
  end

end
