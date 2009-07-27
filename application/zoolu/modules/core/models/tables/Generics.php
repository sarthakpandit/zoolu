<?php

/**
 * Model_Table_Generics
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-04: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Table_Generics extends Zend_Db_Table_Abstract {
  
  protected $_name = '';
  protected $_primary = 'id';
  
  public function __construct($strTableName){
    $this->_name = $strTableName;    
    parent::__construct();    
    //FIXME : table must exist! (generic form manager has to create the table)
  }
}

?>