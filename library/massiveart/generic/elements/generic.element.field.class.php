<?php

/**
 * GenericElementField
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-20: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.elements
 * @subpackage GenericElementField
 */

require_once(dirname(__FILE__).'/generic.element.abstract.class.php');

class GenericElementField extends GenericElementAbstract {
  
  /**
   * mixed value of the element field
   * @var mixed
   */
  protected $value = null;
  
  
  /**
   * mixed value of the element field
   * @var array
   */
  protected $instanceValues = array();
  
  /**
   * setValue
   * @param mixed $value
   */
  public function setValue($value){    
    $this->value = $value;
  }

  /**
   * getValue
   * @param mixed $value
   */
  public function getValue(){
    return ((is_null($this->value)) ? $this->defaultValue : $this->value);
  }
  
  /**
   * setInstanceValue
   * @param integer $intRegionInstanceId
   * @param mixed $value
   */
  public function setInstanceValue($intInstanceId, $value){
    $this->instanceValues[$intInstanceId] = $value;
  }
  
  /**
   * getInstanceValue
   * @param integer $intRegionInstanceId
   * @param mixed $value
   */
  public function getInstanceValue($intInstanceId){
    if(array_key_exists($intInstanceId, $this->instanceValues)){
      return $this->instanceValues[$intInstanceId];  
    }else{
      return $this->defaultValue;
    }
  }
}

?>