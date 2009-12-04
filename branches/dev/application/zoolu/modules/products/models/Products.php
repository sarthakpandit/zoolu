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
   * @var Model_Table_Products
   */
  protected $objProductTable;

  /**
   * @var Model_Table_ProductProperties
   */
  protected $objProductPropertyTable;

  /**
   * @var Model_Table_ProductLinks
   */
  protected $objProductLinkTable;

  /**
   * @var Model_Table_ProductUrls
   */
  protected $objProductUrlTable;

  /**
   * @var Model_Folders
   */
  protected $objModelFolders;

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

    $objSelect->from('products', array('id', 'productId', 'version', 'isStartProduct', 'idParent', 'idParentTypes', 'productProperties.idProductTypes', 'productProperties.showInNavigation', 'productProperties.published', 'productProperties.changed', 'productProperties.idStatus', 'productProperties.creator'));
    $objSelect->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->joinLeft(array('ub' => 'users'), 'ub.id = productProperties.publisher', array('publisher' => 'CONCAT(ub.fname, \' \', ub.sname)'));
    $objSelect->joinLeft(array('uc' => 'users'), 'uc.id = productProperties.idUsers', array('changeUser' => 'CONCAT(uc.fname, \' \', uc.sname)'));
    $objSelect->where('products.id = ?', $intElementId);
    
    return $this->getProductTable()->fetchAll($objSelect);
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

    $objSelect->from('products', array('id', 'productId', 'version', 'isStartProduct', 'idParent', 'idParentTypes', 'productProperties.idProductTypes', 'productProperties.showInNavigation', 'productProperties.published', 'productProperties.changed', 'productProperties.idStatus', 'productProperties.creator'));
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
    $this->core->logger->debug('products->models->Model_Products->add()');
    
    $objProduct->linkProductId = uniqid();
    $objProduct->version = 1;
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
                         'version'          => $objProduct->version,
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

    $objSelect->from('products', array('products.id', 'products.productId', 'products.version', 'productProperties.idProductTypes', 'products.isStartProduct', 'productProperties.idStatus'));
    $objSelect->joinLeft('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array());
    $objSelect->join('productInternalLinks', 'productInternalLinks.linkedProductId = products.productId AND productInternalLinks.productId = '.$this->core->dbh->quote($strElementId).' AND productInternalLinks.version = '.$this->core->dbh->quote($intVersion, Zend_Db::INT_TYPE).' AND productInternalLinks.idLanguages = '.$this->intLanguageId, array('sortPosition'));
    $objSelect->join('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productTitles.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE), array('title'));
    $objSelect->joinLeft('productUrls', 'productUrls.productId = products.productId AND productUrls.version = products.version AND productUrls.idLanguages = '.$this->core->dbh->quote($this->intLanguageId, Zend_Db::INT_TYPE).' AND productUrls.idParent IS NULL', array('url'));
    $objSelect->joinLeft('languages', 'languages.id = productUrls.idLanguages', array('languageCode'));
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
   * getProductUrlTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductUrlTable(){

    if($this->objProductUrlTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'products/models/tables/ProductUrls.php';
      $this->objProductUrlTable = new Model_Table_ProductUrls();
    }

    return $this->objProductUrlTable;
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