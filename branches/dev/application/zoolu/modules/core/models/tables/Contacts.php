<?php

/**
 * Model_Table_Contacts
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-07: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Table_Contacts extends Zend_Db_Table_Abstract {
  
  protected $_name = 'contacts';
  protected $_primary = 'id';
  
}

?>