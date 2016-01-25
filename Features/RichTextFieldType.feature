Feature: Test the validations done on fields from PlatformUI - rich text fieldtype
  In order to validate the rich text fieldtype
  As an Editor user
  I need to be able to create and update content with rich text fieldtypes

  Background:
    Given I am logged in as an 'Administrator' in PlatformUI

    ##
    # Validate the existence of expected fields from a field type when creating a content
    ##
  @javascript @pass @1
  Scenario: A Content of a Content Type that has a rich text fieldtype must have a text field
    Given a Content Type with a "rich text" Field exists
    When I create a content of this type
    Then I should see a "rich text" field

  @javascript @pass @2
  Scenario: When editing a Content, the label of a rich text field must have the same name than field type from the respective Content Type
    Given a Content Type with a "rich text" with field definition name "Test text" exists
    When I create a content of this type
    Then I should see a "Test text" label related with the "rich text" field

  @javascript @pass @3
  Scenario: The label of a required rich text field of a Content must be marked as required
    Given a Content Type with a required "rich text" with field definition name "Required" exists
    When I create a content of this type
    And I publish the content
    Then the "Required" field should be marked as required

    ##
    # Creating Content using a Content Type that has a rich text Field Type
    ##
  @javascript @pass @4
  Scenario: Creating a rich text Field works
    Given a Content Type with a "rich text" Field exists
    When I create a content of this type
    And I set the field value with:
            """
            First line rich text test
            Second line rich text test
            """
    And I publish the content
    Then the Content is successfully published

  @javascript @pass @5
  Scenario: Creating a rich text Field with an empty value works
    Given a Content Type with a "rich text" Field exists
    When I create a content of this type
    And I set an empty value as the Field Value
    And I publish the content
    Then the Content is successfully published

  @javascript @pass @6
  Scenario: Creating a required rich text Field fails validation when using an empty value
    Given a Content Type with a required "rich text" Field exists
    When I create a content of this type
    And I set an empty value as the Field Value
    And I publish the content
    Then Publishing fails with validation error message "This field is required"

  @javascript @fail @1
  Scenario: Creating a valid rich text Field works when using a value below the row number limit
    Given a Content Type with a "rich text" Field exists with Properties:
      | Validator                     | Value |
      | number of text rows validator | 3     |
    When I create a content of this Type
    And I set the field value with:
            """
            First line rich text test
            Second line rich text test
            Third line rich text test
            """
    And I publish the content
    Then the Content is successfully published

  @javascript @fail @2
  Scenario: Creating an invalid rich text Field fails validation when using a value above the row number limit
    Given a Content Type with a "rich text" Field exists with Properties:
      | Validator                     | Value |
      | number of text rows validator | 3     |
    When I create a content of this Type
    And I set the field value with:
            """
            First line rich text test
            Second line rich text test
            Third line rich text test
            Fourth line rich text test
            """
    And I publish the content
    Then Publishing fails with validation error message "The value should have at most 3 rows"

  @javascript @edge
  Scenario: Creating an invalid content type with a rich text Field fails when using a row number limit of zero
    Given I am on the "Content types" page
    And I click in the "Content" Content type group
    When I click at "Create a content type" button
    And I fill form with:
      | Field      | Value |
      | Name       | Test1 |
      | Identifier | test1 |
    And I add a field type "Rich text" with:
      | Field               | Value |
      | Name                | Text  |
      | Identifier          | text  |
      | Number of text rows | 0     |
    And I click at "OK" button
    Then Publishing fails with validation error message "Form did not validate. Please review errors below."

  @javascript @edge
  Scenario: Creating an invalid content type with a rich text Field fails when using a negative row number limit
    Given I am on the "Content types" page
    And I click in the "Content" Content type group
    When I click at "Create a content type" button
    And I fill form with:
      | Field      | Value |
      | Name       | Test2 |
      | Identifier | test2 |
    And I add a field type "Rich text" with:
      | Field               | Value |
      | Name                | Text  |
      | Identifier          | text  |
      | Number of text rows | -1    |
    And I click at "OK" button
    Then Publishing fails with validation error message "Form did not validate. Please review errors below."

    ##
    # Create Content using a Content Type that has a rich text Field Type and use the rich text Field controls
    ##
  @javascript @run
  Scenario: Creating a content with a rich text Field with center aligned text works
    Given a Content Type with a "rich text" Field exists
    When I create a content of this type
    And I set the rich text field value with:
          """
          Test the Remove button
          """
    And I click on "Remove" button
    And I publish the content
    When I view this Content
    Then I should see a field with value "This field is empty"

  @javascript
  Scenario: Creating a content with a rich text Field with center aligned text works
    Given a Content Type with a "rich text" Field exists
    When I create a content of this type
    And I set the rich text field value with:
          """
          Center align rich text test
          """
    And I click on "Center" button
    And I publish the content
    Then I should see a field with value "Center align rich text test" aligned to "center"

    ##
    # Update Content using a Content Type that has a rich text Field Type
    ##
  @javascript @pass @7
  Scenario: Updating a rich text field using a rich text Field works
    Given a Content Type with a "rich text" Field exists
    And a Content of this type exists
    When I edit this content
    And I set "Test text update" as the Field Value
    And I publish the content
    Then the Content is successfully published

  @javascript @pass @8
  Scenario: Updating a rich text Field with an empty value works
    Given a Content Type with a "rich text" Field exists
    When I create a content of this type
    And I set an empty value as the Field Value
    And I publish the content
    Then the Content is successfully published

  @javascript @fail @3
  Scenario: Creating a valid rich text Field works when using a value below the row number limit
    Given a Content Type with a "rich text" Field exists with Properties:
      | Validator                     | Value |
      | number of text rows validator | 3     |
    When I edit this content
    And I set the field value with:
            """
            First line rich text test
            Second line rich text test
            Third line rich text test
            """
    And I publish the content
    Then the Content is successfully published

  @javascript @fail @4
  Scenario: Creating an invalid rich text Field fails validation when using a value above the row number limit
    Given a Content Type with a "rich text" Field exists with Properties:
      | Validator                     | Value |
      | number of text rows validator | 3     |
    When I edit this content
    And I set the field value with:
            """
            First line rich text test
            Second line rich text test
            Third line rich text test
            Fourth line rich text test
            """
    And I publish the content
    Then Publishing fails with validation error message "The value should have at most 3 rows"

  @javascript @fail @5
  Scenario: Updating a required rich text Field fails validation when using an empty value
    Given a Content Type with a required "rich text" Field exists
    And a Content of this type exists
    When I edit this content
    And I set an empty value as the Field Value
    And I publish the content
    Then Publishing fails with validation error message "This field is required"

    ##
    # Viewing content that has a rich text fieldtype
    ##
  @javascript @pass @9
  Scenario: Viewing a Content that has a rich text fieldtype should show the expected value when the value is plausible
    Given a Content Type with a "rich text" Field exists
    And a Content of this type exists with "rich text" Field Value set to "Test text"
    When I view this Content
    Then I should see a field with value "Test text"

  @javascript @pass @10
  Scenario: Viewing a Content that has a rich text fieldtype should return "This field is empty" when the value is empty
    Given a Content Type with a "rich text" Field exists
    And a Content of this type exists with "rich text" Field Value set to empty
    When I view this Content
    Then I should see a field with value "This field is empty"
