class Post
  include MongoMapper::Document


  key :title, String
  key :slug, String
  key :body, String
  key :published, Boolean
  key :published_on, Date

  # this dom thing is not nice here in my model, must find a better place for it
  def dom_id
    slug
  end

end
