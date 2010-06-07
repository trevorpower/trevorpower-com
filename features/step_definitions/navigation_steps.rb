Then /^I should see a link to "([^\"]*)"$/ do |url|
  response.body.should have_xpath "//a[@href = '#{url}']"
end

When /^I (press|follow|check|uncheck|choose) "([^\"]*)" for (.*) whose (.*) is "([^\"]*)"$/ do |action, whatyouclick, class_name, var_name, value|
  unless var_name == "id" then
    id = (eval("\"#{class_name}\".classify.constantize.find_by_#{var_name}(\"#{value}\").dom_id"))
  else
    id = value
  end
  within("tr[id=#{id}]") do
    case action
      when "press"
        click_button(whatyouclick)
      when "follow"
        click_link(whatyouclick)
      when "check"
        check(whatyouclick)
      when "uncheck"
        uncheck(whatyouclick)
      when "choose"
        uncheck(whatyouclick)
    end
  end
end
