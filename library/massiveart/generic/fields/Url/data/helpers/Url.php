<?php
/**
 * GenericDataHelperUrl
 *
 * Helper to save and load the "url" element
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-06: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.data.helpers
 * @subpackage GenericDataHelper_Url
 */

require_once(dirname(__FILE__).'/Abstract.php');

class GenericDataHelper_Url extends GenericDataHelperAbstract  {

  /**
   * @var Model_Pages
   */
  private $objModelPages;

  /**
   * @var Zend_Db_Table_Rowset_Abstract
   */
  private $objUrlReplacers;

  private $strUrl;

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

      $objPageData = $this->objModelPages->loadPage($intElementId);

      if(count($objPageData) > 0){
        $objPage = $objPageData->current();

        $objUrlData = $this->objModelPages->loadPageUrl($objPage->pageId, $objPage->version);

        if(count($objUrlData) > 0){
          $objUrl = $objUrlData->current();
          $this->objElement->setValue('/'.strtolower($objUrl->languageCode).'/'.$objUrl->url);
        }else{
          $this->strUrl = '';

          $objParentFoldersData = $this->objModelPages->loadParentFolders($intElementId);

          if(count($objParentFoldersData) > 0){
            foreach($objParentFoldersData as $objParentFolder){
              if($objParentFolder->isUrlFolder == 1){
                $this->strUrl = $this->makeUrlConform($objParentFolder->title).'/'.$this->strUrl;
              }
            }
          }

          if($objPage->isStartPage == 1){
            $this->strUrl .= '';
          }else{
            $objFieldData = $this->objElement->Setup()->getModelGenericForm()->loadFieldsWithPropery($this->core->sysConfig->fields->properties->url_field, $this->objElement->Setup()->getGenFormId());

            if(count($objFieldData) > 0){
              foreach($objFieldData as $objField){
                if($this->objElement->Setup()->getRegion($objField->regionId)->getField($objField->name)->getValue() != ''){
                  $this->strUrl .= $this->makeUrlConform($this->objElement->Setup()->getRegion($objField->regionId)->getField($objField->name)->getValue());
                  break;
                }
              }
            }
          }

          $this->strUrl = $this->checkUrlUniqueness($this->strUrl);

          $this->objModelPages->insertPageUrl($this->strUrl, $objPage->pageId, $objPage->version);

          $objUrlData = $this->objModelPages->loadPageUrl($objPage->pageId, $objPage->version);
          if(count($objUrlData) > 0){
            $objUrl = $objUrlData->current();
            $this->objElement->setValue('/'.strtolower($objUrl->languageCode).'/'.$objUrl->url);
          }
        }
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
      $this->getModelPages();

      $objUrlData = $this->objModelPages->loadPageUrl($strElementId, $intVersion);

      if(count($objUrlData) > 0){
        $objUrl = $objUrlData->current();
        $this->objElement->setValue('/'.strtolower($objUrl->languageCode).'/'.$objUrl->url);
      }

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * makeUrlConform()
   * @param string $strUrlPart
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function makeUrlConform($strUrlPart){

    $this->getUrlReplacers();

    $strUrlPart = strtolower($strUrlPart);

    if(count($this->objUrlReplacers) > 0){
      foreach($this->objUrlReplacers as $objUrlReplacer){
        $strUrlPart = str_replace(utf8_encode($objUrlReplacer->from), $objUrlReplacer->to, $strUrlPart);
      }
    }

    $strUrlPart = strtolower($strUrlPart);

    $strUrlPart = urlencode(preg_replace('/([^A-za-z0-9\s-_])/', '_', $strUrlPart));

    $strUrlPart = str_replace('+', '-', $strUrlPart);

    return $strUrlPart;
  }

  /**
   * getUrlReplacers()
   * @param string $strUrlPart
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function getUrlReplacers(){
    if($this->objUrlReplacers === null) {
      $this->objUrlReplacers = $this->getModelPages()->loadUrlReplacers();
    }
  }

  /**
   * checkUrlUniqueness()
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function checkUrlUniqueness($strUrl, $intUrlAddon = 0){
    $this->getModelPages();

    $strNewUrl = ($intUrlAddon > 0) ? $strUrl.'-'.$intUrlAddon : $strUrl;
    $objPageUrlsData = $this->objModelPages->loadPageByUrl($this->objElement->Setup()->getRootLevelId(), $strNewUrl);

    if(count($objPageUrlsData) > 0){
      return $this->checkUrlUniqueness($strUrl, $intUrlAddon + 1);
    }else{
      return $strNewUrl;
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