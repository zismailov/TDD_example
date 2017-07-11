Feature: Note Page

  In order to read other notes
  As a guest user
  I want to see public note

  Scenario: guest user sees public note
    Given I am a guest user
    Given there is a public note
    When I go to the note's page
    Then I must see note's content
