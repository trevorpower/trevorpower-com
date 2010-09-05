class Image

  attr :name

  def initialize(key)
    @name = key
  end
  
  def self.from_original_name(original_name)
    Image.new(create_slug(original_name))
  end
  
  def dom_id
    @name
  end 

  def self.create_slug(title)
    title.downcase.gsub /[^a-zA-Z0-9\.]/, '-'
  end
end

