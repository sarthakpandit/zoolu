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
 * @package    library.massiveart.generic.data.types
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * GenericDataTypeProduct
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-11-02: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package generic.data.type.interface.php
 * @subpackage GenericFormTypeProduct
 */

require_once(dirname(__FILE__).'/generic.data.type.abstract.class.php');

class GenericDataTypeProduct extends GenericDataTypeAbstract {

  /**
   * @var Model_Products
   */
  protected $objModelProducts;

  /**
   * @var Model_Folders
   */
  protected $objModelFolders;

  protected $blnHasLoadedFileData = false;
  protected $blnHasLoadedMultiFieldData = false;
  protected $blnHasLoadedInstanceData = false;

  /**
   * save
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function save(){
    $this->core->logger->debug('massiveart->generic->data->GenericDataTypeProduct->save()');
    try{

      $this->getModelProducts()->setLanguageId($this->setup->getLanguageId());

      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

      /**
       * add|edit|newVersion core and instance data
       */
      switch($this->setup->getActionType()){
        case $this->core->sysConfig->generic->actions->add :

          $objProduct = $this->objModelProducts->add($this->setup);

          $this->setup->setElementId($objProduct->id);

          $this->insertCoreData('product', $objProduct->productId, $objProduct->version);
          $this->insertFileData('product', array('Id' => $objProduct->productId, 'Version' => $objProduct->version));
          $this->insertMultiFieldData('product', array('Id' => $objProduct->productId, 'Version' => $objProduct->version));
          $this->insertInstanceData('product', array('Id' => $objProduct->productId, 'Version' => $objProduct->version));
          $this->insertMultiplyRegionData('product', $objProduct->productId, $objProduct->version);
          break;

        case $this->core->sysConfig->generic->actions->edit :

          $objProduct = $this->objModelProducts->load($this->setup->getElementId());
          $objProduct->linkId = $this->setup->getElementLinkId();
          
          if(count($objProduct) > 0){
            $objProduct = $objProduct->current();

            $this->objModelProducts->update($this->setup, $objProduct);

            $this->updateCoreData('product', $objProduct->productId, $objProduct->version);
            $this->updateFileData('product', array('Id' => $objProduct->productId, 'Version' => $objProduct->version));
            $this->updateMultiFieldData('product', $objProduct->productId, $objProduct->version);
            $this->updateInstanceData('product', $objProduct->productId, $objProduct->version);
            $this->updateMultiplyRegionData('product', $objProduct->productId, $objProduct->version);
          }

          break;

        case $this->core->sysConfig->generic->actions->change_template :

          break;

        case $this->core->sysConfig->generic->actions->change_template_id :

          break;
      }

      /**
       * now save all the special fields
       */
      if(count($this->setup->SpecialFields()) > 0){
        foreach($this->setup->SpecialFields() as $objField){
          $objField->setGenericSetup($this->setup);
          if($objField->type == GenericSetup::FIELD_TYPE_URL){
          	$objField->save($this->setup->getElementLinkId(), 'product', $objProduct->productId, $objProduct->version);
          }else{
            $objField->save($this->setup->getElementId(), 'product', $objProduct->productId, $objProduct->version);	
          }
        }
      }

      //product index
      /*
      if($this->setup->getElementTypeId() != $this->core->sysConfig->product_types->link->id && $this->setup->getStatusId() == $this->core->sysConfig->status->live){
        if(substr(PHP_OS, 0, 3) === 'WIN') {
          $this->core->logger->warning('slow product index on windows based OS!');
          $this->updateIndex(GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->product, $objProduct->productId);
        }else{
          $strIndexProductFilePath = GLOBAL_ROOT_PATH.'cli/IndexProduct.php';
          //run product index in background
          exec("php $strIndexProductFilePath --productId='".$objProduct->productId."' --version=".$objProduct->version." --languageId=".$this->setup->getLanguageId()." > /dev/null &#038;");
        }
      }else{
        $this->removeFromIndex(GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->product, $objProduct->productId);
      }*/

      //cache expiring
      /*
      if($this->Setup()->getField('url')){
        $strUrl = $this->Setup()->getField('url')->getValue();

        $arrFrontendOptions = array(
          'lifetime' => null, // cache lifetime (in seconds), if set to null, the cache is valid forever.
          'automatic_serialization' => true
        );

        $arrBackendOptions = array(
          'cache_dir' => GLOBAL_ROOT_PATH.'tmp/cache/products/' // Directory where to put the cache files
        );

        // getting a Zend_Cache_Core object
        $objCache = Zend_Cache::factory('Output',
                                        'File',
                                        $arrFrontendOptions,
                                        $arrBackendOptions);

        $strCacheId = 'product'.preg_replace('/[^a-zA-Z0-9_]/', '_', $strUrl);

        $objCache->remove($strCacheId);

        $objCache->clean(Zend_Cache::CLEANING_MODE_MATCHING_ANY_TAG, array('StartProduct', 'ProductType'.$this->core->sysConfig->product_types->overview->id));
      }*/
      return $this->setup->getElementId();
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * load
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function load(){
    $this->core->logger->debug('massiveart->generic->data->GenericDataTypeProduct->load()');
    try {

      $objProduct = $this->getModelProducts()->load($this->setup->getElementId());

      if(count($objProduct) > 0){
        $objProduct = $objProduct->current();

        /**
         * set some metainformations of current product to get them in the output
         */
        $this->setup->setMetaInformation($objProduct);
        $this->setup->setElementTypeId($objProduct->idProductTypes);
        $this->setup->setIsStartElement($objProduct->isStartProduct);
        $this->setup->setParentTypeId($objProduct->idParentTypes);

        parent::loadGenericData('product', array('Id' => $objProduct->productId, 'Version' => $objProduct->version));
        
        /**
		     * now laod all data from the special fields
		     */
		    if(count($this->setup->SpecialFields()) > 0){
		      foreach($this->setup->SpecialFields() as $objField){
		        $objField->setGenericSetup($this->setup);
		        if($objField->type == GenericSetup::FIELD_TYPE_URL){
		        	$objField->load($this->setup->getElementLinkId(), 'product', $objProduct->productId, $objProduct->version);
	          }else{
	            $objField->load($this->setup->getElementId(), 'product', $objProduct->productId, $objProduct->version); 
	          }		        
		      }
		    }

      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * getModelProducts
   * @return Model_Products
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelProducts(){
    if (null === $this->objModelProducts) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'products/models/Products.php';
      $this->objModelProducts = new Model_Products();
      $this->objModelProducts->setLanguageId($this->setup->getLanguageId());
    }

    return $this->objModelProducts;
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
      $this->objModelFolders->setLanguageId($this->setup->getLanguageId());
    }

    return $this->objModelFolders;
  }
}

?>