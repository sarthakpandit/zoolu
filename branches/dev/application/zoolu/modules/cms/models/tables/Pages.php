<?php

/**
 * Model_Table_Pages
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-06: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Model_Table_Pages extends Zend_Db_Table_Abstract {
  
  protected $_name = 'pages';
  protected $_primary = 'id';
  
}

?>