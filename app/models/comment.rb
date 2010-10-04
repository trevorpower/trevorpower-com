require 'uri'

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

  #validates_length_of :name, :in => 4..100
  #validates_length_of :body, :in => 4..2000
  validates_format_of :email, :with => /([a-z0-9_.-]+)@([a-z0-9-]+)\.[a-z.]+/i
  validates_format_of( :url, 
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix,
    :if => "!url.nil? && !url.empty?",
    :message => "The URL is invalid, it must start with 'http://'"
  )

  # this dom thing is not nice here in my model, must find a better place for it
  def dom_id
    "comment" + _id.to_s
  end

  def normalized_url
    unless url.nil?
      uri = URI.parse url
      uri.normalize.to_s
    end
  rescue
    nil 
  end
end
