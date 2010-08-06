class Image
  include S3ImageStore

  attr :name

  def initialize(name)
    @name = name
  end
  
  def url
    "/uploaded_images/#{Rails.env}/" + @name
  end

  def dom_id
    @name
  end

  def id
    @name
  end

  def slug
    name
  end

end
