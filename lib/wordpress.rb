require "rss/2.0"

module RSS
  CONTENT_PREFIX = 'wp'
  CONTENT_URI = "http://wordpress.org/export/1.0/"

  module ContentModel
    extend BaseModel

    ELEMENTS = ["#{CONTENT_PREFIX}_post_type"]

    def self.append_features(klass)
      super

      klass.install_must_call_validator(CONTENT_PREFIX, CONTENT_URI)
      ELEMENTS.each do |full_name|
        name = full_name[(CONTENT_PREFIX.size + 1)..-1]
        klass.install_text_element(name, CONTENT_URI, "?", full_name)
      end
    end
  end

  prefix_size = CONTENT_PREFIX.size + 1
  ContentModel::ELEMENTS.each do |full_name|
    name = full_name[prefix_size..-1]
    BaseListener.install_get_text_element(CONTENT_URI, name, full_name)
  end
  
  Rss.install_ns(CONTENT_PREFIX, CONTENT_URI)

  class Rss
    class Channel
      class Item; include ContentModel; end
    end
  end
end
