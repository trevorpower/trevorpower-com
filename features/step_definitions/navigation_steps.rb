module Webrat
  class Link < Element
    def http_method
      if !@element["data-method"].blank?
        @element["data-method"]
      elsif !onclick.blank? && onclick.include?("f.submit()")
        http_method_from_js_form
      else
        :get
      end
    end
  end
end

Then /^I should see a link to "([^\"]*)"$/ do |url|
  response.body.should have_xpath "//a[@href = '#{url}']"
end

Then /^I should see \"([^"]*)" for (.*) whose (.*) is "([^\"]*)"$/ do |whatyoushouldsee, class_name, var_name, value|
  unless var_name == "id" then
    id = (eval("\"#{class_name}\".classify.constantize.find_by_#{var_name}(\"#{value}\").dom_id"))
  else
    id = value
  end
  within("*[id=#{id}]") do |content|
    regexp = Regexp.new(whatyoushouldsee)
    if content.respond_to? :should
      content.should contain(regexp)
    else
      assert_match(regexp, content)
    end
  end
end

When /^I (press|follow|check|uncheck|choose) "([^\"]*)" for (.*) whose (.*) is "([^\"]*)"$/ do |action, whatyouclick, class_name, var_name, value|
  unless var_name == "id" then
    id = (eval("\"#{class_name}\".classify.constantize.find_by_#{var_name}(\"#{value}\").dom_id"))
  else
    id = value
  end
  within("*[id=#{id}]") do
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

When /^I (press|follow|check|uncheck|choose) "([^\"]*)" for "([^\"]*)"$/ do |action, whatyouclick, id|
  within("*[id='#{id}']") do
    case action
      when "press"
        click_button(whatyouclick)
      when "follow"
        if (whatyouclick =~ /(Destroy)|(Delete)/i)
          click_link(whatyouclick, :method => 'delete')
        else
          click_link(whatyouclick)
        end
      when "check"
        check(whatyouclick)
      when "uncheck"
        uncheck(whatyouclick)
      when "choose"
        uncheck(whatyouclick)
    end
  end
end

Then /^I should see "([^"]*)" selected in the navigation bar$/ do |text|
  within(".ui-btn-active") do |content|
    content.should contain(text)
  end
end

