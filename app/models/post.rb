class Post
  include MongoMapper::Document
  
  many :comments

  key :title, String, :required => true
  key :slug, String, :required => true
  key :body, String, :required => true
  key :published, Boolean, :default => false
  key :published_on, Date, :default => Date.today
  key :tags, Array

  before_validation_on_create :create_default_slug
  after_save :update_comment_titles

  # this dom thing is not nice here in my model, must find a better place for it
  def dom_id
    slug
  end

  def self.create_slug(title)
    title.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/\A-|-\Z/, '')
  end

  private

  def create_default_slug
    self.slug = Post.create_slug(self.title)
  end

  def update_comment_titles
    comments.each do |comment|
      comment.post_title = self.title
      comment.save
    end
  end

end
