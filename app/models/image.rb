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
    CGI::escape name
  end

  alias to_param slug

end
