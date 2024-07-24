@mod @mod_subsection
Feature: Teachers can rename subsections
  In order to change subsections name
  As an teacher
  I need to sync subsection and activity names

  Background:
    Given I enable "subsection" "mod" plugin
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category | numsections |
      | Course 1 | C1        | 0        | 2           |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And the following "activities" exist:
      | activity   | name         | course | idnumber | section |
      | subsection | Subsection activity  | C1     | forum1   | 1       |
      | data       | Subactivity | C1     | data1    | 3       |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage with editing mode on

  @javascript
  Scenario: Renaming the subsection activity changes the subsection name
    Given I should see "Subsection activity" in the "page-content" "region"
    When I set the field "Edit title" in the "Subsection activity" "activity" to "New name"
    And I should not see "Subsection activity" in the "region-main" "region"
    And I should see "New name" in the "page-content" "region"
    Then I click on "New name" "link" in the "page-content" "region"
    And I should see "New name" in the "page" "region"
    And I should see "Subactivity" in the "region-main" "region"

  Scenario: Renaming the activity using the settings form rename the subsection name
    Given I should see "Subsection activity" in the "page-content" "region"
    When I click on "Edit settings" "link" in the "Subsection activity" "activity"
    And I set the following fields to these values:
      | Name        | New name |
    And I press "Save and display"
    Then I should see "New name" in the "page" "region"
    And I should see "Subactivity" in the "region-main" "region"
    And I am on "Course 1" course homepage
    And I should see "New name" in the "page-content" "region"

  @javascript
  Scenario: Renaming the subsection renames the subsection activity name
    Given I click on "Subsection activity" "link" in the "page-content" "region"
    And I should see "Subsection activity" in the "page" "region"
    And I should see "Subactivity" in the "region-main" "region"
    When I set the field "Edit section name" in the "page" "region" to "New name"
    Then I should see "New name" in the "page" "region"
    And I am on "Course 1" course homepage
    And I should see "New name" in the "page-content" "region"
