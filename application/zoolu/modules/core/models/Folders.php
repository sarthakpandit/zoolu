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
 * Model_Folders
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-17: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Model_Folders {

	private $intLanguageId;

  /**
   * @var Model_Table_Folders
   */
  protected $objFolderTable;

  /**
   * @var Model_Table_FolderProperties
   */
  protected $objFolderPropertyTable;
    
  /**
   * @var Model_Table_FolderPermissions
   */
  protected $objFolderPermissionTable;

  /**
   * @var Model_Table_RootLevels
   */
  protected $objRootLevelTable;

  /**
   * @var Model_Table_RootLevelUrls
   */
  protected $objRootLevelUrlTable;

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
   * load
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>    
   */
  public function load($intElementId){
    $this->core->logger->debug('core->models->Model_Folders->load('.$intElementId.')');

    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);    

    $objSelect->from('folders', array('id', 'folderId', 'relationId' => 'folderId', 'version'));
    $objSelect->joinLeft('folderProperties', 'folderProperties.folderId = folders.folderId AND folderProperties.version = folders.version AND folderProperties.idLanguages = '.$this->intLanguageId, array('idFolderTypes', 'showInNavigation', 'idStatus', 'isUrlFolder', 'published', 'changed', 'creator'));
    $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = folderProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
    $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = folderProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
    $objSelect->where('folders.id = ?', $intElementId);

    return $this->getFolderTable()->fetchAll($objSelect);
  }
  
  /**
   * add
   * @param GenericSetup $objGenericSetup
   * @return stdClass Folder
   * @author Thomas Schedler <tsh@massiveart.com>   
   */
  public function add(GenericSetup &$objGenericSetup){
    $this->core->logger->debug('cms->models->Model_Folders->add()');

    $objFolder = new stdClass();
    $objFolder->folderId = uniqid();
    $objFolder->version = 1;
    $objFolder->sortPosition = GenericSetup::DEFAULT_SORT_POSITION;
    $objFolder->parentId = $objGenericSetup->getParentId();
    $objFolder->rootLevelId = $objGenericSetup->getRootLevelId();
      
    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;
    
    /**
     * check if parent element is rootlevel or folder and get sort position
     */
    if($objGenericSetup->getParentId() != '' && $objGenericSetup->getParentId() > 0){
      $objNaviData = $this->loadChildNavigation($objFolder->parentId);
    }else{
      $objNaviData = $this->loadRootNavigation($objFolder->rootLevelId);
    }
    $objFolder->sortPosition = count($objNaviData);
    
    /**
     * insert main data
     */
    $arrMainData = array('folderId'         => $objFolder->folderId,
                         'version'          => $objFolder->version,
                         'sortPosition'     => $objFolder->sortPosition,
                         'sortTimestamp'    => date('Y-m-d H:i:s'),
                         'idUsers'          => $intUserId,
                         'creator'          => $objGenericSetup->getCreatorId(),
                         'created'          => date('Y-m-d H:i:s'));
    /**
     * add folder node to the "Nested Set Model"
     */
    $objFolder->id = $this->addFolderNode($objFolder->rootLevelId,
                                          $objFolder->parentId,
                                          $arrMainData);                                                           
                                                           
    /**
     * insert language specific properties
     */
    $arrProperties = array('folderId'         => $objFolder->folderId,
                           'version'          => $objFolder->version,
                           'idLanguages'      => $this->intLanguageId,
                           'idGenericForms'   => $objGenericSetup->getGenFormId(),
                           'idFolderTypes'    => $this->core->sysConfig->folder_types->folder,
                           'idUsers'          => $intUserId,
                           'creator'          => $objGenericSetup->getCreatorId(),
                           'publisher'        => $intUserId,
                           'created'          => date('Y-m-d H:i:s'),
                           'published'        => $objGenericSetup->getPublishDate(),
                           'idStatus'         => $objGenericSetup->getStatusId(),
                           'isUrlFolder'      => $objGenericSetup->getUrlFolder(),
                           'showInNavigation' => $objGenericSetup->getShowInNavigation());
    $this->getFolderPropertyTable()->insert($arrProperties);

    return $objFolder;          
  }
    
  /**
   * update
   * @param GenericSetup $objGenericSetup
   * @param object Folder
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function update(GenericSetup &$objGenericSetup, $objFolder){
    $this->core->logger->debug('cms->models->Model_Folders->update()');
    
    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $strWhere = $this->getFolderTable()->getAdapter()->quoteInto('folderId = ?', $objFolder->folderId);
    $strWhere .= $this->getFolderTable()->getAdapter()->quoteInto(' AND version = ?', $objFolder->version);

    $this->getFolderTable()->update(array('idUsers'  => $intUserId,
                                          'changed'  => date('Y-m-d H:i:s')), $strWhere);
    /**
     * update language specific folder properties
     */
    $strWhere .= $this->getFolderTable()->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);
    $intNumOfEffectedRows = $this->getFolderPropertyTable()->update(array('idGenericForms'   => $objGenericSetup->getGenFormId(),
                                                                          'idUsers'          => $intUserId,
                                                                          'creator'          => $objGenericSetup->getCreatorId(),
                                                                          'idStatus'         => $objGenericSetup->getStatusId(),
                                                                          'isUrlFolder'      => $objGenericSetup->getUrlFolder(),
                                                                          'showInNavigation' => $objGenericSetup->getShowInNavigation(),
                                                                          'published'        => $objGenericSetup->getPublishDate(),
                                                                          'changed'          => date('Y-m-d H:i:s')), $strWhere);
    
    /**
     * insert language specific folder properties
     */
    if($intNumOfEffectedRows == 0){      
      $arrProperties = array('folderId'         => $objFolder->folderId,
                             'version'          => $objFolder->version,
                             'idLanguages'      => $this->intLanguageId,
                             'idGenericForms'   => $objGenericSetup->getGenFormId(),
                             'idFolderTypes'    => $this->core->sysConfig->folder_types->folder,
                             'idUsers'          => $intUserId,
                             'creator'          => $objGenericSetup->getCreatorId(),
                             'publisher'        => $intUserId,
                             'created'          => date('Y-m-d H:i:s'),
                             'published'        => $objGenericSetup->getPublishDate(),
                             'idStatus'         => $objGenericSetup->getStatusId(),
                             'isUrlFolder'      => $objGenericSetup->getUrlFolder(),
                             'showInNavigation' => $objGenericSetup->getShowInNavigation());
      $this->getFolderPropertyTable()->insert($arrProperties);
    }
  }

  /**
   * loadAllRootLevels
   * @param integer $intRootLevelType
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadAllRootLevels($intRootLevelModule, $intRootLevelType = -1){
    $this->core->logger->debug('core->models->Folders->loadAllRootLevels('.$intRootLevelModule.', '.$intRootLevelType.')');

    $objSelect = $this->getRootLevelTable()->select();
    $objSelect->setIntegrityCheck(false);

    /**
     * SELECT rootLevels.id, rootLevels.idRootLevelTypes, rootLevelTitles.title FROM rootLevels
     * INNER JOIN rootLevelTitles ON rootLevelTitles.idRootLevels = rootLevels.id
     * WHERE rootLevelTitles.idLanguages = ?
     *  AND rootLevels.idModules = ?
     *  AND rootLevels.idRootLevelTypes = ?
     */
    $objSelect->from('rootLevels', array('id', 'idRootLevelTypes', 'href'));
    $objSelect->join('rootLevelTitles', 'rootLevelTitles.idRootLevels = rootLevels.id', array('title'));
    $objSelect->where('rootLevelTitles.idLanguages = ?', $this->intLanguageId);
    $objSelect->where('rootLevels.idModules = ?', $intRootLevelModule);
    $objSelect->where('rootLevels.active = 1');
    if($intRootLevelType != -1){
      $objSelect->where('rootLevels.idRootLevelTypes = ?', $intRootLevelType);
    }
    $objSelect->order('rootLevels.order');

    return $this->getRootLevelTable()->fetchAll($objSelect);
  }
  
  /**
   * loadAllRootLevelsWithGroups
   * @param integer $intRootLevelModule
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function loadAllRootLevelsWithGroups($intRootLevelModule){
    $this->core->logger->debug('core->models->Folders->loadAllRootLevels('.$intRootLevelModule.')');

    $objSelect = $this->getRootLevelTable()->select();
    $objSelect->setIntegrityCheck(false);

    /**
     * SELECT rootLevels.id, rootLevels.idRootLevelTypes, rootLevelTitles.title FROM rootLevels
     * INNER JOIN rootLevelTitles ON rootLevelTitles.idRootLevels = rootLevels.id
     * WHERE rootLevelTitles.idLanguages = ?
     *  AND rootLevels.idModules = ?
     *  AND rootLevels.idRootLevelTypes = ?
     */
    $objSelect->from('rootLevels', array('id', 'idRootLevelTypes', 'href', 'idRootLevelGroups'));
    $objSelect->join('rootLevelTitles', 'rootLevelTitles.idRootLevels = rootLevels.id', array('title'));
    $objSelect->join('rootLevelGroups', 'rootLevelGroups.id = rootLevels.idRootLevelGroups', array('name'));
    $objSelect->joinLeft('rootLevelGroupTitles', 'rootLevelGroupTitles.idRootLevelGroups = rootLevelGroups.id AND rootLevelGroupTitles.idLanguages = '.$this->intLanguageId, array('rootLevelGroupTitle' => 'title'));
    $objSelect->where('rootLevelTitles.idLanguages = ?', $this->intLanguageId);
    $objSelect->where('rootLevels.idModules = ?', $intRootLevelModule);
    $objSelect->where('rootLevels.active = 1');
    $objSelect->order('idRootLevelGroups');
    $objSelect->order('rootLevels.order');
    
    return $this->getRootLevelTable()->fetchAll($objSelect);
  }  

  /**
   * getThemeByDomain
   * @param string $strDomain
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getThemeByDomain($strDomain){
    $this->core->logger->debug('core->models->Folders->getThemeByDomain('.$strDomain.')');

    $objSelect = $this->getRootLevelUrlTable()->select();
    $objSelect->setIntegrityCheck(false);

    if(strpos($strDomain, 'www.') !== false){
      $strDomain = str_replace('www.', '', $strDomain);
    }

    /**
     * SELECT rootLevelUrls.id, rootLevelUrls.idRootLevels, rootLevelTitles.title, themes.path
     * FROM rootLevelUrls
     *   INNER JOIN rootLevels ON
     *     rootLevels.id = rootLevelUrls.idRootLevels
     *   INNER JOIN rootLevelTitles ON
     *     rootLevelTitles.idRootLevels = rootLevels.id AND rootLevelTitles.idLanguages = ?
     *   INNER JOIN themes ON
     *     themes.id = rootLevels.idThemes
     * WHERE rootLevelUrls.url = ?
     */
    $objSelect->from('rootLevelUrls', array('id', 'idRootLevels'));
    $objSelect->join('rootLevels', 'rootLevels.id = rootLevelUrls.idRootLevels', array());
    $objSelect->joinLeft('rootLevelTitles', 'rootLevelTitles.idRootLevels = rootLevels.id AND rootLevelTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->join('themes', 'themes.id = rootLevels.idThemes', array('path'));
    $objSelect->where('rootLevelUrls.url = ?', $strDomain);

    return $this->getRootLevelUrlTable()->fetchAll($objSelect);

  }

  /**
   * loadRootNavigation
   * @param integer $intRootId
   * @param string $strSortTimestampOrderType = 'DESC'
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadRootNavigation($intRootId, $strSortTimestampOrderType = 'DESC'){
    $this->core->logger->debug('core->models->Folders->loadRootNavigation('.$intRootId.')');
      
    $sqlStmt = $this->core->dbh->query('SELECT id, title, genericFormId, version, templateId, folderType, pageType, type, isStartPage, sortPosition, sortTimestamp, idStatus, pageLinkTitle
																	      FROM (SELECT folders.id, folderTitles.title, genericForms.genericFormId, genericForms.version, -1 AS templateId, folderProperties.idFolderTypes AS folderType, -1 AS pageType, folderTypes.title As type, -1 AS isStartPage, folders.sortPosition, folders.sortTimestamp, folderProperties.idStatus,
																	                   -1 AS pageLinkTitle
																	            FROM folders
																	            INNER JOIN folderProperties ON folderProperties.folderId = folders.folderId 
                                               AND folderProperties.version = folders.version 
                                               AND folderProperties.idLanguages = ?
																				      LEFT JOIN folderTitles ON folderTitles.folderId = folders.folderId
																				        AND folderTitles.version = folders.version AND folderTitles.idLanguages = ?
																				      INNER JOIN genericForms ON genericForms.id = folderProperties.idGenericForms
																				      INNER JOIN folderTypes ON folderTypes.id = folderProperties.idFolderTypes
																				      WHERE folders.idRootLevels = ? AND
																				            folders.idParentFolder = 0
																	            UNION
																	            SELECT pages.id, pageTitles.title, genericForms.genericFormId, genericForms.version, pageProperties.idTemplates  AS templateId, -1 AS folderType, pageProperties.idPageTypes AS pageType, pageTypes.title As type, pages.isStartPage, pages.sortPosition, pages.sortTimestamp, pageProperties.idStatus,
																	                   (SELECT pt.title FROM pageLinks, pages AS p LEFT JOIN pageTitles AS pt ON pt.pageId = p.pageId AND pt.version = p.version AND pt.idLanguages = ? WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1) AS pageLinkTitle
																	            FROM pages
																	            INNER JOIN pageProperties ON pageProperties.pageId = pages.pageId 
																	             AND pageProperties.version = pages.version 
																	             AND pageProperties.idLanguages = ?
																	            LEFT JOIN pageTitles ON pageTitles.pageId = pages.pageId
																	              AND pageTitles.version = pages.version
																	              AND pageTitles.idLanguages = ?
																	            INNER JOIN pageTypes ON pageTypes.id = pageProperties.idPageTypes
																	            INNER JOIN genericForms ON genericForms.id = pageProperties.idGenericForms
																	            WHERE pages.idParent = ?
																	              AND pages.idParentTypes = ?
																	              AND pages.id = (SELECT p.id FROM pages p WHERE p.pageId = pages.pageId ORDER BY p.version DESC LIMIT 1))
																	      AS tbl
																	      ORDER BY sortPosition ASC, sortTimestamp '.$strSortTimestampOrderType.', id ASC', array($this->intLanguageId, $this->intLanguageId, $intRootId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $intRootId, $this->core->sysConfig->parent_types->rootlevel));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadGlobalRootNavigation
   * @param integer $intRootLevelId
   * @param integer $intRootLevelGroupId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadGlobalRootNavigation($intRootLevelId, $intRootLevelGroupId){
    $this->core->logger->debug('core->models->Folders->loadGlobalRootNavigation('.$intRootLevelId.','.$intRootLevelGroupId.')');

    $objFolderSelect = $this->core->dbh->select();
    $objFolderSelect->from('folders', array('id', 'templateId' => new Zend_Db_Expr('-1'), 'folderType' => 'folderProperties.idFolderTypes', 'globalType' => new Zend_Db_Expr('-1'), 'isStartGlobal' => new Zend_Db_Expr('-1'), 'sortPosition', 'sortTimestamp', 'folderProperties.idStatus', 'linkGlobalId' => new Zend_Db_Expr('-1')));
    $objFolderSelect->joinLeft('folderProperties', 'folderProperties.folderId = folders.folderId AND folderProperties.version = folders.version AND folderProperties.idLanguages = '.$this->intLanguageId, array());
    $objFolderSelect->joinLeft('folderTitles', 'folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objFolderSelect->join('genericForms', 'genericForms.id = folderProperties.idGenericForms', array('genericFormId', 'version'));
    $objFolderSelect->join('folderTypes', 'folderTypes.id = folderProperties.idFolderTypes', array('title AS type'));
    $objFolderSelect->where('folders.idRootLevels = ? AND folders.idParentFolder = 0', $intRootLevelId);

    if($intRootLevelGroupId == $this->core->sysConfig->root_level_groups->product){
      $objGlobalSelect = $this->core->dbh->select();
      $objGlobalSelect->from('globals', array('id', 'templateId' => 'globalProperties.idTemplates', 'folderType' => new Zend_Db_Expr('-1'), 'globalType' => 'globalProperties.idGlobalTypes', 'isStartGlobal', 'lP.sortPosition', 'lP.sortTimestamp', 'globalProperties.idStatus', 'linkGlobalId' => 'lP.id'));
      $objGlobalSelect->join('globalLinks', 'globalLinks.globalId = globals.globalId', array());
      $objGlobalSelect->join(array('lP' => 'globals'), 'lP.id = globalLinks.idGlobals', array());
      $objGlobalSelect->join('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->intLanguageId, array());
      $objGlobalSelect->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->intLanguageId, array('title'));
      $objGlobalSelect->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version'));
      $objGlobalSelect->join('globalTypes', 'globalTypes.id = globalProperties.idGlobalTypes', array('title AS type'));
      $objGlobalSelect->where('lP.idParent = ?', $intRootLevelId);
      $objGlobalSelect->where('lP.idParentTypes = ?', $this->core->sysConfig->parent_types->rootlevel);
      $objGlobalSelect->where('globals.id = (SELECT p.id FROM globals p WHERE p.globalId = globals.globalId ORDER BY p.version DESC LIMIT 1)');
    }else{
      $objGlobalSelect = $this->core->dbh->select();
      $objGlobalSelect->from('globals', array('id', 'templateId' => 'globalProperties.idTemplates', 'folderType' => new Zend_Db_Expr('-1'), 'globalType' => 'globalProperties.idGlobalTypes', 'isStartGlobal', 'sortPosition', 'sortTimestamp', 'globalProperties.idStatus', 'linkGlobalId' => new Zend_Db_Expr('-1')));
      $objGlobalSelect->join('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->intLanguageId, array());
      $objGlobalSelect->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->intLanguageId, array('title'));
      $objGlobalSelect->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version'));
      $objGlobalSelect->join('globalTypes', 'globalTypes.id = globalProperties.idGlobalTypes', array('title AS type'));
      $objGlobalSelect->where('globals.idParent = ?', $intRootLevelId);
      $objGlobalSelect->where('globals.idParentTypes = ?', $this->core->sysConfig->parent_types->rootlevel);
    }
    
    $objSelect = $this->getFolderTable()->select()
                                        ->union(array($objFolderSelect, $objGlobalSelect))
                                        ->order(array('sortPosition', 'sortTimestamp DESC', 'id'));

    return $this->getFolderTable()->fetchAll($objSelect);
  }

  /**
   * loadWebsiteRootNavigation
   * @param integer $intRootId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadWebsiteRootNavigation($intRootId){
    $this->core->logger->debug('core->models->Folders->loadWebsiteRootNavigation('.$intRootId.')');

    $strFolderFilter = '';
    $strPageFilter = '';
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $strFolderFilter = 'AND folderProperties.idStatus = '.$this->core->sysConfig->status->live;
      $strPageFilter = 'AND pageProperties.idStatus = '.$this->core->sysConfig->status->live;
    }

    $sqlStmt = $this->core->dbh->query('SELECT id, title, idStatus, url, pageId, folderId, sortPosition, sortTimestamp, isStartPage, (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                        FROM (SELECT DISTINCT folders.id, folderTitles.title, folderProperties.idStatus,
                                                              IF(pageProperties.idPageTypes = ?,
                                                                 (SELECT pU.url FROM pageLinks, pages AS p LEFT JOIN urls AS pU ON pU.relationId = p.pageId AND pU.version = p.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                                 (SELECT pU.url FROM urls AS pU WHERE pU.relationId = pages.pageId AND pU.version = pages.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 ORDER BY pU.version DESC LIMIT 1)) AS url,
                                                              IF(pageProperties.idPageTypes = ?,
                                                                 (SELECT p.pageId FROM pages AS p, pageLinks WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                                 pages.pageId) AS pageId,
                                                              folders.folderId, folders.sortPosition, folders.sortTimestamp, -1 AS isStartPage
                                              FROM folders
                                                INNER JOIN folderProperties ON 
                                                  folderProperties.folderId = folders.folderId AND 
                                                  folderProperties.version = folders.version AND 
                                                  folderProperties.idLanguages = ?
                                                INNER JOIN folderTitles ON
                                                  folderTitles.folderId = folders.folderId AND
                                                  folderTitles.version = folders.version AND
                                                  folderTitles.idLanguages = ?
                                                INNER JOIN pages ON
                                                  pages.idParent = folders.id AND
                                                  pages.idParentTypes = ? AND
                                                  pages.isStartPage = 1
                                                INNER JOIN pageProperties ON 
                                                  pageProperties.pageId = pages.pageId AND 
                                                  pageProperties.version = pages.version AND 
                                                  pageProperties.idLanguages = ?
                                                WHERE folders.idRootLevels = ? AND
                                                      folders.idParentFolder = 0 AND
                                                      folderProperties.showInNavigation = 1
                                                      '.$strFolderFilter.'
                                              UNION
                                              SELECT DISTINCT pages.id, pageTitles.title, pageProperties.idStatus,
                                                              IF(pageProperties.idPageTypes = ?,
                                                                 (SELECT pU.url FROM pageLinks, pages AS p LEFT JOIN urls AS pU ON pU.relationId = p.pageId AND pU.version = p.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1  WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                                 (SELECT pU.url FROM urls AS pU WHERE pU.relationId = pages.pageId AND pU.version = pages.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 ORDER BY pU.version DESC LIMIT 1)) AS url,
                                                              IF(pageProperties.idPageTypes = ?,
                                                                 (SELECT p.pageId FROM pages AS p, pageLinks WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                                 pages.pageId) AS pageId,
                                                              -1 AS folderId, pages.sortPosition, pages.sortTimestamp, pages.isStartPage
                                              FROM pages
                                                INNER JOIN pageProperties ON 
                                                  pageProperties.pageId = pages.pageId AND 
                                                  pageProperties.version = pages.version AND 
                                                  pageProperties.idLanguages = ?
                                                LEFT JOIN pageTitles ON
                                                  pageTitles.pageId = pages.pageId AND
                                                  pageTitles.version = pages.version AND
                                                  pageTitles.idLanguages = ?
                                                WHERE pages.idParent = ? AND
                                                      pages.idParentTypes = ? AND
                                                      pageProperties.showInNavigation = 1 AND
                                                      pages.id = (SELECT p.id FROM pages p WHERE p.pageId = pages.pageId ORDER BY p.version DESC LIMIT 1)
                                                      '.$strPageFilter.')
                                        AS tbl
                                        ORDER BY sortPosition ASC, sortTimestamp DESC, id ASC', array($this->intLanguageId, $this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->parent_types->folder, $this->intLanguageId, $intRootId, $this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $intRootId, $this->core->sysConfig->parent_types->rootlevel));


    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadWebsiteStaticSubNavigation
   * @param integer $intFolderId
   * @param integer $intDepth
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadWebsiteStaticSubNavigation($intFolderId, $intDepth){
    $this->core->logger->debug('core->models->Folders->loadWebsiteSubNavigation('.$intFolderId.','.$intDepth.')');

    $strFolderFilter = '';
    $strPageFilter = '';
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $strFolderFilter = 'AND folderProperties.idStatus = '.$this->core->sysConfig->status->live;
      $strPageFilter = 'AND pageProperties.idStatus = '.$this->core->sysConfig->status->live;
    }

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS idFolder, folders.folderId, folders.idParentFolder as parentId, folderTitles.title AS folderTitle, folderProperties.idStatus AS folderStatus, folders.depth, folders.sortPosition as folderOrder,
                                               pages.id AS idPage, pages.pageId, pageTitles.title AS pageTitle, pages.isStartPage, pageProperties.idStatus AS pageStatus, pages.sortPosition as pageOrder,
                                               IF(pageProperties.idPageTypes = ?,
                                                  (SELECT pU.url FROM pageLinks, pages AS p LEFT JOIN urls AS pU ON pU.relationId = p.pageId AND pU.version = p.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                  (SELECT pU.url FROM urls AS pU WHERE pU.relationId = pages.pageId AND pU.version = pages.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 ORDER BY pU.version DESC LIMIT 1)) AS url,
                                               (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                          FROM folders
                                            INNER JOIN folderProperties ON 
                                              folderProperties.folderId = folders.folderId AND 
                                              folderProperties.version = folders.version AND 
                                              folderProperties.idLanguages = ?
                                            INNER JOIN folderTitles ON
                                              folderTitles.folderId = folders.folderId AND
                                              folderTitles.version = folders.version AND
                                              folderTitles.idLanguages = ?
                                            LEFT JOIN pages ON
                                              pages.idParent = folders.id AND
                                              pages.idParentTypes = ?
                                            LEFT JOIN pageProperties ON 
                                              pageProperties.pageId = pages.pageId AND 
                                              pageProperties.version = pages.version AND 
                                              pageProperties.idLanguages = ?                                              
                                              '.$strPageFilter.'
                                            LEFT JOIN pageTitles ON
                                              pageTitles.pageId = pages.pageId AND
                                              pageTitles.version = pages.version AND
                                              pageTitles.idLanguages = ?
                                          ,folders AS parent
                                           WHERE parent.id = ? AND
                                                 folders.lft BETWEEN parent.lft AND parent.rgt AND
                                                 folders.idRootLevels = parent.idRootLevels AND
                                                 folders.depth <= ? AND
                                                 folderProperties.showInNavigation = 1 AND
                                                 pageProperties.showInNavigation = 1
                                                 '.$strFolderFilter.'
                                             ORDER BY folders.lft, pages.isStartPage DESC, pages.sortPosition ASC, pages.sortTimestamp DESC, pages.id ASC', array($this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->parent_types->folder, $this->intLanguageId, $this->intLanguageId, $intFolderId, $intDepth));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadFolderContentById
   * @param integer $intFolderId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadFolderContentById($intFolderId){
    $this->core->logger->debug('core->models->Folders->loadFolderContentById('.$intFolderId.')');

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS idFolder, folders.folderId, folders.idParentFolder as parentId, folderTitles.title AS folderTitle, folderProperties.idStatus AS folderStatus, folders.depth, folders.sortPosition as folderOrder,
                                               pages.id AS idPage, pages.pageId, pageTitles.title AS pageTitle, pages.isStartPage, pageProperties.idStatus AS pageStatus, pages.sortPosition as pageOrder,
                                               IF(pageProperties.idPageTypes = ?,
                                                  (SELECT pU.url FROM pageLinks, pages AS p LEFT JOIN urls AS pU ON pU.relationId = p.pageId AND pU.version = p.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                  (SELECT pU.url FROM urls AS pU WHERE pU.relationId = pages.pageId AND pU.version = pages.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 ORDER BY pU.version DESC LIMIT 1)) AS url,
                                               (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                          FROM folders
                                            INNER JOIN folderProperties ON 
                                              folderProperties.folderId = folders.folderId AND 
                                              folderProperties.version = folders.version AND 
                                              folderProperties.idLanguages = ?
                                            INNER JOIN folderTitles ON
                                              folderTitles.folderId = folders.folderId AND
                                              folderTitles.version = folders.version AND
                                              folderTitles.idLanguages = ?
                                            LEFT JOIN pages ON
                                              pages.idParent = folders.id AND
                                              pages.idParentTypes = ?
                                            LEFT JOIN pageProperties ON 
                                              pageProperties.pageId = pages.pageId AND 
                                              pageProperties.version = pages.version AND 
                                              pageProperties.idLanguages = ?
                                            LEFT JOIN pageTitles ON
                                              pageTitles.pageId = pages.pageId AND
                                              pageTitles.version = pages.version AND
                                              pageTitles.idLanguages = ?
                                          ,folders AS parent
                                           WHERE parent.id = ? AND
                                                 folders.lft BETWEEN parent.lft AND parent.rgt AND
                                                 folders.idRootLevels = parent.idRootLevels AND
                                                 folders.depth <= (parent.depth + 1)
                                             ORDER BY folders.lft, pages.isStartPage DESC, pages.sortPosition ASC, pages.sortTimestamp DESC, pages.id ASC', array($this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->parent_types->folder, $this->intLanguageId, $this->intLanguageId, $intFolderId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadChildNavigation
   * @param integer $intFolderId
   * @param string $strSortTimestampOrderType = 'DESC'
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadChildNavigation($intFolderId, $strSortTimestampOrderType = 'DESC'){
    $this->core->logger->debug('core->models->Folders->loadChildNavigation('.$intFolderId.')');

    $sqlStmt = $this->core->dbh->query('SELECT id, title, genericFormId, version, templateId, folderType, pageType, type, isStartPage, sortPosition, sortTimestamp, idStatus, pageLinkTitle
																	      FROM (SELECT folders.id, folderTitles.title, genericForms.genericFormId, genericForms.version, -1 AS templateId, folderProperties.idFolderTypes AS folderType, -1 AS pageType, folderTypes.title AS type, -1 AS isStartPage, folders.sortPosition, folders.sortTimestamp, folderProperties.idStatus,
																	                   -1 AS pageLinkTitle
																	            FROM folders
																	            INNER JOIN folderProperties ON 
                                                  folderProperties.folderId = folders.folderId AND 
                                                  folderProperties.version = folders.version AND 
                                                  folderProperties.idLanguages = ?
																	            LEFT JOIN folderTitles ON folderTitles.folderId = folders.folderId
																	              AND folderTitles.version = folders.version AND folderTitles.idLanguages = ?
																	            INNER JOIN genericForms ON genericForms.id = folderProperties.idGenericForms
																	            INNER JOIN folderTypes ON folderTypes.id = folderProperties.idFolderTypes
																	            WHERE folders.idParentFolder = ?
																	            UNION
																	            SELECT pages.id, pageTitles.title, genericForms.genericFormId, genericForms.version, pageProperties.idTemplates  AS templateId, -1 AS folderType, pageProperties.idPageTypes AS pageType, pageTypes.title AS type, pages.isStartPage, pages.sortPosition, pages.sortTimestamp, pageProperties.idStatus,
																	                   (SELECT pt.title FROM pageLinks, pages AS p LEFT JOIN pageTitles AS pt ON pt.pageId = p.pageId AND pt.version = p.version AND pt.idLanguages = ? WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1) AS pageLinkTitle
																	            FROM pages
																	            INNER JOIN pageProperties ON pageProperties.pageId = pages.pageId 
                                               AND pageProperties.version = pages.version 
                                               AND pageProperties.idLanguages = ?
																	            LEFT JOIN pageTitles ON pageTitles.pageId = pages.pageId
																	              AND pageTitles.version = pages.version
																	              AND pageTitles.idLanguages = ?
																	            INNER JOIN pageTypes ON pageTypes.id = pageProperties.idPageTypes
																	            INNER JOIN genericForms ON genericForms.id = pageProperties.idGenericForms
																	            WHERE pages.idParent = ?
																	              AND pages.idParentTypes = ?
																	              AND pages.id = (SELECT p.id FROM pages p WHERE p.pageId = pages.pageId ORDER BY p.version DESC LIMIT 1))
																	      AS tbl
																	      ORDER BY sortPosition ASC, sortTimestamp '.$strSortTimestampOrderType.', id ASC', array($this->intLanguageId, $this->intLanguageId, $intFolderId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $intFolderId, $this->core->sysConfig->parent_types->folder));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadGlobalChildNavigation
   * @param integer $intFolderId
   * @param integer $intRootLevelGroupId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadGlobalChildNavigation($intFolderId, $intRootLevelGroupId){
    $this->core->logger->debug('core->models->Folders->loadGlobalChildNavigation('.$intFolderId.','.$intRootLevelGroupId.')');

    $objFolderSelect = $this->core->dbh->select();
    $objFolderSelect->from('folders', array('id', 'templateId' => new Zend_Db_Expr('-1'), 'folderType' => 'folderProperties.idFolderTypes', 'globalType' => new Zend_Db_Expr('-1'), 'isStartGlobal' => new Zend_Db_Expr('-1'), 'sortPosition', 'sortTimestamp', 'folderProperties.idStatus', 'linkGlobalId' => new Zend_Db_Expr('-1')));
    $objFolderSelect->joinLeft('folderProperties', 'folderProperties.folderId = folders.folderId AND folderProperties.version = folders.version AND folderProperties.idLanguages = '.$this->intLanguageId, array());
    $objFolderSelect->joinLeft('folderTitles', 'folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objFolderSelect->join('genericForms', 'genericForms.id = folderProperties.idGenericForms', array('genericFormId', 'version'));
    $objFolderSelect->join('folderTypes', 'folderTypes.id = folderProperties.idFolderTypes', array('title AS type'));
    $objFolderSelect->where('folders.idParentFolder  = ?', $intFolderId);

    if($intRootLevelGroupId == $this->core->sysConfig->root_level_groups->product){
      $objGlobalSelect = $this->core->dbh->select();
      $objGlobalSelect->from('globals', array('id', 'templateId' => 'globalProperties.idTemplates', 'folderType' => new Zend_Db_Expr('-1'), 'globalType' => 'globalProperties.idGlobalTypes', 'isStartGlobal', 'lP.sortPosition', 'lP.sortTimestamp', 'globalProperties.idStatus', 'linkGlobalId' => 'lP.id'));
      $objGlobalSelect->join('globalLinks', 'globalLinks.globalId = globals.globalId', array());
      $objGlobalSelect->join(array('lP' => 'globals'), 'lP.id = globalLinks.idGlobals', array());
      $objGlobalSelect->join('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->intLanguageId, array());
      $objGlobalSelect->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->intLanguageId, array('title'));
      $objGlobalSelect->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version'));
      $objGlobalSelect->join('globalTypes', 'globalTypes.id = globalProperties.idGlobalTypes', array('title AS type'));
      $objGlobalSelect->where('lP.idParent = ?', $intFolderId);
      $objGlobalSelect->where('lP.idParentTypes = ?', $this->core->sysConfig->parent_types->folder);
      $objGlobalSelect->where('globals.id = (SELECT p.id FROM globals p WHERE p.globalId = globals.globalId ORDER BY p.version DESC LIMIT 1)');
    }else{
      $objGlobalSelect = $this->core->dbh->select();
      $objGlobalSelect->from('globals', array('id', 'templateId' => 'globalProperties.idTemplates', 'folderType' => new Zend_Db_Expr('-1'), 'globalType' => 'globalProperties.idGlobalTypes', 'isStartGlobal', 'sortPosition', 'sortTimestamp', 'globalProperties.idStatus', 'linkGlobalId' => new Zend_Db_Expr('-1')));
      $objGlobalSelect->join('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->intLanguageId, array());
      $objGlobalSelect->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->intLanguageId, array('title'));
      $objGlobalSelect->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version'));
      $objGlobalSelect->join('globalTypes', 'globalTypes.id = globalProperties.idGlobalTypes', array('title AS type'));
      $objGlobalSelect->where('idParent = ?', $intFolderId);
      $objGlobalSelect->where('idParentTypes = ?', $this->core->sysConfig->parent_types->folder);      
    }

    $objSelect = $this->getFolderTable()->select()
                                 ->union(array($objFolderSelect, $objGlobalSelect))
                                 ->order(array('sortPosition', 'sortTimestamp DESC', 'id'));

    return $this->getFolderTable()->fetchAll($objSelect);
  }
  
  /**
   * loadFolderChildPages
   * @param integer $intFolderId
   * @param integer $intCategoryId
   * @param integer $intLabelId
   * @param integer $intLimitNumber
   * @param integer $intSortTypeId
   * @param integer $intSortOrderId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadFolderChildPages($intFolderId, $intCategoryId = 0, $intLabelId = 0, $intLimitNumber = 0, $intSortTypeId = 0, $intSortOrderId = 0){
  	$this->core->logger->debug('core->models->Folders->loadFolderChildPages('.$intFolderId.','.$intCategoryId.','.$intLabelId.','.$intLimitNumber.','.$intSortTypeId.','.$intSortOrderId.')');

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

    $strSqlOrderBy = ' ORDER BY folders.lft';
    if($intSortTypeId > 0 && $intSortTypeId != ''){
	    switch($intSortTypeId){
	      case $this->core->sysConfig->sort->types->manual_sort->id:
	        $strSqlOrderBy = ' ORDER BY pages.sortPosition '.$strSortOrder.', pages.sortTimestamp '.(($strSortOrder == 'DESC') ? 'ASC' : 'DESC');
	        break;
	      case $this->core->sysConfig->sort->types->created->id:
	        $strSqlOrderBy = ' ORDER BY pageProperties.created '.$strSortOrder;
	        break;
	      case $this->core->sysConfig->sort->types->changed->id:
	        $strSqlOrderBy = ' ORDER BY pageProperties.changed '.$strSortOrder;
	        break;
	      case $this->core->sysConfig->sort->types->published->id:
	        $strSqlOrderBy = ' ORDER BY pageProperties.published '.$strSortOrder;
	        break;
	      case $this->core->sysConfig->sort->types->alpha->id:
	        $strSqlOrderBy = ' ORDER BY title '.$strSortOrder;
	    }
    }

    $strJoinCategory = '';
    if($intCategoryId > 0 && $intCategoryId != ''){
      $strJoinCategory = ' INNER JOIN pageCategories ON
                            pageCategories.pageId = pages.pageId AND
                            pageCategories.version = pages.version AND
                            pageCategories.category = '.$intCategoryId;
    }

    $strJoinLabel = '';
    if($intLabelId > 0 && $intLabelId != ''){
      $strJoinLabel = ' INNER JOIN pageLabels ON
                        pageLabels.pageId = pages.pageId AND
                        pageLabels.version = pages.version AND
                        pageLabels.label = '.$intLabelId;
    }

    $strSqlLimit = '';
    if($intLimitNumber > 0 && $intLimitNumber != ''){
      $strSqlLimit = ' LIMIT '.$intLimitNumber;
    }


    $strFolderFilter = '';
    $strPageFilter = '';
    $strFolderPublishedFilter = '';
    $strPagePublishedFilter = '';
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $timestamp = time();
      $now = date('Y-m-d H:i:s', $timestamp);

    	$strFolderFilter = 'AND folderProperties.idStatus = '.$this->core->sysConfig->status->live;
      $strPageFilter = 'AND pageProperties.idStatus = '.$this->core->sysConfig->status->live;
      $strPagePublishedFilter = ' AND pageProperties.published <= \''.$now.'\'';
    }

  	$sqlStmt = $this->core->dbh->query('SELECT DISTINCT folders.id AS idFolder, folderProperties.idStatus AS folderStatus, folders.depth,
                                              pages.id AS idPage, pageTitles.title AS title, genericForms.genericFormId, genericForms.version,
                                              pageProperties.idStatus AS pageStatus, urls.url, languageCode, pageProperties.idPageTypes, pageProperties.created AS pageCreated,
                                              pageProperties.changed AS pageChanged, pageProperties.published AS pagePublished
                                          FROM folders
                                            INNER JOIN folderProperties ON 
                                              folderProperties.folderId = folders.folderId AND 
                                              folderProperties.version = folders.version AND 
                                              folderProperties.idLanguages = ?
                                            INNER JOIN pages ON
                                              pages.idParent = folders.id AND
                                              pages.idParentTypes = ?
                                            INNER JOIN pageProperties ON 
                                              pageProperties.pageId = pages.pageId AND 
                                              pageProperties.version = pages.version AND 
                                              pageProperties.idLanguages = ?
                                              '.$strPageFilter.'
                                              '.$strPagePublishedFilter.'
                                              '.$strJoinCategory.'
                                              '.$strJoinLabel.'                                            
                                            INNER JOIN genericForms ON
                                              genericForms.id = pageProperties.idGenericForms
                                            INNER JOIN pageTitles ON
                                              pageTitles.pageId = pages.pageId AND
                                              pageTitles.version = pages.version AND
                                              pageTitles.idLanguages = ?
                                            INNER JOIN urls ON
                                              urls.relationId = pages.pageId AND
                                              urls.version = pages.version AND
                                              urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                              urls.idLanguages = ?
                                            LEFT JOIN languages  ON
                                              languages.id = ?
                                          ,folders AS parent
                                           WHERE parent.id = ? AND
                                                 folders.lft BETWEEN parent.lft AND parent.rgt AND
                                                 folders.idRootLevels = parent.idRootLevels
                                                 '.$strFolderFilter.'
                                           '.$strSqlOrderBy.'
  	                                       '.$strSqlLimit, array($this->core->sysConfig->parent_types->folder,
  	                                                             $this->intLanguageId,
  	                                                             $this->intLanguageId,
  	                                                             $this->intLanguageId,
  	                                                             $this->intLanguageId,
  	                                                             $this->intLanguageId,
  	                                                             $intFolderId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadRootLevelChilds
   * @param integer $intRootLevelId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadRootLevelChilds($intRootLevelId){
    $this->core->logger->debug('core->models->Folders->loadRootLevelChilds('.$intRootLevelId.')');

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS folderId, folderTitles.title AS folderTitle, folderProperties.idStatus AS folderStatus, folders.depth,
                                               pages.id AS idPage, pages.pageId, pageTitles.title AS pageTitle, pages.isStartPage, pageProperties.idStatus AS pageStatus
                                              FROM folders
                                                INNER JOIN folderProperties ON 
                                                  folderProperties.folderId = folders.folderId AND 
                                                  folderProperties.version = folders.version AND 
                                                  folderProperties.idLanguages = ?
                                                INNER JOIN folderTitles ON
                                                  folderTitles.folderId = folders.folderId AND
                                                  folderTitles.version = folders.version AND
                                                  folderTitles.idLanguages = ?
                                                LEFT JOIN pages ON
                                                  pages.idParent = folders.id AND
                                                  pages.idParentTypes = ?
                                                LEFT JOIN pageProperties ON 
                                                  pageProperties.pageId = pages.pageId AND 
                                                  pageProperties.version = pages.version AND 
                                                  pageProperties.idLanguages = ? AND
                                                  pageProperties.idPageTypes != ? AND
                                                  pageProperties.idPageTypes != ?
                                                LEFT JOIN pageTitles ON pageTitles.pageId = pages.pageId
                                                  AND pageTitles.version = pages.version
                                                  AND pageTitles.idLanguages = ?
                                              WHERE folders.idRootLevels = ?
                                                ORDER BY folders.lft, pages.isStartPage DESC, pages.sortPosition ASC, pages.sortTimestamp DESC, pages.id ASC', array($this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->parent_types->folder, $this->intLanguageId, $this->core->sysConfig->page_types->link->id, $this->core->sysConfig->page_types->external->id, $this->intLanguageId, $intRootLevelId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadGlobalRootLevelChilds
   * @param integer $intRootLevelId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadGlobalRootLevelChilds($intRootLevelId){
    $this->core->logger->debug('core->models->Folders->loadGlobalRootLevelChilds('.$intRootLevelId.')');

    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objFolderTable, array('folderId' => 'id', 'depth'))
              ->join('folderProperties', 'folderProperties.folderId = folders.folderId AND 
                                          folderProperties.version = folders.version AND
                                          folderProperties.idLanguages = '.$this->intLanguageId, array('folderStatus' => 'idStatus'))
              ->join('folderTitles', 'folderTitles.folderId = folders.folderId AND
                                      folderTitles.version = folders.version AND
                                      folderTitles.idLanguages = '.$this->intLanguageId, array('folderTitle' => 'title'))
              ->join('globals AS lP', 'lP.idParent = folders.id AND
                                        lP.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array('idGlobal' => 'id', 'globalId', 'isStartGlobal'))
              ->join('globalLinks', 'globalLinks.idGlobals = lP.id', array())
              ->join('globals', 'globals.globalId = globalLinks.globalId', array())
              ->join('globalProperties', 'globalProperties.globalId = globals.globalId AND 
                                           globalProperties.version = globals.version AND
                                           globalProperties.idLanguages = '.$this->intLanguageId, array('globalStatus' => 'idStatus'))
              ->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->intLanguageId, array('globalTitle' => 'title'))
              ->where('folders.idRootLevels = ?', $intRootLevelId)
              ->where('globals.id = (SELECT p.id FROM globals p WHERE p.globalId = globals.globalId ORDER BY p.version DESC LIMIT 1)')
              ->order('folders.lft')
              ->order('globals.isStartGlobal DESC')
              ->order('globals.sortPosition ASC')
              ->order('globals.sortTimestamp DESC')
              ->order('globals.id ASC');

    return $this->objFolderTable->fetchAll($objSelect);
  }

  /**
   * loadWebsiteRootLevelChilds
   * @param integer $intRootLevelId
   * @param integer $intDepth
   * @param integer $intDisplayOptionId 
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadWebsiteRootLevelChilds($intRootLevelId, $intDepth = 1, $intDisplayOptionId = 1){
    $this->core->logger->debug('core->models->Folders->loadRootLevelChilds('.$intRootLevelId.','.$intDepth.')');

    $strFolderFilter = '';
    $strPageFilter = '';
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $strFolderFilter = 'AND folderProperties.idStatus = '.$this->core->sysConfig->status->live;
      $strPageFilter = 'AND pageProperties.idStatus = '.$this->core->sysConfig->status->live;
    }

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS idFolder, folders.folderId, folderTitles.title AS folderTitle, folders.depth, folders.sortPosition as folderOrder,
                                            IF(folders.idParentFolder = 0, pages.idParent, folders.idParentFolder) AS parentId,
                                            pages.id AS idPage, pages.pageId, pages.isStartPage, pages.sortPosition as pageOrder,
                                            IF(pageProperties.idPageTypes = ?, lUrls.url, urls.url) as url,
                                            IF(pageProperties.idPageTypes = ?, plExternals.external, pageExternals.external) as external,
                                            IF(pageProperties.idPageTypes = ?, plTitle.title, pageTitles.title) as title,
                                            pageProperties.idPageTypes, (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                        FROM folders
                                          INNER JOIN folderProperties ON 
                                            folderProperties.folderId = folders.folderId AND 
                                            folderProperties.version = folders.version AND 
                                            folderProperties.idLanguages = ?
                                          INNER JOIN folderTitles ON
                                            folderTitles.folderId = folders.folderId AND
																			      folderTitles.version = folders.version AND
																			      folderTitles.idLanguages = ?
																			    LEFT JOIN pages ON
																			      pages.idParent = folders.id AND
																			      pages.idParentTypes = ?
																			    LEFT JOIN pageProperties ON 
																			      pageProperties.pageId = pages.pageId AND 
																			      pageProperties.version = pages.version AND 
																			      pageProperties.idLanguages = ?
																			      '.$strPageFilter.'
																			    LEFT JOIN pageTitles ON
																			      pageTitles.pageId = pages.pageId AND
																			      pageTitles.version = pages.version AND
																			      pageTitles.idLanguages = ?
																				  LEFT JOIN urls ON
																				    urls.relationId = pages.pageId AND
																				    urls.version = pages.version AND
                                            urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
																				    urls.idLanguages = ? AND
																				    urls.isMain = 1
																				  LEFT JOIN pageExternals ON
																				    pageExternals.pageId = pages.pageId AND
																				    pageExternals.version = pages.version AND
																				    pageExternals.idLanguages = ?
																				  LEFT JOIN pageLinks ON
																				    pageLinks.idPages = pages.id
																			    LEFT JOIN pages AS pl ON
																			      pl.id = (SELECT p.id FROM pages AS p WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1)
																			    LEFT JOIN pageTitles AS plTitle ON
																			      plTitle.pageId = pl.pageId AND
																			      plTitle.version = pl.version AND
																			      plTitle.idLanguages = ?
																			    LEFT JOIN urls AS lUrls ON
																			      lUrls.relationId = pl.pageId AND
																			      lUrls.version = pl.version AND
                                            lUrls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
																			      lUrls.idLanguages = ? AND
																			      lUrls.isMain = 1
																				  LEFT JOIN pageExternals AS plExternals ON
																				    plExternals.pageId = pl.pageId AND
																				    plExternals.version = pl.version AND
																				    plExternals.idLanguages = ?
                                        WHERE folders.idRootLevels = ? AND
                                          folders.depth <= ? AND
                                          folderProperties.showInNavigation = ? AND
                                          pageProperties.showInNavigation = ?
                                          '.$strFolderFilter.'
                                        ORDER BY folders.lft, pages.isStartPage DESC, pages.sortPosition ASC, pages.sortTimestamp DESC, pages.id ASC', array($this->core->sysConfig->page_types->link->id,
                                                                                                                                                             $this->core->sysConfig->page_types->link->id,
                                                                                                                                                             $this->core->sysConfig->page_types->link->id,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->core->sysConfig->parent_types->folder,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $intRootLevelId,
                                                                                                                                                             $intDepth,
                                                                                                                                                             $intDisplayOptionId,
                                                                                                                                                             $intDisplayOptionId));
    
    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }
  
  /**
   * loadWebsiteGlobalTree
   * @param integer $intParentId
   * @param array $arrFilterOptions
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function loadWebsiteGlobalTree($intParentId, $arrFilterOptions = array()){
    $this->core->logger->debug('core->models->Folders->loadWebsiteGlobalTree('.$intParentId.','.$arrFilterOptions.')');

    $strFolderFilter = '';
    $strGlobalFilter = '';
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $strFolderFilter = 'AND folderProperties.idStatus = '.$this->core->sysConfig->status->live;
      $strGlobalFilter = 'AND globalProperties.idStatus = '.$this->core->sysConfig->status->live;
    }
    
    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objFolderTable, array('idFolder' => 'id', 'folderId', 'parentId' => 'idParentFolder', 'depth', 'folderOrder' => 'sortPosition'))
              ->join(array('parent' => 'folders'), 'parent.id = '.$this->core->dbh->quote($intParentId, Zend_Db::INT_TYPE), array())
              ->join('folderProperties', 'folderProperties.folderId = folders.folderId AND 
                                          folderProperties.version = folders.version AND
                                          folderProperties.idLanguages = '.$this->intLanguageId, array('folderStatus' => 'idStatus'))
              ->join('folderTitles', 'folderTitles.folderId = folders.folderId AND
                                      folderTitles.version = folders.version AND
                                      folderTitles.idLanguages = '.$this->intLanguageId, array('folderTitle' => 'title'))
              ->join('languages', 'languages.id = folderTitles.idLanguages',array('languageCode'))
              ->join('globals AS lP', 'lP.idParent = folders.id AND
                                        lP.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array('idGlobal' => 'id', 'globalId', 'isStartGlobal', 'globalOrder' => 'sortPosition'))
              ->join('globalLinks', 'globalLinks.idGlobals = lP.id', array())
              ->join('globals', 'globals.globalId = globalLinks.globalId', array())
              ->join('globalProperties', 'globalProperties.globalId = globals.globalId AND 
                                           globalProperties.version = globals.version AND
                                           globalProperties.idLanguages = '.$this->intLanguageId.' AND
                                           globalProperties.showInNavigation = 1', array('globalStatus' => 'idStatus', 'idGlobalTypes'))
              ->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->intLanguageId, array('globalTitle' => 'title'))
              ->joinLeft('urls', 'urls.relationId = lP.globalId AND urls.version = lP.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1', array('url'))
              ->joinLeft('globalCategories', 'globalCategories.globalId = globals.globalId AND globalCategories.version = globals.version', array())
              ->joinLeft('globalLabels', 'globalLabels.globalId = globals.globalId AND globalLabels.version = globals.version', array())
              ->where('folders.lft BETWEEN parent.lft AND parent.rgt')
              ->where('folders.idRootLevels = parent.idRootLevels')
              ->where('globals.id = (SELECT p.id FROM globals p WHERE p.globalId = globals.globalId ORDER BY p.version DESC LIMIT 1)')              
              ->order('folders.lft')
              ->order('globals.isStartGlobal DESC')
              ->order('globals.sortPosition ASC')
              ->order('globals.sortTimestamp DESC')
              ->order('globals.id ASC');
              
    if($arrFilterOptions['CategoryId'] > 0 && $arrFilterOptions['CategoryId'] != ''){
      $objSelect->where('globalCategories.category = ?', $arrFilterOptions['CategoryId']);      
    }

    if($arrFilterOptions['LabelId'] > 0 && $arrFilterOptions['LabelId']  != ''){
      $objSelect->where('globalLabels.label = ?', $arrFilterOptions['LabelId'] );
    }

    return $this->objFolderTable->fetchAll($objSelect);
    
  }

  /**
   * loadLimitedRootLevelChilds
   * @param integer $intRootLevelId
   * @param integer $intLimitNumber = 10
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadLimitedRootLevelChilds($intRootLevelId, $intLimitNumber = 10){
    $this->core->logger->debug('core->models->Folders->loadRootLevelChilds('.$intRootLevelId.','.$intLimitNumber.')');

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS folderId, folderProperties.idStatus AS folderStatus,
                                               pages.id AS idPage, pages.pageId, pageTitles.title AS pageTitle, pages.isStartPage,
                                               pageProperties.idStatus AS pageStatus, pageProperties.created, pageProperties.changed,
                                               (SELECT CONCAT(users.fname, \' \', users.sname) AS changeUser FROM users WHERE users.id = pageProperties.idUsers) AS changeUser
                                              FROM folders
                                                INNER JOIN folderProperties ON 
                                                  folderProperties.folderId = folders.folderId AND 
                                                  folderProperties.version = folders.version AND 
                                                  folderProperties.idLanguages = ?
                                                LEFT JOIN pages ON
                                                  pages.idParent = folders.id AND
                                                  pages.idParentTypes = ?
                                                INNER JOIN pageProperties ON 
                                                  pageProperties.pageId = pages.pageId AND 
                                                  pageProperties.version = pages.version AND 
                                                  pageProperties.idLanguages = ? AND
                                                  pageProperties.idPageTypes = ?
                                                LEFT JOIN pageTitles ON pageTitles.pageId = pages.pageId
                                                  AND pageTitles.version = pages.version
                                                  AND pageTitles.idLanguages = ?
                                              WHERE folders.idRootLevels = ?
                                                ORDER BY pages.changed DESC, pages.created DESC
                                              LIMIT '.$intLimitNumber, array($this->intLanguageId, $this->core->sysConfig->parent_types->folder, $this->intLanguageId, $this->core->sysConfig->page_types->page->id, $this->intLanguageId, $intRootLevelId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadRootLevelFolders
   * @param integer $intRootLevelId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadRootLevelFolders($intRootLevelId){
    $this->core->logger->debug('core->models->Folders->loadRootLevelFolders('.$intRootLevelId.')');

    $sqlStmt = $this->core->dbh->query('SELECT folders.id, folderTitles.title, folderProperties.idStatus, folders.depth, folders.idRootLevels, rootLevelTitles.title AS rootLevelTitle
                                              FROM folders
                                                INNER JOIN folderProperties ON 
                                                  folderProperties.folderId = folders.folderId AND 
                                                  folderProperties.version = folders.version AND 
                                                  folderProperties.idLanguages = ?
                                                INNER JOIN folderTitles ON
                                                  folderTitles.folderId = folders.folderId AND
                                                  folderTitles.version = folders.version AND
                                                  folderTitles.idLanguages = ?
                                                INNER JOIN rootLevels ON
                                                  rootLevels.id = folders.idRootLevels
                                                INNER JOIN rootLevelTitles ON
                                                  rootLevelTitles.idRootLevels = rootLevels.id AND
                                                  rootLevelTitles.idLanguages = ?
                                              WHERE folders.idRootLevels = ?
                                                ORDER BY folders.lft, folders.sortPosition ASC, folders.sortTimestamp DESC', array($this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $intRootLevelId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadParentFolders
   * @param integer $intFolderId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadParentFolders($intFolderId){
    $this->core->logger->debug('core->models->Folders->loadParentFolders('.$intFolderId.')');

    $sqlStmt = $this->core->dbh->query('SELECT folders.id, folders.folderId, folderProperties.isUrlFolder, folderTitles.title,
                                               urls.url, (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                          FROM folders
                                            INNER JOIN folderProperties ON 
                                              folderProperties.folderId = folders.folderId AND 
                                              folderProperties.version = folders.version AND 
                                              folderProperties.idLanguages = ?
                                            INNER JOIN pages ON
                                              pages.idParent = folders.id AND
                                              pages.idParentTypes = ? AND
                                              pages.sortPosition = 0
                                            INNER JOIN urls ON
                                              urls.relationId = pages.pageId AND
                                              urls.version = pages.version AND
                                              urls.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND
                                              urls.idLanguages = ? AND
                                              urls.isMain = 1
                                            INNER JOIN folderTitles ON
                                              folderTitles.folderId = folders.folderId AND
                                              folderTitles.version = folders.version AND
                                              folderTitles.idLanguages = ?
                                          ,folders AS parent
                                           WHERE parent.id = ? AND
                                                 folders.lft <= parent.lft AND
                                                 folders.rgt >= parent.rgt AND
                                                 folders.idRootLevels = parent.idRootLevels
                                             ORDER BY folders.rgt', array($this->intLanguageId,
                                                                          $this->intLanguageId,
                                                                          $this->core->sysConfig->parent_types->folder,
                                                                          $this->intLanguageId,
                                                                          $this->intLanguageId,
                                                                          $intFolderId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }
  
  /**
   * loadGlobalParentFolders
   * @param integer $intFolderId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadGlobalParentFolders($intFolderId){
    $this->core->logger->debug('core->models->Folders->loadGlobalParentFolders('.$intFolderId.')');

    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objFolderTable, array('id', 'folderId'))
              ->join('folderProperties', 'folderProperties.folderId = folders.folderId AND 
                                          folderProperties.version = folders.version AND
                                          folderProperties.idLanguages = '.$this->intLanguageId, array('isUrlFolder'))
              ->join(array('parent' => 'folders'), 'parent.id = '.$this->core->dbh->quote($intFolderId, Zend_Db::INT_TYPE), array())
              ->join('folderTitles', 'folderTitles.folderId = folders.folderId AND
                                      folderTitles.version = folders.version AND
                                      folderTitles.idLanguages = '.$this->intLanguageId, array('title'))
              ->join('languages', 'languages.id = folderTitles.idLanguages',array('languageCode'))
              ->join('globals AS lP', 'lP.idParent = folders.id AND
                                        lP.idParentTypes = '.$this->core->sysConfig->parent_types->folder.' AND
                                        lP.sortPosition = 0', array())
              ->join('globalLinks', 'globalLinks.idGlobals = lP.id', array())
              ->join('globals', 'globals.globalId = globalLinks.globalId', array())
              ->join('urls', 'urls.relationId = lP.globalId AND urls.version = lP.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1', array('url'))
              ->where('folders.lft <= parent.lft')
              ->where('folders.rgt >= parent.rgt')
              ->where('folders.idRootLevels = parent.idRootLevels')
              ->where('globals.id = (SELECT p.id FROM globals p WHERE p.globalId = globals.globalId ORDER BY p.version DESC LIMIT 1)')
              ->order('folders.rgt');

    return $this->objFolderTable->fetchAll($objSelect);    
  }

  /**
   * loadRootFolders
   * @param integer $intRootId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadRootFolders($intRootId){
    $this->core->logger->debug('core->models->Folders->loadRootFolders('.$intRootId.')');

    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('folders', array('id'));
    $objSelect->join('folderProperties', 'folderProperties.folderId = folders.folderId AND 
                                          folderProperties.version = folders.version AND
                                          folderProperties.idLanguages = '.$this->intLanguageId, array('idGenericForms'));
    $objSelect->join('folderTitles', 'folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->join('genericForms', 'genericForms.id = folderProperties.idGenericForms', array('genericFormId', 'version'));
    $objSelect->where('folders.idRootLevels  = ? AND folders.idParentFolder = 0', $intRootId);

    return $this->getFolderTable()->fetchAll($objSelect);
  }

  /**
   * loadChildFolders
   * @param integer $intFolderId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadChildFolders($intFolderId){
    $this->core->logger->debug('core->models->Folders->loadChildFolders('.$intFolderId.')');

    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('folders', array('id'));
    $objSelect->join('folderProperties', 'folderProperties.folderId = folders.folderId AND 
                                          folderProperties.version = folders.version AND
                                          folderProperties.idLanguages = '.$this->intLanguageId, array('idGenericForms'));
    $objSelect->join('folderTitles', 'folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->join('genericForms', 'genericForms.id = folderProperties.idGenericForms', array('genericFormId', 'version'));
    $objSelect->where('folders.idParentFolder = ?', $intFolderId);

    return $this->getFolderTable()->fetchAll($objSelect);
  }

  /**
   * loadLastRootFolder
   * @param integer $intRootId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadLastRootFolder($intRootId){
    $this->core->logger->debug('core->models->Folders->loadLastRootFolder('.$intRootId.')');

    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);

    /**
     * SELECT `folders`.`id`
     *    FROM `folders`
     *    WHERE (folders.idRootLevels = '?' AND folders.idParentFolder = 0)
     *    ORDER BY folders.lft
     *      LIMIT 1
     */
    $objSelect->from('folders', array('id'));
    $objSelect->where('folders.idRootLevels  = ? AND folders.idParentFolder = 0', $intRootId);
    $objSelect->order(array('folders.lft DESC'));
    $objSelect->limit(1);

    return $this->getFolderTable()->fetchAll($objSelect);
  }

  /**
   * updateSortPosition
   * @param integer $intElementId
   * @param string $strElementType
   * @param integer $intSortPosition
   * @param integer $intRootLevelId = 0
   * @param integer $intParentId = 0
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function updateSortPosition($intElementId, $strElementType, $intSortPosition, $intRootLevelId = 0, $intParentId = 0) {
    $this->core->logger->debug('core->models->Folders->updateSortPosition('.$intElementId.','.$strElementType.','.$intSortPosition.','.$intRootLevelId.','.$intParentId.')');

    try{
  		if($intElementId != '' && $intSortPosition > 0){
	    	$strTable = $strElementType.'s';
	    	if($strElementType == 'link'){
	        $strTable = 'pages';
	    	}

	    	$sqlStmt = $this->core->dbh->query('SELECT '.$strTable.'.sortPosition FROM '.$strTable.' WHERE '.$strTable.'.id = ?', array($intElementId));
	    	$objElement = $sqlStmt->fetch(Zend_Db::FETCH_OBJ);

	    	$strSortTimestampType = ($objElement->sortPosition >= $intSortPosition) ? 'DESC' : 'ASC' ;

        $this->core->logger->debug('update: '.$strTable.' / elementId: '.$intElementId. ' / sortPosition: '.$intSortPosition);
	    	$this->core->dbh->update($strTable, array('sortPosition' => $intSortPosition, 'sortTimestamp' => date('Y-m-d H:i:s')), $strTable.'.id = '.$intElementId);

  		  if($intParentId > 0){
          $objNaviData = $this->loadChildNavigation($intParentId, $strSortTimestampType);
        }else if($intRootLevelId > 0){
          $objNaviData = $this->loadRootNavigation($intRootLevelId, $strSortTimestampType);
        }else{
          throw new Exception('Not able to load navigation, because rootLevelId and parentId are empty or 0!');
        }

  		  if(count($objNaviData) > 0){
          $counter = 1;
          foreach($objNaviData as $objNavItem){
            if($objNavItem->isStartPage != 1){
              if($objNavItem->type == 'folder'){
                $this->core->logger->debug('update: '.$objNavItem->type.' / id: '.$objNavItem->id. ' / counter: '.$counter);
                $this->core->dbh->update('folders', array('sortPosition' => $counter, 'sortTimestamp' => date('Y-m-d H:i:s')), 'folders.id = '.$objNavItem->id); //('UPDATE folders SET folders.sortPosition = ? WHERE folders.id = ?', array($intSortPosition, $objNavItem->id));
              }
              else if($objNavItem->type == 'page' || $objNavItem->type == 'link'){
                $this->core->logger->debug('update: '.$objNavItem->type.' / id: '.$objNavItem->id. ' / counter: '.$counter);
                $this->core->dbh->update('pages', array('sortPosition' => $counter, 'sortTimestamp' => date('Y-m-d H:i:s')), 'pages.id = '.$objNavItem->id); //('UPDATE pages SET pages.sortPosition = ? WHERE pages.id = ?', array($intSortPosition, $objNavItem->id));
              }
              $counter++;
            }
          }
        }
  		}

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * addFolderNode
   * @param integer $intRootId,
   * @param integer $intParentId
   * @param array $arrData
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addFolderNode($intRootId, $intParentId, $arrData = array()){
    try{
      $intFolderId = null;

      $this->getFolderTable();

      $objNestedSet = new NestedSet($this->objFolderTable);
      $objNestedSet->setDBFParent('idParentFolder');
      $objNestedSet->setDBFRoot('idRootLevels');

      /**
       * if $intParentId > 0, has parent folder id
       */
      if($intParentId != '' && $intParentId > 0){
        $intFolderId = $objNestedSet->newLastChild($intParentId, $arrData);
      }else{
        $objLastRootFolderData = $this->loadLastRootFolder($intRootId);
        if(count($objLastRootFolderData) > 0){
          $objLastRootFolder = $objLastRootFolderData->current();
          $intFolderId = $objNestedSet->newNextSibling($objLastRootFolder->id, $arrData);
        }else{
          $intFolderId = $objNestedSet->newRootNodeWithExistingRootId($intRootId, $arrData);
        }
      }

      return $intFolderId;
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * deleteFolder
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function deleteFolder($intElementId){
    $this->core->logger->debug('core->models->Folders->deleteFolder('.$intElementId.')');

    $this->getFolderTable();

    /**
     * delete folder with $intElementId
     */
		$strWhere = $this->objFolderTable->getAdapter()->quoteInto('id = ?', $intElementId);
		return $this->objFolderTable->delete($strWhere);

    //FIXME:: delete sub folder and content (pages, files)?
  }

  /**
   * deleteFolderNode
   * @param integer $intFolderId
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function deleteFolderNode($intFolderId){
    $this->core->logger->debug('core->models->Folders->deleteFolderNode('.$intFolderId.')');

    $this->getFolderTable();

    $objNestedSet = new NestedSet($this->objFolderTable);
    $objNestedSet->setDBFParent('idParentFolder');
    $objNestedSet->setDBFRoot('idRootLevels');

    $objNestedSet->deleteNode($intFolderId);

    //FIXME:: delete sub folder and content (pages, files, folders, ...) ???
  }

  /**
   * moveFolderToLastChildOf
   * @param integer $intFolderId
   * @param integer $intParentFolderId
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function moveFolderToLastChildOf($intFolderId, $intParentFolderId){
    $this->core->logger->debug('core->models->Folders->moveFolderToLastChildOf('.$intFolderId.','.$intParentFolderId.')');

    $this->getFolderTable();

    $objNestedSet = new NestedSet($this->objFolderTable);
    $objNestedSet->setDBFParent('idParentFolder');
    $objNestedSet->setDBFRoot('idRootLevels');

    $objNestedSet->moveToLastChild($intFolderId, $intParentFolderId);
  }

  /**
   * moveFolderToLastChildOfRootFolder
   * @param integer $intFolderId
   * @param integer $intRootFolderId
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function moveFolderToLastChildOfRootFolder($intFolderId, $intRootFolderId){
    $this->core->logger->debug('core->models->Folders->moveFolderToLastChildOfRootFolder('.$intFolderId.','.$intRootFolderId.')');

    $this->getFolderTable();

    $objNestedSet = new NestedSet($this->objFolderTable);
    $objNestedSet->setDBFParent('idParentFolder');
    $objNestedSet->setDBFRoot('idRootLevels');

    $objLastRootFolderData = $this->loadLastRootFolder($intRootFolderId);

    if(count($objLastRootFolderData) > 0){
      $objLastRootFolder = $objLastRootFolderData->current();
      $objNestedSet->moveToNextSibling($intFolderId, $objLastRootFolder->id);
    }
  }

  /**
   * updateFolderSecurity
   * @param integer $intFolderId
   * @param integer $arrGroups
   * @param integer $intEnvironment
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function updateFolderSecurity($intFolderId, $arrGroups, $intEnvironment){
    $this->core->logger->debug('core->models->Folders->updateFolderSecurity('.$intFolderId.', '.$arrGroups.', '.$intEnvironment.')');

    try{
      $this->getFolderPermissionTable();

      /**
       * delete data
       */
      $strWhere = $this->objFolderPermissionTable->getAdapter()->quoteInto('idFolders = ?', $intFolderId);
      $strWhere .= $this->objFolderPermissionTable->getAdapter()->quoteInto('AND environment = ?', $intEnvironment);
      $this->objFolderPermissionTable->delete($strWhere);

      if(count($arrGroups) > 0){
        foreach($arrGroups as $intGroupId){
          $arrData = array('idFolders'    => $intFolderId,
                           'environment'  => $intEnvironment,
                           'idGroups'     => $intGroupId);
          $this->objFolderPermissionTable->insert($arrData);
        }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * getFolderSecurity
   * @param integer $intFolderId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getFolderSecurity($intFolderId){
    $this->core->logger->debug('core->models->Folders->getFolderSecurity('.$intFolderId.')');

    $objSelect = $this->getFolderPermissionTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objFolderPermissionTable, array('idGroups', 'environment'))
              ->joinInner('groups', 'groups.id = folderPermissions.idGroups', array('id', 'title', 'key'))
              ->where('idFolders = ?', $intFolderId);
    return $this->objFolderPermissionTable->fetchAll($objSelect);
  }

  /**
   * getFoldersPermissions
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getFoldersPermissions(){
    $this->core->logger->debug('core->models->Folders->getFoldersPermissions()');

    $objSelect = $this->getFolderPermissionTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objFolderPermissionTable, array('idGroups', 'environment'))
              ->joinInner('folders', 'folders.id = folderPermissions.idFolders', array('id'))
              ->joinInner('groups', 'groups.id = folderPermissions.idGroups', array('id AS groupId', 'title AS groupTitle', 'key AS groupKey'))
              ->joinInner('groupPermissions', 'groupPermissions.idGroups = groups.id', array())
              ->joinInner('permissions', 'permissions.id = groupPermissions.idPermissions', array('id AS permissionId', 'title AS permissionTitle'));

    return $this->objFolderPermissionTable->fetchAll($objSelect);
  }

  /**
   * getFolderTable
   * @return Model_Table_Folders
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getFolderTable(){

    if($this->objFolderTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/Folders.php';
      $this->objFolderTable = new Model_Table_Folders();
    }

    return $this->objFolderTable;
  }
  
  /**
   * getFolderPropertyTable
   * @return Model_Table_Folders
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getFolderPropertyTable(){

    if($this->objFolderPropertyTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/FolderProperties.php';
      $this->objFolderPropertyTable = new Model_Table_FolderProperties();
    }

    return $this->objFolderPropertyTable;
  }

  /**
   * getFolderPermissionTable
   * @return Model_Table_FolderPermissions
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getFolderPermissionTable(){

    if($this->objFolderPermissionTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/FolderPermissions.php';
      $this->objFolderPermissionTable = new Model_Table_FolderPermissions();
    }

    return $this->objFolderPermissionTable;
  }


  /**
   * getRootLevelTable
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getRootLevelTable(){

    if($this->objRootLevelTable === null){
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/RootLevels.php';
      $this->objRootLevelTable = new Model_Table_RootLevels();
    }

    return $this->objRootLevelTable;
  }

  /**
   * getRootLevelUrlTable
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getRootLevelUrlTable(){

    if($this->objRootLevelUrlTable === null){
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/RootLevelUrls.php';
      $this->objRootLevelUrlTable = new Model_Table_RootLevelUrls();
    }

    return $this->objRootLevelUrlTable;
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