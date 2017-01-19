Feature: As a customer, I want to search something in Youtube

  Scenario: Search something in Youtube
    Given I am on "https://www.youtube.com" page
    When I type "Install Cucumber Ruby Capybara" in search field
    Then I should see "Install Selenium Ruby Capybara step by step" in result