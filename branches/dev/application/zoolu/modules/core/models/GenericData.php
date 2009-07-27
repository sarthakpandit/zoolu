<?php

/**
 * Model_GenericData
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-19: Thomas Schedler
  * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_GenericData {
  
  protected $arrGenericTables = array();
  
  /**
   * @var Core
   */
  private $core;  
  
  /**
   * Constructor 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }
    
  /**
   * getGenericTable
   * @return Model_Table_Generics 
   * @author Thomas Schedler <cha@massiveart.com>
   * @version 1.0
   */
  public function getGenericTable($strTableName){
    try{ 
          
      if(!array_key_exists($strTableName, $this->arrGenericTables)) {
        require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/Generics.php';
        $this->arrGenericTables[$strTableName] = new Model_Table_Generics($strTableName);
      }
      
      return $this->arrGenericTables[$strTableName];
      
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  } 
}

?>