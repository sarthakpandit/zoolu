<?php

/**
 * Form_Decorator_Region
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-07-22: Florian Mathis
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

class Form_Decorator_Tab extends Zend_Form_Decorator_Fieldset {

  protected $_helper = 'tab';

	public function getHelper(){
	  if(null !== ($helper = $this->getOption('helper'))){
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
    $form = $this->getElement();
    $view = $form->getView();

    if(null === $view){
      return $content;
    }

    $helper        = $this->getHelper();
    $attribs       = $this->getOptions();
    $name          = $form->getFullyQualifiedName();
    $attribs['id'] = $form->getId();

    $strHideTab = ($form->getHide() == true) ? ' style="display:none;"' : '';
    $strOutput = '<div class="tab" id="div'.$name.'"'.$strHideTab.'>'.$content.'</div>';
    return $strOutput;
  }
}

?>