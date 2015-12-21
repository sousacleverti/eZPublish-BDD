<?php

namespace BDDTestBundle\Features\Context;

use EzSystems\PlatformUIBundle\Features\Context\PlatformUI;
use eZ\Publish\API\Repository\Values\Content\Query;
use eZ\Publish\API\Repository\Values\Content\Query\Criterion;
//use EzSystems\BehatBundle\Helper\EzAssertion;
use Behat\Gherkin\Node\TableNode;

class ContentActions extends PlatformUI {

    private function goToLocationTab($content) {
        $this->clickNavigationZone('Content');
        $this->clickElementByText('Content structure', '.ez-navigation-item');
        $this->clickOnTreePath($content);
        $this->clickElementByText('Locations', '.ez-tabs-label');
        $this->waitWhileLoading();
    }

    //    /**
    //    * @Given I add the location :location to the content :content
    //    */
    //    public function addLocation($location, $content) {
    //        $this->clickNavigationZone('Content');
    //        $this->clickElementByText('Content structure', '.ez-navigation-item');
    //        $this->clickOnTreePath($content);
    //        $this->clickElementByText('Locations', '.ez-tabs-label');
    //        $this->clickElementByText('Add location', 'button');
    //        $this->selectFromUniversalDiscovery($location);
    //        $this->clickElementByText('Choose this content', 'button');
    //        $this->clickElementByText('Confirm selection', 'button');
    //    }

    /**
     * @Given I add the folder :folder as location to the article :article
     */
    public function addLocation($folder, $article) {
        $repository = $this->getRepository();
        $searchService = $repository->getSearchService();
        $criterion = new Criterion\LogicalAnd(
            array(
                new Criterion\ContentTypeIdentifier("folder"),
                new Criterion\Field("name", Criterion\Operator::EQ, $folder)
            )
        );
        $query = new Query();
        $query->query = $criterion;
        $searchResult = $searchService->findContent($query);
        $folderContent = $searchResult->searchHits[0]->valueObject;
        $criterion = new Criterion\LogicalAnd(
            array(
                new Criterion\ContentTypeIdentifier("article"),
                new Criterion\Field("title", Criterion\Operator::EQ, $article)
            )
        );
        $query->query = $criterion;
        $searchResult = $searchService->findContent($query);
        $articleContent = $searchResult->searchHits[0]->valueObject;

        $repository->sudo(function() use($repository, $folderContent, $articleContent) {
            $contentService = $repository->getContentService();
            $locationService = $repository->getLocationService();
            $folderContentInfo = $contentService->loadContentInfo($folderContent->id);
            $locationCreateStruct = $locationService->newLocationCreateStruct($folderContentInfo->mainLocationId);
            $articleContentInfo = $contentService->loadContentInfo($articleContent->id);
            $newLocation = $locationService->createLocation($articleContentInfo, $locationCreateStruct);
        });
    }
    /**
     * @Given I change the content :content main location to the path :newPath
     */
    public function changeContentMainLocation($content, $newPath) {
        $this->goToLocationTab($content);
        $table = $this->getSession()->getPage()->findAll('css', '.ez-locations-list-table tr');
        $newPath = str_replace('/', ' ', $newPath);
        foreach ($table as $t) {
            $path = $t->find('css', '.ez-breadcrumbs-list');
            if ($path) {
                if ($path->getText() == $newPath) {
                    $radioButton = $t->find('css', ".ez-main-location-radio");
                    $radioButton->click();
                    $this->waitWhileLoading();
                    $this->clickElementByText('Confirm', 'button');
                    break;
                }
            }
        }
    }

    /**
     * @Then I verify that the main location of the content :content is :newPath
     */
    public function verifyContentMainLocation($content, $newPath) {
        $this->goToLocationTab($content);
        $table = $this->getSession()->getPage()->findAll('css', '.ez-locations-list-table tr');
        $newPath = str_replace('/', ' ', $newPath);
        foreach ($table as $t) {
            $path = $t->find('css', '.ez-breadcrumbs-list');
            if ($path) {
                if ($path->getText() == $newPath) {
                    $radioButton = $t->find('css', ".ez-main-location-radio");
                    if(!$radioButton->isChecked()) {
                        throw new \Exception("Content '$content' doesn't have the correct main location!");
                    }
                    break;
                }
            }
        }
    }

    /*
     * Functions used at:
     * https://github.com/miguelcleverti/PlatformUIBundle/blob/master/Features/Context/SubContext/CommonActions.php
     */
}
