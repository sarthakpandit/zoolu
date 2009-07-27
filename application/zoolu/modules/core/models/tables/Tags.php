<?php

/**
 * Model_Table_Tags
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-16: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Table_Tags extends Zend_Db_Table_Abstract {
  
  protected $_name = 'tags';
  protected $_primary = 'id';
  
}

?>