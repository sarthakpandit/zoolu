<?php
/**
 * GenericDataHelperInternalLink
 *
 * Helper to save and load the "url" element
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-06: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.data.helpers
 * @subpackage GenericDataHelper_InternalLink
 */

require_once(dirname(__FILE__).'/Abstract.php');

class GenericDataHelper_InternalLink extends GenericDataHelperAbstract  {

  /**
   * @var Model_Pages
   */
  private $objModelPages;

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

      $this->getModelPages();

      $this->objModelPages->deletePageLink($intElementId);

      $this->objModelPages->addPageLink($this->objElement->getValue(), $intElementId);

      $this->load($intElementId, $strType);

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
      $this->getModelPages();

      $objLinkedPageData = $this->objModelPages->loadPageLink($intElementId);

      if(count($objLinkedPageData) > 0){
        $this->setPageLinkData($objLinkedPageData->current());
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * loadLinkedPage()
   * @param integer $intElementId
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadLinkPage($intElementId){
    try{
      $this->getModelPages();

      $objLinkedPageData = $this->objModelPages->loadLinkPage($intElementId);

      if(count($objLinkedPageData) > 0){
        $this->setPageLinkData($objLinkedPageData->current());
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * loadLinkedPage()
   * @param Zend_Db_Table_Row_Abstract $objLinkedPage
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function setPageLinkData($objLinkedPage){
    try{

      $objParentFoldersData = $this->objModelPages->loadParentFolders($objLinkedPage->id);

      $strBreadcrumb = '';
      if(count($objParentFoldersData) > 0){
        foreach($objParentFoldersData as $objParentFolder){
          $strBreadcrumb = ' » '.$objParentFolder->title.$strBreadcrumb;
        }
      }

      $this->objElement->setValue($objLinkedPage->pageId);
      $this->objElement->strLinkedPageId = $objLinkedPage->pageId;
      $this->objElement->intLinkedPageVersion = $objLinkedPage->version;
      $this->objElement->strLinkedPageTitle = $objLinkedPage->title;
      $this->objElement->strLinkedPageUrl = '/'.strtolower($objLinkedPage->languageCode).'/'.$objLinkedPage->url;
      $this->objElement->intLinkedPageId= $objLinkedPage->id;
      $this->objElement->strLinkedPageBreadcrumb= ltrim($strBreadcrumb, ' » ').' » ';
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * getModelPages
   * @return Model_Pages
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelPages(){
    if (null === $this->objModelPages) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/Pages.php';
      $this->objModelPages = new Model_Pages();
      $this->objModelPages->setLanguageId($this->objElement->Setup()->getLanguageId());
    }

    return $this->objModelPages;
  }
}
?>