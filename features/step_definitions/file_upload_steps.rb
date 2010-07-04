When /^I fill in file with name "([^"]*)" for "([^"]*)"$/ do |filename, field|
  fill_in(field, :with => File.join(RAILS_ROOT, 'features', 'upload_images', filename))
end

