# Load the rails application
require File.expand_path('../application', __FILE__)

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance|
html_tag }

# Initialize the rails application
Blog::Application.initialize!
