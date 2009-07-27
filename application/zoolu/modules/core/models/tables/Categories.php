<?php

/**
 * Model_Table_Categories
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-16: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Model_Table_Categories extends Zend_Db_Table_Abstract {
  
  protected $_name = 'categories';
  protected $_primary = 'id';
  
}

?>