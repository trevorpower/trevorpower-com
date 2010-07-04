class Image
  include MongoMapper::EmbeddedDocument 

  key :slug, String

  belongs_to :post
end
