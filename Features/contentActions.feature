Feature: Change main location of a content
    @runnable
    @javascript
    Scenario: I want to change the main location of a content
        Given I go to PlatformUI app with username "admin" and password "publish"
        And a "LocationTestFolder" folder exists
        And an "LocationTestArticle" article exists
        And I add the folder "LocationTestFolder" as location to the article "LocationTestArticle"
        And I change the content "LocationTestArticle" main location to the path "eZ Platform/LocationTestFolder/LocationTestArticle"
        Then I verify that the main location of the content "LocationTestArticle" is "eZ Platform/LocationTestFolder/LocationTestArticle"


