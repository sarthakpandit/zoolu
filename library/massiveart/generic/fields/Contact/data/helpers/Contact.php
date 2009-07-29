<?php
/**
 * GenericDataHelperContact
 *
 * Helper to save and load the "Contact" element
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-10: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.data.helpers
 * @subpackage GenericDataHelper_Contact
 */

require_once(dirname(__FILE__).'/../../../../data/helpers/Abstract.php');

class GenericDataHelper_Contact extends GenericDataHelperAbstract  {

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
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function save($intElementId, $strType, $strElementId = null, $intVersion = null){
    try{
      $this->strType = $strType;

      $this->getModel();

      $this->objModel->addContact($intElementId, $this->objElement->getValue(), $this->objElement->id);

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
      $this->strType = $strType;

      $this->getModel();

      $this->objElement->setValue($this->objModel->loadContacts($intElementId, $this->objElement->id));

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
        $this->objModel = new Model_Pages();
        $this->objModel->setLanguageId($this->objElement->Setup()->getLanguageId());
      }else{
        throw new Exception('Not able to load type specific model, because the file didn\'t exist! - strType: "'.$this->strType.'"');
      }
    }
    return $this->objModel;
  }
}
?>