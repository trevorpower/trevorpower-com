# Fix the issue between webrat 0.7.3 using "example.org" and rails 3.x using "example.com"
#Webrat::Session.class_eval do
    #def current_host
        #URI.parse(current_url).host || @custom_headers["Host"] || default_current_host
    #end

    #def default_current_host
        #adapter.class == Webrat::RackAdapter ? "example.org" : "www.example.com"
    #end
#end
# Necessary evil thing: Rack::Test sports as default host
# "example.org", but Webrat and Ruby on Rails's integration test
# classes use "example.com"; this discrepancy leads to Webrat not
# being able to follow simple internal redirects.
#
# Drop in in features/support/

module Rack
  module Test
    DEFAULT_HOST = "example.com"
  end
end
