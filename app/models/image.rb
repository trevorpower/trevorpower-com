class Image

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
    Post.create_slug(@name)
  end

  alias to_param slug

end
