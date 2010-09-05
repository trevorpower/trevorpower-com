class Comment
  include MongoMapper::Document

  key :name, String, :required => true
  key :url, String
  key :email, String, :required => true
  key :body, String, :required => true
  key :published_on, Date, :default => Date.today
  key :published, Boolean, :default => true

  key :post_title, String
  key :post_id, ObjectId

  belongs_to :post

  # this dom thing is not nice here in my model, must find a better place for it
  def dom_id
    "comment" + _id.to_s
  end

end
