<?php

/**
 * GenericDataHelperAbstract
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-20: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.data.helpers
 * @subpackage GenericDataHelperAbstract
 */

abstract class GenericDataHelperAbstract {
  
  /**
   * @var Core
   */
  protected $core;
    
  /**
   * @var GenericElementAbstract
   */
  protected $objElement;
  
  /**
   * Constructor
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');    
  }
  
  /**
   * setElement
   * @param GenericElementAbstract $objElement
   */
  public function setElement(GenericElementAbstract &$objElement){
    $this->objElement = $objElement;
  }
}

?>