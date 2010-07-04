class Image
  include MongoMapper::EmbeddedDocument 

  key :name, String

  belongs_to :post
end
