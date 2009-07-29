<?php

/**
 * Form_Element_SelectTree
 * 
 * MultiCheckboxTree form element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-19: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.elements
 * @subpackage Form_Element_SelectTree
 */

class Form_Element_SelectTree extends FormElementMultiAbstract {
  
  /**
   * Use formSelectTree view helper by default
   * @var string
   */
  public $helper = 'formSelectTree';
  
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