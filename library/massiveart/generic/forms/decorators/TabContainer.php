<?php

/**
 * Form_Decorator_TabContainer
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-07-22: Florian Mathis
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

class Form_Decorator_TabContainer extends Zend_Form_Decorator_Fieldset {

  protected $_helper = 'tabcontainer';

	public function getHelper() {
	  if (null !== ($helper = $this->getOption('helper'))) {
	    $this->setHelper($helper);
	    $this->removeOption('helper');
	  }
    return $this->_helper;
	}

  /**
   * Render a region
   *
   * @param  string $content
   * @return string
   */
  public function render($content) {
    $form    = $this->getElement();
    $view    = $form->getView();

    if(null === $view){
      return $content;
    }

    $helper        = $this->getHelper();
    $attribs       = $this->getOptions();
    $name          = $form->getFullyQualifiedName();
    $attribs['id'] = $form->getId();

    if(count($form->getSubForms()) > 1){
      $strTab = '
        <div class="tabNavContainer">
          <ul>';
      $intCounter = 0;
      $strScriptAddon = '';
      foreach($form->getSubForms() as $objSubForm){
        $intCounter++;

        $strSelected = '';
        if($intCounter == 1){
          $strSelected = ' selected';
          $strScriptAddon = 'myForm.setActiveTab('.$objSubForm->getId().');';
        }

        $strTab .= '
            <li id="tabNavItem_'.$objSubForm->getId().'" class="item'.$strSelected.'" onclick="myForm.selectTab('.$objSubForm->getId().'); return false;">
              <div class="start"></div>
              <div class="middle"><a href="#">'.$objSubForm->getTitle().'</a></div>
              <div class="end"></div>
            </li>';
      }

      $strTab .= '
          </ul>
        </div>
        <script type="text/javascript">//<![CDATA[
          '.$strScriptAddon.'
        //]]>
        </script>';

      $content = $strTab.$content;
    }

    return $content;
  }
}

?>