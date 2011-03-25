class Message 
  include ActiveModel::Validations

  attr_accessor :id, :name, :address, :subject, :body
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      instance_variable_set "@#{name}", value
    end
    @attributes = attributes
  end
  def read_attribute_for_validation(key)
    @attributes[key]
  end
  def to_key
  end

  validates_length_of :name, :in => 4..100
  validates_length_of :body, :maximum => 2000
  validates_presence_of :name, :address, :subject
  validates :address, :format => { :with => /([a-z0-9_.-]+)@([a-z0-9-]+)\.[a-z.]+/i }

end
