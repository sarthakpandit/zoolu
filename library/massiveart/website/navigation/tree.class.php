<?php
/**
 * NavigationTree
 * 
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-17: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.website.navigation
 * @subpackage NavigationTree
 */

require_once(dirname(__FILE__).'/item.class.php');

class NavigationTree extends NavigationItem implements Iterator,Countable {
  
  private $blnOrderUpdated = false;
  
  private $arrItems = array();
  private $arrTrees = array();
  
  private $arrOrder = array();  
  
  /**
   * construct
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public public function __construct() { }
  
  /**
   * addItem
   * @param NavigationItem $objItem
   * @param string $strName 
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function addItem(NavigationItem $objItem, $strName = null){
    $this->arrItems[$strName] = $objItem;
    $this->arrOrder[$strName] = $this->arrItems[$strName]->getOrder();
    $this->blnOrderUpdated = true;
  }
  
  /**
   * hasSubTrees
   * @return boolean
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function hasSubTrees(){
    return (count($this->arrTrees) > 0) ? true : false;
  }
  
  /**
   * addTree
   * @param NavigationTree $objTree
   * @param string $strName 
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function addTree(NavigationTree $objTree, $strName = null){
    $this->arrTrees[$strName] = $objTree;
    $this->arrOrder[$strName] = $this->arrTrees[$strName]->getOrder();
    $this->blnOrderUpdated = true;
  }
  
  /**
   * addToParentTree
   * @param NavigationTree $objTree
   * @param string $strName 
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function addToParentTree($objTree, $strName){
    if($this->intId == $objTree->getParentId()){
      $this->addTree($objTree, $strName);
      return true;
    }else{
      foreach($this->arrTrees as $objSubTree){        
        if($objSubTree->addToParentTree($objTree, $strName)){
          break;
        }
      }
    }
  }
  
  /**
   * sort()
   * Sort elements according to their order
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  protected function sort(){
    if($this->blnOrderUpdated){
      $arrItems = array();
      $intIndex = 0;
      
      foreach ($this->arrOrder as $strKey => $intOrder){
        if($intOrder === null){
          if(($intOrder = $this->{$strKey}->getOrder()) === null) {
            while(array_search($intIndex, $this->arrOrder, true)) {
              $intIndex++;
            }            
            $arrItems[$intIndex] = $strKey;
            $intIndex++;
          }else{
            $arrItems[$intOrder] = $strKey;
          }
        }else{
          $arrItems[$intOrder] = $strKey;
        }
      }

      $arrItems = array_flip($arrItems);
      asort($arrItems);
      $this->arrOrder = $arrItems;
      $this->blnOrderUpdated = false;
    }
  }
    
  /**
   * Overloading: access to navigation items and trees   
   * @param  string $strName 
   * @return NavigationItem|NavigationTree|null
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function __get($strName){
    if(isset($this->arrItems[$strName])){
      return $this->arrItems[$strName];
    }elseif (isset($this->arrTrees[$strName])){
      return $this->arrTrees[$strName];
    }
    
    return null;
  }
  
  /**
   * Overloading: access to navigation items and trees
   * @param  string $strName 
   * @param  NavigationItem|NavigationTree $obj 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function __set($strName, $obj){
    if($value instanceof NavigationItem){
      $this->addtem($obj, $strName);
      return;
    }elseif($obj instanceof NavigationTree){
      $this->addTree($obj, $strName);
      return;
    }
    
    if(is_object($obj)){
      $strType = get_class($obj);
    }else{
      $strType = gettype($obj);
    }
    throw new Zend_Form_Exception('Only navigation items and trees may be overloaded; variable of type "'.$strType.'" provided');
  }
      

  /**
   * rewind      
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function rewind() {
    $this->sort();
    reset($this->arrOrder);
  }

  /**
   * current
   * @return NavigationItem|NavigationTree   
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function current() {
    $this->sort();
    current($this->arrOrder);
    $strKey = key($this->arrOrder);

    if(isset($this->arrItems[$strKey])){
      return $this->arrItems[$strKey];
    }elseif (isset($this->arrTrees[$strKey])){
      return $this->arrTrees[$strKey];
    } else{
      throw new Exception('Corruption detected in navigation tree; invalid key ("'.$strKey.'") found in internal iterator');
    }
  }

  /**
   * key
   * @return string   
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function key() {
    $this->sort();
    return key($this->arrOrder);    
  }

  /**
   * next   
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function next() {
    $this->sort();
    next($this->arrOrder);
  }

  /**
   * valid
   * @return boolean
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function valid() {    
    $this->sort();
    return (current($this->arrOrder) !== false);
  }
  
  /**
   * count
   * @return integer
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public function count(){
    return count($this->arrOrder);
  }
}
?>