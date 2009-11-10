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
   * add
   * @param GenericSetup $objGenericSetup
   * @return object Product
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function add(GenericSetup &$objGenericSetup){
    $this->core->logger->debug('products->models->Model_Products->add()');

    $objPrduct = new stdClass();
    $objPrduct->productId = uniqid();
    $objPrduct->version = 1;
    $objPrduct->sortPosition = GenericSetup::DEFAULT_SORT_POSITION;
    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    /**
     * insert main data
     */
    $arrMainData = array('idParent'         => $this->core->sysConfig->product->rootLevels->list->id,
                         'idParentTypes'    => $this->core->sysConfig->parent_types->rootlevel,
                         'isStartProduct'   => $objGenericSetup->getIsStartElement(),
                         'idUsers'          => $intUserId,
                         'sortPosition'     => $objPrduct->sortPosition,
                         'sortTimestamp'    => date('Y-m-d H:i:s'),
                         'productId'        => $objPrduct->productId,
                         'version'          => $objPrduct->version,
                         'creator'          => $objGenericSetup->getCreatorId(),
                         'created'          => date('Y-m-d H:i:s'));
    $objPrduct->id = $this->getProductTable()->insert($arrMainData);

    /**
     * insert language specific properties
     */
    $arrProperties = array('productId'        => $objPrduct->productId,
                           'version'          => $objPrduct->version,
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

      $objPrduct->linkProductId = uniqid();

      /**
       * check if parent element is rootlevel or folder and get sort position
       */
      if($objGenericSetup->getParentId() != '' && $objGenericSetup->getParentId() > 0){
        $objGenericSetup->setParentTypeId($this->core->sysConfig->parent_types->folder);
        $objNaviData = $this->getModelFolders()->loadProductChildNavigation($objGenericSetup->getParentId());
      }else{
        if($objGenericSetup->getRootLevelId() != '' && $objGenericSetup->getRootLevelId() > 0){
          $objGenericSetup->setParentId($objGenericSetup->getRootLevelId());
        }else{
          $this->core->logger->err('zoolu->modules->products->models->Model_Products->add(): intRootLevelId is empty!');
        }
        $objGenericSetup->setParentTypeId($this->core->sysConfig->parent_types->rootlevel);
        $objNaviData = $this->getModelFolders()->loadProductRootNavigation($objGenericSetup->getRootLevelId());
      }
      $objPrduct->sortPosition = count($objNaviData);

      /**
       * insert main data
       */
      $arrMainData = array('idParent'         => $objGenericSetup->getParentId(),
                           'idParentTypes'    => $objGenericSetup->getParentTypeId(),
                           'isStartProduct'   => $objGenericSetup->getIsStartElement(),
                           'idUsers'          => $intUserId,
                           'sortPosition'     => $objPrduct->sortPosition,
                           'sortTimestamp'    => date('Y-m-d H:i:s'),
                           'productId'        => $objPrduct->linkProductId,
                           'version'          => $objPrduct->version,
                           'creator'          => $objGenericSetup->getCreatorId(),
                           'created'          => date('Y-m-d H:i:s'));
      $objPrduct->linkId = $this->getProductTable()->insert($arrMainData);

      $arrLinkedProduct = array('idProducts'  => $objPrduct->linkId,
                                'productId'   => $objPrduct->productId);
      $this->getProductLinkTable()->insert($arrLinkedProduct);
    }

    return $objPrduct;
  }

  /**
   * update
   * @param GenericSetup $objGenericSetup
   * @param object Product
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function update(GenericSetup &$objGenericSetup, $objPrduct){
    $this->core->logger->debug('products->models->Model_Products->update()');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $strWhere = $this->getProductTable()->getAdapter()->quoteInto('productId = ?', $objPrduct->productId);
    $strWhere .= $this->getProductTable()->getAdapter()->quoteInto(' AND version = ?', $objPrduct->version);

    $this->getProductTable()->update(array('idUsers'          => $intUserId,
                                           'changed'          => date('Y-m-d H:i:s')), $strWhere);
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
      $arrProperties = array('productId'        => $objPrduct->productId,
                             'version'          => $objPrduct->version,
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