Feature: See how an AOI relates to Protected Areas
  In order to see how my operations sites relate to PA's
  As a business/government geographic site owner/geographic site manager
  I want to define where my current operational sites are on a map

  @wip
  Scenario: Define a site by drawing a polygon
    Given I am a guest user
    And I visit the homepage
    When I draw a polygon
    Then I get information on the "location" of PA's the polygon covers
    And I get information on the "size" of PA's the polygon covers
    And I get information on the "amount" of PA's the polygon covers
