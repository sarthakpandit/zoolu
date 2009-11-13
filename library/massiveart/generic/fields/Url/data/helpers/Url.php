<?php
/**
 * ZOOLU - Content Management System
 * Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 *
 * LICENSE
 *
 * This file is part of ZOOLU.
 *
 * ZOOLU is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ZOOLU is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ZOOLU. If not, see http://www.gnu.org/licenses/gpl-3.0.html.
 *
 * For further information visit our website www.getzoolu.org
 * or contact us at zoolu@getzoolu.org
 *
 * @category   ZOOLU
 * @package    library.massiveart.generic.fields.Url.data.helpers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */
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

require_once(dirname(__FILE__).'/../../../../data/helpers/Abstract.php');

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
   * @var $strParentPageUrl
   */
  private $strParentPageUrl;

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

        $this->strParentPageUrl = '';

        // load the url from the parent page
        if($objPage->idParentTypes == $this->core->sysConfig->parent_types->folder){
          if($objPage->isStartPage == 1){
            $objParentFolderData = $this->objModelPages->loadStartPageParentUrl($intElementId);
          }else{
            $objParentFolderData = $this->objModelPages->loadParentUrl($intElementId);
          }

          if(count($objParentFolderData) > 0){
            $objParentFolderUrl = $objParentFolderData->current();
            $this->strParentPageUrl = $objParentFolderUrl->url;
          }
        }

        if(count($objUrlData) > 0){
            
          $objUrl = $objUrlData->current();
          $strUrlCurrent = $objUrl->url;
          $strUrlNew = '';

          // get the new url
          if(array_key_exists($this->objElement->name.'_EditableUrl', $_POST)){
            $strUrlNew = $_POST[$this->objElement->name.'_EditableUrl'];
            $strUrlNew = $this->makeUrlConform($strUrlNew);
          }
          
          // compare the new url with the url from the db and check if there is a new url
          if(strcmp($strUrlCurrent, $this->strParentPageUrl.$strUrlNew) !== 0 && $strUrlNew != ''){
            //urls are unequal
            
            $strUrlNew = $this->checkUrlUniqueness($this->strParentPageUrl.$strUrlNew);

            // set all page urls to isMain 0
            $this->objModelPages->updatePageUrlIsMain($objPage->pageId); 
                      
            if($objPage->isStartPage == 1){
              //logic for rootnodes 
              $this->objModelPages->insertPageUrl($strUrlNew.'/', $objPage->pageId, $objPage->version); 
            }else{
              //logic for childnodes
              $this->objModelPages->insertPageUrl($strUrlNew, $objPage->pageId, $objPage->version);   
            }
          }

        }else{
              	
          /**
          // if no url is saved

          if($this->strParentPageUrl != ''){
            $this->strUrl = $this->strParentPageUrl;
          }else{
            $this->strUrl = '';
          }*/

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

          /**
          if($objPage->isStartPage == 1 && $this->strUrl != ''){
          	$this->objModelPages->insertPageUrl($this->strUrl.'/', $objPage->pageId, $objPage->version);
          }else{
            $this->objModelPages->insertPageUrl($this->strUrl, $objPage->pageId, $objPage->version);
          }*/

          $this->objModelPages->insertPageUrl($this->strUrl, $objPage->pageId, $objPage->version);
        }

        $objUrlData = $this->objModelPages->loadPageUrl($objPage->pageId, $objPage->version);
        $objUrl = $objUrlData->current();
        $this->objElement->setValue('/'.strtolower($objUrl->languageCode).'/'.$objUrl->url);
        $this->objElement->url = $objUrl->url;
        $this->objElement->isStartPage = $objUrl->isStartPage;
        $this->objElement->idParentFolder = $objUrl->idParentFolder;
        $this->objElement->depth = $objUrl->depth;

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
        $this->objElement->isStartPage = $objUrl->isStartPage;
        $this->objElement->url = $objUrl->url;
        $this->objElement->idParentFolder = $objUrl->idParentFolder;
        $this->objElement->depth = $objUrl->depth;
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
  public function makeUrlConform($strUrlPart){

    $this->getUrlReplacers();

    $strUrlPart = strtolower($strUrlPart);

    if(count($this->objUrlReplacers) > 0){
      foreach($this->objUrlReplacers as $objUrlReplacer){
        $strUrlPart = str_replace($objUrlReplacer->from, $objUrlReplacer->to, $strUrlPart);
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
  public function checkUrlUniqueness($strUrl, $intUrlAddon = 0){
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