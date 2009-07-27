<?php
/**
 * PageEntry
 * 
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-20: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.website.page
 * @subpackage PageEntry
 */

class PageEntry {
  
	protected $intEntryId = 0;
	
	/**
   * properties of the element
   * @var Array
   */
  protected $arrProperties = array();
	
  /**
   * construct
   * @author Cornelius Hansjakob <cha@massiveart.com>   
   * @version 1.0
   */
  public public function __construct() { }
  
  /**
   * __set
   * @param string $strName
   * @param mixed $mixedValue
   */
  public function __set($strName, $mixedValue) {      
    $this->arrProperties[$strName] = $mixedValue;
  }
  
  /**
   * __get
   * @param string $strName
   * @return mixed $mixedValue
   */
  public function __get($strName) {      
    if (array_key_exists($strName, $this->arrProperties)) {
      return $this->arrProperties[$strName];
    }
    return null;
  }
  
  /**
   * setEntryId
   * @param integer $intEntryId
   */
  public function setEntryId($intEntryId){
    $this->intEntryId = $intEntryId;
  }

  /**
   * getEntryId
   * @param integer $intEntryId
   */
  public function getEntryId(){
    return $this->intEntryId;
  }
  
}

?>