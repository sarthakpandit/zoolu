<?php
/**
 * GenericDataHelper_Gmaps
 *
 * Helper to save and load Google Maps
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-07-24: Florian Mathis
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.data.helpers
 * @subpackage GenericDataHelper_Gmaps
 */

require_once(dirname(__FILE__).'/../../../../../library/massiveart/generic/data/helpers/Abstract.php');

class Plugin_DataHelper_Gmaps extends GenericDataHelperAbstract  {

  /**
   * @var Model_Pages
   */
  private $objModel;

  private $strType;

  /**
   * save()
   * @param integer $intElementId
   * @param string $strType
   * @param string $strElementId
   * @param integet $intVersion
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function save($intElementId, $strType, $strElementId = null, $intVersion = null){
    try{
    	$this->core->logger->debug('save Google Map');
      $this->strType = $strType;

      $this->getModel();

      $strGmapsLatitude = '';
      if(array_key_exists($this->objElement->name.'Latitude', $_POST)){
        $strGmapsLatitude = $_POST[$this->objElement->name.'Latitude'];
      }

      $strGmapsLongitude = '';
      if(array_key_exists($this->objElement->name.'Longitude', $_POST)){
        $strGmapsLongitude = $_POST[$this->objElement->name.'Longitude'];
      }

      if($strGmapsLongitude != '' && $strGmapsLatitude != ''){
        $this->objModel->addGmaps($intElementId, $strGmapsLongitude, $strGmapsLatitude);
        $this->load($intElementId, $strType, $strElementId, $intVersion);
      }else{
        //$this->objModel->removeGmaps($intElementId);
      }

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * load()
   * @param integer $intElementId
   * @param string $strType
   * @param string $strElementId
   * @param integet $intVersion
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function load($intElementId, $strType, $strElementId = null, $intVersion = null){
    try{
    	$this->core->logger->debug('load Google Map');
      $this->strType = $strType;
      
    	$this->getModel();
    	$elementId = $this->strType.'Id';
    	
      $objGmap = $this->objModel->loadGmap($intElementId);
      $this->objElement->setValue($objGmap[0]);

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * getModel
   * @return type Model
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModel(){
    if($this->objModel === null) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      $strModelFilePath = GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.$this->objElement->Setup()->getModelSubPath().((substr($this->strType, strlen($this->strType) - 1) == 'y') ? ucfirst(rtrim($this->strType, 'y')).'ies' : ucfirst($this->strType).'s').'.php';
 
      if(file_exists($strModelFilePath)){
        require_once $strModelFilePath;
        $strModel = 'Model_'.((substr($this->strType, strlen($this->strType) - 1) == 'y') ? ucfirst(rtrim($this->strType, 'y')).'ies' : ucfirst($this->strType).'s');
        $this->objModel = new $strModel();
        $this->objModel->setLanguageId($this->objElement->Setup()->getLanguageId());
      }else{
        throw new Exception('Not able to load type specific model, because the file didn\'t exist! - strType: "'.$this->strType.'"');
      }
    }
    return $this->objModel;
  }
}
?>