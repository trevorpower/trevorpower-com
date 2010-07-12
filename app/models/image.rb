class Image

  attr :name

  def initialize(name)
    @name = name
  end
  
  def url
    "http://staticimagelocation.example.com/dir/" + @name
  end

  def dom_id
    @name
  end

  def id
    @name
  end

end
