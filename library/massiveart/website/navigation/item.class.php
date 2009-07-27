<?php
/**
 * NavigationItem
 * 
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-17: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.website.navigation
 * @subpackage NavigationItem
 */

class NavigationItem {
  
  protected $intOrder;
  
  protected $strTitle;
  protected $strUrl;
  
  protected $intId;
  protected $intParentId;
  protected $strItemId;
  
  /**
   * construct
   * @author Thomas Schedler <tsh@massiveart.com>   
   * @version 1.0
   */
  public public function __construct() { }
  
  /**
   * setTitle
   * @param string $strTitle
   */
  public function setTitle($strTitle){
    $this->strTitle = $strTitle;
  }

  /**
   * getTitle
   * @param string $strTitle
   */
  public function getTitle(){
    return $this->strTitle;
  }
  
  /**
   * setUrl
   * @param string $strUrl
   */
  public function setUrl($strUrl){
    $this->strUrl = $strUrl;
  }

  /**
   * getUrl
   * @param string $strUrl
   */
  public function getUrl(){
    return $this->strUrl;
  }
  
  /**
   * setOrder
   * @return integer $intOrder
   */
  public function setOrder($intOrder){
    $this->intOrder = $intOrder;
  }
  
  /**
   * getOrder
   * @return integer
   */
  public function getOrder(){
    return $this->intOrder;
  }
  
  /**
   * setId
   * @return integer $intId
   */
  public function setId($intId){
    $this->intId = $intId;
  }
  
  /**
   * getId
   * @return integer
   */
  public function getId(){
    return $this->intId;
  }
  
  /**
   * setParentId
   * @return integer $intParentId
   */
  public function setParentId($intParentId){
    $this->intParentId = $intParentId;
  }
  
  /**
   * getParentId
   * @return integer
   */
  public function getParentId(){
    return $this->intParentId;
  }
  
  /**
   * setItemId
   * @param stirng $strItemId
   */
  public function setItemId($strItemId){
    $this->strItemId = $strItemId;
  }

  /**
   * getItemId
   * @param string $strItemId
   */
  public function getItemId(){
    return $this->strItemId;
  }
}
?>