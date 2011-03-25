When /^I fill in file with name "([^"]*)" for "([^"]*)"$/ do |filename, field|
  fill_in(field, :with => File.join(::Rails.root.to_s, 'features', 'upload_images', filename))
end

Given /^the following images:$/ do |images|
  images.hashes.each do |hash|
    image = Image.new(hash["name"])
    File.open('tmp/' + hash["name"], "w+") do |file|
      image.store(file)
    end
  end
end
