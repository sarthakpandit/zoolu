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
 * @package    application.zoolu.modules.core.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_Urls
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-12-04: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Urls {

  private $intLanguageId;

  /**
   * @var Model_Table_Urls
   */
  protected $objUrlTable;
  
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
   * loadUrl
   * @param string $strRelationId
   * @param integer $intVersion
   * @param integer $intUrlTypeId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadUrl($strRelationId, $intVersion, $intUrlTypeId){
    $this->core->logger->debug('core->models->Model_Urls->loadUrl('.$strRelationId.', '.$intVersion.', '.$intUrlTypeId.')');

    $objSelect = $this->getUrlTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objUrlTable, array('url'));
    $objSelect->join('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->where('urls.relationId = ?', $strRelationId)
              ->where('urls.version = ?', $intVersion)
              ->where('urls.idUrlTypes = ?', $intUrlTypeId)
              ->where('urls.idLanguages = ?', $this->intLanguageId)
              ->where('urls.isMain = 1')
              ->where('urls.idParent IS NULL');
    return $this->objUrlTable->fetchAll($objSelect);
  }
  
  /**
   * loadByUrl
   * @param integer $intRootLevelId
   * @param string $strUrl
   * @return stdClass
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadByUrl($intRootLevelId, $strUrl){
    $this->core->logger->debug('core->models->Model_Urls->loadByUrl('.$intRootLevelId.', '.$strUrl.')');
    
    $objUrlData = new stdClass();
    
    $objFolderPageSelect = $this->core->dbh->select();
    $objFolderPageSelect->from('urls', array('relationId' => 'pages.pageId', 'pages.version', 'urls.idLanguages', 'urls.idParent', 'urls.idParentTypes', 'urls.idUrlTypes', 'linkId' => new Zend_Db_Expr('-1'), 'linkParentId' => new Zend_Db_Expr('-1')));
    $objFolderPageSelect->join('pages', 'pages.pageId = urls.relationId AND pages.version = urls.version AND pages.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array());
    $objFolderPageSelect->join('folders', 'folders.id = pages.idParent', array());
    $objFolderPageSelect->where('urls.url = ?', $strUrl)
											  ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->page)
											  ->where('urls.idLanguages = ?', $this->intLanguageId)
											  ->where('folders.idRootLevels = ?', $intRootLevelId);
    
    $objRootLevelPageSelect = $this->core->dbh->select();
    $objRootLevelPageSelect->from('urls', array('relationId' => 'pages.pageId', 'pages.version', 'urls.idLanguages', 'urls.idParent', 'urls.idParentTypes', 'urls.idUrlTypes', 'linkId' => new Zend_Db_Expr('-1'), 'linkParentId' => new Zend_Db_Expr('-1')));
    $objRootLevelPageSelect->join('pages', 'pages.pageId = urls.relationId AND pages.version = urls.version AND pages.idParentTypes = '.$this->core->sysConfig->parent_types->rootlevel, array());
    $objRootLevelPageSelect->join('rootLevels', ' rootLevels.id = pages.idParent', array());
    $objRootLevelPageSelect->where('urls.url = ?', $strUrl)
					                 ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->page)
					                 ->where('urls.idLanguages = ?', $this->intLanguageId)
					                 ->where('rootLevels.id = ?', $intRootLevelId);
	  
    $objGlobalSelect = $this->core->dbh->select();
    $objGlobalSelect->from('urls', array('relationId' => 'globals.globalId', 'globals.version', 'urls.idLanguages', 'urls.idParent', 'urls.idParentTypes', 'urls.idUrlTypes', 'linkId' => 'lG.id', 'linkParentId' => 'lG.idParent'));
    $objGlobalSelect->join(array('lG' => 'globals'), 'lG.globalId = urls.relationId AND lG.version = urls.version', array());
    $objGlobalSelect->join('globalLinks', 'globalLinks.idGlobals = lG.id', array());
    $objGlobalSelect->join('globals', 'globals.globalId = globalLinks.globalId', array());
    $objGlobalSelect->where('urls.url = ?', $strUrl)
                     ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->global)
                     ->where('urls.idLanguages = ?', $this->intLanguageId)
                     ->where('globals.id = (SELECT p.id FROM globals p WHERE p.globalId = globals.globalId ORDER BY p.version DESC LIMIT 1)');
    
    $objSelect = $this->getUrlTable()->select()
                                     ->union(array($objFolderPageSelect, $objRootLevelPageSelect, $objGlobalSelect));

    $objUrlData->url = $this->objUrlTable->fetchAll($objSelect);
    
    /**
     * check if url is global of a linkde global tree
     */
    if(count($objUrlData->url) == 0){
      $objGlobalTreeBaseUrls = $this->loadGlobalTreeBaseUrls($intRootLevelId);
      foreach($objGlobalTreeBaseUrls as $objBaseUrl){
        if(strpos($strUrl, $objBaseUrl->url) === 0){
          $objUrlData->url = $this->loadGlobalByUrl(str_replace($objBaseUrl->url, '', $strUrl));
          $objUrlData->baseUrl = $objBaseUrl;
          break;
        }
      }
    }
    
    return $objUrlData;
  }
  
  /**
   * loadGlobalTreeBaseUrls
   * @param integer $intRootLevelId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function loadGlobalTreeBaseUrls($intRootLevelId){
    $this->core->logger->debug('core->models->Model_Urls->loadGlobalTreeBaseUrls('.$intRootLevelId.')');
    
    $objSelect = $this->getUrlTable()->select();
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from('urls', array('url', 'relationId' => 'pages.pageId', 'pages.version', 'urls.idLanguages', 'urls.idParent', 'urls.idParentTypes', 'urls.idUrlTypes', 'linkId' => new Zend_Db_Expr('-1')));
    $objSelect->join('pages', 'pages.pageId = urls.relationId AND pages.version = urls.version AND pages.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array());
    $objSelect->join('pageProperties', 'pageProperties.pageId = pages.pageId AND pageProperties.version = pages.version AND pageProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->join('folders', 'folders.id = pages.idParent', array());
    $objSelect->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->page)
              ->where('urls.idLanguages = ?', $this->intLanguageId)
              ->where('folders.idRootLevels = ?', $intRootLevelId)
              ->where('pageProperties.idPageTypes = ?', $this->core->sysConfig->page_types->product_tree->id);

    return $this->objUrlTable->fetchAll($objSelect);
  }
  
  /**
   * loadGlobalByUrl
   * @param string $strUrl
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function loadGlobalByUrl($strUrl){
    $this->core->logger->debug('core->models->Model_Urls->loadGlobalByUrl('.$strUrl.')');
    
    $objSelect = $this->getUrlTable()->select();
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from('urls', array('relationId' => 'globals.globalId', 'globals.version', 'urls.idLanguages', 'urls.idParent', 'urls.idParentTypes', 'urls.idUrlTypes', 'linkId' => 'lG.id', 'linkParentId' => 'lG.idParent'));
    $objSelect->join(array('lG' => 'globals'), 'lG.globalId = urls.relationId AND lG.version = urls.version', array());
    $objSelect->join('globalLinks', 'globalLinks.idGlobals = lG.id', array());
    $objSelect->join('globals', 'globals.globalId = globalLinks.globalId', array());
    $objSelect->where('urls.url = ?', $strUrl)
              ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->global)
              ->where('urls.idLanguages = ?', $this->intLanguageId)
              ->where('globals.id = (SELECT p.id FROM globals p WHERE p.globalId = globals.globalId ORDER BY p.version DESC LIMIT 1)');

    return $this->objUrlTable->fetchAll($objSelect);
  }
  
  /**
   * insertUrl
   * @param string $strUrl
   * @param string $strRelationId
   * @param integer $intVersion
   * @param integer $intUrlTypeId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function insertUrl($strUrl, $strRelationId, $intVersion, $intUrlTypeId){
    $this->core->logger->debug('core->models->Model_Urls->insertUrl('.$strUrl.', '.$strRelationId.', '.$intVersion.', '.$intUrlTypeId.')');
    
    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;
   
    $arrDataInsert = array('relationId'   => $strRelationId,
                           'version'      => $intVersion,
                           'idUrlTypes'   => $intUrlTypeId,
                           'isMain'       => '1',
                           'idLanguages'  => $this->intLanguageId,
                           'url'          => $strUrl,
                           'idUsers'      => $intUserId,
                           'creator'      => $intUserId,
                           'created'      => date('Y-m-d H:i:s'));

    return $objSelect = $this->getUrlTable()->insert($arrDataInsert);
  }
  
  /**
   * resetIsMainUrl
   * @param string $strRelationId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function resetIsMainUrl($strRelationId, $intVersion, $intUrlTypeId){
    $this->core->logger->debug('core->models->Model_Urls->resetIsMainUrl('.$strRelationId.', '.$intVersion.', '.$intUrlTypeId.')');
   
    $arrDataUpdate = array('isMain' => 0);
    
    $strWhere = $this->getUrlTable()->getAdapter()->quoteInto('relationId = ?', $strRelationId);
    $strWhere .= $this->getUrlTable()->getAdapter()->quoteInto(' AND version = ?', $intVersion);
    $strWhere .= $this->getUrlTable()->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);
    $strWhere .= $this->getUrlTable()->getAdapter()->quoteInto(' AND idUrlTypes = ?', $intUrlTypeId);
    
    return $this->getUrlTable()->update($arrDataUpdate, $strWhere);
  }

  /**
   * removeUrlHistoryEntry
   * @param integer $intUrlId
   * @param string $strRelationId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function removeUrlHistoryEntry($intUrlId, $strRelationId){
    $this->core->logger->debug('core->models->Model_Urls->removeUrlHistoryEntry('.$intUrlId.', '.$strRelationId.')');

    $strWhere = $this->getUrlTable()->getAdapter()->quoteInto('relationId = ?', $strRelationId);
    $strWhere .= $this->objUrlTable->getAdapter()->quoteInto(' AND id = ?', $intUrlId);
   
    return $this->objUrlTable->delete($strWhere);  
  }
  
   /**
   * getUrlTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getUrlTable(){

    if($this->objUrlTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/Urls.php';
      $this->objUrlTable = new Model_Table_Urls();
    }

    return $this->objUrlTable;
  }
  
  /**
   * setLanguageId
   * @param integer $intLanguageId
   */
  public function setLanguageId($intLanguageId){
    $this->intLanguageId = $intLanguageId;
  }

  /**
   * getLanguageId
   * @param integer $intLanguageId
   */
  public function getLanguageId(){
    return $this->intLanguageId;
  }
  
}
?>