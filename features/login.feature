@login_page
  Feature: Test the login page

    Scenario: Login
      Given I visit the login page
      And I have input tomsmith as my username
      And I have input SuperSecretPassword! as my password
      When I click the login button
      Then I am logged into the secure area
