<?php

/**
 * Form_Element_MultiCheckboxTree
 * 
 * MultiCheckboxTree form element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-04: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.elements
 * @subpackage Form_Element_MultiCheckboxTree
 */

class Form_Element_MultiCheckboxTree extends FormElementMultiAbstract {
	
  /**
   * Use formMultiCheckbox view helper by default
   * @var string
   */
  public $helper = 'formMultiCheckboxTree';
  
  /**
   * MultiCheckbox is an array of values by default
   * @var bool
   */
  protected $_isArray = true;	
  
  /**
   * Is the value provided valid?
   *
   * Autoregisters InArray validator if necessary.
   *
   * @param  string $value
   * @param  mixed $context
   * @return bool
   */
  public function isValid($value, $context = null){
    if($this->registerInArrayValidator()){
      if (!$this->getValidator('InArray')){
        $multiOptions = $this->getMultiOptions();
        $options      = array();

        foreach($multiOptions as $opt_value => $opt_label){
          $options[] = $opt_value;
        }

        $this->addValidator('InArray', true, array($options));
      }
    }
    return parent::isValid($value, $context);
  }
}

?>