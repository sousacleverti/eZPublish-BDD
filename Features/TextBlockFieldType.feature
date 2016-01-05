

Feature: Test the validations done on fields from PlatformUI - text block fieldtype
    In order to validate the text block fieldtype
    As an Editor user
    I need to be able to create and update content with text block fieldtypes

    Background:
       Given I am logged in as an 'Administrator' in PlatformUI

    ##
    # Validate the existence of expected fields from a field type when creating a content
    ##
    @javascript @pass
    Scenario: A Content of a Content Type that has a text block fieldtype must have a text field
        Given a Content Type with a "text block" Field exists
        When I create a content of this type
        Then I should see a "text block" field

    @javascript @pass
    Scenario: When editing a Content, the label of a text block field must have the same name than field type from the respective Content Type
        Given a Content Type with a "text block" with field definition name "Test text" exists
        When I create a content of this type
        Then I should see a "Test text" label related with the "text block" field

    @javascript @pass
    Scenario: The label of a required text block field of a Content must be marked as required
        Given a Content Type with a required "text block" with field definition name "Required" exists
        When I create a content of this type
        Then the "Required" field should be marked as required

    ##
    # Creating Content using a Content Type that has a text block Field Type
    ##
    @javascript @pass
    Scenario: Creating a text block Field works
        Given a Content Type with a "text block" Field exists
        When I create a content of this type
        And I set the field value with:
            """
            First line text block test
            Second line text block test
            """
        And I publish the content
        Then the Content is successfully published

    @javascript @pass
    Scenario: Creating a text block Field with an empty value works
        Given a Content Type with a "text block" Field exists
        When I create a content of this type
        And I set an empty value as the Field Value
        And I publish the content
        Then the Content is successfully published

    @javascript @pass
    Scenario: Creating a required text block Field fails validation when using an empty value
        Given a Content Type with a required "text block" Field exists
        When I create a content of this type
        And I set an empty value as the Field Value
        And I publish the content
        Then Publishing fails with validation error message "This field is required"

    @javascript @fail @run
    Scenario: Creating a valid text block Field works when using a value within limited row number scope
        Given a Content Type with a "text block" Field exists with Properties:
            | Validator                     | Value |
            | number of text rows validator | 3     |
        When I create a content of this Type
        And I set the field value with:
            """
            First line text block test
            Second line text block test
            Third line text block test
            """
        And I publish the content
        Then the Content is successfully published

    @javascript @fail
    Scenario: Creating an invalid text block Field fails validation when using a value bigger than maximum row number limit allowed
        Given a Content Type with a "text block" Field exists with Properties:
            | Validator                     | Value |
            | number of text rows validator | 3     |
        When I create a content of this Type
        And I set the field value with:
            """
            First line text block test
            Second line text block test
            Third line text block test
            Fourth line text block test
            """
        And I publish the content
        Then Publishing fails with validation error message "The value should have at most 3 rows"

    ##
    # Update Content using a Content Type that has a text block Field Type
    ##
    @javascript @pass
    Scenario: Updating a text block field using a text block Field works
        Given a Content Type with a "text block" Field exists
        And a Content of this type exists
        When I edit this content
        And I set "Test text update" as the Field Value
        And I publish the content
        Then the Content is successfully published

    @javascript @pass
    Scenario: Updating a text block Field with an empty value works
        Given a Content Type with a "text block" Field exists
        When I create a content of this type
        And I set an empty value as the Field Value
        And I publish the content
        Then the Content is successfully published

    @javascript @fail
    Scenario: Updating a valid text block Field works when using a value within limited row number scope
        Given a Content Type with a "text block" Field exists with Properties:
            | Validator                     | Value |
            | number of text rows validator | 3     |
        When I edit this content
        And I set the field value with:
            """
            First line text block test
            Second line text block test
            Third line text block test
            """
        And I publish the content
        Then the Content is successfully published

    @javascript @fail
    Scenario: Updating a text block Field fails validation when using a value bigger than maximum row number limit allowed
        Given a Content Type with a "text block" Field exists with Properties:
            | Validator                     | Value |
            | number of text rows validator | 3     |
        When I edit this content
        And I set the field value with:
            """
            First line text block test
            Second line text block test
            Third line text block test
            Fourth line text block test
            """
        And I publish the content
        Then Publishing fails with validation error message "The value should have at most 3 rows"

    @javascript @fail
    Scenario: Updating a required text block Field fails validation when using an empty value
        Given a Content Type with a required "text block" Field exists
        And a Content of this type exists
        When I edit this content
        And I set an empty value as the Field Value
        And I publish the content
        Then Publishing fails with validation error message "This field is required"

    ##
    # Viewing content that has a text block fieldtype
    ##
    @javascript @pass
    Scenario: Viewing a Content that has a text block fieldtype should show the expected value when the value is positive
        Given a Content Type with a "text block" Field exists
        And a Content of this type exists with "text block" Field Value set to "Test text"
        When I view this Content
        Then I should see a field with value "Test text"

    @javascript @pass
    Scenario: Viewing a Content that has a text block fieldtype should return "This field is empty" when the value is empty
        Given a Content Type with a "text block" Field exists
        And a Content of this type exists with "text block" Field Value set to empty
        When I view this Content
        Then I should see a field with value "This field is empty"
