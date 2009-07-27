<?php

/**
 * Form_Decorator_Input
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-23: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Form_Decorator_Hidden extends Zend_Form_Decorator_Abstract {
	
	/**
   * buildInput
   */
  public function buildInput(){
    
  	$element = $this->getElement();
    $helper  = $element->helper;
    
    return $element->getView()->$helper($element->getName(), $element->getValue(), $element->getAttribs(), $element->options);
  }
    
  /**
   * render
   */
  public function render($content){
    
  	$element = $this->getElement();
       
    if (!$element instanceof Zend_Form_Element) {
      return $content;
    }
        
    if (null === $element->getView()) {
      return $content;
    }

    $separator = $this->getSeparator();
    $placement = $this->getPlacement();
    $input     = $this->buildInput();    
    
    $output = $input;

    switch ($placement) {
      case (self::PREPEND):
        return $output . $separator . $content;
      case (self::APPEND):
      default:
        return $content . $separator . $output;
    }
  }
  
}

?>