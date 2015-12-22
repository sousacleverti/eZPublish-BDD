<?php

namespace BDDTestBundle\Features\Context;

use EzSystems\PlatformUIBundle\Features\Context\PlatformUI;
use Behat\Gherkin\Node\TableNode;

class Languages extends PlatformUI {

    /**
     * @Given I click on the button :button
     */
    public function iClickButton($button) {
        $this->clickElementByText($button, 'button');
    }

    /**
     * @Given I click on the link :link
     */
    public function iClickLink($link) {
        $this->clickElementByText($link, 'a');
    }

    /**
     * @Then I should see the newly created language with:
     */
    public function iSeeTheLanguage(TableNode $fields) {
        foreach ($fields as $field) {
            $languageName = $field['Language name'];
            $languageCode = $field['Language code'];
            $isEnabled = $field['Enabled'];
        }
        $isEnabled = filter_var($isEnabled, FILTER_VALIDATE_BOOLEAN);

        $tableRow = $this->getElementContainsText($languageName, '.ez-selection-table-row');
        $tableCols = $tableRow->findAll('css', 'td');

        if($languageName != $tableCols[0]->getText() ||
           $languageCode != $tableCols[1]->getText() ||
           //$isEnabled != $tableCols[3]->isChecked()) { // WTF???? _> returns false when the checkbox is checked...
           $isEnabled != ($tableCols[3]->getAttribute('checked') == null)) {
            throw new \Exception("Language '$languageName' couldn't be created!");
        }
    }
}
