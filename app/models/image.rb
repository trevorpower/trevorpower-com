class Image

  attr :name

  def initialize(name)
    @name = name
  end
  
  def dom_id
    @name
  end

end
