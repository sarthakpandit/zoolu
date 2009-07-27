<?php

/**
 * GenericElementTab
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-07-23: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.elements
 * @subpackage GenericElementTab
 */

require_once(dirname(__FILE__).'/generic.element.abstract.class.php');

class GenericElementTab extends GenericElementAbstract {

	protected $intTabId;
	protected $strTabTitle;
	protected $intTabOrder;

	protected $arrRegions = array();
  /**
   * property of the regions array
   * @return Array $arrRegions
   */
  public function Regions(){
    return $this->arrRegions;
  }

	/**
   * addRegion
   * @param GenericElementRegion $objRegion
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
	public function addRegion(GenericElementRegion &$objRegion){
	  $this->arrRegions[$objRegion->getRegionId()] = $objRegion;
	}

  /**
   * getRegion
   * @param integer $intRegionId
   * @return GenericElementRegion|null
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getRegion($intRegionId){
    if(array_key_exists($intRegionId, $this->arrRegions)){
      return $this->arrRegions[$intRegionId];
    }
    return null;
  }

	/**
	 * setTabId
	 * @param integer $intTabId
	 */
	public function setTabId($intTabId){
		$this->intTabId = $intTabId;
	}

	/**
	 * getTabId
	 * @param integer $intTabId
	 */
	public function getTabId(){
		return $this->intTabId;
	}

  /**
   * setTabOrder
   * @param integer $intTabOrder
   */
  public function setTabOrder($intTabOrder){
    $this->intTabOrder = $intTabOrder;
  }

  /**
   * getTabOrder
   * @param integer $intTabOrder
   */
  public function getTabOrder(){
    return $this->intTabOrder;
  }

	/**
	 * setTabTitle
	 * @param string $strTabTitle
	 */
	public function setTabTitle($strTabTitle){
		$this->strTabTitle = $strTabTitle;
	}

	/**
	 * getTabTitle
	 * @param string $strTabTitle
	 */
	public function getTabTitle(){
		return $this->strTabTitle;
	}
}

?>