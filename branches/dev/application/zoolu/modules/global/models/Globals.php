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
 * @package    application.zoolu.modules.globals.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_Globals
 *
 * Version history (please keep backward compatible):
 * 1.0, 2010-03-10: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Globals {

  private $intLanguageId;
  
  /**
   * @var Model_Folders
   */
  protected $objModelFolders;

  /**
   * @var Model_Table_Globals
   */
  protected $objGlobalTable;

  /**
   * @var Model_Table_GlobalProperties
   */
  protected $objGlobalPropertyTable;

  /**
   * @var Model_Table_Urls
   */
  protected $objGlobalUrlTable;

  /**
   * @var Model_Table_GlobalLinks
   */
  protected $objGlobalLinkTable;

  /**
   * @var Model_Table_GlobalInternalLinks
   */
  protected $objGlobalInternalLinkTable;

  /**
   * @var Model_Table_GlobalVideosTable
   */
  protected $objGlobalVideoTable;

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
   * load
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract Global
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function load($intElementId){
    $this->core->logger->debug('global->models->Model_Globals->load('.$intElementId.')');

    $objSelect = $this->getGlobalTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('globals', array('id', 'globalId', 'relationId' => 'globalId', 'version', 'isStartGlobal', 'idParent', 'idParentTypes', 'globalProperties.idGlobalTypes', 'globalProperties.showInNavigation', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.idStatus', 'globalProperties.creator'));
    $objSelect->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = globalProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
    $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = globalProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
    $objSelect->where('globals.id = ?', $intElementId);
    
    return $this->getGlobalTable()->fetchAll($objSelect);
  }
    
  /**
   * loadByIdAndVersion
   * @param string $strGlobalId
   * @param integer $intVersion
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadByIdAndVersion($strGlobalId, $intVersion){
    $this->core->logger->debug('global->models->Model_Globals->loadByIdAndVersion('.$strGlobalId.', '.$intVersion.')');

    $objSelect = $this->getGlobalTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('globals', array('id', 'globalId', 'relationId' => 'globalId', 'version', 'isStartElement' => 'isStartGlobal', 'idParent', 'idParentTypes', 'globalProperties.idTemplates', 'globalProperties.idGlobalTypes', 'globalProperties.showInNavigation', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.created', 'globalProperties.idStatus'));
    $objSelect->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = globalProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
    $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = globalProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
    $objSelect->joinLeft(array('ucr' => 'users'), 'ucr.id = globalProperties.creator', array('creator' => 'CONCAT(ucr.fname, \' \', ucr.sname)'));
    $objSelect->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'));
    $objSelect->join('templates', 'templates.id = globalProperties.idTemplates', array('filename'));
    $objSelect->where('globals.globalId = ?', $strGlobalId)
              ->where('globals.version = ?', $intVersion);
    
    return $this->getGlobalTable()->fetchAll($objSelect);   
  }
  
  /**
   * loadFormAndTemplateById
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadFormAndTemplateById($intElementId){
    $this->core->logger->debug('cms->models->Model_Globals->load('.$intElementId.')');

    $objSelect = $this->getGlobalTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('globals', array('globalProperties.idGenericForms', 'globalProperties.idTemplates', 'globalProperties.idGlobalTypes', 'globalProperties.showInNavigation'));
    $objSelect->join('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId'));
    $objSelect->where('globals.id = ?', $intElementId);

    return $this->getGlobalTable()->fetchAll($objSelect);
  }
  
  /**
   * loadByParentId
   * @param integer $intParentId
   * @param integer $intTypeId
   * @param boolean $blnOnlyStartGlobal
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadByParentId($intParentId, $intTypeId, $blnOnlyStartGlobal = false){
    $this->core->logger->debug('global->models->Model_Globals->loadByParentId('.$intParentId.', '.$intTypeId.', '.$blnOnlyStartGlobal.')');
    
    $objSelect = $this->getGlobalTable()->select();
    $objSelect->setIntegrityCheck(false);

    if($intTypeId == $this->core->sysConfig->page_types->product_tree->id){
      $objSelect->from('globals', array('id', 'globalId', 'relationId' => 'globalId', 'linkId' => 'lP.id', 'version', 'isStartElement' => 'isStartGlobal', 'idParent', 'idParentTypes', 'globalProperties.idTemplates', 'globalProperties.idGlobalTypes', 'globalProperties.showInNavigation', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.created', 'globalProperties.idStatus'));
      $objSelect->join('globalLinks', 'globalLinks.globalId = globals.globalId', array());
      $objSelect->join(array('lP' => 'globals'), 'lP.id = globalLinks.idGlobals', array());              
      $objSelect->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
      $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = globalProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
      $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = globalProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
      $objSelect->joinLeft(array('ucr' => 'users'), 'ucr.id = globalProperties.creator', array('creator' => 'CONCAT(ucr.fname, \' \', ucr.sname)'));
      $objSelect->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'));
      $objSelect->join('templates', 'templates.id = globalProperties.idTemplates', array('filename'));
      $objSelect->where('lP.idParent = ?', $intParentId)
                ->where('lP.idParentTypes = ?', $this->core->sysConfig->parent_types->folder);
      
      if($blnOnlyStartGlobal == true){
        $objSelect->where('lP.isStartGlobal = 1');
      }  
    }else{
      $objSelect->from('globals', array('id', 'globalId', 'relationId' => 'globalId', 'linkId' => new Zend_Db_Expr('-1'), 'version', 'isStartElement' => 'isStartGlobal', 'idParent', 'idParentTypes', 'globalProperties.idTemplates', 'globalProperties.idGlobalTypes', 'globalProperties.showInNavigation', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.created', 'globalProperties.idStatus'));
      $objSelect->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
      $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = globalProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
      $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = globalProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
      $objSelect->joinLeft(array('ucr' => 'users'), 'ucr.id = globalProperties.creator', array('creator' => 'CONCAT(ucr.fname, \' \', ucr.sname)'));
      $objSelect->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'));
      $objSelect->join('templates', 'templates.id = globalProperties.idTemplates', array('filename'));
      $objSelect->where('idParent = ?', $intParentId)
                ->where('idParentTypes = ?', $this->core->sysConfig->parent_types->folder);
      
      if($blnOnlyStartGlobal == true){
        $objSelect->where('isStartGlobal = 1');
      }  
    }
        
    return $this->getGlobalTable()->fetchAll($objSelect);   
  }

  /**
   * loadItems
   * @param integer $intTypeId
   * @param integer $intParentId
   * @param integer $intCategoryId
   * @param integer $intLabelId
   * @param integer $intEntryNumber
   * @param integer $intSortTypeId
   * @param integer $intSortOrderId
   * @param integer $intEntryDepthId
   * @param array $arrGlobalIds
   * @param boolean $blnOnlyItems load only items, no start items
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadItems($intTypeId, $intParentId, $intCategoryId = 0, $intLabelId = 0, $intEntryNumber = 0, $intSortTypeId = 0, $intSortOrderId = 0, $intEntryDepthId = 0, $arrGlobalIds = array(), $blnOnlyItems = false){
    $this->core->logger->debug('cms->models->Model_Globals->loadItems('.$intParentId.','.$intCategoryId.','.$intLabelId.','.$intEntryNumber.','.$intSortTypeId.','.$intSortOrderId.','.$intEntryDepthId.','.$arrGlobalIds.')');

    $strSortOrder = '';
    if($intSortOrderId > 0 && $intSortOrderId != ''){
      switch($intSortOrderId){
        case $this->core->sysConfig->sort->orders->asc->id:
          $strSortOrder = ' ASC';
          break;
        case $this->core->sysConfig->sort->orders->desc->id:
          $strSortOrder = ' DESC';
          break;
      }
    }    

    $objSelect1 = $this->core->dbh->select();
    
    if($intTypeId == $this->core->sysConfig->page_types->product_tree->id){
      $objSelect1->from('globals', array('id', 'globalId', 'relationId' => 'globalId', 'plId' => 'lP.id', 'isStartElement' => 'isStartGlobal', 'idParent', 'idParentTypes', 'sortPosition' => 'folders.sortPosition', 'sortTimestamp' => 'folders.sortTimestamp', 'globalProperties.idGlobalTypes', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.created', 'globalProperties.idStatus'))
               ->join('globalLinks', 'globalLinks.globalId = globals.globalId', array())
               ->join(array('lP' => 'globals'), 'lP.id = globalLinks.idGlobals', array())
               ->join('folders', 'folders.id = lP.idParent AND lP.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array())
               ->join('folders AS parent', 'parent.id = '.$intParentId, array())        
               ->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array())
               ->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'))
               ->joinLeft(array('ub' => 'users'), 'ub.id = globalProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'))
               ->joinLeft('globalCategories', 'globalCategories.globalId = globals.globalId AND globalCategories.version = globals.version', array())
               ->joinLeft('globalLabels', 'globalLabels.globalId = globals.globalId AND globalLabels.version = globals.version', array())
               ->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'))
               ->joinLeft('urls', 'urls.relationId = lP.globalId AND urls.version = lP.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND urls.idParent IS NULL AND urls.isMain = 1', array('url'))
               ->joinLeft('languages', 'languages.id = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('languageCode'))
               ->where('folders.lft BETWEEN parent.lft AND parent.rgt')
               ->where('folders.idRootLevels = parent.idRootLevels');
                 
      if($blnOnlyItems === true){
        $objSelect1->where('lP.isStartGlobal = 0');
      }
      
      switch($intEntryDepthId){
        case $this->core->sysConfig->filter->depth->all:
          $objSelect1->where('folders.depth > parent.depth');
          break;
        case $this->core->sysConfig->filter->depth->first:
        default:
          $objSelect1->where('lP.isStartGlobal = 1')
                     ->where('folders.depth = (parent.depth + 1)');        
          break;
      }
      
      
      $objSelect2 = $this->core->dbh->select();
      $objSelect2->from('globals', array('id', 'globalId', 'relationId' => 'globalId', 'plId' => 'lP.id', 'isStartElement' => 'isStartGlobal', 'idParent', 'idParentTypes', 'sortPosition' => 'lP.sortPosition', 'sortTimestamp' => 'lP.sortTimestamp', 'globalProperties.idGlobalTypes', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.created', 'globalProperties.idStatus'))
                 ->join('globalLinks', 'globalLinks.globalId = globals.globalId', array())
                 ->join(array('lP' => 'globals'), 'lP.id = globalLinks.idGlobals', array())
                 ->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array())
                 ->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'))
                 ->joinLeft(array('ub' => 'users'), 'ub.id = globalProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'))
                 ->joinLeft('globalCategories', 'globalCategories.globalId = globals.globalId AND globalCategories.version = globals.version', array())
                 ->joinLeft('globalLabels', 'globalLabels.globalId = globals.globalId AND globalLabels.version = globals.version', array())
                 ->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'))
                 ->joinLeft('urls', 'urls.relationId = lP.globalId AND urls.version = lP.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND urls.idParent IS NULL AND urls.isMain = 1', array('url'))
                 ->joinLeft('languages', 'languages.id = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('languageCode'))
                 ->where('lP.idParent = ?', $intParentId)
                 ->where('lP.isStartGlobal = 0');
    }else{
      $objSelect1->from('globals', array('id', 'globalId', 'relationId' => 'globalId', 'plId' => new Zend_Db_Expr('-1'), 'isStartElement' => 'isStartGlobal', 'idParent', 'idParentTypes', 'sortPosition' => 'folders.sortPosition', 'sortTimestamp' => 'folders.sortTimestamp', 'globalProperties.idGlobalTypes', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.created', 'globalProperties.idStatus'))
               ->join('folders', 'folders.id = globals.idParent AND globals.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array())
               ->join('folders AS parent', 'parent.id = '.$intParentId, array())        
               ->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array())
               ->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'))
               ->joinLeft(array('ub' => 'users'), 'ub.id = globalProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'))
               ->joinLeft('globalCategories', 'globalCategories.globalId = globals.globalId AND globalCategories.version = globals.version', array())
               ->joinLeft('globalLabels', 'globalLabels.globalId = globals.globalId AND globalLabels.version = globals.version', array())
               ->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'))
               ->joinLeft('urls', 'urls.relationId = globals.globalId AND urls.version = globals.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND urls.idParent IS NULL AND urls.isMain = 1', array('url'))
               ->joinLeft('languages', 'languages.id = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('languageCode'))
               ->where('folders.lft BETWEEN parent.lft AND parent.rgt')
               ->where('folders.idRootLevels = parent.idRootLevels');
                 
      if($blnOnlyItems === true){
        $objSelect1->where('globals.isStartGlobal = 0');
      }
      
      switch($intEntryDepthId){
        case $this->core->sysConfig->filter->depth->all:
          $objSelect1->where('folders.depth > parent.depth');
          break;
        case $this->core->sysConfig->filter->depth->first:
        default:
          $objSelect1->where('globals.isStartGlobal = 1')
                     ->where('folders.depth = (parent.depth + 1)');        
          break;
      }
            
      $objSelect2 = $this->core->dbh->select();
      $objSelect2->from('globals', array('id', 'globalId', 'relationId' => 'globalId', 'plId' => new Zend_Db_Expr('-1'), 'isStartElement' => 'isStartGlobal', 'idParent', 'idParentTypes', 'sortPosition' => 'globals.sortPosition', 'sortTimestamp' => 'globals.sortTimestamp', 'globalProperties.idGlobalTypes', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.created', 'globalProperties.idStatus'))
                 ->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array())
                 ->join('genericForms', 'genericForms.id = globalProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'))
                 ->joinLeft(array('ub' => 'users'), 'ub.id = globalProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'))
                 ->joinLeft('globalCategories', 'globalCategories.globalId = globals.globalId AND globalCategories.version = globals.version', array())
                 ->joinLeft('globalLabels', 'globalLabels.globalId = globals.globalId AND globalLabels.version = globals.version', array())
                 ->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'))
                 ->joinLeft('urls', 'urls.relationId = globals.globalId AND urls.version = globals.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND urls.idParent IS NULL AND urls.isMain = 1', array('url'))
                 ->joinLeft('languages', 'languages.id = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('languageCode'))
                 ->where('globals.idParent = ?', $intParentId)
                 ->where('globals.isStartGlobal = 0');
      
    }
    

    if(count($arrGlobalIds) > 0){
      $objSelect1->where('globals.id NOT IN ('.implode(',', $arrGlobalIds).')');
      $objSelect2->where('globals.id NOT IN ('.implode(',', $arrGlobalIds).')');
    }

    if($intCategoryId > 0 && $intCategoryId != ''){
      $objSelect1->where('globalCategories.category = ?', $intCategoryId);
      $objSelect2->where('globalCategories.category = ?', $intCategoryId);
    }

    if($intLabelId > 0 && $intLabelId != ''){
      $objSelect1->where('globalLabels.label = ?', $intLabelId);
      $objSelect2->where('globalLabels.label = ?', $intLabelId);
    }
    
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $objSelect1->where('globalProperties.idStatus = ?', $this->core->sysConfig->status->live)
                 ->where('globalProperties.published <= ?', date('Y-m-d H:i:s'));
      $objSelect2->where('globalProperties.idStatus = ?', $this->core->sysConfig->status->live)
                 ->where('globalProperties.published <= ?', date('Y-m-d H:i:s'));
    }

    $objSelect = $this->getGlobalTable()->select()
                                         ->distinct()
                                         ->union(array($objSelect1, $objSelect2));
                        
    if($intSortTypeId > 0 && $intSortTypeId != ''){
      switch($intSortTypeId){
        case $this->core->sysConfig->sort->types->manual_sort->id:
          $objSelect->order(array('sortPosition'.$strSortOrder, 'sortTimestamp'.(($strSortOrder == 'DESC') ? ' ASC' : ' DESC')));
          break;
        case $this->core->sysConfig->sort->types->created->id:
          $objSelect->order(array('created'.$strSortOrder));
          break;
        case $this->core->sysConfig->sort->types->changed->id:
          $objSelect->order(array('changed'.$strSortOrder));
          break;
        case $this->core->sysConfig->sort->types->published->id:
          $objSelect->order(array('published'.$strSortOrder));
          break;
        case $this->core->sysConfig->sort->types->alpha->id:
          $objSelect->order(array('title'.$strSortOrder)); 
          break;
      }
    }
    
    if($intEntryNumber > 0 && $intEntryNumber != ''){
      $objSelect->limit($intEntryNumber);
    }

    return $this->getGlobalTable()->fetchAll($objSelect);
  }
  
  /**
   * loadItemInstanceDataByIds
   * @param string $strGenForm
   * @param array $arrGlobalIds
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadItemInstanceDataByIds($strGenForm, $arrGlobalIds){
    $this->core->logger->debug('cms->models->Model_Globals->loadItemInstanceDataByIds('.$strGenForm.', '.$arrGlobalIds.')');

    // FIXME : !!! CHANGE INSTANCE FIELDS DEFINTION
    // FIXME : !!! iFl.idFields IN (5,55) -> define
    if($strGenForm != '' && $strGenForm != '-' && strpos($strGenForm, $this->core->sysConfig->global_types->product_link->default_formId) === false){
      $strSqlInstanceFields = '';
      if(strpos($strGenForm, $this->core->sysConfig->form->ids->press->default) !== false){
        $strSqlInstanceFields = ' `global-'.$strGenForm.'-Instances`.shortdescription,
                                  `global-'.$strGenForm.'-Instances`.description,
                                  globalDatetimes.datetime,';
      }else{
        $strSqlInstanceFields = ' `global-'.$strGenForm.'-Instances`.shortdescription,
                                  `global-'.$strGenForm.'-Instances`.description,';
      }
      
      $strSqlWhereGlobalIds = '';
      if(count($arrGlobalIds) > 0){
        $strSqlWhereGlobalIds = ' WHERE globals.id IN ('.implode(',',$arrGlobalIds).')';
      }

      $sqlStmt = $this->core->dbh->query('SELECT globals.id,
                                            '.$strSqlInstanceFields.'
                                            files.filename, files.version AS fileversion, files.path AS filepath, fileTitles.title AS filetitle
                                          FROM globals
                                          LEFT JOIN globalDatetimes ON
                                            globalDatetimes.globalId = globals.globalId AND
                                            globalDatetimes.version = globals.version AND
                                            globalDatetimes.idLanguages = ?
                                          LEFT JOIN `global-'.$strGenForm.'-Instances` ON
                                            `global-'.$strGenForm.'-Instances`.globalId = globals.globalId AND
                                            `global-'.$strGenForm.'-Instances`.version = globals.version AND
                                            `global-'.$strGenForm.'-Instances`.idLanguages = ?
                                          LEFT JOIN `global-'.$strGenForm.'-InstanceFiles` AS iFiles ON
                                            iFiles.id = (SELECT iFl.id FROM `global-'.$strGenForm.'-InstanceFiles` AS iFl
                                                         WHERE iFl.globalId = globals.globalId AND iFl.version = globals.version AND iFl.idLanguages = ? AND iFl.idFields IN (5,55)
                                                         ORDER BY iFl.idFields DESC LIMIT 1)
                                          LEFT JOIN files ON
                                            files.id = iFiles.idFiles AND
                                            files.isImage = 1
                                          LEFT JOIN fileTitles ON
                                            fileTitles.idFiles = files.id AND
                                            fileTitles.idLanguages = ?
                                          '.$strSqlWhereGlobalIds, array($this->intLanguageId, $this->intLanguageId, $this->intLanguageId, $this->intLanguageId));

      return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
    }
  }
  
  /**
   * search
   * @param string $strSearchValue
   * @return Zend_Db_Table_Rowset_Abstract Global
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   *
   */
  public function search($strSearchValue){

    $objSelect = $this->getGlobalTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('globals', array('id', 'globalId', 'version', 'isStartGlobal', 'idParent', 'idParentTypes', 'globalProperties.idGlobalTypes', 'globalProperties.showInNavigation', 'globalProperties.published', 'globalProperties.changed', 'globalProperties.idStatus', 'globalProperties.creator'));
    $objSelect->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->joinLeft('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'));
    $objSelect->where('globalTitles.title LIKE ?', '%'.$strSearchValue.'%')
              ->where('idParent = ?', $this->core->sysConfig->product->rootLevels->list->id)
              ->where('idParentTypes = ?', $this->core->sysConfig->parent_types->rootlevel)
              ->where('isStartGlobal = 0')
              ->order('globalTitles.title');

    return $this->getGlobalTable()->fetchAll($objSelect);
  }

  /**
   * add
   * @param GenericSetup $objGenericSetup
   * @return stdClass Global
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function add(GenericSetup &$objGenericSetup){
    $this->core->logger->debug('global->models->Model_Globals->add()');

    $objGlobal = new stdClass();
    $objGlobal->globalId = uniqid();
    $objGlobal->version = 1;
    $objGlobal->sortPosition = GenericSetup::DEFAULT_SORT_POSITION;
    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    if($objGenericSetup->getRootLevelGroupId() == $this->core->sysConfig->root_level_groups->product){
      $objGlobal->parentId = $this->core->sysConfig->product->rootLevels->list->id;
      $objGlobal->parentTypeId = $this->core->sysConfig->parent_types->rootlevel;
    }else{
      /**
       * check if parent element is rootlevel or folder and get sort position
       */
      if($objGenericSetup->getParentId() != '' && $objGenericSetup->getParentId() > 0){
        $objGlobal->parentId = $objGenericSetup->getParentId();
        $objGlobal->parentTypeId = $this->core->sysConfig->parent_types->folder;
        $this->getModelFolders()->setLanguageId($this->core->sysConfig->languages->default->id);
        $objNaviData = $this->getModelFolders()->loadGlobalChildNavigation($objGenericSetup->getParentId(), $objGenericSetup->getRootLevelGroupId());
      }else{
        if($objGenericSetup->getRootLevelId() != '' && $objGenericSetup->getRootLevelId() > 0){
          $objGlobal->parentId = $objGenericSetup->getRootLevelId();          
        }else{
          $this->core->logger->err('zoolu->modules->global->models->Model_Globals->add(): intRootLevelId is empty!');
        }
        $objGlobal->parentTypeId = $this->core->sysConfig->parent_types->rootlevel;
        $this->getModelFolders()->setLanguageId($this->core->sysConfig->languages->default->id);
        $objNaviData = $this->getModelFolders()->loadGlobalRootNavigation($objGenericSetup->getRootLevelId(), $objGenericSetup->getRootLevelGroupId());
      }
      $objGlobal->sortPosition = count($objNaviData);
    }
    
    /**
     * insert main data
     */
    $arrMainData = array('idParent'         => $objGlobal->parentId,
                         'idParentTypes'    => $objGlobal->parentTypeId,
                         'isStartGlobal'    => $objGenericSetup->getIsStartElement(),
                         'idUsers'          => $intUserId,
                         'sortPosition'     => $objGlobal->sortPosition,
                         'sortTimestamp'    => date('Y-m-d H:i:s'),
                         'globalId'         => $objGlobal->globalId,
                         'version'          => $objGlobal->version,
                         'creator'          => $objGenericSetup->getCreatorId(),
                         'created'          => date('Y-m-d H:i:s'));
    $objGlobal->id = $this->getGlobalTable()->insert($arrMainData);

    /**
     * insert language specific properties
     */
    $arrProperties = array('globalId'         => $objGlobal->globalId,
                           'version'          => $objGlobal->version,
                           'idLanguages'      => $this->intLanguageId,
                           'idGenericForms'   => $objGenericSetup->getGenFormId(),
                           'idTemplates'      => $objGenericSetup->getTemplateId(),
                           'idGlobalTypes'    => $objGenericSetup->getElementTypeId(),
                           'showInNavigation' => $objGenericSetup->getShowInNavigation(),
                           'idUsers'          => $intUserId,
                           'creator'          => $objGenericSetup->getCreatorId(),
                           'publisher'        => $intUserId,
                           'created'          => date('Y-m-d H:i:s'),
                           'published'        => $objGenericSetup->getPublishDate(),
                           'idStatus'         => $objGenericSetup->getStatusId());
    $this->getGlobalPropertyTable()->insert($arrProperties);
    
    /**
     * add properties for zoolu gui
     */
    $arrZooluLanguages = $this->core->zooConfig->languages->language->toArray();
    foreach($arrZooluLanguages as $arrZooluLanguage){
      if($arrZooluLanguage['id'] != $this->intLanguageId){
        $arrProperties = array('globalId'         => $objGlobal->globalId,
                               'version'          => $objGlobal->version,
                               'idLanguages'      => $arrZooluLanguage['id'],
                               'idGenericForms'   => $objGenericSetup->getGenFormId(),
                               'idTemplates'      => $objGenericSetup->getTemplateId(),
                               'idGlobalTypes'    => $objGenericSetup->getElementTypeId(),
                               'showInNavigation' => $objGenericSetup->getShowInNavigation(),
                               'idUsers'          => $intUserId,
                               'creator'          => $objGenericSetup->getCreatorId(),
                               'publisher'        => $intUserId,
                               'created'          => date('Y-m-d H:i:s'),
                               'idStatus'         => $this->core->sysConfig->status->test);
        $this->getGlobalPropertyTable()->insert($arrProperties);
      }
    }

    /**
     * if is tree add, make alis now
     */
    if($objGenericSetup->getRootLevelId() == $this->core->sysConfig->product->rootLevels->tree->id){
      $objGlobal->parentId = $objGenericSetup->getParentId();
      $objGlobal->rootLevelId = $objGenericSetup->getRootLevelId();
      $objGlobal->rootLevelGroupId = $objGenericSetup->getRootLevelGroupId();
      $objGlobal->isStartElement = $objGenericSetup->getIsStartElement();
      $this->addLink($objGlobal);
    }

    return $objGlobal;
  }

  /**
   * addLink
   * @param stdClass $objGlobal
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addLink(&$objGlobal){
    $this->core->logger->debug('global->models->Model_Globals->addLink()');
    
    $objGlobal->linkGlobalId = uniqid();
    $objGlobal->linkVersion = 1;
    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    /**
     * check if parent element is rootlevel or folder and get sort position
     */
    if($objGlobal->parentId != '' && $objGlobal->parentId > 0){
      $objGlobal->parentTypeId = $this->core->sysConfig->parent_types->folder;
      $objNaviData = $this->getModelFolders()->loadGlobalChildNavigation($objGlobal->parentId, $objGlobal->rootLevelGroupId);
    }else{
      if($objGlobal->rootLevelId != '' && $objGlobal->rootLevelId > 0){
        $objGlobal->parentId = $objGlobal->rootLevelId;
      }else{
        $this->core->logger->err('zoolu->modules->global->models->Model_Globals->addLink(): intRootLevelId is empty!');
      }
      $objGlobal->parentTypeId = $this->core->sysConfig->parent_types->rootlevel;
      $objNaviData = $this->getModelFolders()->loadGlobalRootNavigation($objGlobal->rootLevelId, $objGlobal->rootLevelGroupId);
    }
    $objGlobal->sortPosition = count($objNaviData);

    /**
     * insert main data
     */
    $arrMainData = array('idParent'         => $objGlobal->parentId,
                         'idParentTypes'    => $objGlobal->parentTypeId,
                         'isStartGlobal'    => $objGlobal->isStartElement,
                         'idUsers'          => $intUserId,
                         'sortPosition'     => $objGlobal->sortPosition,
                         'sortTimestamp'    => date('Y-m-d H:i:s'),
                         'globalId'         => $objGlobal->linkGlobalId,
                         'version'          => $objGlobal->linkVersion,
                         'creator'          => $intUserId,
                         'created'          => date('Y-m-d H:i:s'));
    $objGlobal->linkId = $this->getGlobalTable()->insert($arrMainData);

    $arrLinkedGlobal = array('idGlobals'  => $objGlobal->linkId,
                             'globalId'   => $objGlobal->globalId);
    $this->getGlobalLinkTable()->insert($arrLinkedGlobal);
  }

  /**
   * update
   * @param GenericSetup $objGenericSetup
   * @param object Global
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function update(GenericSetup &$objGenericSetup, $objGlobal){
    $this->core->logger->debug('global->models->Model_Globals->update()');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $strWhere = $this->getGlobalTable()->getAdapter()->quoteInto('globalId = ?', $objGlobal->globalId);
    $strWhere .= $this->getGlobalTable()->getAdapter()->quoteInto(' AND version = ?', $objGlobal->version);

    $this->getGlobalTable()->update(array('idUsers'  => $intUserId,
                                          'changed' => date('Y-m-d H:i:s')), $strWhere);
    /**
     * update language specific global properties
     */
    $strWhere .= $this->getGlobalTable()->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);
    $intNumOfEffectedRows = $this->getGlobalPropertyTable()->update(array('idGenericForms'    => $objGenericSetup->getGenFormId(),
                                                                           'idTemplates'      => $objGenericSetup->getTemplateId(),
                                                                           'idGlobalTypes'    => $objGenericSetup->getElementTypeId(),
                                                                           'showInNavigation' => $objGenericSetup->getShowInNavigation(),
                                                                           'idUsers'          => $intUserId,
                                                                           'creator'          => $objGenericSetup->getCreatorId(),
                                                                           'idStatus'         => $objGenericSetup->getStatusId(),
                                                                           'published'        => $objGenericSetup->getPublishDate(),
                                                                           'changed'          => date('Y-m-d H:i:s')), $strWhere);
    
    /**
     * insert language specific global properties
     */
    if($intNumOfEffectedRows == 0){      
      $arrProperties = array('globalId'         => $objGlobal->globalId,
                             'version'          => $objGlobal->version,
                             'idLanguages'      => $this->intLanguageId,
                             'idGenericForms'   => $objGenericSetup->getGenFormId(),
                             'idTemplates'      => $objGenericSetup->getTemplateId(),
                             'idGlobalTypes'    => $objGenericSetup->getElementTypeId(),
                             'showInNavigation' => $objGenericSetup->getShowInNavigation(),
                             'idUsers'          => $intUserId,
                             'creator'          => $objGenericSetup->getCreatorId(),
                             'publisher'        => $intUserId,
                             'created'          => date('Y-m-d H:i:s'),
                             'published'        => $objGenericSetup->getPublishDate(),
                             'idStatus'         => $objGenericSetup->getStatusId());
      $this->getGlobalPropertyTable()->insert($arrProperties);
    }

  }

  /**
   * updateFolderStartGlobal
   * @param integer $intFolderId
   * @param array $arrProperties
   * @param string $arrTitle
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function updateFolderStartGlobal($intFolderId, $arrProperties, $arrTitle, $intRootLevelGroupId){
    $objSelect = $this->getGlobalTable()->select();
    $objSelect->from('globals', array('globalId', 'version'));
    
    if($intRootLevelGroupId == $this->core->sysConfig->root_level_groups->product){
      $objSelect->join('globalLinks', 'globalLinks.globalId = globals.globalId', array());
      $objSelect->join(array('lP' => 'globals'), 'lP.id = globalLinks.idGlobals', array());
      $objSelect->where('lP.idParent = ?', $intFolderId)
                ->where('lP.idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
                ->where('lP.isStartGlobal = 1');
      $objSelect->order(array('lP.version DESC'));      
    }else{
      $objSelect->where('idParent = ?', $intFolderId)
                ->where('idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
                ->where('isStartGlobal = 1');
      $objSelect->order(array('version DESC'));
    }
    $objSelect->limit(1);
    
    $objStartGlobal = $this->objGlobalTable->fetchAll($objSelect);

    if(count($objStartGlobal) > 0){
      $objStartGlobal = $objStartGlobal->current();

      $strWhere = $this->getGlobalPropertyTable()->getAdapter()->quoteInto('globalId = ?', $objStartGlobal->globalId);
      $strWhere .= $this->objGlobalPropertyTable->getAdapter()->quoteInto(' AND version = ?',  $objStartGlobal->version);
      $strWhere .= $this->objGlobalPropertyTable->getAdapter()->quoteInto(' AND idLanguages = ?',  $this->intLanguageId);

      $intNumOfEffectedRows = $this->objGlobalPropertyTable->update($arrProperties, $strWhere);
      if($intNumOfEffectedRows == 0){
        $arrProperties = array_merge($arrProperties, array('globalId' => $objStartGlobal->globalId, 'version' => $objStartGlobal->version, 'idLanguages' => $this->intLanguageId));
        $this->objGlobalPropertyTable->insert($arrProperties);
      }
      
      $intNumOfEffectedRows = $this->core->dbh->update('globalTitles', $arrTitle, $strWhere);

      if($intNumOfEffectedRows == 0){
        $arrTitle = array_merge($arrTitle, array('globalId' => $objStartGlobal->globalId, 'version' => $objStartGlobal->version, 'idLanguages' => $this->intLanguageId));
        $this->core->dbh->insert('globalTitles', $arrTitle);
      }
    }
  }

  /**
   * delete
   * @param integer $intElementId
   * @return the number of rows deleted
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function delete($intElementId){
    $this->core->logger->debug('global->models->Model_Globals->delete()');

    $objGlobal = $this->load($intElementId);
    if(count($objGlobal) == 1){
      $objGlobal = $objGlobal->current();
      $strGlobalId = $objGlobal->globalId;
      
      if($objGlobal->idParent == $this->core->sysConfig->product->rootLevels->list->id &&
         $objGlobal->idParentTypes == $this->core->sysConfig->parent_types->rootlevel){
        //TODO:: delet all link globals
      }
      
      $strWhere = $this->objGlobalTable->getAdapter()->quoteInto('relationId = ?', $strGlobalId);
      $strWhere .= $this->objGlobalTable->getAdapter()->quoteInto(' AND idUrlTypes = ?', $this->core->sysConfig->url_types->global);
      $this->getGlobalUrlTable()->delete($strWhere);
    }
    
    $strWhere = $this->getGlobalTable()->getAdapter()->quoteInto('id = ?', $intElementId);
    return $this->objGlobalTable->delete($strWhere);
  }
  
  /**
   * loadParentFolders
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadParentFolders($intElementId){
    $this->core->logger->debug('global->models->Model_Globals->loadParentFolders('.$intElementId.')');

    $sqlStmt = $this->core->dbh->query('SELECT folders.id, folders.isUrlFolder, folderTitles.title
                                          FROM folders
                                            INNER JOIN folderTitles ON
                                              folderTitles.folderId = folders.folderId AND
                                              folderTitles.version = folders.version AND
                                              folderTitles.idLanguages = ?
                                          ,folders AS parent
                                            INNER JOIN globals ON
                                              globals.id = ? AND
                                              parent.id = globals.idParent AND
                                              globals.idParentTypes = ?
                                           WHERE folders.lft <= parent.lft AND
                                                 folders.rgt >= parent.rgt AND
                                                 folders.idRootLevels = parent.idRootLevels
                                             ORDER BY folders.rgt', array($this->intLanguageId, $intElementId, $this->core->sysConfig->parent_types->folder));
    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * addInternalLinks
   * @param string $strLinkedGlobalIds
   * @param string $strElementId
   * @param integer $intVersion
   * @return integer
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addInternalLinks($strLinkedGlobalIds, $strElementId, $intVersion){
    $this->core->logger->debug('cms->models->Model_Globals->addInternalLinks('.$strLinkedGlobalIds.', '.$strElementId.', '.$intVersion.')');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $arrData = array('globalId'     => $strElementId,
                     'version'     => $intVersion,
                     'idLanguages' => $this->intLanguageId,
                     'idUsers'     => $intUserId,
                     'creator'     => $intUserId,
                     'created'     => date('Y-m-d H:i:s'));

    $strTmpLinkedGlobalIds = trim($strLinkedGlobalIds, '[]');
    $arrLinkedGlobalIds = split('\]\[', $strTmpLinkedGlobalIds);

    if(count($arrLinkedGlobalIds) > 0){
      foreach($arrLinkedGlobalIds as $sortPosition => $strLinkedGlobalId){
        $arrData['linkedGlobalId'] = $strLinkedGlobalId;
        $arrData['sortPosition'] = $sortPosition + 1;
        $this->getGlobalInternalLinkTable()->insert($arrData);
      }
    }
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
    $this->core->logger->debug('cms->models->Model_Globals->loadInternalLinks('.$strElementId.','.$intVersion.')');

    $objSelect = $this->getGlobalInternalLinkTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('globals', array('globals.id', 'relationId' => 'globals.globalId', 'globals.globalId', 'globals.version', 'globalProperties.idGlobalTypes', 'isStartItem' => 'globals.isStartGlobal', 'globals.isStartGlobal', 'globalProperties.idStatus'));
    $objSelect->joinLeft('globalProperties', 'globalProperties.globalId = globals.globalId AND globalProperties.version = globals.version AND globalProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->join('globalLinks', 'globalLinks.globalId = globals.globalId', array());
    $objSelect->join(array('lP' => 'globals'), 'lP.id = globalLinks.idGlobals', array('lPId' => 'globalId'));
    $objSelect->joinLeft('urls', 'urls.relationId = lP.globalId AND urls.version = lP.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND urls.isMain = 1 AND urls.idParent IS NULL', array('url'));
    $objSelect->joinLeft('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->join('globalInternalLinks', 'globalInternalLinks.linkedGlobalId = lP.globalId AND globalInternalLinks.globalId = '.$this->core->dbh->quote($strElementId).' AND globalInternalLinks.version = '.$this->core->dbh->quote($intVersion, Zend_Db::INT_TYPE).' AND globalInternalLinks.idLanguages = '.$this->intLanguageId, array('sortPosition'));
    $objSelect->join('globalTitles', 'globalTitles.globalId = globals.globalId AND globalTitles.version = globals.version AND globalTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'));
    $objSelect->where('globals.id = (SELECT p.id FROM globals AS p WHERE globals.globalId = p.globalId ORDER BY p.version DESC LIMIT 1)');
    $objSelect->order('globalInternalLinks.sortPosition ASC');

    return $this->objGlobalInternalLinkTable->fetchAll($objSelect);
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
    $this->core->logger->debug('cms->models->Model_Globals->deleteInternalLinks('.$strElementId.','.$intVersion.')');

    $strWhere = $this->getGlobalInternalLinkTable()->getAdapter()->quoteInto('globalId = ?', $strElementId);
    $strWhere .= $this->objGlobalInternalLinkTable->getAdapter()->quoteInto(' AND version = ?', $intVersion);
    $strWhere .= $this->objGlobalInternalLinkTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);

    return $this->objGlobalInternalLinkTable->delete($strWhere);
  }

   /**
   * loadVideo
   * @param string $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadVideo($intElementId){
    $this->core->logger->debug('global->models->Model_Globals->loadVideo('.$intElementId.')');

    $objSelect = $this->getGlobalVideoTable()->select();
    $objSelect->from($this->objGlobalVideoTable, array('userId', 'videoId', 'idVideoTypes', 'thumb'));
    $objSelect->join('globals', 'globals.globalId = globalVideos.globalId AND globals.version = globalVideos.version', array());
    $objSelect->where('globals.id = ?', $intElementId)
              ->where('idLanguages = ?', $this->getLanguageId());

    return $this->objGlobalVideoTable->fetchAll($objSelect);
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
   $this->core->logger->debug('global->models->Model_Globals->addVideo('.$intElementId.','.$mixedVideoId.','.$intVideoTypeId.','.$strVideoUserId.','.$strVideoThumb.')');

    $objGlobalData = $this->load($intElementId);

    if(count($objGlobalData) > 0){
      $objGlobal = $objGlobalData->current();

      $this->getGlobalVideoTable();

      $strWhere = $this->objGlobalVideoTable->getAdapter()->quoteInto('globalId = ?', $objGlobal->globalId);
      $strWhere .= 'AND '.$this->objGlobalVideoTable->getAdapter()->quoteInto('version = ?', $objGlobal->version);
      $this->objGlobalVideoTable->delete($strWhere);

      if($mixedVideoId != ''){
        $intUserId = Zend_Auth::getInstance()->getIdentity()->id;
        $arrData = array('globalId'      => $objGlobal->globalId,
                         'version'      => $objGlobal->version,
                         'idLanguages'  => $this->intLanguageId,
                         'userId'       => $strVideoUserId,
                         'videoId'      => $mixedVideoId,
                         'idVideoTypes' => $intVideoTypeId,
                         'thumb'        => $strVideoThumb,
                         'creator'      => $intUserId);
        return $objSelect = $this->objGlobalVideoTable->insert($arrData);
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
    $this->core->logger->debug('global->models->Model_Globals->removeVideo('.$intElementId.')');

    $objGlobalData = $this->load($intElementId);

    if(count($objGlobalData) > 0){
      $objGlobal = $objGlobalData->current();

      $this->getGlobalVideoTable();

      $strWhere = $this->objGlobalVideoTable->getAdapter()->quoteInto('globalId = ?', $objGlobal->globalId);
      $strWhere .= 'AND '.$this->objGlobalVideoTable->getAdapter()->quoteInto('version = ?', $objGlobal->version);

      return $this->objGlobalVideoTable->delete($strWhere);
    }
  }

  /**
   * loadParentUrl
   * @param integer $intGlobalId
   * @param boolean $blnIsStartElement
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadParentUrl($intGlobalId, $blnIsStartElement){
    $this->core->logger->debug('global->models->Model_Globals->loadParentUrl('.$intGlobalId.','.$blnIsStartElement.')');

    $objSelect = $this->getGlobalUrlTable()->select();
    $objSelect->setIntegrityCheck(false);

    if($blnIsStartElement == true){
      $objSelect->from($this->objGlobalUrlTable, array('url','id'));
      $objSelect->join('globals', 'globals.globalId = urls.relationId', array('globalId','version','isStartglobal'));
      $objSelect->join('folders', 'folders.id = (SELECT idParent FROM globals WHERE id = '.$intGlobalId.')', array());
      $objSelect->where('urls.version = globals.version')
                ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->global)
                ->where('urls.idLanguages = ?', $this->intLanguageId)
                ->where('urls.isMain = 1')
                ->where('globals.idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
                ->where('globals.idParent = folders.idParentFolder')
                ->where('globals.isStartGlobal = 1');
    }else{
      $objSelect->from($this->objGlobalUrlTable, array('url','id'));
      $objSelect->join('globals', 'globals.globalId = urls.relationId', array('globalId','version','isStartglobal'));
      $objSelect->where('urls.version = globals.version')
                ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->global)
                ->where('urls.idLanguages = ?', $this->intLanguageId)
                ->where('urls.isMain = 1')
                ->where('globals.idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
                ->where('globals.idParent = (SELECT idParent FROM globals WHERE id = '.$intGlobalId.')')
                ->where('globals.isStartGlobal = 1');
    }

    return $this->objGlobalUrlTable->fetchAll($objSelect);
  }

  /**
   * loadUrlHistory
   * @param str $strGlobalId
   * @param integer $intLanguageId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  public function loadUrlHistory($intGlobalId, $intLanguageId){
    $this->core->logger->debug('cms->models->Model_Globals->loadGlobalUrlHistory('.$intGlobalId.', '.$intLanguageId.')');

    $objSelect = $this->getGlobalTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objGlobalTable, array('globalId', 'relationId' => 'globalId', 'version', 'isStartglobal'))
              ->join('urls', 'urls.relationId = globals.globalId AND urls.version = globals.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$intLanguageId.' AND urls.isMain = 0 AND urls.idParent IS NULL', array('id', 'url'))
              ->join('languages', 'languages.id = urls.idLanguages', array('languageCode'))
              ->where('globals.id = ?', $intGlobalId);

    return $this->objGlobalTable->fetchAll($objSelect);
  }

  /**
   * getChildUrls
   * @param integer $intParentId
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getChildUrls($intParentId){

    $objSelect = $this->getGlobalTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objGlobalTable, array('id', 'globalId', 'relationId' => 'globalId', 'version'))
              ->join('urls', 'urls.relationId = globals.globalId AND urls.version = globals.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->global.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1', array('id', 'url'))
              ->join('folders AS parent', 'parent.id = '.$intParentId, array())
              ->join('folders', 'folders.lft BETWEEN parent.lft AND parent.rgt AND folders.idRootLevels = parent.idRootLevels', array())
              ->where('globals.idParent = folders.id')
              ->where('globals.idParentTypes = ?', $this->core->sysConfig->parent_types->folder);

    return $this->objGlobalTable->fetchAll($objSelect);
  }

  /**
   * getModelFolders
   * @return Model_Folders
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelFolders(){
    if (null === $this->objModelFolders) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/Folders.php';
      $this->objModelFolders = new Model_Folders();
      $this->objModelFolders->setLanguageId($this->intLanguageId);
    }

    return $this->objModelFolders;
  }

  /**
   * getGlobalTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getGlobalTable(){

    if($this->objGlobalTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'global/models/tables/Globals.php';
      $this->objGlobalTable = new Model_Table_Globals();
    }

    return $this->objGlobalTable;
  }

  /**
   * getGlobalPropertyTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getGlobalPropertyTable(){

    if($this->objGlobalPropertyTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'global/models/tables/GlobalProperties.php';
      $this->objGlobalPropertyTable = new Model_Table_GlobalProperties();
    }

    return $this->objGlobalPropertyTable;
  }

  /**
   * getGlobalUrlTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getGlobalUrlTable(){

    if($this->objGlobalUrlTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/Urls.php';
      $this->objGlobalUrlTable = new Model_Table_Urls();
    }

    return $this->objGlobalUrlTable;
  }

  /**
   * getGlobalLinkTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getGlobalLinkTable(){

    if($this->objGlobalLinkTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'global/models/tables/GlobalLinks.php';
      $this->objGlobalLinkTable = new Model_Table_GlobalLinks();
    }

    return $this->objGlobalLinkTable;
  }

  /**
   * getGlobalInternalLinkTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getGlobalInternalLinkTable(){

    if($this->objGlobalInternalLinkTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'global/models/tables/GlobalInternalLinks.php';
      $this->objGlobalInternalLinkTable = new Model_Table_GlobalInternalLinks();
    }

    return $this->objGlobalInternalLinkTable;
  }

  /**
   * getGlobalVideoTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getGlobalVideoTable(){

    if($this->objGlobalVideoTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'global/models/tables/GlobalVideos.php';
      $this->objGlobalVideoTable = new Model_Table_GlobalVideos();
    }

    return $this->objGlobalVideoTable;
  }

  /**
   * Returns a table for a plugin
   * @param string $type The type of the plugin
   * @return Zend_Db_Table_Abstract
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function getPluginTable($type) {
    require_once(GLOBAL_ROOT_PATH.'application/plugins/'.$type.'/data/models/Global'.$type.'.php');
    $strClass = 'Model_Table_Global'.$type;
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