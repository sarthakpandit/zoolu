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
 * @package    application.zoolu.modules.products.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_Products
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-11-02: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Products {

  private $intLanguageId;
  
  /**
   * @var Model_Folders
   */
  protected $objModelFolders;

  /**
   * @var Model_Table_Products
   */
  protected $objProductTable;

  /**
   * @var Model_Table_ProductProperties
   */
  protected $objProductPropertyTable;

  /**
   * @var Model_Table_Urls
   */
  protected $objProductUrlTable;

  /**
   * @var Model_Table_ProductLinks
   */
  protected $objProductLinkTable;

  /**
   * @var Model_Table_ProductInternalLinks
   */
  protected $objProductInternalLinkTable;

  /**
   * @var Model_Table_ProductVideosTable
   */
  protected $objProductVideoTable;

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
   * @return Zend_Db_Table_Rowset_Abstract Product
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function load($intElementId){
    $this->core->logger->debug('products->models->Model_Products->load('.$intElementId.')');

    $objSelect = $this->getProductTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('products', array('id', 'productId', 'relationId' => 'productId', 'version', 'isStartProduct', 'idParent', 'idParentTypes', 'productProperties.idProductTypes', 'productProperties.showInNavigation', 'productProperties.published', 'productProperties.changed', 'productProperties.idStatus', 'productProperties.creator'));
    $objSelect->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = productProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
    $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = productProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
    $objSelect->where('products.id = ?', $intElementId);
    
    return $this->getProductTable()->fetchAll($objSelect);
  }
  
  /**
   * loadByIdAndVersion
   * @param string $strProductId
   * @param integer $intVersion
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadByIdAndVersion($strProductId, $intVersion){
    $this->core->logger->debug('products->models->Model_Products->loadByIdAndVersion('.$strProductId.', '.$intVersion.')');

    $objSelect = $this->getProductTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('products', array('id', 'productId', 'relationId' => 'productId', 'version', 'isStartElement' => 'isStartProduct', 'idParent', 'idParentTypes', 'productProperties.idTemplates', 'productProperties.idProductTypes', 'productProperties.showInNavigation', 'productProperties.published', 'productProperties.changed', 'productProperties.created', 'productProperties.idStatus'));
    $objSelect->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = productProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
    $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = productProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
    $objSelect->joinLeft(array('ucr' => 'users'), 'ucr.id = productProperties.creator', array('creator' => 'CONCAT(ucr.fname, \' \', ucr.sname)'));
    $objSelect->join('genericForms', 'genericForms.id = productProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'));
    $objSelect->join('templates', 'templates.id = productProperties.idTemplates', array('filename'));
    $objSelect->where('products.productId = ?', $strProductId)
              ->where('products.version = ?', $intVersion);
    
    return $this->getProductTable()->fetchAll($objSelect);   
  }
  
  /**
   * loadByParentId
   * @param integer $intParentId
   * @param boolean $blnOnlyStartProduct
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadByParentId($intParentId, $blnOnlyStartProduct = false){
    $this->core->logger->debug('products->models->Model_Products->loadByParentId('.$intParentId.', '.$blnOnlyStartProduct.')');
    
    $objSelect = $this->getProductTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('products', array('id', 'productId', 'relationId' => 'productId', 'linkId' => 'lP.id','version', 'isStartElement' => 'isStartProduct', 'idParent', 'idParentTypes', 'productProperties.idTemplates', 'productProperties.idProductTypes', 'productProperties.showInNavigation', 'productProperties.published', 'productProperties.changed', 'productProperties.created', 'productProperties.idStatus'));
    $objSelect->join('productLinks', 'productLinks.productId = products.productId', array());
    $objSelect->join(array('lP' => 'products'), 'lP.id = productLinks.idProducts', array());              
    $objSelect->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = productProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
    $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = productProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
    $objSelect->joinLeft(array('ucr' => 'users'), 'ucr.id = productProperties.creator', array('creator' => 'CONCAT(ucr.fname, \' \', ucr.sname)'));
    $objSelect->join('genericForms', 'genericForms.id = productProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'));
    $objSelect->join('templates', 'templates.id = productProperties.idTemplates', array('filename'));
    $objSelect->where('lP.idParent = ?', $intParentId)
              ->where('lP.idParentTypes = ?', $this->core->sysConfig->parent_types->folder);
    
    if($blnOnlyStartProduct == true){
      $objSelect->where('lP.isStartProduct = 1');
    }
        
    return $this->getProductTable()->fetchAll($objSelect);   
  }

  /**
   * loadItems
   * @param integer $intParentId
   * @param integer $intCategoryId
   * @param integer $intLabelId
   * @param integer $intEntryNumber
   * @param integer $intSortTypeId
   * @param integer $intSortOrderId
   * @param integer $intEntryDepthId
   * @param array $arrProductIds
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadItems($intParentId, $intCategoryId = 0, $intLabelId = 0, $intEntryNumber = 0, $intSortTypeId = 0, $intSortOrderId = 0, $intEntryDepthId = 0, $arrProductIds = array()){
    $this->core->logger->debug('cms->models->Model_Products->loadItems('.$intParentId.','.$intCategoryId.','.$intLabelId.','.$intEntryNumber.','.$intSortTypeId.','.$intSortOrderId.','.$intEntryDepthId.','.$arrProductIds.')');

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
    $objSelect1->from('products', array('id', 'productId', 'relationId' => 'productId', 'plId' => 'lP.id', 'isStartElement' => 'isStartProduct', 'idParent', 'idParentTypes', 'sortPosition' => 'folders.sortPosition', 'sortTimestamp' => 'folders.sortTimestamp', 'productProperties.idProductTypes', 'productProperties.published', 'productProperties.changed', 'productProperties.created', 'productProperties.idStatus'))
               ->join('productLinks', 'productLinks.productId = products.productId', array())
               ->join(array('lP' => 'products'), 'lP.id = productLinks.idProducts', array())
               ->join('folders', 'folders.id = lP.idParent AND lP.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array())
               ->join('folders AS parent', 'parent.id = '.$intParentId, array())        
               ->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array())
               ->join('genericForms', 'genericForms.id = productProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'))
               ->joinLeft(array('ub' => 'users'), 'ub.id = productProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'))
               ->joinLeft('productCategories', 'productCategories.productId = products.productId AND productCategories.version = products.version', array())
               ->joinLeft('productLabels', 'productLabels.productId = products.productId AND productLabels.version = products.version', array())
               ->joinLeft('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'))
               ->joinLeft('urls', 'urls.relationId = lP.productId AND urls.version = lP.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->product.' AND urls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND urls.idParent IS NULL AND urls.isMain = 1', array('url'))
               ->joinLeft('languages', 'languages.id = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('languageCode'))
               ->where('folders.lft BETWEEN parent.lft AND parent.rgt')
               ->where('folders.idRootLevels = parent.idRootLevels');
               
    switch($intEntryDepthId){
      case $this->core->sysConfig->filter->depth->all:
        $objSelect1->where('folders.depth > parent.depth');
        break;
      case $this->core->sysConfig->filter->depth->first:
      default:
        $objSelect1->where('lP.isStartProduct = 1')
                   ->where('folders.depth = (parent.depth + 1)');        
        break;
    }
    
    
    $objSelect2 = $this->core->dbh->select();
    $objSelect2->from('products', array('id', 'productId', 'relationId' => 'productId', 'plId' => 'lP.id', 'isStartElement' => 'isStartProduct', 'idParent', 'idParentTypes', 'sortPosition' => 'lP.sortPosition', 'sortTimestamp' => 'lP.sortTimestamp', 'productProperties.idProductTypes', 'productProperties.published', 'productProperties.changed', 'productProperties.created', 'productProperties.idStatus'))
               ->join('productLinks', 'productLinks.productId = products.productId', array())
               ->join(array('lP' => 'products'), 'lP.id = productLinks.idProducts', array())
               ->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array())
               ->join('genericForms', 'genericForms.id = productProperties.idGenericForms', array('genericFormId', 'version', 'idGenericFormTypes'))
               ->joinLeft(array('ub' => 'users'), 'ub.id = productProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'))
               ->joinLeft('productCategories', 'productCategories.productId = products.productId AND productCategories.version = products.version', array())
               ->joinLeft('productLabels', 'productLabels.productId = products.productId AND productLabels.version = products.version', array())
               ->joinLeft('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'))
               ->joinLeft('urls', 'urls.relationId = lP.productId AND urls.version = lP.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->product.' AND urls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND urls.idParent IS NULL AND urls.isMain = 1', array('url'))
               ->joinLeft('languages', 'languages.id = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('languageCode'))
               ->where('lP.idParent = ?', $intParentId)
               ->where('lP.isStartProduct = 0');
    
    

    if(count($arrProductIds) > 0){
      $objSelect1->where('products.id NOT IN ('.implode(',', $arrProductIds).')');
      $objSelect2->where('products.id NOT IN ('.implode(',', $arrProductIds).')');
    }

    if($intCategoryId > 0 && $intCategoryId != ''){
      $objSelect1->where('productCategories.category = ?', $intCategoryId);
      $objSelect2->where('productCategories.category = ?', $intCategoryId);
    }

    if($intLabelId > 0 && $intLabelId != ''){
      $objSelect1->where('productLabels.label = ?', $intLabelId);
      $objSelect2->where('productLabels.label = ?', $intLabelId);
    }
    
    if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
      $objSelect1->where('productProperties.idStatus = ?', $this->core->sysConfig->status->live)
                 ->where('productProperties.published <= ?', date('Y-m-d H:i:s'));
      $objSelect2->where('productProperties.idStatus = ?', $this->core->sysConfig->status->live)
                 ->where('productProperties.published <= ?', date('Y-m-d H:i:s'));
    }
                                        
    $objSelect = $this->getProductTable()->select()
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

    return $this->getProductTable()->fetchAll($objSelect);
  }
  
  /**
   * loadItemInstanceDataByIds
   * @param string $strGenForm
   * @param array $arrPageIds
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadItemInstanceDataByIds($strGenForm, $arrProductIds){
    $this->core->logger->debug('cms->models->Model_Products->loadItemInstanceDataByIds('.$strGenForm.', '.$arrProductIds.')');

    // FIXME : !!! CHANGE INSTANCE FIELDS DEFINTION
    // FIXME : !!! iFl.idFields IN (5,55) -> define
    if($strGenForm != '' && $strGenForm != '-' && strpos($strGenForm, $this->core->sysConfig->product_types->link->default_formId) === false){
      $strSqlInstanceFields = '';
      $strSqlInstanceFields = ' `product-'.$strGenForm.'-Instances`.shortdescription,
                                  `product-'.$strGenForm.'-Instances`.description,';
      
      $strSqlWhereProductIds = '';
      if(count($arrProductIds) > 0){
        $strSqlWhereProductIds = ' WHERE products.id IN ('.implode(',',$arrProductIds).')';
      }

      $sqlStmt = $this->core->dbh->query('SELECT products.id,
                                            '.$strSqlInstanceFields.'
                                            files.filename, fileTitles.title AS filetitle
                                          FROM products
                                          LEFT JOIN `product-'.$strGenForm.'-Instances` ON
                                            `product-'.$strGenForm.'-Instances`.productId = products.productId AND
                                            `product-'.$strGenForm.'-Instances`.version = products.version AND
                                            `product-'.$strGenForm.'-Instances`.idLanguages = ?
                                          LEFT JOIN `product-'.$strGenForm.'-InstanceFiles` AS iFiles ON
                                            iFiles.id = (SELECT iFl.id FROM `product-'.$strGenForm.'-InstanceFiles` AS iFl
                                                         WHERE iFl.productId = products.productId AND iFl.version = products.version AND iFl.idFields IN (5,55)
                                                         ORDER BY iFl.idFields DESC LIMIT 1)
                                          LEFT JOIN files ON
                                            files.id = iFiles.idFiles AND
                                            files.isImage = 1
                                          LEFT JOIN fileTitles ON
                                            fileTitles.idFiles = files.id AND
                                            fileTitles.idLanguages = ?
                                          '.$strSqlWhereProductIds, array($this->intLanguageId, $this->intLanguageId));

      return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
    }
  }
  
  /**
   * search
   * @param string $strSearchValue
   * @return Zend_Db_Table_Rowset_Abstract Product
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   *
   */
  public function search($strSearchValue){

    $objSelect = $this->getProductTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('products', array('id', 'productId', 'productId', 'version', 'isStartProduct', 'idParent', 'idParentTypes', 'productProperties.idProductTypes', 'productProperties.showInNavigation', 'productProperties.published', 'productProperties.changed', 'productProperties.idStatus', 'productProperties.creator'));
    $objSelect->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->joinLeft('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'));
    $objSelect->where('productTitles.title LIKE ?', '%'.$strSearchValue.'%')
              ->where('idParent = ?', $this->core->sysConfig->product->rootLevels->list->id)
              ->where('idParentTypes = ?', $this->core->sysConfig->parent_types->rootlevel)
              ->where('isStartProduct = 0')
              ->order('productTitles.title');

    return $this->getProductTable()->fetchAll($objSelect);
  }

  /**
   * add
   * @param GenericSetup $objGenericSetup
   * @return stdClass Product
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function add(GenericSetup &$objGenericSetup){
    $this->core->logger->debug('products->models->Model_Products->add()');

    $objProduct = new stdClass();
    $objProduct->productId = uniqid();
    $objProduct->version = 1;
    $objProduct->sortPosition = GenericSetup::DEFAULT_SORT_POSITION;
    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    /**
     * insert main data
     */
    $arrMainData = array('idParent'         => $this->core->sysConfig->product->rootLevels->list->id,
                         'idParentTypes'    => $this->core->sysConfig->parent_types->rootlevel,
                         'isStartProduct'   => $objGenericSetup->getIsStartElement(),
                         'idUsers'          => $intUserId,
                         'sortPosition'     => $objProduct->sortPosition,
                         'sortTimestamp'    => date('Y-m-d H:i:s'),
                         'productId'        => $objProduct->productId,
                         'version'          => $objProduct->version,
                         'creator'          => $objGenericSetup->getCreatorId(),
                         'created'          => date('Y-m-d H:i:s'));
    $objProduct->id = $this->getProductTable()->insert($arrMainData);

    /**
     * insert language specific properties
     */
    $arrProperties = array('productId'        => $objProduct->productId,
                           'version'          => $objProduct->version,
                           'idLanguages'      => $this->intLanguageId,
                           'idGenericForms'   => $objGenericSetup->getGenFormId(),
                           'idTemplates'      => $objGenericSetup->getTemplateId(),
                           'idProductTypes'   => $objGenericSetup->getElementTypeId(),
                           'showInNavigation' => $objGenericSetup->getShowInNavigation(),
                           'idUsers'          => $intUserId,
                           'creator'          => $objGenericSetup->getCreatorId(),
                           'publisher'        => $intUserId,
                           'created'          => date('Y-m-d H:i:s'),
                           'published'        => $objGenericSetup->getPublishDate(),
                           'idStatus'         => $objGenericSetup->getStatusId());
    $this->getProductPropertyTable()->insert($arrProperties);

    /**
     * if is tree add, make alis now
     */
    if($objGenericSetup->getRootLevelId() == $this->core->sysConfig->product->rootLevels->tree->id){
      $objProduct->parentId = $objGenericSetup->getParentId();
      $objProduct->rootLevelId = $objGenericSetup->getRootLevelId();
      $objProduct->isStartElement = $objGenericSetup->getIsStartElement();
      $this->addLink($objProduct);
    }

    return $objProduct;
  }

  /**
   * addLink
   * @param stdClass $objProduct
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addLink(&$objProduct){
    $this->core->logger->debug('products->models->Model_Products->addLink()');
    
    $objProduct->linkProductId = uniqid();
    $objProduct->linkVersion = 1;
    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    /**
     * check if parent element is rootlevel or folder and get sort position
     */
    if($objProduct->parentId != '' && $objProduct->parentId > 0){
      $objProduct->parentTypeId = $this->core->sysConfig->parent_types->folder;
      $objNaviData = $this->getModelFolders()->loadProductChildNavigation($objProduct->parentId);
    }else{
      if($objProduct->rootLevelId != '' && $objProduct->rootLevelId > 0){
        $objProduct->parentId = $objProduct->rootLevelId;
      }else{
        $this->core->logger->err('zoolu->modules->products->models->Model_Products->addLink(): intRootLevelId is empty!');
      }
      $objProduct->parentTypeId = $this->core->sysConfig->parent_types->rootlevel;
      $objNaviData = $this->getModelFolders()->loadProductRootNavigation($objProduct->rootLevelId);
    }
    $objProduct->sortPosition = count($objNaviData);

    /**
     * insert main data
     */
    $arrMainData = array('idParent'         => $objProduct->parentId,
                         'idParentTypes'    => $objProduct->parentTypeId,
                         'isStartProduct'   => $objProduct->isStartElement,
                         'idUsers'          => $intUserId,
                         'sortPosition'     => $objProduct->sortPosition,
                         'sortTimestamp'    => date('Y-m-d H:i:s'),
                         'productId'        => $objProduct->linkProductId,
                         'version'          => $objProduct->linkVersion,
                         'creator'          => $intUserId,
                         'created'          => date('Y-m-d H:i:s'));
    $objProduct->linkId = $this->getProductTable()->insert($arrMainData);

    $arrLinkedProduct = array('idProducts'  => $objProduct->linkId,
                              'productId'   => $objProduct->productId);
    $this->getProductLinkTable()->insert($arrLinkedProduct);
  }

  /**
   * update
   * @param GenericSetup $objGenericSetup
   * @param object Product
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function update(GenericSetup &$objGenericSetup, $objProduct){
    $this->core->logger->debug('products->models->Model_Products->update()');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $strWhere = $this->getProductTable()->getAdapter()->quoteInto('productId = ?', $objProduct->productId);
    $strWhere .= $this->getProductTable()->getAdapter()->quoteInto(' AND version = ?', $objProduct->version);

    $this->getProductTable()->update(array('idUsers'  => $intUserId,
                                           'changed'  => date('Y-m-d H:i:s')), $strWhere);
    /**
     * update language specific product properties
     */
    $strWhere .= $this->getProductTable()->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);
    $intNumOfEffectedRows = $this->getProductPropertyTable()->update(array('idGenericForms'   => $objGenericSetup->getGenFormId(),
                                                                           'idTemplates'      => $objGenericSetup->getTemplateId(),
                                                                           'idProductTypes'   => $objGenericSetup->getElementTypeId(),
                                                                           'showInNavigation' => $objGenericSetup->getShowInNavigation(),
                                                                           'idUsers'          => $intUserId,
                                                                           'creator'          => $objGenericSetup->getCreatorId(),
                                                                           'idStatus'         => $objGenericSetup->getStatusId(),
                                                                           'published'        => $objGenericSetup->getPublishDate(),
                                                                           'changed'          => date('Y-m-d H:i:s')), $strWhere);
    
    /**
     * insert language specific product properties
     */
    if($intNumOfEffectedRows == 0){      
      $arrProperties = array('productId'        => $objProduct->productId,
                             'version'          => $objProduct->version,
                             'idLanguages'      => $this->intLanguageId,
                             'idGenericForms'   => $objGenericSetup->getGenFormId(),
                             'idTemplates'      => $objGenericSetup->getTemplateId(),
                             'idProductTypes'   => $objGenericSetup->getElementTypeId(),
                             'showInNavigation' => $objGenericSetup->getShowInNavigation(),
                             'idUsers'          => $intUserId,
                             'creator'          => $objGenericSetup->getCreatorId(),
                             'publisher'        => $intUserId,
                             'created'          => date('Y-m-d H:i:s'),
                             'published'        => $objGenericSetup->getPublishDate(),
                             'idStatus'         => $objGenericSetup->getStatusId());
      $this->getProductPropertyTable()->insert($arrProperties);
    }

  }

  /**
   * updateFolderStartProduct
   * @param integer $intFolderId
   * @param array $arrProperties
   * @param string $strTitle
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function updateFolderStartProduct($intFolderId, $arrProperties, $arrTitle){
    $objSelect = $this->getProductTable()->select();
    $objSelect->from('products', array('productId', 'version'));
    $objSelect->join('productLinks', 'productLinks.productId = products.productId', array());
    $objSelect->join(array('lP' => 'products'), 'lP.id = productLinks.idProducts', array());
    $objSelect->where('lP.idParent = ?', $intFolderId)
              ->where('lP.idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
              ->where('lP.isStartProduct = 1');
    $objSelect->order(array('lP.version DESC'));
    $objSelect->limit(1);
    
    $objStartProduct = $this->objProductTable->fetchAll($objSelect);

    if(count($objStartProduct) > 0){
      $objStartProduct = $objStartProduct->current();

      $strWhere = $this->getProductPropertyTable()->getAdapter()->quoteInto('productId = ?', $objStartProduct->productId);
      $strWhere .= $this->objProductPropertyTable->getAdapter()->quoteInto(' AND version = ?',  $objStartProduct->version);
      $strWhere .= $this->objProductPropertyTable->getAdapter()->quoteInto(' AND idLanguages = ?',  $this->intLanguageId);

      $this->objProductPropertyTable->update($arrProperties, $strWhere);

      $intNumOfEffectedRows = $this->core->dbh->update('productTitles', $arrTitle, $strWhere);

      if($intNumOfEffectedRows == 0){
        $arrTitle = array_merge($arrTitle, array('productId' => $objStartProduct->productId, 'version' => $objStartProduct->version, 'idLanguages' => $this->intLanguageId));
        $this->core->dbh->insert('productTitles', $arrTitle);
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
    $this->core->logger->debug('products->models->Model_Products->delete()');

    $objProduct = $this->load($intElementId);
    if(count($objProduct) == 1){
      $objProduct = $objProduct->current();

      if($objProduct->idParent == $this->core->sysConfig->product->rootLevels->list->id &&
         $objProduct->idParentTypes == $this->core->sysConfig->parent_types->rootlevel){
        //TODO:: delet all link products
      }

      $strWhere = $this->getProductTable()->getAdapter()->quoteInto('id = ?', $intElementId);
      return $this->objProductTable->delete($strWhere);
    }
  }
  
  /**
   * loadParentFolders
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadParentFolders($intElementId){
    $this->core->logger->debug('products->models->Model_Products->loadParentFolders('.$intElementId.')');

    $sqlStmt = $this->core->dbh->query('SELECT folders.id, folders.isUrlFolder, folderTitles.title
                                          FROM folders
                                            INNER JOIN folderTitles ON
                                              folderTitles.folderId = folders.folderId AND
                                              folderTitles.version = folders.version AND
                                              folderTitles.idLanguages = ?
                                          ,folders AS parent
                                            INNER JOIN products ON
                                              products.id = ? AND
                                              parent.id = products.idParent AND
                                              products.idParentTypes = ?
                                           WHERE folders.lft <= parent.lft AND
                                                 folders.rgt >= parent.rgt AND
                                                 folders.idRootLevels = parent.idRootLevels
                                             ORDER BY folders.rgt', array($this->intLanguageId, $intElementId, $this->core->sysConfig->parent_types->folder));
    return $sqlStmt->fetchAll(Zend_Db::FETCH_OBJ);
  }

  /**
   * addInternalLinks
   * @param string $strLinkedProductIds
   * @param string $strElementId
   * @param integer $intVersion
   * @return integer
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addInternalLinks($strLinkedProductIds, $strElementId, $intVersion){
    $this->core->logger->debug('cms->models->Model_Products->addInternalLinks('.$strLinkedProductIds.', '.$strElementId.', '.$intVersion.')');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $arrData = array('productId'   => $strElementId,
                     'version'     => $intVersion,
                     'idLanguages' => $this->intLanguageId,
                     'idUsers'     => $intUserId,
                     'creator'     => $intUserId,
                     'created'     => date('Y-m-d H:i:s'));

    $strTmpLinkedProductIds = trim($strLinkedProductIds, '[]');
    $arrLinkedProductIds = split('\]\[', $strTmpLinkedProductIds);

    if(count($arrLinkedProductIds) > 0){
      foreach($arrLinkedProductIds as $sortPosition => $strLinkedProductId){
        $arrData['linkedProductId'] = $strLinkedProductId;
        $arrData['sortPosition'] = $sortPosition + 1;
        $this->getProductInternalLinkTable()->insert($arrData);
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
    $this->core->logger->debug('cms->models->Model_Products->loadInternalLinks('.$strElementId.','.$intVersion.')');

    $objSelect = $this->getProductInternalLinkTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from('products', array('products.id', 'relationId' => 'products.productId', 'products.productId', 'products.version', 'productProperties.idProductTypes', 'isStartItem' => 'products.isStartProduct', 'products.isStartProduct', 'productProperties.idStatus'));
    $objSelect->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->join('productLinks', 'productLinks.productId = products.productId', array());
    $objSelect->join(array('lP' => 'products'), 'lP.id = productLinks.idProducts', array('lPId' => 'productId'));
    $objSelect->joinLeft('urls', 'urls.relationId = lP.productId AND urls.version = lP.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->product.' AND urls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND urls.isMain = 1 AND urls.idParent IS NULL', array('url'));
    $objSelect->joinLeft('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->join('productInternalLinks', 'productInternalLinks.linkedProductId = lP.productId AND productInternalLinks.productId = '.$this->core->dbh->quote($strElementId).' AND productInternalLinks.version = '.$this->core->dbh->quote($intVersion, Zend_Db::INT_TYPE).' AND productInternalLinks.idLanguages = '.$this->intLanguageId, array('sortPosition'));
    $objSelect->join('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'));
    $objSelect->where('products.id = (SELECT p.id FROM products AS p WHERE products.productId = p.productId ORDER BY p.version DESC LIMIT 1)');
    $objSelect->order('productInternalLinks.sortPosition ASC');

    return $this->objProductInternalLinkTable->fetchAll($objSelect);
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
    $this->core->logger->debug('cms->models->Model_Products->deleteInternalLinks('.$strElementId.','.$intVersion.')');

    $strWhere = $this->getProductInternalLinkTable()->getAdapter()->quoteInto('productId = ?', $strElementId);
    $strWhere .= $this->objProductInternalLinkTable->getAdapter()->quoteInto(' AND version = ?', $intVersion);
    $strWhere .= $this->objProductInternalLinkTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->intLanguageId);

    return $this->objProductInternalLinkTable->delete($strWhere);
  }

   /**
   * loadVideo
   * @param string $intElementId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadVideo($intElementId){
    $this->core->logger->debug('cms->products->models->Model_Products->loadVideo('.$intElementId.')');

    $objSelect = $this->getProductVideoTable()->select();
    $objSelect->from($this->objProductVideoTable, array('userId', 'videoId', 'idVideoTypes', 'thumb'));
    $objSelect->join('products', 'products.productId = productVideos.productId AND products.version = productVideos.version', array());
    $objSelect->where('products.id = ?', $intElementId)
              ->where('idLanguages = ?', $this->getLanguageId());

    return $this->objProductVideoTable->fetchAll($objSelect);
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
   $this->core->logger->debug('cms->products->models->Model_Products->addVideo('.$intElementId.','.$mixedVideoId.','.$intVideoTypeId.','.$strVideoUserId.','.$strVideoThumb.')');

    $objProductData = $this->load($intElementId);

    if(count($objProductData) > 0){
      $objProduct = $objProductData->current();

      $this->getProductVideoTable();

      $strWhere = $this->objProductVideoTable->getAdapter()->quoteInto('productId = ?', $objProduct->productId);
      $strWhere .= 'AND '.$this->objProductVideoTable->getAdapter()->quoteInto('version = ?', $objProduct->version);
      $this->objProductVideoTable->delete($strWhere);

      if($mixedVideoId != ''){
        $intUserId = Zend_Auth::getInstance()->getIdentity()->id;
        $arrData = array('productId'       => $objProduct->productId,
                         'version'      => $objProduct->version,
                         'idLanguages'  => $this->intLanguageId,
                         'userId'       => $strVideoUserId,
                         'videoId'      => $mixedVideoId,
                         'idVideoTypes' => $intVideoTypeId,
                         'thumb'        => $strVideoThumb,
                         'creator'      => $intUserId);
        return $objSelect = $this->objProductVideoTable->insert($arrData);
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
    $this->core->logger->debug('cms->products->models->Model_Products->removeVideo('.$intElementId.')');

    $objProductData = $this->load($intElementId);

    if(count($objProductData) > 0){
      $objProduct = $objProductData->current();

      $this->getProductVideoTable();

      $strWhere = $this->objProductVideoTable->getAdapter()->quoteInto('productId = ?', $objProduct->productId);
      $strWhere .= 'AND '.$this->objProductVideoTable->getAdapter()->quoteInto('version = ?', $objProduct->version);

      return $this->objProductVideoTable->delete($strWhere);
    }
  }

  /**
   * loadParentUrl
   * @param integer $intProductId
   * @param boolean $blnIsStartElement
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadParentUrl($intProductId, $blnIsStartElement){
    $this->core->logger->debug('cms->models->Model_Products->loadParentUrl('.$intProductId.','.$blnIsStartElement.')');

    $objSelect = $this->getProductUrlTable()->select();
    $objSelect->setIntegrityCheck(false);

    if($blnIsStartElement == true){
      $objSelect->from($this->objProductUrlTable, array('url','id'));
      $objSelect->join('products', 'products.productId = urls.relationId', array('productId','version','isStartproduct'));
      $objSelect->join('folders', 'folders.id = (SELECT idParent FROM products WHERE id = '.$intProductId.')', array());
      $objSelect->where('urls.version = products.version')
                ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->product)
                ->where('urls.idLanguages = ?', $this->intLanguageId)
                ->where('urls.isMain = 1')
                ->where('products.idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
                ->where('products.idParent = folders.idParentFolder')
                ->where('products.isStartProduct = 1');
    }else{
      $objSelect->from($this->objProductUrlTable, array('url','id'));
      $objSelect->join('products', 'products.productId = urls.relationId', array('productId','version','isStartproduct'));
      $objSelect->where('urls.version = products.version')
                ->where('urls.idUrlTypes = ?', $this->core->sysConfig->url_types->product)
                ->where('urls.idLanguages = ?', $this->intLanguageId)
                ->where('urls.isMain = 1')
                ->where('products.idParentTypes = ?', $this->core->sysConfig->parent_types->folder)
                ->where('products.idParent = (SELECT idParent FROM products WHERE id = '.$intProductId.')')
                ->where('products.isStartProduct = 1');
    }

    return $this->objProductUrlTable->fetchAll($objSelect);
  }

  /**
   * loadUrlHistory
   * @param str $strProductId
   * @param integer $intLanguageId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  public function loadUrlHistory($intProductId, $intLanguageId){
    $this->core->logger->debug('cms->models->Model_Products->loadProductUrlHistory('.$intProductId.', '.$intLanguageId.')');

    $objSelect = $this->getProductTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objProductTable, array('productId', 'relationId' => 'productId', 'version', 'isStartproduct'))
              ->join('urls', 'urls.relationId = products.productId AND urls.version = products.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->product.' AND urls.idLanguages = '.$intLanguageId.' AND urls.isMain = 0 AND urls.idParent IS NULL', array('id', 'url'))
              ->join('languages', 'languages.id = urls.idLanguages', array('languageCode'))
              ->where('products.id = ?', $intProductId);

    return $this->objProductTable->fetchAll($objSelect);
  }

  /**
   * getChildUrls
   * @param integer $intParentId
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getChildUrls($intParentId){

    $objSelect = $this->getProductTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objProductTable, array('id', 'productId', 'relationId' => 'productId', 'version'))
              ->join('urls', 'urls.relationId = products.productId AND urls.version = products.version AND urls.idUrlTypes = '.$this->core->sysConfig->url_types->product.' AND urls.idLanguages = '.$this->intLanguageId.' AND urls.isMain = 1', array('id', 'url'))
              ->join('folders AS parent', 'parent.id = '.$intParentId, array())
              ->join('folders', 'folders.lft BETWEEN parent.lft AND parent.rgt AND folders.idRootLevels = parent.idRootLevels', array())
              ->where('products.idParent = folders.id')
              ->where('products.idParentTypes = ?', $this->core->sysConfig->parent_types->folder);

    return $this->objProductTable->fetchAll($objSelect);
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
   * getProductTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductTable(){

    if($this->objProductTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'products/models/tables/Products.php';
      $this->objProductTable = new Model_Table_Products();
    }

    return $this->objProductTable;
  }

  /**
   * getProductPropertyTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductPropertyTable(){

    if($this->objProductPropertyTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'products/models/tables/ProductProperties.php';
      $this->objProductPropertyTable = new Model_Table_ProductProperties();
    }

    return $this->objProductPropertyTable;
  }

  /**
   * getProductUrlTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductUrlTable(){

    if($this->objProductUrlTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/Urls.php';
      $this->objProductUrlTable = new Model_Table_Urls();
    }

    return $this->objProductUrlTable;
  }

  /**
   * getProductLinkTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductLinkTable(){

    if($this->objProductLinkTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'products/models/tables/ProductLinks.php';
      $this->objProductLinkTable = new Model_Table_ProductLinks();
    }

    return $this->objProductLinkTable;
  }

  /**
   * getProductInternalLinkTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductInternalLinkTable(){

    if($this->objProductInternalLinkTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'products/models/tables/ProductInternalLinks.php';
      $this->objProductInternalLinkTable = new Model_Table_ProductInternalLinks();
    }

    return $this->objProductInternalLinkTable;
  }

  /**
   * getProductVideoTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductVideoTable(){

    if($this->objProductVideoTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'products/models/tables/ProductVideos.php';
      $this->objProductVideoTable = new Model_Table_ProductVideos();
    }

    return $this->objProductVideoTable;
  }

  /**
   * Returns a table for a plugin
   * @param string $type The type of the plugin
   * @return Zend_Db_Table_Abstract
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function getPluginTable($type) {
    require_once(GLOBAL_ROOT_PATH.'application/plugins/'.$type.'/data/models/Product'.$type.'.php');
    $strClass = 'Model_Table_Product'.$type;
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