
Feature: Test the validations done on fields from PlatformUI - isbn fieldtype
    In order to validate the isbn fieldtype
    As an Editor user
    I need to be able to create and update content with isbn fieldtype

    Background:
        Given I am logged in as an Editor in PlatformUI

    ##
    # Validate the existence of expected fields from a field type when creating a content
    ##
    @javascript
    Scenario: A Content of a Content Type that has isbn fieldtype must have an isbn field
        Given a Content Type with an "isbn" Field exists
        When I create a content of this type
        Then I should see an "isbn" field

    @javascript
    Scenario: When editing a Content the label of an isbn field must have the same name than field type from the respective Content Type
        Given a Content Type with an "isbn" with field definition name "ISBN" exists
        When I create a content of this type
        Then I should see an "ISBN" label related with the "isbn" field

    @javascript
    Scenario: The label of a required isbn field of a Content must be marked as required
        Given a Content Type with a required "isbn" with field definition name "Required" exists
        When I create a content of this type
        Then the "Required" field should be marked as required

    ##
    # Creating Content using a Content Type that has an isbn Field Type
    @javascript @run
    Scenario: Creating a required isbn Field fails validation when using an empty value
        Given a Content Type with a required "isbn" field exists
        When I create a content of this type
        And I set an empty value as the Field Value
        And I publish the content
        Then Publishing fails with validation error message "This field is required"

    ##
    # Creating Content using a Content Type that has an isbn Field Type with ISBN-13 format
    ##
    @javascript
    Scenario: Creating a valid isbn Field works with ISBN-13 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value |
            | isISBN13 validator | true  |
        When I create a content of this type
        And I set "978-8087888247" as the Field Value
        And I publish the content
        Then the Content is successfully published

    @javascript
    Scenario: Creating an invalid isbn Field fails validation when using an invalid ISBN-13 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value |
            | isISBN13 validator | true  |
        When I create a content of this type
        And I set "8087888243" as the Field Value
        And I publish the content
        Then Publishing fails with validation error message "This is not a correct ISBN13 pattern"

    @javascript
    Scenario: Creating an isbn Field with an empty value works with ISBN-13 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value |
            | isISBN13 validator | true  |
        When I create a content of this type
        And I set an empty value as the Field Value
        And I publish the content
        Then the Content is successfully published

    ##
    # Update Content using a Content Type that has an isbn Field Type
    ##
    @javascript
    Scenario: Updating a required isbn Field fails validation when using an empty value with ISBN-13 format
        Given a Content Type with a required "isbn" field exists
        When I edit this content
        And I set an empty value as the Field Value
        And I publish the content
        Then Publishing fails with validation error message "This field is required"

    ##
    # Update Content using a Content Type that has an isbn Field Type with ISBN-13 format
    ##
    @javascript
    Scenario: Updating to a valid isbn Field works with ISBN-13 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value |
            | isISBN13 validator | true  |
        When I edit this content
        And I set "978-8087888247" as the Field Value
        And I publish the content
        Then the Content is successfully published

    @javascript
    Scenario: Updating an invalid isbn Field fails validation when using an invalid ISBN-13 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value |
            | isISBN13 validator | true  |
        When I edit this content
        And I set "8087888243" as the Field Value
        And I publish the content
        Then Publishing fails with validation error message "This is not a correct ISBN13 pattern"

    ##
    # Viewing content that has an isbn Field Type with ISBN-13 format
    ##
    @javascript
    Scenario: Viewing a Content that has an isbn fieldtype should show the expected value with ISBN-13 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value |
            | isISBN13 validator | true  |
        And a Content of this type exists with "isbn" Field Value set to "978-8087888247"
        When I view this Content
        Then I should see a field with value "978-8087888247"

    @javascript
    Scenario: Viewing a Content that has an isbn fieldtype should return "This field is empty" when the value is empty with ISBN-13 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value |
            | isISBN13 validator | true  |
        And a Content of this type exists with "isbn" Field Value set to empty
        When I view this Content
        Then I should see a field with value "This field is empty"

    ##
    # Creating Content using a Content Type that has an isbn Field Type with ISBN-10 format
    ##
    @javascript @run
    Scenario: Creating a valid isbn Field works with ISBN-10 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value  |
            | isISBN13 validator | false  |
        When I create a content of this type
        And I set "8087888243" as the Field Value
        And I publish the content
        Then the Content is successfully published

    @javascript @run
    Scenario: Creating an invalid isbn Field fails validation when using an invalid ISBN-10 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value  |
            | isISBN13 validator | false  |
        When I create a content of this type
        And I set "978-8087888247" as the Field Value
        And I publish the content
        Then Publishing fails with validation error message "This is not a correct ISBN10 pattern"

    @javascript @run
    Scenario: Creating an isbn Field with an empty value works with ISBN-10 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value  |
            | isISBN13 validator | false  |
        When I create a content of this type
        And I set an empty value as the Field Value
        And I publish the content
        Then the Content is successfully published

    ##
    # Update Content using a Content Type that has an isbn Field Type with ISBN-10 format
    ##
    @javascript @run
    Scenario: Updating to a valid isbn Field works with ISBN-10 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value  |
            | isISBN13 validator | false  |
        When I edit this content
        And I set "8087888243" as the Field Value
        And I publish the content
        Then the Content is successfully published

    @javascript @run
    Scenario: Updating an invalid isbn Field fails validation when using an invalid ISBN-10 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value  |
            | isISBN13 validator | false  |
        When I edit this content
        And I set "978-8087888247" as the Field Value
        And I publish the content
        Then Publishing fails with validation error message "This is not a correct ISBN10 pattern"

    ##
    # Viewing content that has an isbn Field Type with ISBN-13 format
    ##
    @javascript @run
    Scenario: Viewing a Content that has an isbn fieldtype should show the expected value with ISBN-10 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value  |
            | isISBN13 validator | false  |
        And a Content of this type exists with "isbn" Field Value set to "8087888243"
        When I view this Content
        Then I should see a field with value "8087888243"

    @javascript @run
    Scenario: Viewing a Content that has an isbn fieldtype should return "This field is empty" when the value is empty with ISBN-10 format
        Given a Content Type with an "isbn" Field exists with Properties:
            | Validator          | Value  |
            | isISBN13 validator | false  |
        And a Content of this type exists with "isbn" Field Value set to empty
        When I view this Content
        Then I should see a field with value "This field is empty"