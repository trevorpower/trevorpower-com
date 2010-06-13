class Comment
  include MongoMapper::Document

  key :name, String
  key :url, String
  key :email, String
  key :body, String
  key :published_at, Date
  key :spam, Boolean
  key :published, Boolean

  key :post_id, ObjectId

  belongs_to :post

end
