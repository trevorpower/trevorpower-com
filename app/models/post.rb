class Post
  include MongoMapper::Document


  key :title, String
  key :slug, String
  key :body, String
  key :published, Boolean
  key :published_on, Date

end
