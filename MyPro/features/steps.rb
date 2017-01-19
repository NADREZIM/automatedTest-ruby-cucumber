Given(/^I am on "([^"]*)" page$/) do |path_to|
  visit path_to
end

When(/^I type "([^"]*)" in search field$/) do |string_search|
  TXT_SEARCH = ".//*[@id='masthead-search-term']"
  BTN_SEARCH = ".//*[@id='search-btn']"

  find(:xpath,TXT_SEARCH).set string_search
  find(:xpath,BTN_SEARCH).click
end

Then(/^I should see "([^"]*)" in result$/) do |string_expectation|
  page.should have_content  string_expectation
end