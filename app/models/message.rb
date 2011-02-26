class Message 
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :address, :subject, :body
  
  validates_length_of :name, :in => 4..100
  validates_length_of :body, :maximum => 2000
  validates_presence_of :name, :address, :subject
  validates_format_of :address, :with => /([a-z0-9_.-]+)@([a-z0-9-]+)\.[a-z.]+/i

  def persisted?
    false
  end
end
