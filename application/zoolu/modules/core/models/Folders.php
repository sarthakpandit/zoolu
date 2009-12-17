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
    if($intRootLevelType != -1){
      $objSelect->where('rootLevels.idRootLevelTypes = ?', $intRootLevelType);
    }

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
																	      FROM (SELECT folders.id, folderTitles.title, genericForms.genericFormId, genericForms.version, -1 AS templateId, folders.idFolderTypes AS folderType, -1 AS pageType, folderTypes.title As type, -1 AS isStartPage, folders.sortPosition, folders.sortTimestamp, folders.idStatus,
																	                   -1 AS pageLinkTitle
																	            FROM folders
																				      LEFT JOIN folderTitles ON folderTitles.folderId = folders.folderId
																				        AND folderTitles.version = folders.version AND folderTitles.idLanguages = ?
																				      INNER JOIN genericForms ON genericForms.id = folders.idGenericForms
																				      INNER JOIN folderTypes ON folderTypes.id = folders.idFolderTypes
																				      WHERE folders.idRootLevels = ? AND
																				            folders.idParentFolder = 0
																	            UNION
																	            SELECT pages.id, pageTitles.title, genericForms.genericFormId, genericForms.version, pages.idTemplates  AS templateId, -1 AS folderType, pages.idPageTypes AS pageType, pageTypes.title As type, pages.isStartPage, pages.sortPosition, pages.sortTimestamp, pages.idStatus,
																	                   (SELECT pt.title FROM pageLinks, pages AS p LEFT JOIN pageTitles AS pt ON pt.pageId = p.pageId AND pt.version = p.version AND pt.idLanguages = ? WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1) AS pageLinkTitle
																	            FROM pages
																	            LEFT JOIN pageTitles ON pageTitles.pageId = pages.pageId
																	              AND pageTitles.version = pages.version
																	              AND pageTitles.idLanguages = ?
																	            INNER JOIN pageTypes ON pageTypes.id = pages.idPageTypes
																	            INNER JOIN genericForms ON genericForms.id = pages.idGenericForms
																	            WHERE pages.idParent = ?
																	              AND pages.idParentTypes = ?
																	              AND pages.id = (SELECT p.id FROM pages p WHERE p.pageId = pages.pageId ORDER BY p.version DESC LIMIT 1))
																	      AS tbl
																	      ORDER BY sortPosition ASC, sortTimestamp '.$strSortTimestampOrderType.', id ASC', array($this->intLanguageId, $intRootId, $this->intLanguageId, $this->intLanguageId, $intRootId, $this->core->sysConfig->parent_types->rootlevel));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadProductRootNavigation
   * @param integer $intRootId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadProductRootNavigation($intRootId){
    $this->core->logger->debug('core->models->Folders->loadProductRootNavigation('.$intRootId.')');

    $objFolderSelect = $this->core->dbh->select();

    /**
     * SELECT `folders`.`id`, -1 AS `templateId`, `folders`.`idFolderTypes` AS `folderType`, -1 AS `productType`, -1 AS `isStartPage`, `folders`.`sortPosition`, `folders`.`sortTimestamp`, `folders`.`idStatus`, -1 AS `productLinkTitle`, `folderTitles`.`title`, `genericForms`.`genericFormId`, `genericForms`.`version`, `folderTypes`.`title` AS `type`
     *  FROM `folders`
     *    LEFT JOIN `folderTitles` ON
     *      folderTitles.folderId = folders.folderId AND
     *      folderTitles.version = folders.version AND
     *      folderTitles.idLanguages = 1
     *    INNER JOIN `genericForms` ON
     *      genericForms.id = folders.idGenericForms
     *    INNER JOIN `folderTypes` ON
     *      folderTypes.id = folders.idFolderTypes
     *  WHERE (folders.idRootLevels = '8' AND folders.idParentFolder = 0)
     */
    $objFolderSelect->from('folders', array('id', 'templateId' => new Zend_Db_Expr('-1'), 'folderType' => 'idFolderTypes', 'productType' => new Zend_Db_Expr('-1'), 'isStartProduct' => new Zend_Db_Expr('-1'), 'sortPosition', 'sortTimestamp', 'idStatus', 'linkProductId' => new Zend_Db_Expr('-1')));
    $objFolderSelect->joinLeft('folderTitles', 'folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objFolderSelect->join('genericForms', 'genericForms.id = folders.idGenericForms', array('genericFormId', 'version'));
    $objFolderSelect->join('folderTypes', 'folderTypes.id = folders.idFolderTypes', array('title AS type'));
    $objFolderSelect->where('folders.idRootLevels = ? AND folders.idParentFolder = 0', $intRootId);


    $objProductSelect = $this->core->dbh->select();

    /**
     * SELECT `products`.`id`, `productProperties`.`idTemplates` AS `templateId`, -1 AS `folderType`, `productProperties`.`idProductTypes` AS `productType`, `products`.`isStartProduct`, `products`.`sortPosition`, `products`.`sortTimestamp`, `productProperties`.`idStatus`, -1 AS `productLinkTitle`, `productTitles`.`title`, `genericForms`.`genericFormId`, `genericForms`.`version`, `productTypes`.`title` AS `type`
     *  FROM `products`
     *    INNER JOIN `productLinks` ON
     *      productLinks.productId = products.productId
     *    INNER JOIN `products` AS `lP` ON
     *      lP.id = productLinks.idProducts
     *    INNER JOIN `productProperties` ON
     *      productProperties.productId = products.productId AND
     *      productProperties.version = products.version AND
     *      productProperties.idLanguages = 1
     *    LEFT JOIN `productTitles` ON
     *      productTitles.productId = products.productId AND
     *      productTitles.version = products.version AND
     *      productTitles.idLanguages = 1
     *    INNER JOIN `genericForms` ON
     *      genericForms.id = productProperties.idGenericForms
     *    INNER JOIN `productTypes` ON
     *      productTypes.id = productProperties.idProductTypes
     *  WHERE (lP.idParent = '12') AND
     *        (lP.idParentTypes = '1') AND
     *        (products.id = (SELECT p.id FROM products p WHERE p.productId = products.productId ORDER BY p.version DESC LIMIT 1))
     */
    $objProductSelect->from('products', array('id', 'templateId' => 'productProperties.idTemplates', 'folderType' => new Zend_Db_Expr('-1'), 'productType' => 'productProperties.idProductTypes', 'isStartProduct', 'lP.sortPosition', 'lP.sortTimestamp', 'productProperties.idStatus', 'linkProductId' => 'lP.id'));
    $objProductSelect->join('productLinks', 'productLinks.productId = products.productId', array());
    $objProductSelect->join(array('lP' => 'products'), 'lP.id = productLinks.idProducts', array());
    $objProductSelect->join('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->intLanguageId, array());
    $objProductSelect->joinLeft('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objProductSelect->join('genericForms', 'genericForms.id = productProperties.idGenericForms', array('genericFormId', 'version'));
    $objProductSelect->join('productTypes', 'productTypes.id = productProperties.idProductTypes', array('title AS type'));
    $objProductSelect->where('lP.idParent = ?', $intRootId);
    $objProductSelect->where('lP.idParentTypes = ?', $this->core->sysConfig->parent_types->rootlevel);
    $objProductSelect->where('products.id = (SELECT p.id FROM products p WHERE p.productId = products.productId ORDER BY p.version DESC LIMIT 1)');

    $objSelect = $this->getFolderTable()->select()
                                        ->union(array($objFolderSelect, $objProductSelect))
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
      $strFolderFilter = 'AND folders.idStatus = '.$this->core->sysConfig->status->live;
      $strPageFilter = 'AND pages.idStatus = '.$this->core->sysConfig->status->live;
    }

    $sqlStmt = $this->core->dbh->query('SELECT id, title, idStatus, url, pageId, folderId, sortPosition, sortTimestamp, isStartPage, (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                        FROM (SELECT DISTINCT folders.id, folderTitles.title, folders.idStatus,
                                                              IF(pages.idPageTypes = ?,
                                                                 (SELECT pU.url FROM pageLinks, pages AS p LEFT JOIN urls AS pU ON pU.relationId = p.pageId AND pU.version = p.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                                 (SELECT pU.url FROM urls AS pU WHERE pU.relationId = pages.pageId AND pU.version = pages.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 ORDER BY pU.version DESC LIMIT 1)) AS url,
                                                              IF(pages.idPageTypes = ?,
                                                                 (SELECT p.pageId FROM pages AS p, pageLinks WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                                 pages.pageId) AS pageId,
                                                              folders.folderId, folders.sortPosition, folders.sortTimestamp, -1 AS isStartPage
                                              FROM folders
                                              INNER JOIN folderTitles ON
                                                folderTitles.folderId = folders.folderId AND
                                                folderTitles.version = folders.version AND
                                                folderTitles.idLanguages = ?
                                              INNER JOIN pages ON
                                                pages.idParent = folders.id AND
                                                pages.idParentTypes = ? AND
                                                pages.isStartPage = 1
                                              WHERE folders.idRootLevels = ? AND
                                                    folders.idParentFolder = 0 AND
                                                    folders.showInNavigation = 1
                                                    '.$strFolderFilter.'
                                              UNION
                                              SELECT DISTINCT pages.id, pageTitles.title, pages.idStatus,
                                                              IF(pages.idPageTypes = ?,
                                                                 (SELECT pU.url FROM pageLinks, pages AS p LEFT JOIN urls AS pU ON pU.relationId = p.pageId AND pU.version = p.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1  WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                                 (SELECT pU.url FROM urls AS pU WHERE pU.relationId = pages.pageId AND pU.version = pages.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 ORDER BY pU.version DESC LIMIT 1)) AS url,
                                                              IF(pages.idPageTypes = ?,
                                                                 (SELECT p.pageId FROM pages AS p, pageLinks WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                                 pages.pageId) AS pageId,
                                                              -1 AS folderId, pages.sortPosition, pages.sortTimestamp, pages.isStartPage
                                              FROM pages
                                              LEFT JOIN pageTitles ON
                                                pageTitles.pageId = pages.pageId AND
                                                pageTitles.version = pages.version AND
                                                pageTitles.idLanguages = ?
                                              WHERE pages.idParent = ? AND
                                                    pages.idParentTypes = ? AND
                                                    pages.showInNavigation = 1 AND
                                                    pages.id = (SELECT p.id FROM pages p WHERE p.pageId = pages.pageId ORDER BY p.version DESC LIMIT 1)
                                                    '.$strPageFilter.')
                                        AS tbl
                                        ORDER BY sortPosition ASC, sortTimestamp DESC, id ASC', array($this->intLanguageId, $this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->core->sysConfig->parent_types->folder, $intRootId, $this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->page_types->link->id, $this->intLanguageId, $intRootId, $this->core->sysConfig->parent_types->rootlevel));


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
      $strFolderFilter = 'AND folders.idStatus = '.$this->core->sysConfig->status->live;
      $strPageFilter = 'AND pages.idStatus = '.$this->core->sysConfig->status->live;
    }

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS idFolder, folders.folderId, folders.idParentFolder as parentId, folderTitles.title AS folderTitle, folders.idStatus AS folderStatus, folders.depth, folders.sortPosition as folderOrder,
                                               pages.id AS idPage, pages.pageId, pageTitles.title AS pageTitle, pages.isStartPage, pages.idStatus AS pageStatus, pages.sortPosition as pageOrder,
                                               IF(pages.idPageTypes = ?,
                                                  (SELECT pU.url FROM pageLinks, pages AS p LEFT JOIN urls AS pU ON pU.relationId = p.pageId AND pU.version = p.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                  (SELECT pU.url FROM urls AS pU WHERE pU.relationId = pages.pageId AND pU.version = pages.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 ORDER BY pU.version DESC LIMIT 1)) AS url,
                                               (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                          FROM folders
                                            INNER JOIN folderTitles ON
                                              folderTitles.folderId = folders.folderId AND
                                              folderTitles.version = folders.version AND
                                              folderTitles.idLanguages = ?
                                            LEFT JOIN pages ON
                                              pages.idParent = folders.id AND
                                              pages.idParentTypes = ? AND
                                              pages.showInNavigation = 1
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
                                                 folders.showInNavigation = 1
                                                 '.$strFolderFilter.'
                                             ORDER BY folders.lft, pages.isStartPage DESC, pages.sortPosition ASC, pages.sortTimestamp DESC, pages.id ASC', array($this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->parent_types->folder, $this->intLanguageId, $intFolderId, $intDepth));

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

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS idFolder, folders.folderId, folders.idParentFolder as parentId, folderTitles.title AS folderTitle, folders.idStatus AS folderStatus, folders.depth, folders.sortPosition as folderOrder,
                                               pages.id AS idPage, pages.pageId, pageTitles.title AS pageTitle, pages.isStartPage, pages.idStatus AS pageStatus, pages.sortPosition as pageOrder,
                                               IF(pages.idPageTypes = ?,
                                                  (SELECT pU.url FROM pageLinks, pages AS p LEFT JOIN urls AS pU ON pU.relationId = p.pageId AND pU.version = p.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1),
                                                  (SELECT pU.url FROM urls AS pU WHERE pU.relationId = pages.pageId AND pU.version = pages.version AND pU.idUrlTypes = '.$this->core->sysConfig->url_types->page.' AND pU.idLanguages = ? AND pU.isMain = 1 ORDER BY pU.version DESC LIMIT 1)) AS url,
                                               (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                          FROM folders
                                            INNER JOIN folderTitles ON
                                              folderTitles.folderId = folders.folderId AND
                                              folderTitles.version = folders.version AND
                                              folderTitles.idLanguages = ?
                                            LEFT JOIN pages ON
                                              pages.idParent = folders.id AND
                                              pages.idParentTypes = ?
                                            LEFT JOIN pageTitles ON
                                              pageTitles.pageId = pages.pageId AND
                                              pageTitles.version = pages.version AND
                                              pageTitles.idLanguages = ?
                                          ,folders AS parent
                                           WHERE parent.id = ? AND
                                                 folders.lft BETWEEN parent.lft AND parent.rgt AND
                                                 folders.idRootLevels = parent.idRootLevels AND
                                                 folders.depth <= (parent.depth + 1)
                                             ORDER BY folders.lft, pages.isStartPage DESC, pages.sortPosition ASC, pages.sortTimestamp DESC, pages.id ASC', array($this->core->sysConfig->page_types->link->id, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->core->sysConfig->parent_types->folder, $this->intLanguageId, $intFolderId));

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
																	      FROM (SELECT folders.id, folderTitles.title, genericForms.genericFormId, genericForms.version, -1 AS templateId, folders.idFolderTypes AS folderType, -1 AS pageType, folderTypes.title AS type, -1 AS isStartPage, folders.sortPosition, folders.sortTimestamp, folders.idStatus,
																	                   -1 AS pageLinkTitle
																	            FROM folders
																	            LEFT JOIN folderTitles ON folderTitles.folderId = folders.folderId
																	              AND folderTitles.version = folders.version AND folderTitles.idLanguages = ?
																	            INNER JOIN genericForms ON genericForms.id = folders.idGenericForms
																	            INNER JOIN folderTypes ON folderTypes.id = folders.idFolderTypes
																	            WHERE folders.idParentFolder = ?
																	            UNION
																	            SELECT pages.id, pageTitles.title, genericForms.genericFormId, genericForms.version, pages.idTemplates  AS templateId, -1 AS folderType, pages.idPageTypes AS pageType, pageTypes.title AS type, pages.isStartPage, pages.sortPosition, pages.sortTimestamp, pages.idStatus,
																	                   (SELECT pt.title FROM pageLinks, pages AS p LEFT JOIN pageTitles AS pt ON pt.pageId = p.pageId AND pt.version = p.version AND pt.idLanguages = ? WHERE pageLinks.idPages = pages.id AND pageLinks.pageId = p.pageId ORDER BY p.version DESC LIMIT 1) AS pageLinkTitle
																	            FROM pages
																	            LEFT JOIN pageTitles ON pageTitles.pageId = pages.pageId
																	              AND pageTitles.version = pages.version
																	              AND pageTitles.idLanguages = ?
																	            INNER JOIN pageTypes ON pageTypes.id = pages.idPageTypes
																	            INNER JOIN genericForms ON genericForms.id = pages.idGenericForms
																	            WHERE pages.idParent = ?
																	              AND pages.idParentTypes = ?
																	              AND pages.id = (SELECT p.id FROM pages p WHERE p.pageId = pages.pageId ORDER BY p.version DESC LIMIT 1))
																	      AS tbl
																	      ORDER BY sortPosition ASC, sortTimestamp '.$strSortTimestampOrderType.', id ASC', array($this->intLanguageId, $intFolderId, $this->intLanguageId, $this->intLanguageId, $intFolderId, $this->core->sysConfig->parent_types->folder));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadProductChildNavigation
   * @param integer $intFolderId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadProductChildNavigation($intFolderId){
    $this->core->logger->debug('core->models->Folders->loadProductChildNavigation('.$intFolderId.')');

    $objFolderSelect = $this->core->dbh->select();

    /**
     * SELECT `folders`.`id`, -1 AS `templateId`, `folders`.`idFolderTypes` AS `folderType`, -1 AS `productType`, -1 AS `isStartPage`, `folders`.`sortPosition`, `folders`.`sortTimestamp`, `folders`.`idStatus`, -1 AS `productLinkTitle`, `folderTitles`.`title`, `genericForms`.`genericFormId`, `genericForms`.`version`, `folderTypes`.`title` AS `type`
     *  FROM `folders`
     *    LEFT JOIN `folderTitles` ON
     *      folderTitles.folderId = folders.folderId AND
     *      folderTitles.version = folders.version AND
     *      folderTitles.idLanguages = 1
     *    INNER JOIN `genericForms` ON
     *      genericForms.id = folders.idGenericForms
     *    INNER JOIN `folderTypes` ON
     *      folderTypes.id = folders.idFolderTypes
     *  WHERE (folders.idParentFolder  = '8')
     */
    $objFolderSelect->from('folders', array('id', 'templateId' => new Zend_Db_Expr('-1'), 'folderType' => 'idFolderTypes', 'productType' => new Zend_Db_Expr('-1'), 'isStartProduct' => new Zend_Db_Expr('-1'), 'sortPosition', 'sortTimestamp', 'idStatus', 'linkProductId' => new Zend_Db_Expr('-1')));
    $objFolderSelect->joinLeft('folderTitles', 'folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objFolderSelect->join('genericForms', 'genericForms.id = folders.idGenericForms', array('genericFormId', 'version'));
    $objFolderSelect->join('folderTypes', 'folderTypes.id = folders.idFolderTypes', array('title AS type'));
    $objFolderSelect->where('folders.idParentFolder  = ?', $intFolderId);


    $objProductSelect = $this->core->dbh->select();

    /**
     * SELECT `products`.`id`, `productProperties`.`idTemplates` AS `templateId`, -1 AS `folderType`, `productProperties`.`idProductTypes` AS `productType`, `products`.`isStartProduct`, `products`.`sortPosition`, `products`.`sortTimestamp`, `productProperties`.`idStatus`, -1 AS `productLinkTitle`, `productTitles`.`title`, `genericForms`.`genericFormId`, `genericForms`.`version`, `productTypes`.`title` AS `type`
     *  FROM `products`
     *    INNER JOIN `productLinks` ON
     *      productLinks.productId = products.productId
     *    INNER JOIN `products` AS `lP` ON
     *      lP.id = productLinks.idProducts
     *    INNER JOIN `productProperties` ON
     *      productProperties.productId = products.productId AND
     *      productProperties.version = products.version AND
     *      productProperties.idLanguages = 1
     *    LEFT JOIN `productTitles` ON
     *      productTitles.productId = products.productId AND
     *      productTitles.version = products.version AND
     *      productTitles.idLanguages = 1
     *    INNER JOIN `genericForms` ON
     *      genericForms.id = productProperties.idGenericForms
     *    INNER JOIN `productTypes` ON
     *      productTypes.id = productProperties.idProductTypes
     *  WHERE (lP.idParent = '15') AND
     *        (lP.idParentTypes = '2') AND
     *        (products.id = (SELECT p.id FROM products p WHERE p.productId = products.productId ORDER BY p.version DESC LIMIT 1))
     */
    $objProductSelect->from('products', array('id', 'templateId' => 'productProperties.idTemplates', 'folderType' => new Zend_Db_Expr('-1'), 'productType' => 'productProperties.idProductTypes', 'isStartProduct', 'lP.sortPosition', 'lP.sortTimestamp', 'productProperties.idStatus', 'linkProductId' => 'lP.id'));
    $objProductSelect->join('productLinks', 'productLinks.productId = products.productId', array());
    $objProductSelect->join(array('lP' => 'products'), 'lP.id = productLinks.idProducts', array());
    $objProductSelect->join('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->intLanguageId, array());
    $objProductSelect->joinLeft('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objProductSelect->join('genericForms', 'genericForms.id = productProperties.idGenericForms', array('genericFormId', 'version'));
    $objProductSelect->join('productTypes', 'productTypes.id = productProperties.idProductTypes', array('title AS type'));
    $objProductSelect->where('lP.idParent = ?', $intFolderId);
    $objProductSelect->where('lP.idParentTypes = ?', $this->core->sysConfig->parent_types->folder);
    $objProductSelect->where('products.id = (SELECT p.id FROM products p WHERE p.productId = products.productId ORDER BY p.version DESC LIMIT 1)');

    $objSelect = $this->getFolderTable()->select()
                                 ->union(array($objFolderSelect, $objProductSelect))
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
	        $strSqlOrderBy = ' ORDER BY pages.created '.$strSortOrder;
	        break;
	      case $this->core->sysConfig->sort->types->changed->id:
	        $strSqlOrderBy = ' ORDER BY pages.changed '.$strSortOrder;
	        break;
	      case $this->core->sysConfig->sort->types->published->id:
	        $strSqlOrderBy = ' ORDER BY pages.published '.$strSortOrder;
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

    	$strFolderFilter = 'AND folders.idStatus = '.$this->core->sysConfig->status->live;
      $strPageFilter = 'AND pages.idStatus = '.$this->core->sysConfig->status->live;
      $strPagePublishedFilter = ' AND pages.published <= \''.$now.'\'';
    }

  	$sqlStmt = $this->core->dbh->query('SELECT DISTINCT folders.id AS idFolder, folders.idStatus AS folderStatus, folders.depth,
                                              pages.id AS idPage, pageTitles.title AS title, genericForms.genericFormId, genericForms.version,
                                              pages.idStatus AS pageStatus, urls.url, languageCode, pages.idPageTypes, pages.created AS pageCreated,
                                              pages.changed AS pageChanged, pages.published AS pagePublished
                                          FROM folders
                                            INNER JOIN pages ON
                                              pages.idParent = folders.id AND
                                              pages.idParentTypes = ?
                                              '.$strPageFilter.'
                                              '.$strPagePublishedFilter.'
                                            '.$strJoinCategory.'
                                            '.$strJoinLabel.'
                                            INNER JOIN genericForms ON
                                              genericForms.id = pages.idGenericForms
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

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS folderId, folderTitles.title AS folderTitle, folders.idStatus AS folderStatus, folders.depth,
                                               pages.id AS idPage, pages.pageId, pageTitles.title AS pageTitle, pages.isStartPage, pages.idStatus AS pageStatus
                                              FROM folders
                                                INNER JOIN folderTitles ON
                                                  folderTitles.folderId = folders.folderId AND
                                                  folderTitles.version = folders.version AND
                                                  folderTitles.idLanguages = ?
                                                LEFT JOIN pages ON
                                                  pages.idParent = folders.id AND
                                                  pages.idParentTypes = ? AND
                                                  pages.idPageTypes != ? AND
                                                  pages.idPageTypes != ?
                                                LEFT JOIN pageTitles ON pageTitles.pageId = pages.pageId
                                                  AND pageTitles.version = pages.version
                                                  AND pageTitles.idLanguages = ?
                                              WHERE folders.idRootLevels = ?
                                                ORDER BY folders.lft, pages.isStartPage DESC, pages.sortPosition ASC, pages.sortTimestamp DESC, pages.id ASC', array($this->intLanguageId, $this->core->sysConfig->parent_types->folder, $this->core->sysConfig->page_types->link->id, $this->core->sysConfig->page_types->external->id, $this->intLanguageId, $intRootLevelId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * loadProductRootLevelChilds
   * @param integer $intRootLevelId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadProductRootLevelChilds($intRootLevelId){
    $this->core->logger->debug('core->models->Folders->loadRootLevelChilds('.$intRootLevelId.')');

    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objFolderTable, array('folderId' => 'id', 'folderStatus' => 'idStatus', 'depth'))
              ->join('folderTitles', 'folderTitles.folderId = folders.folderId AND
                                      folderTitles.version = folders.version AND
                                      folderTitles.idLanguages = '.$this->intLanguageId, array('folderTitle' => 'title'))
              ->join('products AS lP', 'lP.idParent = folders.id AND
                                        lP.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array('idProduct' => 'id', 'productId', 'isStartProduct'))
              ->join('productLinks', 'productLinks.idProducts = lP.id', array())
              ->join('products', 'products.productId = productLinks.productId', array())
              ->join('productProperties', 'productProperties.productId = products.productId AND 
                                           productProperties.version = products.version AND
                                           productProperties.idLanguages = '.$this->intLanguageId, array('productStatus' => 'idStatus'))
              ->joinLeft('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productTitles.idLanguages = '.$this->intLanguageId, array('productTitle' => 'title'))
              ->where('folders.idRootLevels = ?', $intRootLevelId)
              ->where('products.id = (SELECT p.id FROM products p WHERE p.productId = products.productId ORDER BY p.version DESC LIMIT 1)')
              ->order('folders.lft')
              ->order('products.isStartProduct DESC')
              ->order('products.sortPosition ASC')
              ->order('products.sortTimestamp DESC')
              ->order('products.id ASC');

    return $this->objFolderTable->fetchAll($objSelect);
  }

  /**
   * loadWebsiteRootLevelChilds
   * @param integer $intRootLevelId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadWebsiteRootLevelChilds($intRootLevelId, $intDepth = 1){
    $this->core->logger->debug('core->models->Folders->loadRootLevelChilds('.$intRootLevelId.','.$intDepth.')');

    $strFolderFilter = '';
    $strPageFilter = '';
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $strFolderFilter = 'AND folders.idStatus = '.$this->core->sysConfig->status->live;
      $strPageFilter = 'AND pages.idStatus = '.$this->core->sysConfig->status->live;
    }

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS idFolder, folders.folderId, folderTitles.title AS folderTitle, folders.depth,
                                            IF(folders.idParentFolder = 0, pages.idParent, folders.idParentFolder) AS parentId,
                                            pages.id AS idPage, pages.pageId, pages.isStartPage,
                                            IF(pages.idPageTypes = ?, lUrls.url, urls.url) as url,
                                            IF(pages.idPageTypes = ?, plExternals.external, pageExternals.external) as external,
                                            IF(pages.idPageTypes = ?, plTitle.title, pageTitles.title) as title,
                                            pages.idPageTypes, (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                        FROM folders
                                          INNER JOIN folderTitles ON
                                            folderTitles.folderId = folders.folderId AND
																			      folderTitles.version = folders.version AND
																			      folderTitles.idLanguages = ?
																			    LEFT JOIN pages ON
																			      pages.idParent = folders.id AND
																			      pages.idParentTypes = ? AND
																			      pages.showInNavigation = 1
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
                                          folders.showInNavigation = 1
                                          '.$strFolderFilter.'
                                        ORDER BY folders.lft, pages.isStartPage DESC, pages.sortPosition ASC, pages.sortTimestamp DESC, pages.id ASC', array($this->core->sysConfig->page_types->link->id,
																																																																																													                                $this->core->sysConfig->page_types->link->id,
																																																																																													                                $this->core->sysConfig->page_types->link->id,
																																																																																													                                $this->intLanguageId,
																																																																																													                                $this->intLanguageId,
                                                                                                                                                             $this->core->sysConfig->parent_types->folder,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $this->intLanguageId,
                                                                                                                                                             $intRootLevelId,
                                                                                                                                                             $intDepth));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
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

    $sqlStmt = $this->core->dbh->query('SELECT folders.id AS folderId, folders.idStatus AS folderStatus,
                                               pages.id AS idPage, pages.pageId, pageTitles.title AS pageTitle, pages.isStartPage,
                                               pages.idStatus AS pageStatus, pages.created, pages.changed,
                                               (SELECT CONCAT(users.fname, \' \', users.sname) AS changeUser FROM users WHERE users.id = pages.idUsers) AS changeUser
                                              FROM folders
                                                LEFT JOIN pages ON
                                                  pages.idParent = folders.id AND
                                                  pages.idParentTypes = ? AND
                                                  pages.idPageTypes = ?
                                                LEFT JOIN pageTitles ON pageTitles.pageId = pages.pageId
                                                  AND pageTitles.version = pages.version
                                                  AND pageTitles.idLanguages = ?
                                              WHERE folders.idRootLevels = ?
                                                ORDER BY pages.changed DESC, pages.created DESC
                                              LIMIT '.$intLimitNumber, array($this->core->sysConfig->parent_types->folder, $this->core->sysConfig->page_types->page->id, $this->intLanguageId, $intRootLevelId));

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

    $sqlStmt = $this->core->dbh->query('SELECT folders.id, folderTitles.title, folders.idStatus, folders.depth, folders.idRootLevels, rootLevelTitles.title AS rootLevelTitle
                                              FROM folders
                                                INNER JOIN folderTitles ON
                                                  folderTitles.folderId = folders.folderId AND
                                                  folderTitles.version = folders.version AND
                                                  folderTitles.idLanguages = ?
                                                INNER JOIN rootLevels ON
                                                  rootLevels.id = folders.idRootLevels
                                                INNER JOIN rootLevelTitles ON
                                                  rootLevelTitles.idRootLevels = rootLevels.id
                                              WHERE folders.idRootLevels = ?
                                                ORDER BY folders.lft, folders.sortPosition ASC, folders.sortTimestamp DESC', array($this->intLanguageId, $intRootLevelId));

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

    /*$sqlStmt = $this->core->dbh->query('SELECT folders.id, folders.folderId, folders.isUrlFolder, folderTitles.title
                                          FROM folders
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
                                                                          $intFolderId));*/

    $sqlStmt = $this->core->dbh->query('SELECT folders.id, folders.folderId, folders.isUrlFolder, folderTitles.title,
                                               urls.url, (SELECT languageCode FROM languages WHERE id = ?) AS languageCode
                                          FROM folders
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
                                                                          $this->core->sysConfig->parent_types->folder,
                                                                          $this->intLanguageId,
                                                                          $this->intLanguageId,
                                                                          $intFolderId));

    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
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

    /**
     * SELECT `folders`.`id`, `folderTitles`.`title`, `genericForms`.`genericFormId`, `genericForms`.`version`
     *    FROM `folders`
     *        INNER JOIN `folderTitles` ON
     *            folderTitles.folderId = folders.folderId AND
     *            folderTitles.version = folders.version AND
     *            folderTitles.idLanguages = ?
     *        INNER JOIN `genericForms` ON genericForms.id = folders.idGenericForms
     *    WHERE (folders.idRootLevels = '?' AND folders.idParentFolder = 0)
     */
    $objSelect->from('folders', array('id'));
    $objSelect->join('folderTitles', 'folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->join('genericForms', 'genericForms.id = folders.idGenericForms', array('genericFormId', 'version'));
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

    /**
     * SELECT `folders`.`id`, `folderTitles`.`title`, `genericForms`.`genericFormId`, `genericForms`.`version`
     *    FROM `folders`
     *        INNER JOIN `folderTitles` ON
     *            folderTitles.folderId = folders.folderId AND
     *            folderTitles.version = folders.version AND
     *            folderTitles.idLanguages = ?
     *        INNER JOIN `genericForms` ON genericForms.id = folders.idGenericForms
     *    WHERE (folders.idParentFolder = '?')
     */
    $objSelect->from('folders', array('id'));
    $objSelect->join('folderTitles', 'folderTitles.folderId = folders.folderId AND folderTitles.version = folders.version AND folderTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->join('genericForms', 'genericForms.id = folders.idGenericForms', array('genericFormId', 'version'));
    $objSelect->where('folders.idParentFolder = ?', $intFolderId);

    return $this->getFolderTable()->fetchAll($objSelect);
  }

  /**
   * loadFolder
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadFolder($intElementId){
    $this->core->logger->debug('core->models->Folders->loadFolder('.$intElementId.')');

    $objSelect = $this->getFolderTable()->select();
    $objSelect->setIntegrityCheck(false);

    /**
     * SELECT `folders`.`id`, `folders`.`folderId`, `folders`.`version`, `folders`.`published`, `folders`.`changed`, `folders`.`idStatus`,
     *        `folders`.`creator`, `folders`.`isUrlFolder`, `folders`.`showInNavigation`,
		 *        (SELECT CONCAT(users.fname, ' ', users.sname) AS publisher
		 *          FROM users
		 *          WHERE users.id = folders.publisher)
		 *        AS publisher,
		 *        (SELECT CONCAT(users.fname, ' ', users.sname) AS changeUser
		 *          FROM users
		 *          WHERE users.id = folders.idUsers)
		 *        AS changeUser
     *    FROM `folders`
     *    WHERE (folders.id = '?')
     */

    $objSelect->from('folders', array('id', 'folderId', 'version', 'published', 'changed', 'idStatus', 'creator', 'isUrlFolder', 'showInNavigation',
                                      '(SELECT CONCAT(users.fname, \' \', users.sname) AS publisher FROM users WHERE users.id = folders.publisher) AS publisher',
                                      '(SELECT CONCAT(users.fname, \' \', users.sname) AS changeUser FROM users WHERE users.id = folders.idUsers) AS changeUser'));
    $objSelect->where('folders.id = ?', $intElementId);

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