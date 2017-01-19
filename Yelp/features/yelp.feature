Feature: As a customer, I want to search something in Yelp

 Scenario: Search restaurants in Yelp
    Given I am on "https://www.yelp.com" page
    When I type "Restaurants" in search field
    Then I should see "Best Restaurants" in result
    When I type "Restaurants Pizza" in search field ones more
    Then Now I should see "Best Restaurants" in result
    And I record information about offers on current page and their general count and write it into report.txt file
    When I press All Filters
    Then I check in dropdown list "open_now" and "$"
    And I record information about filtered offers on current page and their general count and write it into report.txt file
    And On current page I receive star rating of each offer and write it into report.txt file
    When I click on the "1." offer in the top of the page
    Then I write all main information: address, phone, restaurant home page and first three comments