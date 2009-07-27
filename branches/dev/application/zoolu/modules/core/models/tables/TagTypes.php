<?php

/**
 * Model_Table_Tag_Types
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-29: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Table_Tag_Types extends Zend_Db_Table_Abstract {
  
  protected $_name = '';
  protected $_primary = '';
    
  public function __construct($strType){
    $this->_name = 'tag'.((substr($strType, strlen($strType) - 1) == 'y') ? ucfirst(rtrim($strType, 'y')).'ies' : ucfirst($strType).'s');;    
    parent::__construct();    
    //FIXME : table must exist!
  }
}

?>