Feature: Alexa knows to list our offices

  Scenario: List offices
    Given we have offices "New York" and "Omaha"
    When I ask Alexa to list the offices
    Then it lists them correctly
