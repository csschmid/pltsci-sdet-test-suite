Feature: Contract Test
  Test api contract adherence

  Scenario: Required arguments are present
    Given I provide a "default" cleaning session request
    When I create a cleaning scenario
    Then I should see a "successful" response
    And The response should match "default"