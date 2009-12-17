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
 * @package    application.zoolu.modules.cms.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_Pages
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-06: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Model_Pages {

  private $intLanguageId;

  /**
   * @var Model_Table_Pages
   */
  protected $objPageTable;

  /**
   * @var Model_Table_Urls
   */
  protected $objPageUrlTable;

  /**
   * @var Model_Table_PageLinks
   */
  protected $objPageLinksTable;

  /**
   * @var Model_Table_PageInternalLinks
   */
  protected $objPageInternalLinksTable;

  /**
   * @var Model_Table_PageCollections
   */
  protected $objPageCollectionTable;

  /**
   * @var Model_Table_PageVideos
   */
  protected $objPageVideosTable;


  /**
   * @var Model_Table_PageContacts
   */
  protected $objPageContactsTable;

  /**
   * @var Core
   */
  private $core;

  /**
   * Constructor
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }

  /**
   * loadPlugin
   * @param integer $intElementId
   * @param array $arrFields
   * @param string $strType
   * @return array
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function loadPlugin($intElementId, $arrFields, $strType) {
  	$this->core->logger->debug('cms->models->Model_Pages->loadPlugin('.$intElementId.', '.$arrFields.', '.$strType.')');
  	$objPagePluginTable = $this->getPluginTable($strType);

  	$objSelect = $objPagePluginTable->select();
  	$objSelect->from($objPagePluginTable, $arrFields);
  	$objSelect->join('pages', 'pages.pageId = '.$objPagePluginTable->info(Zend_Db_Table_Abstract::NAME).'.pageId AND pages.version = '.$objPagePluginTable->info(Zend_Db_Table_Abstract::NAME).'.version', array());
  	$objSelect->where('pages.id = ?', $intElementId)
  	          ->where('idLanguages = ?', $this->getLanguageId());

  	return $objPagePluginTable->fetchAll($objSelect);
  }

  /**
   * addPlugin
   * @param integer $intElementId
   * @param array $arrValues
   * @param string $strType
   * @return mixed
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function addPlugin($intElementId, $arrValues, $strType) {
  	$this->core->logger->debug('cms->models->Model_Pages->addPlugin('.$arrValues.','.$strType.')');

  	$objPageData = $this->load($intElementId);

  	if(count($objPageData) > 0){
  		$objPage = $objPageData->current();

  		$objPagePluginTable = $this->getPluginTable($strType);

  		$strWhere = $objPagePluginTable->getAdapter()->quoteInto('pageId = ?', $objPage->pageId);
  		$strWhere .= 'AND '.$objPagePluginTable->getAdapter()->quoteInto('version = ?', $objPage->version);
  		$objPagePluginTable->delete($strWhere);

  		$intUserId = Zend_Auth::getInstance()->getIdentity()->id;
  		$arrData = array( 'pageId'      =>  $objPage->pageId,
  		                  'version'     =>  $objPage->version,
  		                  'idLanguages' =>  $this->intLanguageId,
  		                  'creator'     =>  $intUserId);
  		$arrData = array_merge($arrData, $arrValues);
  		return $objSelect = $objPagePluginTable->insert($arrData);
  	}
  }

  /**
   * load
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function load($intElementId){
    $this->core->logger->debug('cms->models->Model_Pages->load('.$intElementId.')');

    $objSelect = $this->getPageTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('pages', array('id', 'pageId', 'relationId' => 'pageId', 'version', 'idPageTypes', 'isStartPage', 'showInNavigation', 'idParent', 'idParentTypes', 'published', 'changed', 'idStatus', 'creator',
                                    '(SELECT CONCAT(users.fname, \' \', users.sname) AS publisher FROM users WHERE users.id = pages.publisher) AS publisher',
                                    '(SELECT CONCAT(users.fname, \' \', users.sname) AS changeUser FROM users WHERE users.id = pages.idUsers) AS changeUser'));
    $objSelect->where('pages.id = ?', $intElementId);

    return $this->getPageTable()->fetchAll($objSelect);
  }

  /**
   * loadByIdAndVersion
   * @param string $strPageId
   * @param integer $intPageVersion
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadByIdAndVersion($strPageId, $intPageVersion){
    $this->core->logger->debug('cms->models->Model_Pages->loadByIdAndVersion('.$strPageId.', '.$intPageVersion.')');

    $objSelect = $this->getPageTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('pages', array('id', 'idTemplates', 'idStatus', 'published', 'changed', 'created', 'idPageTypes', 'isStartElement' => 'isStartPage', 'showInNavigation', 'idParent', 'idParentTypes',
                                    '(SELECT CONCAT(users.fname, \' \', users.sname) AS publisher FROM users WHERE users.id = pages.publisher) AS publisher',
                                    '(SELECT CONCAT(users.fname, \' \', users.sname) AS changeUser FROM users WHERE users.id = pages.idUsers) AS changeUser',
                                    '(SELECT CONCAT(users.fname, \' \', users.sname) AS creator FROM users WHERE users.id = pages.creator) AS creator'));
    $objSelect->join('genericForms', 'genericForms.id = pages.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'));
    $objSelect->join('templates', 'templates.id = pages.idTemplates', array('filename'));
    $objSelect->where('pages.pageId = ?', $strPageId);
    $objSelect->where('pages.version = ?', $intPageVersion);

    return $this->getPageTable()->fetchAll($objSelect);
  }

  /**
   * addPageLink
   * @param string $strPageId
   * @param integer $intElementId
   * @return integer
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addPageLink($strPageId, $intElementId){
    $this->core->logger->debug('cms->models->Model_Pages->addPageLink('.$strPageId.', '.$intElementId.')');
    $arrData = array('idPages' => $intElementId,
                     'pageId'  => $strPageId);
    return $this->getPageLinksTable()->insert($arrData);
  }

  /**
   * addInternalLinks
   * @param string $strLinkedPageIds
   * @param string $strElementId
   * @param integer $intVersion
   * @return integer
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addInternalLinks($strLinkedPageIds, $strElementId, $intVersion){
    $this->core->logger->debug('cms->models->Model_Pages->addInternalLinks('.$strLinkedPageIds.', '.$strElementId.', '.$intVersion.')');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $arrData = array('pageId'      => $strElementId,
                     'version'     => $intVersion,
                     'idLanguages' => $this->intLanguageId,
                     'idUsers'     => $intUserId,
                     'creator'     => $intUserId,
                     'created'     => date('Y-m-d H:i:s'));

    $strTmpLinkedPageIds = trim($strLinkedPageIds, '[]');
    $arrLinkedPageIds = split('\]\[', $strTmpLinkedPageIds);

    if(count($arrLinkedPageIds) > 0){
      foreach($arrLinkedPageIds as $sortPosition => $strLinkedPageId){
        $arrData['linkedPageId'] = $strLinkedPageId;
        $arrData['sortPosition'] = $sortPosition + 1;
        $this->getPageInternalLinksTable()->insert($arrData);
      }
    }
  }

  /**
   * addPageCollection
   * @param string $strCollectedPageIds
   * @param string $strPageId
   * @param integer $intElementId
   * @return integer
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addPageCollection($strCollectedPageIds, $strElementId, $intVersion){
    $this->core->logger->debug('cms->models->Model_Pages->addPageCollection('.$strCollectedPageIds.', '.$strElementId.', '.$intVersion.')');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $arrData = array('pageId'      => $strElementId,
                     'version'     => $intVersion,
                     'idLanguages' => $this->intLanguageId,
                     'idUsers'     => $intUserId,
                     'creator'     => $intUserId,
                     'created'     => date('Y-m-d H:i:s'));

    $strTmpCollectedPageIds = trim($strCollectedPageIds, '[]');
    $arrCollectedPageIds = split('\]\[', $strTmpCollectedPageIds);

    if(count($arrCollectedPageIds) > 0){
      foreach($arrCollectedPageIds as $sortPosition => $strCollectedPageId){
        $arrData['collectedPageId'] = $strCollectedPageId;
        $arrData['sortPosition'] = $sortPosition + 1;
        $this->getPageCollectionTable()->insert($arrData);
      }
    }
  }

  /**
   * addPageCollectionUrls
   * @param Zend_Db_Table_Rowset_Abstract $objPageCollection
   * @param integer $intParentId
   * @param integer $intParentTypeId
   * @param string $strBaseUrl
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addPageCollectionUrls(Zend_Db_Table_Rowset_Abstract &$objPageCollectionData, $intParentId, $intParentTypeId){
    $this->core->logger->debug('cms->models->Model_Pages->addPageCollectionUrls(Zend_Db_Table_Rowset_Abstract, '.$intParentId.', '.$intParentTypeId.')');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $arrData = array('idLanguages'    => $this->intLanguageId,
                     'idUsers'        => $intUserId,
                     'idParent'       => $intParentId,
                     'idParentTypes'  => $intParentTypeId,
                     'creator'        => $intUserId,
                     'created'        => date('Y-m-d H:i:s'));

    if(count($objPageCollectionData) > 0){

      $objUrlHelper = new GenericDataHelper_Url();

      foreach($objPageCollectionData as $objPageCollection){

        $arrData['relationId'] = $objPageCollection->pageId;
        $arrData['version'] = $objPageCollection->version;
        $arrData['idUrlTypes'] = $this->core->sysConfig->url_types->page;
        $arrData['url'] = $objPageCollection->url;

        $this->getPageUrlTable()->insert($arrData);

      }
    }
  }

  /**
   * updateStartPageMainData
   * @param integer $intFolderId
   * @param array $arrProperties
   * @param string $strTitle
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function updateStartPageMainData($intFolderId, $arrProperties, $arrTitle){
    $objSelect = $this->getPageTable()->select();
    $objSelect->from($this->objPageTable, array('pageId', 'version'));
    $objSelect->where('idParent = ?', $intFolderId)
              ->where('idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
              ->where('isStartPage = 1');
    $objSelect->order(array('version DESC'));
    $objSelect->limit(1);

    $objStartPageData = $this->objPageTable->fetchAll($objSelect);

    if(count($objStartPageData) > 0){
      $objStartPage = $objStartPageData->current();

      $strWhere = $this->objPageTable->getAdapter()->quoteInto('pageId = ?', $objStartPage->pageId);
      $strWhere .= $this->objPageTable->getAdapter()->quoteInto(' AND version = ?',  $objStartPage->version);
      $this->objPageTable->update($arrProperties, $strWhere);

      $strWhere .= $this->objPageTable->getAdapter()->quoteInto(' AND idLanguages = ?',  $this->intLanguageId);
      $intNumOfEffectedRows = $this->core->dbh->update('pageTitles', $arrTitle, $strWhere);

      if($intNumOfEffectedRows == 0){
        $arrTitle = array_merge($arrTitle, array('pageId' => $objStartPage->pageId, 'version' => $objStartPage->version, 'idLanguages' => $this->intLanguageId));
        $this->core->dbh->insert('pageTitles', $arrTitle);
      }
    }
  }

  /**
   * loadPageLink
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadPageLink($intElementId){
    $this->core->logger->debug('cms->models->Model_Pages->loadPageLink('.$intElementId.')');

    $objSelect = $this->getPageTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('pages', array('id', 'pageId', 'version'));
    $objSelect->join('pageTitles', 'pageTitles.pageId = pages.pageId AND pageTitles.version = pages.version AND pageTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->joinleft('urls', 'urls.relationId = pages.pageId AND urls.version = pages.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1 AND urls.idParent IS NULL', array('url'));
    $objSelect->joinleft('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->where('pages.id = (SELECT p.id FROM pages AS p, pageLinks WHERE pageLinks.idPages = ? AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1)', $intElementId);

    return $this->objPageTable->fetchAll($objSelect);
  }

  /**
   * loadInternalLinks
   * @param string $strElementId
   * @param integer $intVersion
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadInternalLinks($strElementId, $intVersion){
    $this->core->logger->debug('cms->models->Model_Pages->loadInternalLinks('.$strElementId.','.$intVersion.')');

    $objSelect = $this->getPageInternalLinksTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('pages', array('id', 'relationId' => 'pageId', 'pageId', 'version', 'idPageTypes', 'isStartItem' => 'isStartPage', 'isStartPage', 'idStatus'));
    $objSelect->join('pageInternalLinks', 'pageInternalLinks.linkedPageId = pages.pageId AND pageInternalLinks.pageId = \''.$strElementId.'\' AND pageInternalLinks.version = '.$intVersion.' AND pageInternalLinks.idLanguages = '.$this->intLanguageId, array('sortPosition'));
    $objSelect->join('pageTitles', 'pageTitles.pageId = pages.pageId AND pageTitles.version = pages.version AND pageTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->joinleft('urls', 'urls.relationId = pages.pageId AND urls.version = pages.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1 AND urls.idParent IS NULL', array('url'));
    $objSelect->joinleft('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->where('pages.id = (SELECT p.id FROM pages AS p WHERE pages.pageId = p.pageId ORDER BY p.version DESC LIMIT 1)');
    $objSelect->order('pageInternalLinks.sortPosition ASC');

    echo $objSelect;
    return $this->objPageInternalLinksTable->fetchAll($objSelect);
  }

  /**
   * loadPageCollection
   * @param string $strElementId
   * @param integer $intVersion
   * @param integer $intParentId
   * @param integer $intParentTypeId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadPageCollection($strElementId, $intVersion, $intParentId, $intParentTypeId){
    $this->core->logger->debug('cms->models->Model_Pages->loadPageCollection('.$strElementId.')');

    $objSelect = $this->getPageCollectionTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('pages', array('id', 'pageId', 'version', 'idPageTypes', 'isStartPage', 'idStatus'));
    $objSelect->join('pageCollections', 'pageCollections.collectedPageId = pages.pageId AND pageCollections.pageId = \''.$strElementId.'\' AND pageCollections.version = '.$intVersion.' AND pageCollections.idLanguages = '.$this->intLanguageId, array('sortPosition'));
    $objSelect->join('pageTitles', 'pageTitles.pageId = pages.pageId AND pageTitles.version = pages.version AND pageTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->join('genericForms', 'genericForms.id = pages.idGenericForms', array('genericFormId', 'version AS genericFormVersion'));
    $objSelect->joinleft('urls', 'urls.relationId = pages.pageId AND urls.version = pages.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.idParent = '.$intParentId.' AND urls.idParentTypes = '.$intParentTypeId, array('url'));
    $objSelect->joinleft('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->where('pages.id = (SELECT p.id FROM pages AS p WHERE pages.pageId = p.pageId ORDER BY p.version DESC LIMIT 1)');
    $objSelect->order('pageCollections.sortPosition ASC');

    return $this->objPageCollectionTable->fetchAll($objSelect);
  }

  /**
   * loadPages
   * @param integer $intParentId
   * @param integer $intCategoryId
   * @param integer $intLabelId
   * @param integer $intEntryNumber
   * @param integer $intSortTypeId
   * @param integer $intSortOrderId
   * @param integer $intEntryDepthId
   * @param array $arrPageIds
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadPages($intParentId, $intCategoryId = 0, $intLabelId = 0, $intEntryNumber = 0, $intSortTypeId = 0, $intSortOrderId = 0, $intEntryDepthId = 0, $arrPageIds = array()){
    $this->core->logger->debug('cms->models->Model_Pages->loadPages('.$intParentId.','.$intCategoryId.','.$intLabelId.','.$intEntryNumber.','.$intSortTypeId.','.$intSortOrderId.','.$intEntryDepthId.','.$arrPageIds.')');

    $strSortOrder = '';
    if($intSortOrderId > 0 && $intSortOrderId != ''){
      switch($intSortOrderId){
        case $this->core->sysConfig->sort->orders->asc->id:
          $strSortOrder = 'ASC';
          break;
        case $this->core->sysConfig->sort->orders->desc->id:
          $strSortOrder = 'DESC';
          break;
      }
    }

    $strSqlOrderBy = '';
    if($intSortTypeId > 0 && $intSortTypeId != ''){
      switch($intSortTypeId){
        case $this->core->sysConfig->sort->types->manual_sort->id:
          $strSqlOrderBy = ' ORDER BY sortPosition '.$strSortOrder.', sortTimestamp '.(($strSortOrder == 'DESC') ? 'ASC' : 'DESC');
          break;
        case $this->core->sysConfig->sort->types->created->id:
          $strSqlOrderBy = ' ORDER BY created '.$strSortOrder;
          break;
        case $this->core->sysConfig->sort->types->changed->id:
          $strSqlOrderBy = ' ORDER BY changed '.$strSortOrder;
          break;
        case $this->core->sysConfig->sort->types->published->id:
          $strSqlOrderBy = ' ORDER BY published '.$strSortOrder;
          break;
        case $this->core->sysConfig->sort->types->alpha->id:
          $strSqlOrderBy = ' ORDER BY title '.$strSortOrder;
      }
    }

    switch($intEntryDepthId){
      case $this->core->sysConfig->filter->depth->all:
        $strSqlPageDepth = ' AND folders.depth > parent.depth';
        break;
      case $this->core->sysConfig->filter->depth->first:
      default:
        $strSqlPageDepth = ' AND pages.isStartPage = 1
                             AND folders.depth = (parent.depth + 1)';
        break;
    }

    $strSqlPageIds = '';
    if(count($arrPageIds) > 0){
      $strSqlPageIds = ' AND pages.id NOT IN ('.implode(',', $arrPageIds).')';
    }

    $strSqlCategory = '';
    if($intCategoryId > 0 && $intCategoryId != ''){
      $strSqlCategory = ' AND (pageCategories.category = '.$intCategoryId.' OR plCategories.category = '.$intCategoryId.')';
    }

    $strSqlLabel = '';
    if($intLabelId > 0 && $intLabelId != ''){
      $strSqlLabel = ' AND (pageLabels.label = '.$intLabelId.' OR plLabels.label = '.$intLabelId.')';
    }

    $strSqlLimit = '';
    if($intEntryNumber > 0 && $intEntryNumber != ''){
      $strSqlLimit = ' LIMIT '.$intEntryNumber;
    }

    $strPageFilter = '';
    $strPublishedFilter = '';
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $timestamp = time();
      $now = date('Y-m-d H:i:s', $timestamp);
      $strPageFilter = ' AND pages.idStatus = '.$this->core->sysConfig->status->live;
      $strPublishedFilter = ' AND pages.published <= \''.$now.'\'';
    }

    $sqlStmt = $this->core->dbh->query('SELECT DISTINCT id, plId, genericFormId, version, plGenericFormId, plVersion,
                                          url, plUrl, title, languageCode, idPageTypes, sortPosition, sortTimestamp, created, changed, published
                                        FROM
                                          (SELECT pages.id, pl.id AS plId, genericForms.genericFormId, genericForms.version,
                                            plGenForm.genericFormId AS plGenericFormId, plGenForm.version AS plVersion, urls.url, lUrls.url AS plUrl,
                                            IF(pages.idPageTypes = ?, plTitle.title, pageTitles.title) as title, languageCode, pages.idPageTypes,
                                            pages.created, pages.changed, pages.published, pages.sortPosition, pages.sortTimestamp
                                          FROM folders, pages
                                            LEFT JOIN pageCategories ON
                                              pageCategories.pageId = pages.pageId AND
                                              pageCategories.version = pages.version
                                            LEFT JOIN pageLabels ON
                                              pageLabels.pageId = pages.pageId AND
                                              pageLabels.version = pages.version
                                            INNER JOIN genericForms ON
                                              genericForms.id = pages.idGenericForms
                                            LEFT JOIN pageTitles ON
                                              pageTitles.pageId = pages.pageId AND
                                              pageTitles.version = pages.version AND
                                              pageTitles.idLanguages = ?
                                            LEFT JOIN urls ON
                                              urls.relationId = pages.pageId AND
                                              urls.version = pages.version AND
                                              urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                              urls.idLanguages = ? AND
                                              urls.idParent IS NULL AND
                                              urls.isMain = 1
                                            LEFT JOIN pageLinks ON
                                              pageLinks.idPages = pages.id
                                            LEFT JOIN pages AS pl ON
                                              pl.id = (SELECT p.id FROM pages AS p WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1)
                                            LEFT JOIN pageCategories AS plCategories ON
                                              plCategories.pageId = pl.pageId AND
                                              plCategories.version = pl.version
                                            LEFT JOIN pageLabels AS plLabels ON
                                              plLabels.pageId = pl.pageId AND
                                              plLabels.version = pl.version
                                            LEFT JOIN genericForms AS plGenForm ON
                                              plGenForm.id = pl.idGenericForms
                                            LEFT JOIN pageTitles AS plTitle ON
                                              plTitle.pageId = pl.pageId AND
                                              plTitle.version = pl.version AND
                                              plTitle.idLanguages = ?
                                            LEFT JOIN urls AS lUrls ON
                                              lUrls.relationId = pl.pageId AND
                                              lUrls.version = pl.version AND
                                              lUrls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                              lUrls.idLanguages = ? AND
                                              lUrls.idParent IS NULL AND
                                              lUrls.isMain = 1
                                            LEFT JOIN languages ON
                                              languages.id = ?
                                            ,folders AS parent
                                          WHERE pages.idParent = folders.id AND
                                            pages.idParentTypes = ? AND
                                            parent.id = ? AND
                                            folders.lft BETWEEN parent.lft AND parent.rgt AND
                                            folders.idRootLevels = parent.idRootLevels
                                            '.$strSqlPageDepth.'
                                            '.$strPageFilter.'
                                            '.$strPublishedFilter.'
                                            '.$strSqlCategory.'
                                            '.$strSqlLabel.'
                                            '.$strSqlPageIds.'
                                          UNION
                                          SELECT pages.id, pl.id AS plId, genericForms.genericFormId, genericForms.version,
                                            plGenForm.genericFormId AS plGenericFormId, plGenForm.version AS plVersion, urls.url, lUrls.url AS plUrl,
                                            IF(pages.idPageTypes = ?, plTitle.title, pageTitles.title) as title, languageCode, pages.idPageTypes,
                                            pages.created, pages.changed, pages.published, pages.sortPosition, pages.sortTimestamp
                                          FROM pages
                                            LEFT JOIN pageCategories ON
                                              pageCategories.pageId = pages.pageId AND
                                              pageCategories.version = pages.version
                                            LEFT JOIN pageLabels ON
                                              pageLabels.pageId = pages.pageId AND
                                              pageLabels.version = pages.version
                                            INNER JOIN genericForms ON
                                              genericForms.id = pages.idGenericForms
                                            LEFT JOIN pageTitles ON
                                              pageTitles.pageId = pages.pageId AND
                                              pageTitles.version = pages.version AND
                                              pageTitles.idLanguages = ?
                                            LEFT JOIN urls ON
                                              urls.relationId = pages.pageId AND
                                              urls.version = pages.version AND
                                              urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                              urls.idLanguages = ? AND
                                              urls.idParent IS NULL AND
                                              urls.isMain = 1
                                            LEFT JOIN pageLinks ON
                                              pageLinks.idPages = pages.id
                                            LEFT JOIN pages AS pl ON
                                              pl.id = (SELECT p.id FROM pages AS p WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1)
                                            LEFT JOIN pageCategories AS plCategories ON
                                              plCategories.pageId = pl.pageId AND
                                              plCategories.version = pl.version
                                            LEFT JOIN pageLabels AS plLabels ON
                                              plLabels.pageId = pl.pageId AND
                                              plLabels.version = pl.version
                                            LEFT JOIN genericForms AS plGenForm ON
                                              plGenForm.id = pl.idGenericForms
                                            LEFT JOIN pageTitles AS plTitle ON
                                              plTitle.pageId = pl.pageId AND
                                              plTitle.version = pl.version AND
                                              plTitle.idLanguages = ?
                                            LEFT JOIN urls AS lUrls ON
                                              lUrls.relationId = pl.pageId AND
                                              lUrls.version = pl.version AND
                                              lUrls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                              lUrls.idLanguages = ? AND
                                              lUrls.idParent IS NULL AND
                                              lUrls.isMain = 1
                                            LEFT JOIN languages ON
                                              languages.id = ?
                                          WHERE pages.idParent = ? AND
                                            pages.isStartPage = 0
                                            '.$strPageFilter.'
                                            '.$strPublishedFilter.'
                                            '.$strSqlCategory.'
                                            '.$strSqlLabel.'
                                            '.$strSqlPageIds.') AS tbl
                                        '.$strSqlOrderBy.$strSqlLimit, array($this->core->sysConfig->page_types->link->id,
                                                                             $this->intLanguageId,
                                                                             $this->intLanguageId,
                                                                             $this->intLanguageId,
                                                                             $this->intLanguageId,
                                                                             $this->intLanguageId,
                                                                             $this->core->sysConfig->parent_types->folder,
                                                                             $intParentId,
                                                                             $this->core->sysConfig->page_types->link->id,
                                                                             $this->intLanguageId,
                                                                             $this->intLanguageId,
                                                                             $this->intLanguageId,
                                                                             $this->intLanguageId,
                                                                             $this->intLanguageId,
                                                                             $intParentId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadPagesInstanceDataByIds
   * @param string $strGenForm
   * @param array $arrPageIds
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadPagesInstanceDataByIds($strGenForm, $arrPageIds){
    $this->core->logger->debug('cms->models->Model_Pages->loadPagesInstanceDataByIds('.$strGenForm.', '.$arrPageIds.')');

    // FIXME : !!! CHANGE INSTANCE FIELDS DEFINTION
    // FIXME : !!! iFl.idFields IN (5,55) -> define
    if($strGenForm != '' && $strGenForm != '-' && strpos($strGenForm, $this->core->sysConfig->page_types->link->default_formId) === false){
      $strSqlInstanceFields = '';
      if(strpos($strGenForm, $this->core->sysConfig->form->ids->pages->overview) !== false){
        $strSqlInstanceFields = ' `page-'.$strGenForm.'-Instances`.shortdescription,
                                  `page-'.$strGenForm.'-Instances`.description,';
      }else if(strpos($strGenForm, $this->core->sysConfig->form->ids->events->default.'-1') !== false){ // FIXME : genform-version (e.g. DEFAULT_EVENT-1)
        $strSqlInstanceFields = ' `page-'.$strGenForm.'-Instances`.shortdescription,
                                  `page-'.$strGenForm.'-Instances`.description,
                                  `page-'.$strGenForm.'-Instances`.event_status,';
      }else{
        $strSqlInstanceFields = ' `page-'.$strGenForm.'-Instances`.shortdescription,
                                  `page-'.$strGenForm.'-Instances`.description,';
      }

      $strSqlWherePageIds = '';
      if(count($arrPageIds) > 0){
        $strSqlWherePageIds = ' WHERE pages.id IN ('.implode(',',$arrPageIds).')';
      }

      $sqlStmt = $this->core->dbh->query('SELECT pages.id,
                                            '.$strSqlInstanceFields.'
                                            files.filename, fileTitles.title AS filetitle
                                          FROM pages
                                          LEFT JOIN `page-'.$strGenForm.'-Instances` ON
                                            `page-'.$strGenForm.'-Instances`.pageId = pages.pageId AND
                                            `page-'.$strGenForm.'-Instances`.version = pages.version AND
                                            `page-'.$strGenForm.'-Instances`.idLanguages = ?
                                          LEFT JOIN `page-'.$strGenForm.'-InstanceFiles` AS iFiles ON
                                            iFiles.id = (SELECT iFl.id FROM `page-'.$strGenForm.'-InstanceFiles` AS iFl
                                                         WHERE iFl.pageId = pages.pageId AND iFl.version = pages.version AND iFl.idFields IN (5,55)
                                                         ORDER BY iFl.idFields DESC LIMIT 1)
                                          LEFT JOIN files ON
                                            files.id = iFiles.idFiles AND
                                            files.isImage = 1
                                          LEFT JOIN fileTitles ON
                                            fileTitles.idFiles = files.id AND
                                            fileTitles.idLanguages = ?
                                          '.$strSqlWherePageIds, array($this->intLanguageId, $this->intLanguageId));

      return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
    }
  }

  /**
   * loadPageInstanceDataById
   * @param integer $intPageId
   * @param string $strGenForm
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadPageInstanceDataById($intPageId, $strGenForm){
    $this->core->logger->debug('cms->models->Model_Pages->loadPageInstanceDataById('.$intPageId.', '.$strGenForm.')');

    // FIXME : !!! iFl.idFields IN (5,55) -> define
    if($strGenForm != '' && $strGenForm != '-' && strpos($strGenForm, $this->core->sysConfig->page_types->link->default_formId) === false){
      $sqlStmt = $this->core->dbh->query('SELECT pages.id AS pId, `page-'.$strGenForm.'-Instances`.*,
                                            files.filename, fileTitles.title AS filetitle, urls.url
                                          FROM pages
                                          LEFT JOIN `page-'.$strGenForm.'-Instances` ON
                                            `page-'.$strGenForm.'-Instances`.pageId = pages.pageId AND
                                            `page-'.$strGenForm.'-Instances`.version = pages.version AND
                                            `page-'.$strGenForm.'-Instances`.idLanguages = ?
                                          LEFT JOIN `page-'.$strGenForm.'-InstanceFiles` AS iFiles ON
                                            iFiles.id = (SELECT iFl.id FROM `page-'.$strGenForm.'-InstanceFiles` AS iFl
                                                         WHERE iFl.pageId = pages.pageId AND iFl.version = pages.version AND iFl.idFields IN (5,55)
                                                         ORDER BY iFl.idFields DESC LIMIT 1)
                                          LEFT JOIN files ON
                                            files.id = iFiles.idFiles AND
                                            files.isImage = 1
                                          LEFT JOIN fileTitles ON
                                            fileTitles.idFiles = files.id AND
                                            fileTitles.idLanguages = ?
                                          LEFT JOIN urls ON
                                            urls.relationId = pages.pageId AND
                                            urls.version = pages.version AND
                                            urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                            urls.idLanguages = ? AND
                                            urls.idParent IS NULL AND
                                            urls.isMain = 1
                                          WHERE pages.id = ?', array($this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $intPageId));

      return $sqlStmt->fetch(Zend_Db::FETCH_OBJ);
    }
  }

  /**
   * deletePageLink
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function deletePageLink($intElementId){
    $this->core->logger->debug('cms->models->Model_Pages->deletePageLink('.$intElementId.')');

    $this->getPageLinksTable();

    $strWhere = $this->objPageLinksTable->getAdapter()->quoteInto('idPages = ?', $intElementId);
    return $this->objPageLinksTable->delete($strWhere);
  }

  /**
   * deleteInternalLinks
   * @param string $strElementId
   * @param integer $intVersion
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function deleteInternalLinks($strElementId, $intVersion){
    $this->core->logger->debug('cms->models->Model_Pages->deleteInternalLinks('.$strElementId.','.$intVersion.')');

    $strWhere = $this->getPageInternalLinksTable()->getAdapter()->quoteInto('pageId = ?', $strElementId);
    $strWhere .= $this->objPageInternalLinksTable->getAdapter()->quoteInto(' AND version = ?', $intVersion);
    $strWhere .= $this->objPageInternalLinksTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);

    return $this->objPageInternalLinksTable->delete($strWhere);
  }

  /**
   * deletePageCollection
   * @param string $strElementId
   * @param integer $intVersion
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function deletePageCollection($strElementId, $intVersion){
    $this->core->logger->debug('cms->models->Model_Pages->deletePageCollection('.$strElementId.','.$intVersion.')');

    $strWhere = $this->getPageCollectionTable()->getAdapter()->quoteInto('pageId = ?', $strElementId);
    $strWhere .= $this->objPageCollectionTable->getAdapter()->quoteInto(' AND version = ?', $intVersion);
    $strWhere .= $this->objPageCollectionTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);

    return $this->objPageCollectionTable->delete($strWhere);
  }

  /**
   * deletePageCollectionUrls
   * @param integer $intParentId
   * @param integer $intParentTypeId
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function deletePageCollectionUrls($intParentId, $intParentTypeId){
    $this->core->logger->debug('cms->models->Model_Pages->deletePageCollectionUrls('.$intParentId.','.$intParentTypeId.')');

    $strWhere = $this->getPageUrlTable()->getAdapter()->quoteInto('idParent = ?', $intParentId);
    $strWhere .= $this->objPageUrlTable->getAdapter()->quoteInto(' AND idParentTypes = ?', $intParentTypeId);
    $strWhere .= $this->objPageUrlTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);

    return $this->objPageUrlTable->delete($strWhere);
  }

  /**
   * loadPageLink
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadLinkPage($intElementId){
    $this->core->logger->debug('cms->models->Model_Pages->loadLinkPage('.$intElementId.')');

    $objSelect = $this->getPageTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('pages', array('id', 'pageId', 'version'));
    $objSelect->join('pageTitles', 'pageTitles.pageId = pages.pageId AND pageTitles.version = pages.version AND pageTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->joinleft('urls', 'urls.relationId = pages.pageId AND urls.version = pages.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1 AND urls.idParent IS NULL', array('url'));
    $objSelect->joinleft('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->where('pages.id = ?', $intElementId);

    return $this->objPageTable->fetchAll($objSelect);
  }

  /**
   * deletePage
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function deletePage($intElementId){
    $this->core->logger->debug('cms->models->Model_Pages->deletePage('.$intElementId.')');

    $this->getPageTable();

    $objPageData = $this->load($intElementId);

    if(count($objPageData) > 0){
      $objPage = $objPageData->current();
      $strIndexPath = GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->page;
      $strPageId = $objPage->pageId;

      if(count(scandir($strIndexPath)) > 2){
        $this->objIndex = Zend_Search_Lucene::open($strIndexPath);

        $objTerm = new Zend_Search_Lucene_Index_Term($strPageId.'_'.$this->intLanguageId, 'key');
        $objQuery = new Zend_Search_Lucene_Search_Query_Term($objTerm);

        $objHits = $this->objIndex->find($objQuery);

        foreach($objHits as $objHit){
          $this->objIndex->delete($objHit->id);
        }

        $this->objIndex->commit();
      }
    }


    $strWhere = $this->objPageTable->getAdapter()->quoteInto('id = ?', $intElementId);
    return $this->objPageTable->delete($strWhere);
  }
  
  /**
   * loadUrl
   * @param string $strPageId
   * @param integer $intVersion
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadUrl($strPageId, $intVersion){
    $this->core->logger->debug('cms->models->Model_Pages->loadUrl('.$strPageId.', '.$intVersion.')');

    $objSelect = $this->getPageUrlTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objPageUrlTable, array('url'));
    $objSelect->join('pages', 'pages.pageId = urls.relationId', array('isStartPage'));
    $objSelect->joinleft('folders', 'pages.idParent = folders.id AND pages.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array('depth','idParentFolder'));
    $objSelect->join('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->where('urls.relationId = ?', $strPageId)
              ->where('urls.version = ?', $intVersion)
              ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->page)
              ->where('urls.idLanguages = ?', $this->intLanguageId)
              ->where('urls.isMain = 1')
              ->where('urls.idParent IS NULL');

    return $this->objPageUrlTable->fetchAll($objSelect);
  }
  
  /**
   * loadUrlHistory
   * @param str $strPageId
   * @param integer $intLanguageId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  public function loadUrlHistory($intPageId, $intLanguageId){
    $this->core->logger->debug('cms->models->Model_Pages->loadPageUrlHistory('.$intPageId.', '.$intLanguageId.')');

    $objSelect = $this->getPageTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objPageTable, array('pageId', 'relationId' => 'pageId', 'version', 'isStartpage'))
              ->join('urls', 'urls.relationId = pages.pageId AND urls.version = pages.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND urls.idLanguages = '.$intLanguageId.' AND urls.isMain = 0 AND urls.idParent IS NULL', array('id', 'url'))
              ->join('languages', 'languages.id = urls.idLanguages', array('languageCode'))
              ->where('pages.id = ?', $intPageId);

    return $this->objPageTable->fetchAll($objSelect);
  }
  
  /**
   * loadParentUrl
   * @param integer $intPageId
   * @param boolean $blnIsStartElement
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadParentUrl($intPageId, $blnIsStartElement){
    $this->core->logger->debug('cms->models->Model_Pages->loadParentUrl('.$intPageId.','.$blnIsStartElement.')');
    
    $objSelect = $this->getPageUrlTable()->select();
    $objSelect->setIntegrityCheck(false);

    if($blnIsStartElement == true){
      $objSelect->from($this->objPageUrlTable, array('url','id'));
      $objSelect->join('pages', 'pages.pageId = urls.relationId', array('pageId','version','isStartpage'));
      $objSelect->join('folders', 'folders.id = (SELECT idParent FROM pages WHERE id = '.$intPageId.')', array());
      $objSelect->where('urls.version = pages.version')
                ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->page)
                ->where('urls.idLanguages = ?', $this->intLanguageId)
                ->where('urls.isMain = 1')
                ->where('pages.idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
                ->where('pages.idParent = folders.idParentFolder')
                ->where('pages.isStartPage = 1');
    }else{
      $objSelect->from($this->objPageUrlTable, array('url','id'));
      $objSelect->join('pages', 'pages.pageId = urls.relationId', array('pageId','version','isStartpage'));
      $objSelect->where('urls.version = pages.version')
                ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->page)
                ->where('urls.idLanguages = ?', $this->intLanguageId)
                ->where('urls.isMain = 1')
                ->where('pages.idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
                ->where('pages.idParent = (SELECT idParent FROM pages WHERE id = '.$intPageId.')')
                ->where('pages.isStartPage = 1');
    }

    return $this->objPageUrlTable->fetchAll($objSelect);
  }

  /**
   * getChildUrls
   * @param integer $intParentId
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getChildUrls($intParentId){

    $objSelect = $this->getPageTable()->select();
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from($this->objPageTable, array('id', 'pageId', 'relationId' => 'pageId', 'version'))
              ->joinInner('urls', 'urls.relationId = pages.pageId AND urls.version = pages.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1', array('id', 'url'))
              ->joinInner('folders AS parent', 'parent.id = '.$intParentId, array())
              ->joinInner('folders', 'folders.lft BETWEEN parent.lft AND parent.rgt AND folders.idRootLevels = parent.idRootLevels', array())
              ->where('pages.idParent = folders.id')
              ->where('pages.idParentTypes = ?', $this->core->sysConfig->parent_types->folder);
    
    return $this->objPageTable->fetchAll($objSelect);
  }

  /**
   * loadByUrl
   * @param integer $intRootLevelId
   * @param string $strUrl
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadByUrl($intRootLevelId, $strUrl){
    $this->core->logger->debug('cms->models->Model_Pages->loadByUrl('.$intRootLevelId.', '.$strUrl.')');

    $sqlStmt = $this->core->dbh->query('SELECT pages.pageId, pages.version, urls.idLanguages, urls.idParent, urls.idParentTypes
                                          FROM urls
                                            INNER JOIN pages ON
                                              pages.pageId = urls.relationId AND
                                              pages.version = urls.version AND
                                              pages.idParentTypes = ?
                                            INNER JOIN folders ON
                                              folders.id = pages.idParent
                                            WHERE urls.url = ? AND
                                              urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                              urls.idLanguages = ? AND
                                              folders.idRootLevels = ?
                                        UNION
                                        SELECT pages.pageId, pages.version, urls.idLanguages, urls.idParent, urls.idParentTypes
                                          FROM urls
                                            INNER JOIN pages ON
                                              pages.pageId = urls.relationId AND
                                              pages.version = urls.version AND
                                              pages.idParentTypes = ?
                                            INNER JOIN rootLevels ON
                                              rootLevels.id = pages.idParent
                                            WHERE urls.url = ? AND
                                              urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                              urls.idLanguages = ? AND
                                              rootLevels.id = ?', array($this->core->sysConfig->parent_types->folder,
                                                                        $strUrl,
                                                                        $this->intLanguageId,
                                                                        $intRootLevelId,
                                                                        $this->core->sysConfig->parent_types->rootlevel,
                                                                        $strUrl,
                                                                        $this->intLanguageId,
                                                                        $intRootLevelId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadAllPublicPages
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadAllPublicPages(){
    $this->core->logger->debug('cms->models->Model_Pages->loadAllPublicPages()');

    $objSelect = $this->getPageUrlTable()->select();

    $objSelect->from($this->objPageUrlTable, array('pages.pageId', 'version', 'idLanguages'));
    $objSelect->join('pages', 'pages.pageId = urls.relationId AND pages.version = urls.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->page, array());
    $objSelect->where('pages.idStatus = ?', $this->core->sysConfig->status->live)
              ->where('pages.idPageTypes != ?', $this->core->sysConfig->page_types->link->id);

    return $this->objPageUrlTable->fetchAll($objSelect);
  }

  /**
   * loadVideo
   * @param string $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadVideo($intElementId){
    $this->core->logger->debug('cms->models->Model_Pages->loadVideo('.$intElementId.')');

    $objSelect = $this->getPageVideosTable()->select();
    $objSelect->from($this->objPageVideosTable, array('userId', 'videoId', 'idVideoTypes', 'thumb'));
    $objSelect->join('pages', 'pages.pageId = pageVideos.pageId AND pages.version = pageVideos.version', array());
    $objSelect->where('pages.id = ?', $intElementId)
              ->where('idLanguages = ?', $this->getLanguageId());

    return $this->objPageVideosTable->fetchAll($objSelect);
  }

  /**
   * addVideo
   * @param  integer $intElementId
   * @param  mixed $mixedVideoId
   * @param  integer $intVideoTypeId
   * @param  string $strVideoUserId
   * @param  string $strVideoThumb
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addVideo($intElementId, $mixedVideoId, $intVideoTypeId, $strVideoUserId, $strVideoThumb){
    $this->core->logger->debug('cms->models->Model_Pages->addVideo('.$intElementId.','.$mixedVideoId.','.$intVideoTypeId.','.$strVideoUserId.','.$strVideoThumb.')');

    $objPageData = $this->load($intElementId);

    if(count($objPageData) > 0){
      $objPage = $objPageData->current();

      $this->getPageVideosTable();

      $strWhere = $this->objPageVideosTable->getAdapter()->quoteInto('pageId = ?', $objPage->pageId);
      $strWhere .= 'AND '.$this->objPageVideosTable->getAdapter()->quoteInto('version = ?', $objPage->version);
      $this->objPageVideosTable->delete($strWhere);

      if($mixedVideoId != ''){
        $intUserId = Zend_Auth::getInstance()->getIdentity()->id;
        $arrData = array('pageId'       => $objPage->pageId,
                         'version'      => $objPage->version,
                         'idLanguages'  => $this->intLanguageId,
                         'userId'       => $strVideoUserId,
                         'videoId'      => $mixedVideoId,
                         'idVideoTypes' => $intVideoTypeId,
                         'thumb'        => $strVideoThumb,
                         'creator'      => $intUserId);
        return $objSelect = $this->objPageVideosTable->insert($arrData);
      }
    }
  }

  /**
   * removeVideo
   * @param  integer $intElementId
   * @return integer affected rows
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function removeVideo($intElementId){
    $this->core->logger->debug('cms->models->Model_Pages->removeVideo('.$intElementId.')');

    $objPageData = $this->load($intElementId);

    if(count($objPageData) > 0){
      $objPage = $objPageData->current();

      $this->getPageVideosTable();

      $strWhere = $this->objPageVideosTable->getAdapter()->quoteInto('pageId = ?', $objPage->pageId);
      $strWhere .= 'AND '.$this->objPageVideosTable->getAdapter()->quoteInto('version = ?', $objPage->version);

      return $this->objPageVideosTable->delete($strWhere);
    }
  }

  /**
   * loadContacts
   * @param string $intElementId
   * @param  integer $intFieldId
   * @return string
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadContacts($intElementId, $intFieldId){
    $this->core->logger->debug('cms->models->Model_Pages->loadVideo('.$intElementId.','.$intFieldId.')');

    $objSelect = $this->getPageContactsTable()->select();
    $objSelect->from($this->objPageContactsTable, array('idContacts'));
    $objSelect->join('pages', 'pages.pageId = pageContacts.pageId AND pages.version = pageContacts.version', array());
    $objSelect->where('pages.id = ?', $intElementId)
              ->where('idFields = ?', $intFieldId);

    $arrPageContactData = $this->objPageContactsTable->fetchAll($objSelect);

    $strContactIds = '';
    foreach($arrPageContactData as $objPageContact){
      $strContactIds .= '['.$objPageContact->idContacts.']';
    }

    return $strContactIds;
  }

  /**
   * addContact
   * @param  integer $intElementId
   * @param  string $strContactIds
   * @param  integer $intFieldId
   * @return Zend_Db_Table_Rowset_Abstract
   * @version 1.0
   */
  public function addContact($intElementId, $strContactIds, $intFieldId){
    $this->core->logger->debug('cms->models->Model_Pages->addContact('.$intElementId.','.$strContactIds.','.$intFieldId.')');

    $objPageData = $this->load($intElementId);

    if(count($objPageData) > 0){
      $objPage = $objPageData->current();

      $this->getPageContactsTable();

      $strWhere = $this->objPageContactsTable->getAdapter()->quoteInto('pageId = ?', $objPage->pageId);
      $strWhere .= 'AND '.$this->objPageContactsTable->getAdapter()->quoteInto('version = ?', $objPage->version);
      $this->objPageContactsTable->delete($strWhere);

      $strContactIds = trim($strContactIds, '[]');
      $arrContactIds = split('\]\[', $strContactIds);

      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

      foreach($arrContactIds as $intContactId){
        $arrData = array('pageId'       => $objPage->pageId,
                         'version'      => $objPage->version,
                         'idContacts'   => $intContactId,
                         'idFields'     => $intFieldId,
                         'creator'      => $intUserId);
        $this->objPageContactsTable->insert($arrData);
      }
    }
  }

  /**
   * loadParentFolders
   * @param integer $intPageId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadParentFolders($intPageId){
    $this->core->logger->debug('cms->models->Model_Pages->loadParentFolders('.$intPageId.')');

    $sqlStmt = $this->core->dbh->query('SELECT folders.id, folders.isUrlFolder, folderTitles.title
                                          FROM folders
                                            INNER JOIN folderTitles ON
                                              folderTitles.folderId = folders.folderId AND
                                              folderTitles.version = folders.version AND
                                              folderTitles.idLanguages = ?
                                          ,folders AS parent
                                            INNER JOIN pages ON
                                              pages.id = ? AND
                                              parent.id = pages.idParent AND
                                              pages.idParentTypes = ?
                                           WHERE folders.lft <= parent.lft AND
                                                 folders.rgt >= parent.rgt AND
                                                 folders.idRootLevels = parent.idRootLevels
                                             ORDER BY folders.rgt', array($this->intLanguageId, $intPageId, $this->core->sysConfig->parent_types->folder));



    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadPagesByTemplatedId
   * @param integer $intTemplateId
   * @param integer $intQuarter
   * @param integer $intYear
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadPagesByTemplatedId($intTemplateId, $intQuarter = 0, $intYear = 0){
    $this->core->logger->debug('cms->models->Model_Pages->loadPagesByTemplatedId('.$intTemplateId.')');

    $objSelect = $this->getPageTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('pages', array('id', 'pageId', 'version', 'created', 'changed', 'published'));
    $objSelect->join('pageTitles', 'pageTitles.pageId = pages.pageId AND pageTitles.version = pages.version AND pageTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->join('genericForms', 'genericForms.id = pages.idGenericForms', array('genericFormId', 'version AS genericFormVersion', 'idGenericFormTypes'));
    if($intTemplateId == $this->core->sysConfig->page_types->page->event_templateId){
	    $objSelect->join('pageDatetimes', 'pageDatetimes.pageId = pages.pageId AND pageDatetimes.version = pages.version AND pageDatetimes.idLanguages = '.$this->intLanguageId, array('datetime'));
    }
    $objSelect->joinleft('urls', 'urls.relationId = pages.pageId AND urls.version = pages.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1 AND urls.idParent IS NULL', array('url'));
    $objSelect->joinleft('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->where('pages.idTemplates = ?', $intTemplateId);
    if($intTemplateId == $this->core->sysConfig->page_types->page->event_templateId){
      $timestamp = time();
      if($intQuarter > 0 && $intQuarter <= 4){
        $intCurrQuarter = $intQuarter;
      }else{
        $intCurrQuarter = ceil(date('m', $timestamp) / 3);
      }

      if($intYear > 0){
        $intCurrYear = $intYear;
      }else{
        $intCurrYear = date('Y', $timestamp);
      }
      $objSelect->where('QUARTER(STR_TO_DATE(pageDatetimes.datetime, \'%d.%m.%Y\')) = ?', $intCurrQuarter);
      $objSelect->where('SUBSTRING(STR_TO_DATE(pageDatetimes.datetime, \'%d.%m.%Y\'),1,4) = ?', $intCurrYear);
    }
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $timestamp = time();
      $now = date('Y-m-d H:i:s', $timestamp);
    	$objSelect->where('pages.idStatus = ?', $this->core->sysConfig->status->live);
    	$objSelect->where('pages.published <= \''.$now.'\'');
    }
    if($intTemplateId == $this->core->sysConfig->page_types->page->event_templateId){
      $objSelect->order('STR_TO_DATE(pageDatetimes.datetime, \'%d.%m.%Y\') ASC');
    }

    return $this->objPageTable->fetchAll($objSelect);
  }

  /**
   * loadPagesByCategory
   * @param integer $intCategoryId
   * @param integer $intLabelId
   * @param integer $intLimitNumber
   * @param integer $intSortTypeId
   * @param integer $intSortOrderId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadPagesByCategory($intRootLevelId, $intCategoryId = 0, $intLabelId = 0, $intLimitNumber = 0, $intSortTypeId = 0, $intSortOrderId = 0){
    $this->core->logger->debug('cms->models->Model_Pages->loadPagesByCategory('.$intRootLevelId.','.$intCategoryId.','.$intLabelId.','.$intLimitNumber.','.$intSortTypeId.','.$intSortOrderId.')');

    $strSortOrder = '';
    if($intSortOrderId > 0 && $intSortOrderId != ''){
      switch($intSortOrderId){
        case $this->core->sysConfig->sort->orders->asc->id:
          $strSortOrder = 'ASC';
          break;
        case $this->core->sysConfig->sort->orders->desc->id:
          $strSortOrder = 'DESC';
          break;
      }
    }

    $strSqlOrderBy = '';
    if($intSortTypeId > 0 && $intSortTypeId != ''){
      switch($intSortTypeId){
        case $this->core->sysConfig->sort->types->manual_sort->id:
          $strSqlOrderBy = ' ORDER BY pages.sortPosition '.$strSortOrder.', pages.sortTimestamp '.(($strSortOrder == 'DESC') ? 'ASC' : 'DESC').', pages.id ASC';
          break;
        case $this->core->sysConfig->sort->types->created->id:
          $strSqlOrderBy = ' ORDER BY pages.created '.$strSortOrder;
          break;
        case $this->core->sysConfig->sort->types->changed->id:
          $strSqlOrderBy = ' ORDER BY pages.changed '.$strSortOrder;
          break;
        case $this->core->sysConfig->sort->types->published->id:
          $strSqlOrderBy = ' ORDER BY pages.published '.$strSortOrder;
          break;
        case $this->core->sysConfig->sort->types->alpha->id:
          $strSqlOrderBy = ' ORDER BY pageTitles.title '.$strSortOrder;
      }
    }

    $strSqlCategoryTitle = '';
    $strSqlCategory = '';
    $strSqlCategoryTitleJoin = '';
    if($intCategoryId > 0 && $intCategoryId != ''){
    	$strSqlCategoryTitle = ' categoryTitles.title AS catTitle,';
    	$strSqlCategory = ' INNER JOIN pageCategories ON
                            pageCategories.pageId = pages.pageId AND
                            pageCategories.version = pages.version AND
                            pageCategories.category = '.$intCategoryId;
    	$strSqlCategoryTitleJoin = '
    	                     LEFT JOIN categoryTitles ON
                             categoryTitles.idCategories = pageCategories.category';
    }

    $strSqlLabel = '';
    if($intLabelId > 0 && $intLabelId != ''){
      $strSqlLabel = ' INNER JOIN pageLabels ON
                         pageLabels.pageId = pages.pageId AND
                         pageLabels.version = pages.version AND
                         pageLabels.label = '.$intLabelId;
    }

    $strSqlLimit = '';
    if($intLimitNumber > 0 && $intLimitNumber != ''){
      $strSqlLimit = ' LIMIT '.$intLimitNumber;
    }

    $strPageFilter = '';
    $strPublishedFilter = '';
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $timestamp = time();
      $now = date('Y-m-d H:i:s', $timestamp);
    	$strPageFilter = 'AND pages.idStatus = '.$this->core->sysConfig->status->live;
    	$strPublishedFilter = ' AND pages.published <= \''.$now.'\'';
    }

    if($intRootLevelId > 0 && $intRootLevelId != ''){
      $sqlStmt = $this->core->dbh->query('SELECT DISTINCT pages.id, pages.pageId, pages.version, pages.created, pages.published,
                                          genericForms.genericFormId, genericForms.version AS genericFormVersion, genericForms.idGenericFormTypes,
                                          pageVideos.videoId, pageVideos.thumb, pageVideos.idVideoTypes,
                                          '.$strSqlCategoryTitle.' pageTitles.title
                                        FROM pages
                                        '.$strSqlCategory.'
                                        '.$strSqlLabel.'
                                        INNER JOIN folders ON
                                          folders.id = pages.idParent
                                        INNER JOIN genericForms ON
                                          genericForms.id = pages.idGenericForms
                                        INNER JOIN pageVideos ON
                                          pageVideos.pageId = pages.pageId AND
                                          pageVideos.version = pages.version AND
                                          pageVideos.idLanguages = ?
                                        '.$strSqlCategoryTitleJoin.'
                                        LEFT JOIN pageTitles ON
                                          pageTitles.pageId = pages.pageId AND
                                          pageTitles.version = pages.version AND
                                          pageTitles.idLanguages = ?
                                        WHERE NOT genericForms.genericFormId = ? AND
                                          folders.idRootLevels = ?
                                        '.$strPageFilter.'
                                        '.$strPublishedFilter.'
                                        '.$strSqlOrderBy.'
                                        '.$strSqlLimit, array($this->intLanguageId,
                                                              $this->intLanguageId,
                                                              $this->core->sysConfig->page_types->link->default_formId,
                                                              $intRootLevelId));

      return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
    }
  }

  /**
   * getPageTable
   * @return Zend_Db_Table_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getPageTable(){

    if($this->objPageTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/Pages.php';
      $this->objPageTable = new Model_Table_Pages();
    }

    return $this->objPageTable;
  }

  /**
   * getPageUrlTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getPageUrlTable(){

    if($this->objPageUrlTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/Urls.php';
      $this->objPageUrlTable = new Model_Table_Urls();
    }

    return $this->objPageUrlTable;
  }

  /**
   * getPageLinksTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getPageLinksTable(){

    if($this->objPageLinksTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/PageLinks.php';
      $this->objPageLinksTable = new Model_Table_PageLinks();
    }

    return $this->objPageLinksTable;
  }

  /**
   * getPageInternalLinksTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getPageInternalLinksTable(){

    if($this->objPageInternalLinksTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/PageInternalLinks.php';
      $this->objPageInternalLinksTable = new Model_Table_PageInternalLinks();
    }

    return $this->objPageInternalLinksTable;
  }

  /**
   * getPageCollectionTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getPageCollectionTable(){

    if($this->objPageCollectionTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/PageCollections.php';
      $this->objPageCollectionTable = new Model_Table_PageCollections();
    }

    return $this->objPageCollectionTable;
  }

  /**
   * getPageVideosTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getPageVideosTable(){

    if($this->objPageVideosTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/PageVideos.php';
      $this->objPageVideosTable = new Model_Table_PageVideos();
    }

    return $this->objPageVideosTable;
  }

  /**
   * getPageContactsTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getPageContactsTable(){

    if($this->objPageContactsTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/PageContacts.php';
      $this->objPageContactsTable = new Model_Table_PageContacts();
    }

    return $this->objPageContactsTable;
  }

  /**
   * Returns a table for a plugin
   * @param string $type The type of the plugin
   * @return Zend_Db_Table_Abstract
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function getPluginTable($type) {
    require_once(GLOBAL_ROOT_PATH.'application/plugins/'.$type.'/data/models/Page'.$type.'.php');
    $strClass = 'Model_Table_Page'.$type;
    return new $strClass();
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