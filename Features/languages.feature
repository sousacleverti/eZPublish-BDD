Feature: Create a new language

    @javascript @run
    Scenario: I want to create a new language in Administration dashboard
        Given I go to PlatformUI app with username "admin" and password "publish"
        And I click on the navigation zone "Admin Panel"
        And I click on the navigation item "Languages"
        And I click on the link "Create a new language"
        When I fill in "Name" with "NewLanguageTest"
        And I fill in "Language code" with "NLT"
        And I check "Enabled" checkbox
        And I click on the button "Save"
        And I click on the navigation item "Languages"
        Then I should see the newly created language with:
            | Language name   | Language code | Enabled |
            | NewLanguageTest | NLT           | true    |
