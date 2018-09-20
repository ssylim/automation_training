@checkboxes
  Feature: Test the checkboxes page

    Scenario Outline: Click the first checkbox
      Given I visit the checkboxes page
      When I click on the checkbox <checkbox>
      Then the checkbox <checkbox> is <status>
      Examples:
        | checkbox | status   |
        | 1        | ticked   |
        | 2        | unticked |