Given(/^I am on "([^"]*)" page$/) do |path_to|
  visit path_to

end


When(/^I type "([^"]*)" in search field$/) do |string_search|
  TXT_SEARCH = "//input[@id='find_desc']"
  BTN_SEARCH = "//button[@id='header-search-submit']"
  find(:xpath, TXT_SEARCH).set string_search
  find(:xpath, BTN_SEARCH).click

end


Then(/^I should see "([^"]*)" in result$/) do |string_expectation|
  page.should have_content string_expectation
end


When(/^I type "([^"]*)" in search field ones more$/) do |string_search|
  find(:xpath, TXT_SEARCH).set string_search
  find(:xpath, BTN_SEARCH).click
end

Then(/^Now I should see "([^"]*)" in result$/) do |string_expectation|
  page.should have_content string_expectation

end

And(/^I record information about offers on current page and their general count and write it into report.txt file$/) do
  ref_amount = "//span[@class='pagination-results-window']"
  string_amount = find(:xpath, ref_amount).text
  all_offers_parsed_data = string_amount.match(/\-(\d*)\s.*\s(\d*)/)
  File.new('report.txt', 'w')
  File.open('report.txt', 'a') { |temp| temp.write "Current page offers amount:  " + all_offers_parsed_data[1] + "\n" }
  File.open('report.txt', 'a') { |temp| temp.write "Total request offers amount:  " + all_offers_parsed_data[2] + "\n" }
end

When (/^I press All Filters$/) do
  ALL_FILTERS_BUTTON = "//span[@class='filter-label all-filters-toggle show-tooltip']"
  find(:xpath, ALL_FILTERS_BUTTON).click
end

Then(/^I check in dropdown list "([^"]*)" and "([^"]*)"$/) do |features, price|
  FEATURES_DROP = "(//input[@value='"+features.to_s+"'])[2]"
  find(:xpath, FEATURES_DROP).set(true); sleep(5)

  PRISE_DROP = "//span[@class='filter-label'][contains(text(),'"+price.to_s+"')]/../input[@value='RestaurantsPriceRange2.1']"
  find(:xpath, PRISE_DROP).set(true); sleep(5)

end

And(/^I record information about filtered offers on current page and their general count and write it into report.txt file$/) do
  ref_amount = "//span[@class='pagination-results-window']"
  string_amount = find(:xpath, ref_amount).text
  filtered_offers_parsed_data = string_amount.match(/\-(\d*)\s.*\s(\d*)/)
  File.open('report.txt', 'a') { |temp| temp.write "current page filtered offers amount:  " + filtered_offers_parsed_data[1] + "\n" }
  File.open('report.txt', 'a') { |temp| temp.write "total request filtered offers amount:  " + filtered_offers_parsed_data[2] + "\n" }
  COUNT = filtered_offers_parsed_data[1].to_i
end


And(/^On current page I receive star rating of each offer and write it into report\.txt file$/) do
  i = 0
  loop do
    break if i >= COUNT
    i += 1
    star_value = find(:xpath, "//div[@data-key='"+i.to_s+"']/div/div/div/div[2]/div/div")['title']
    File.open('report.txt', 'a') { |temp| temp.write star_value + "\n" }
  end
end

When (/^I click on the "([^"]*)" offer in the top of the page$/) do |element|
  FIRST_ELEMENT = "//span[@class='indexed-biz-name'][contains(text(),'"+element.to_s+"')]/a"
  find(:xpath, FIRST_ELEMENT).click
  sleep(5)
end

Then(/^I write all main information: address, phone, restaurant home page and first three comments$/) do
  ADDRESS = "//div[@class='map-box-address u-space-l4']/strong/address"
  PHONE = "//span[@class='biz-phone']"
  SITE_HOME_PAGE = "//span[@class='biz-website js-add-url-tagging']/a"
  sleep(2)
  adress_text =  find(:xpath, ADDRESS).text
  File.open('report.txt', 'a'){|temp| temp.write "adsress: " + adress_text + "\n"}
  sleep(2)
  phone_text = find(:xpath, PHONE).text
  File.open('report.txt', 'a'){|temp| temp.write "phone: " + phone_text + "\n"}
  sleep(2)
  vis = page.has_xpath?(:xpath,"//span[@class='biz-website js-add-url-tagging']/a")
  if vis
  site_name_text = find(:xpath, SITE_HOME_PAGE).text
  File.open('report.txt', 'a'){|temp| temp.write "restaurant home page " + site_name_text + "\n"}
  end
  sleep(2)
  g = 0
  loop do
    g += 1
    break if g > 3
    comment = find(:xpath, "//li[@class='media-block media-block--12 review-highlight']["+g.to_s+"]/div[@class='media-story']/p[1]").text
    File.open('report.txt', 'a'){|temp| temp.write "comments: " + comment + "\n"}
  end

end