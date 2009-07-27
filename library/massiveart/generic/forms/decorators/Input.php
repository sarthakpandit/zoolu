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

class Form_Decorator_Input extends Zend_Form_Decorator_Abstract {
	
	/**
	 * @var Core
	 */
	private $core;
	
  /**
   * Constructor 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function __construct($options = null){        
    $this->core = Zend_Registry::get('Core');
    parent::__construct($options);
  } 
	
	/**
	 * buildLabel
	 */
  public function buildLabel(){
    
  	$element = $this->getElement();
    $label = $element->getLabel();
    
    if (empty($label)){
      return '';
    }
    
    if ($element->isRequired()) {
      $label .= ' *';
    }
    
    return $element->getView()->formLabel($element->getName(), $label, array('class' => 'fieldtitle')).'<br/>';
  }
  
  /**
   * buildDescription
   */
  public function buildDescription(){
    $element = $this->getElement();
    $desc    = $element->getDescription();
    
    if (empty($desc)){
      return '';
    }
    
    return '<div class="description">'.$desc.'</div>';
  }
  
  /**
   * buildInput
   */
  public function buildInput(){
    
  	$element = $this->getElement();
    $helper  = $element->helper;
    
    switch ($helper){
      case 'form'.ucfirst(GenericSetup::FIELD_TYPE_TEXTEDITOR) :
        return $element->getView()->$helper($element->getName(), $element->getValue(), $element->getAttribs(), $element->options, $element->regionId);
      case 'form'.ucfirst(GenericSetup::FIELD_TYPE_INTERNALLINK) :              
        return $element->getView()->$helper($element->getName(), $element->getValue(), $element->getAttribs(), $element->options, $element);
      default:
        return $element->getView()->$helper($element->getName(), $element->getValue(), $element->getAttribs(), $element->options);
    }
  }
  
  /**
   * buildErrors
   */
  public function buildErrors(){
    
  	$element  = $this->getElement();
    $messages = $element->getMessages();
    
    if (empty($messages)){
      return '';
    }
    
    return '<div class="errors">'.$element->getView()->formErrors($messages).'</div>';
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
    
    /**
     * is empty element
     */
    $blnIsEmpty = false;
    if(array_key_exists('isEmptyField', $element->getAttribs()) && $element->getAttrib('isEmptyField') == 1){
      $blnIsEmpty = true;  
    }

    $separator = $this->getSeparator();
    $placement = $this->getPlacement();
    $label     = $this->buildLabel();
    $input     = $this->buildInput();
    $errors    = $this->buildErrors();
    $desc      = $this->buildDescription();
    
    $output = '<div class="field-'.$element->getAttrib('columns').'">';
    $output .= '<div class="field">'
                    .$label
                    .$desc
                    .$input
                    .$errors
              .'</div>';
    $output .= '</div>';
    
    if($element->isRegionTitle == 1){
      if($blnIsEmpty == true){
        $output .= '
        <script type="text/javascript">//<![CDATA[ 
          myForm.addRegionTitle(\''.$element->getName().'\', \''.$element->regionId.'\');         
        //]]>
        </script>';
      }else{
        $output .= '
        <script type="text/javascript">//<![CDATA[ 
          myForm.initRegionTitleObserver(\''.$element->getName().'\', \''.$element->regionId.$element->regionExtension.'\');         
        //]]>
        </script>';
      }  
    }

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