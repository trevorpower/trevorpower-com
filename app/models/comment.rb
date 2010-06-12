class Comment
  include MongoMapper::EmbeddedDocument

  key :name, String
  key :url, String
  key :email, String
  key :body, String
  key :published_at, Date
  key :spam, Boolean
  key :published, Boolean

  belongs_to :post

end
