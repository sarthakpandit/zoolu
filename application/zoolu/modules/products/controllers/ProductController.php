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
 * @package    application.zoolu.modules.products.controllers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * ProductController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-30: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Products_ProductController extends AuthControllerAction {

  /**
   * @var GenericForm
   */
  var $objForm;

  /**
   * request object instance
   * @var Zend_Controller_Request_Abstract
   */
  protected $objRequest;

  /**
   * @var Model_Products
   */
  protected $objModelProducts;

  /**
   * @var Model_Folders
   */
  protected $objModelFolders;

  /**
   * @var Model_Files
   */
  protected $objModelFiles;

  /**
   * @var Model_Contacts
   */
  protected $objModelContacts;

  /**
   * @var Model_Templates
   */
  protected $objModelTemplates;

  /**
   * @var Model_GenericForms
   */
  protected $objModelGenericForm;

  /**
   * init
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   * @return void
   */
  public function init(){
    parent::init();
    $this->objRequest = $this->getRequest();
  }

  /**
   * The default action
   */
  public function indexAction(){ }

  /**
   * listAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function listAction(){
    $this->core->logger->debug('products->controllers->ProductController->listAction()');

    $strOrderColumn = (($this->getRequest()->getParam('order') != '') ? $this->getRequest()->getParam('order') : 'title');
    $strSortOrder = (($this->getRequest()->getParam('sort') != '') ? $this->getRequest()->getParam('sort') : 'asc');

    $objSelect = $this->getModelProducts()->getProductTable()->select();
    $objSelect->setIntegrityCheck(false);
    $objSelect->from($this->getModelProducts()->getProductTable(), array('id', 'productTitles.title'))
              ->joinInner('productProperties', 'productProperties.productId = products.productId AND productProperties.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote(Zend_Auth::getInstance()->getIdentity()->languageId, Zend_Db::INT_TYPE), array())
              ->joinInner('productTitles', 'productTitles.productId = products.productId AND productTitles.version = products.version AND productProperties.idLanguages = '.$this->core->dbh->quote(Zend_Auth::getInstance()->getIdentity()->languageId, Zend_Db::INT_TYPE), array())
              ->joinInner(array('editor' => 'users'), 'editor.id = productProperties.idUsers', array('editor' => 'CONCAT(`editor`.`fname`, \' \', `editor`.`sname`)', 'productProperties.changed'))
              ->where('idParent = ?', $this->core->sysConfig->product->rootLevels->list->id)
              ->where('idParentTypes = ?', $this->core->sysConfig->parent_types->rootlevel)
              ->where('isStartProduct = 0')
              ->where('productTitles.idLanguages = ?', Zend_Auth::getInstance()->getIdentity()->languageId)
              ->order($strOrderColumn.' '.strtoupper($strSortOrder));

    $objAdapter = new Zend_Paginator_Adapter_DbTableSelect($objSelect);
    $objProductsPaginator = new Zend_Paginator($objAdapter);
    $objProductsPaginator->setItemCountPerPage((int) $this->getRequest()->getParam('itemsPerPage', 20));
    $objProductsPaginator->setCurrentPageNumber($this->getRequest()->getParam('page'));
    $objProductsPaginator->setView($this->view);

    $this->view->assign('productPaginator', $objProductsPaginator);
    $this->view->assign('orderColumn', $strOrderColumn);
    $this->view->assign('sortOrder', $strSortOrder);

    $this->getModelFolders();
    $objRootLevels = $this->objModelFolders->loadAllRootLevels($this->core->sysConfig->modules->products);

    $this->view->assign('rootLevels', $objRootLevels);
    $this->view->assign('folderFormDefaultId', $this->core->sysConfig->form->ids->folders->default);
    $this->view->assign('productFormDefaultId', $this->core->sysConfig->product_types->product->default_formId);
    $this->view->assign('productTemplateDefaultId', $this->core->sysConfig->product_types->product->default_templateId);
    $this->view->assign('productTypeDefaultId', $this->core->sysConfig->product_types->product->id);
  }

  /**
   * treeAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function treeAction(){

  	$this->getModelFolders();
    $objRootLevels = $this->objModelFolders->loadAllRootLevels($this->core->sysConfig->modules->products);

    $this->view->assign('rootLevels', $objRootLevels);
    $this->view->assign('folderFormDefaultId', $this->core->sysConfig->form->ids->folders->default);
    $this->view->assign('productFormDefaultId', $this->core->sysConfig->product_types->product->default_formId);
    $this->view->assign('productTemplateDefaultId', $this->core->sysConfig->product_types->product->default_templateId);
    $this->view->assign('productTypeDefaultId', $this->core->sysConfig->product_types->product->id);
  }

  /**
   * getaddformAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getaddformAction(){
    $this->core->logger->debug('products->controllers->ProductController->getaddformAction()');

    try{
	    $this->getForm($this->core->sysConfig->generic->actions->add);
	    $this->addProductSpecificFormElements();

	    /**
	     * set action
	     */
	    $this->objForm->setAction('/zoolu/products/product/add');

	    /**
	     * prepare form (add fields and region to the Zend_Form)
	     */
	    $this->objForm->prepareForm();

	    /**
	     * get form title
	     */
	    $this->view->formtitle = $this->objForm->Setup()->getFormTitle();

	    /**
       * output of metainformation to hidden div
       */
      $this->setViewMetaInfos();

	    $this->view->form = $this->objForm;

	    $this->renderScript('product/form.phtml');
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * addAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addAction(){
    $this->core->logger->debug('products->controllers->ProductController->addAction()');

    try{
	    $this->getForm($this->core->sysConfig->generic->actions->add);
	    $this->addProductSpecificFormElements();

	    if($this->objRequest->isPost() && $this->objRequest->isXmlHttpRequest()) {

	      $arrFormData = $this->objRequest->getPost();
	      $this->objForm->Setup()->setFieldValues($arrFormData);

	      /**
	       * prepare form (add fields and region to the Zend_Form)
	       */
	      $this->objForm->prepareForm();

	      if($this->objForm->isValid($arrFormData)){
	        /**
	         * set action
	         */
	        $this->objForm->setAction('/zoolu/products/product/edit');

	        $intProductId = $this->objForm->saveFormData();
	        $this->objForm->Setup()->setElementId($intProductId);
	        $this->objForm->Setup()->setActionType($this->core->sysConfig->generic->actions->edit);
	        $this->objForm->getElement('id')->setValue($intProductId);

	        $this->view->assign('blnShowFormAlert', true);
	      }else{
	        /**
	         * set action
	         */
	        $this->objForm->setAction('/zoolu/products/product/add');
	        $this->view->assign('blnShowFormAlert', false);
	      }
	    }else{

	    	/**
	       * prepare form (add fields and region to the Zend_Form)
	       */
	      $this->objForm->prepareForm();
	    }

	    /**
       * update special field values
       */
      $this->objForm->updateSpecificFieldValues();

	    /**
	     * get form title
	     */
	    $this->view->formtitle = $this->objForm->Setup()->getFormTitle();

	     /**
       * output of metainformation to hidden div
       */
      $this->setViewMetaInfos();

      $this->view->form = $this->objForm;

	    $this->renderScript('product/form.phtml');
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * geteditformAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function geteditformAction(){
    $this->core->logger->debug('products->controllers->ProductController->geteditformAction()');

    try{
	    $this->getForm($this->core->sysConfig->generic->actions->edit);

	    /**
	     * load generic data
	     */
	    $this->objForm->loadFormData();
      $this->addProductSpecificFormElements();

	    /**
	     * set action
	     */
	    $this->objForm->setAction('/zoolu/products/product/edit');

	    /**
	     * prepare form (add fields and region to the Zend_Form)
	     */
	    $this->objForm->prepareForm();

	    /**
	     * get form title
	     */
	    $this->view->formtitle = $this->objForm->Setup()->getFormTitle();

	    /**
	     * output of metainformation to hidden div
	     */
	    $this->setViewMetaInfos();

	    $this->view->form = $this->objForm;

	    $this->renderScript('product/form.phtml');
	  }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * editAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function editAction(){
    $this->core->logger->debug('products->controllers->ProductController->editAction()');

    try{
	    $this->getForm($this->core->sysConfig->generic->actions->edit);
	    $this->addProductSpecificFormElements();

	    /**
	     * get form title
	     */
	    $this->view->formtitle = $this->objForm->Setup()->getFormTitle();

	    if($this->objRequest->isPost() && $this->objRequest->isXmlHttpRequest()) {

	      $arrFormData = $this->objRequest->getPost();
	      $this->objForm->Setup()->setFieldValues($arrFormData);

	      /**
	       * prepare form (add fields and region to the Zend_Form)
	       */
	      $this->objForm->prepareForm();


	      if($this->objForm->isValid($arrFormData)){
	      	$this->objForm->saveFormData();
	        $this->view->assign('blnShowFormAlert', true);
	      }else{
	      	$this->view->assign('blnShowFormAlert', false);
	      }
	    }else{
	    	/**
	       * prepare form (add fields and region to the Zend_Form)
	       */
	      $this->objForm->prepareForm();
	    }

	    /**
       * update special field values
       */
      $this->objForm->updateSpecificFieldValues();

	    /**
       * set action
       */
      $this->objForm->setAction('/zoolu/products/product/edit');


      /**
       * output of metainformation to hidden div
       */
      $this->setViewMetaInfos();

      $this->view->form = $this->objForm;

	    $this->renderScript('product/form.phtml');
	  }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * setViewMetaInfos
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function setViewMetaInfos(){
    if(is_object($this->objForm) && $this->objForm instanceof GenericForm){
      $this->view->version = $this->objForm->Setup()->getFormVersion();
      $this->view->publisher = $this->objForm->Setup()->getPublisherName();
      $this->view->showinnavigation = $this->objForm->Setup()->getShowInNavigation();
      $this->view->changeUser = $this->objForm->Setup()->getChangeUserName();
      $this->view->publishDate = $this->objForm->Setup()->getPublishDate('d. M. Y, H:i');
      $this->view->changeDate = $this->objForm->Setup()->getChangeDate('d. M. Y, H:i');
      $this->view->statusOptions = HtmlOutput::getOptionsOfSQL($this->core, 'SELECT id AS VALUE, (SELECT statusTitles.title AS DISPLAY FROM statusTitles WHERE statusTitles.idStatus = status.id AND statusTitles.idLanguages = '.$this->objForm->Setup()->getFormLanguageId().') AS DISPLAY FROM status', $this->objForm->Setup()->getStatusId());
      $this->view->creatorOptions = HtmlOutput::getOptionsOfSQL($this->core, 'SELECT id AS VALUE, CONCAT(fname, \' \', sname) AS DISPLAY FROM users', $this->objForm->Setup()->getCreatorId());

      if($this->objForm->Setup()->getIsStartElement(false) == true){
        $this->view->typeOptions = HtmlOutput::getOptionsOfSQL($this->core, 'SELECT id AS VALUE, (SELECT productTypeTitles.title AS DISPLAY FROM productTypeTitles WHERE productTypeTitles.idProductTypes = productTypes.id AND productTypeTitles.idLanguages = '.$this->objForm->Setup()->getFormLanguageId().') AS DISPLAY FROM productTypes WHERE startproduct = 1 ORDER BY DISPLAY', $this->objForm->Setup()->getElementTypeId());
      }else{
        $this->view->typeOptions = HtmlOutput::getOptionsOfSQL($this->core, 'SELECT id AS VALUE, (SELECT productTypeTitles.title AS DISPLAY FROM productTypeTitles WHERE productTypeTitles.idProductTypes = productTypes.id AND productTypeTitles.idLanguages = '.$this->objForm->Setup()->getFormLanguageId().') AS DISPLAY FROM productTypes WHERE product = 1 ORDER BY DISPLAY', $this->objForm->Setup()->getElementTypeId());
      }

      $this->view->arrPublishDate = DateTimeHelper::getDateTimeArray($this->objForm->Setup()->getPublishDate());
      $this->view->monthOptions = DateTimeHelper::getOptionsMonth(false, $this->objForm->Setup()->getPublishDate('n'));

      $this->view->blnIsStartProduct = $this->objForm->Setup()->getIsStartElement(false);

      if($this->objForm->Setup()->getField('url')) $this->view->producturl = $this->objForm->Setup()->getField('url')->getValue();

      if($this->objForm->Setup()->getElementTypeId() != $this->core->sysConfig->product_types->link->id) $this->view->languageOptions = HtmlOutput::getOptionsOfSQL($this->core, 'SELECT id AS VALUE, languageCode AS DISPLAY FROM languages', $this->objForm->Setup()->getLanguageId());
    }
  }

  /**
   * getfilesAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getfilesAction(){
    $this->core->logger->debug('products->controllers->ProductController->getfilesAction()');

    try{
	    $strFileIds = $this->objRequest->getParam('fileIds');
	    $strFieldName = $this->objRequest->getParam('fileFieldId');
	    $strViewType = $this->objRequest->getParam('viewtype');

	    /**
	     * get files
	     */
	    $this->getModelFiles();
	    $objFiles = $this->objModelFiles->loadFilesById($strFileIds);

	    $this->view->assign('objFiles', $objFiles);
	    $this->view->assign('fieldname', $strFieldName);
	    $this->view->assign('viewtype', $strViewType);
	  }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * getcontactsAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getcontactsAction(){
    $this->core->logger->debug('products->controllers->ProductController->getcontactsAction()');

    try{
      $strContactIds = $this->objRequest->getParam('contactIds');
      $strFieldName = $this->objRequest->getParam('fieldId');

      /**
       * get files
       */
      $this->getModelContacts();
      $objContacts = $this->objModelContacts->loadContactsById($strContactIds);

      $this->view->assign('elements', $objContacts);
      $this->view->assign('fieldname', $strFieldName);
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * deleteAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function deleteAction(){
    $this->core->logger->debug('products->controllers->ProductController->deleteAction()');

    try{
	    $this->getModelProducts();

	    if($this->objRequest->isPost() && $this->objRequest->isXmlHttpRequest()) {
		    if(intval($this->objRequest->getParam('linkId', -1)) > 0){
          $this->objModelProducts->delete($this->objRequest->getParam("linkId"));
        }else{
          $this->objModelProducts->delete($this->objRequest->getParam("id"));
        }

		    $this->view->blnShowFormAlert = true;
	    }

	    $this->renderScript('product/form.phtml');
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * dashboardAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function dashboardAction(){
    $this->core->logger->debug('products->controllers->ProductController->dashboardAction()');

    try{
      $this->getModelFolders();

      if($this->objRequest->isPost() && $this->objRequest->isXmlHttpRequest()) {
        $intRootLevelId = $this->objRequest->getParam('rootLevelId');
        $intLimitNumber = 10;

        $objProducts = $this->objModelFolders->loadLimitedRootLevelChilds($intRootLevelId, $intLimitNumber);

        $this->view->assign('objProducts', $objProducts);
        $this->view->assign('limit', $intLimitNumber);
      }

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * changetemplateAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function changetemplateAction(){
    $this->core->logger->debug('products->controllers->ProductController->changetemplateAction()');

    try{
      $objGenericData = new GenericData();

      $objGenericData->Setup()->setFormId($this->objRequest->getParam("formId"));
      $objGenericData->Setup()->setFormVersion($this->objRequest->getParam("formVersion"));
      $objGenericData->Setup()->setFormTypeId($this->objRequest->getParam("formTypeId"));
      $objGenericData->Setup()->setTemplateId($this->objRequest->getParam("templateId"));
      $objGenericData->Setup()->setElementId($this->objRequest->getParam("id"));
      $objGenericData->Setup()->setActionType($this->core->sysConfig->generic->actions->edit);
      $objGenericData->Setup()->setLanguageId($this->objRequest->getParam("languageId", $this->core->sysConfig->languages->default->id));
      $objGenericData->Setup()->setFormLanguageId(Zend_Auth::getInstance()->getIdentity()->languageId);
      $objGenericData->Setup()->setModelSubPath('products/models/');

      /**
       * change Template
       */
      $objGenericData->changeTemplate($this->objRequest->getParam("newTemplateId"));

      $this->objRequest->setParam("formId", $objGenericData->Setup()->getFormId());
      $this->objRequest->setParam("templateId", $objGenericData->Setup()->getTemplateId());
      $this->objRequest->setParam("formVersion", $objGenericData->Setup()->getFormVersion());

      $this->getForm($this->core->sysConfig->generic->actions->edit);

      /**
       * load generic data
       */
      $this->objForm->setGenericSetup($objGenericData->Setup());
      $this->addProductSpecificFormElements();

      /**
       * set action
       */
      $this->objForm->setAction('/zoolu/products/product/edit');

      /**
       * prepare form (add fields and region to the Zend_Form)
       */
      $this->objForm->prepareForm();

      /**
       * get form title
       */
      $this->view->formtitle = $this->objForm->Setup()->getFormTitle();

      /**
       * output of metainformation to hidden div
       */
      $this->setViewMetaInfos();

      $this->view->form = $this->objForm;

      $this->renderScript('product/form.phtml');

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * changelanguageAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function changelanguageAction(){
    $this->core->logger->debug('products->controllers->ProductController->changelanguageAction()');

    try{

      if(intval($this->objRequest->getParam('id')) > 0){
        $this->_forward('geteditform');
      }else{
        $this->_forward('getaddform');
      }
      
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * changetypeAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function changetypeAction(){
    $this->core->logger->debug('products->controllers->ProductController->changetypeAction()');

    try{

      if($this->objRequest->getParam('productTypeId') != '' && $this->objRequest->getParam('productTypeId') > 0){
      	switch($this->objRequest->getParam('productTypeId')){
        	case $this->core->sysConfig->product_types->product->id :
            $this->objRequest->setParam('formId', '');
            if($this->objRequest->getParam('isStartProduct') == 'true' && $this->objRequest->getParam('parentTypeId') == $this->core->sysConfig->parent_types->rootlevel){
              $this->objRequest->setParam('templateId', $this->core->sysConfig->product_types->product->portal_startproduct_templateId);
            }else if($this->objRequest->getParam('isStartProduct') == 'true'){
              $this->objRequest->setParam('templateId', $this->core->sysConfig->product_types->product->startproduct_templateId);
            }else{
              $this->objRequest->setParam('templateId', $this->core->sysConfig->product_types->product->default_templateId);
            }
            break;
          case $this->core->sysConfig->product_types->link->id :
            $this->objRequest->setParam('formId', $this->core->sysConfig->product_types->link->default_formId);
            break;
          case $this->core->sysConfig->product_types->overview->id :
            $this->objRequest->setParam('formId', '');
            $this->objRequest->setParam('templateId', $this->core->sysConfig->product_types->overview->default_templateId);
            break;          
        }
      }

      $this->getForm($this->core->sysConfig->generic->actions->edit);

      /**
       * load generic data
       */
      $this->objForm->loadFormData();

      /**
       * overwrite now the product type
       */
      $this->objForm->Setup()->setElementTypeId($this->objRequest->getParam('productTypeId'));
      $this->addProductSpecificFormElements();

      /**
       * set action
       */
      $this->objForm->setAction('/zoolu/products/product/edit');

      /**
       * prepare form (add fields and region to the Zend_Form)
       */
      $this->objForm->prepareForm();

      /**
       * get form title
       */
      $this->view->formtitle = $this->objForm->Setup()->getFormTitle();

      /**
       * output of metainformation to hidden div
       */
      $this->setViewMetaInfos();

      $this->view->form = $this->objForm;

      $this->renderScript('product/form.phtml');

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }
  
  /**
   * getoverlaysearchAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getoverlaysearchAction(){
    $this->core->logger->debug('products->controllers->ProductController->getoverlaysearchAction()');

    $this->view->currLevel = $this->objRequest->getParam('currLevel');
    $this->view->overlaytitle = $this->core->translate->_('Search_Product');
  }
  
  /**
   * overlaysearchAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function overlaysearchAction(){
    $this->core->logger->debug('products->controllers->ProductController->getoverlaysearchAction()');

    $strSearchValue = $this->objRequest->getParam('searchValue');

    if($strSearchValue != ''){
      $this->view->searchResult = $this->getModelProducts()->search($strSearchValue);      
    }

    $this->view->searchValue = $strSearchValue;
    $this->view->currLevel = $this->objRequest->getParam('currLevel');
  }

  /**
   * addproductlinkAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addproductlinkAction(){
    $this->_helper->viewRenderer->setNoRender(true);

    $objProduct = new stdClass();
    $objProduct->parentId = $this->objRequest->getParam('parentFolderId');
    $objProduct->rootLevelId = $this->objRequest->getParam('rootLevelId');
    $objProduct->isStartElement = $this->objRequest->getParam('isStartProduct');
    $objProduct->productId = $this->objRequest->getParam('linkId');

    $this->getModelProducts()->addLink($objProduct);
  }

  /**
   * getForm
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function getForm($intActionType = null){
    $this->core->logger->debug('products->controllers->ProductController->getForm('.$intActionType.')');

    try{

      $strFormId = $this->objRequest->getParam("formId");
      $intTemplateId = $this->objRequest->getParam("templateId");

      /**
       * if there is now formId, try to load form template
       */
      if($strFormId == ''){
        if($intTemplateId != ''){
          /**
           * get files
           */
          $this->getModelTemplates();
          $objTemplateData = $this->objModelTemplates->loadTemplateById($intTemplateId);

          if(count($objTemplateData) == 1){
            $objTemplate = $objTemplateData->current();

            /**
             * set form id from template
             */
            $strFormId = $objTemplate->genericFormId;
          }else{
            throw new Exception('Not able to create a form, because there is no form id!');
          }
        }else{
          throw new Exception('Not able to create a form, because there is no form id!');
        }
      }

      $intFormVersion = ($this->objRequest->getParam("formVersion") != '') ? $this->objRequest->getParam("formVersion") : null;
      $intElementId = ($this->objRequest->getParam("id") != '') ? $this->objRequest->getParam("id") : null;
      
      $objFormHandler = FormHandler::getInstance();
      $objFormHandler->setFormId($strFormId);
      $objFormHandler->setTemplateId($intTemplateId);
      $objFormHandler->setFormVersion($intFormVersion);
      $objFormHandler->setActionType($intActionType);
      $objFormHandler->setLanguageId($this->objRequest->getParam("languageId", $this->core->sysConfig->languages->default->id));
      $objFormHandler->setFormLanguageId(Zend_Auth::getInstance()->getIdentity()->languageId);
      $objFormHandler->setElementId($intElementId);

      $this->objForm = $objFormHandler->getGenericForm();

      /**
       * set product default & specific form values
       */
      $this->objForm->Setup()->setCreatorId((($this->objRequest->getParam("creator") != '') ? $this->objRequest->getParam("creator") : Zend_Auth::getInstance()->getIdentity()->id));
      $this->objForm->Setup()->setStatusId((($this->objRequest->getParam("idStatus") != '') ? $this->objRequest->getParam("idStatus") : $this->core->sysConfig->form->status->default));
      $this->objForm->Setup()->setRootLevelId((($this->objRequest->getParam("rootLevelId") != '') ? $this->objRequest->getParam("rootLevelId") : null));
      $this->objForm->Setup()->setParentId((($this->objRequest->getParam("parentFolderId") != '') ? $this->objRequest->getParam("parentFolderId") : null));
      $this->objForm->Setup()->setIsStartElement((($this->objRequest->getParam("isStartProduct") != '') ? $this->objRequest->getParam("isStartProduct") : 0));
      $this->objForm->Setup()->setPublishDate((($this->objRequest->getParam("publishDate") != '') ? $this->objRequest->getParam("publishDate") : date('Y-m-d H:i:s')));
      $this->objForm->Setup()->setShowInNavigation((($this->objRequest->getParam("showInNavigation") != '') ? $this->objRequest->getParam("showInNavigation") : 0));
      $this->objForm->Setup()->setElementTypeId((($this->objRequest->getParam("productTypeId") != '') ? $this->objRequest->getParam("productTypeId") : $this->core->sysConfig->product_types->product->id));
      $this->objForm->Setup()->setParentTypeId((($this->objRequest->getParam("parentTypeId") != '') ? $this->objRequest->getParam("parentTypeId") : (($this->objRequest->getParam("parentFolderId") != '') ? $this->core->sysConfig->parent_types->folder : $this->core->sysConfig->parent_types->rootlevel)));
      $this->objForm->Setup()->setModelSubPath('products/models/');
      $this->objForm->Setup()->setElementLinkId($this->objRequest->getParam("linkId", -1));

      /**
       * add currlevel hidden field
       */
      $this->objForm->addElement('hidden', 'currLevel', array('value' => $this->objRequest->getParam("currLevel"), 'decorators' => array('Hidden'), 'ignore' => true));

      /**
       * add elementTye hidden field (folder, product, ...)
       */
      $this->objForm->addElement('hidden', 'elementType', array('value' => $this->objRequest->getParam("elementType"), 'decorators' => array('Hidden'), 'ignore' => true));

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }

  /**
   * addProductSpecificFormElements
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function addProductSpecificFormElements(){
    if(is_object($this->objForm) && $this->objForm instanceof GenericForm){
      /**
       * add product specific hidden fields
       */
      $this->objForm->addElement('hidden', 'creator', array('value' => $this->objForm->Setup()->getCreatorId(), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'idStatus', array('value' => $this->objForm->Setup()->getStatusId(), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'rootLevelId', array('value' => $this->objForm->Setup()->getRootLevelId(), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'rootLevelTypeId', array('value' => $this->objForm->Setup()->getRootLevelTypeId(), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'parentFolderId', array('value' => $this->objForm->Setup()->getParentId(), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'productTypeId', array('value' => $this->objForm->Setup()->getElementTypeId(), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'isStartProduct', array('value' => $this->objForm->Setup()->getIsStartElement(), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'publishDate', array('value' => $this->objForm->Setup()->getPublishDate('Y-m-d H:i:s'), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'showInNavigation', array('value' => $this->objForm->Setup()->getShowInNavigation(), 'decorators' => array('Hidden')));
      $this->objForm->addElement('hidden', 'parentTypeId', array('value' => $this->objForm->Setup()->getParentTypeId(), 'decorators' => array('Hidden')));

      /**
       * product link Id form the tree view
       */
      $this->objForm->addElement('hidden', 'linkId', array('value' => $this->objForm->Setup()->getElementLinkId(), 'decorators' => array('Hidden')));
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
      $this->objModelProducts->setLanguageId($this->objRequest->getParam("languageId", $this->core->sysConfig->languages->default->id));
    }

    return $this->objModelProducts;
  }

  /**
   * getModelFolders
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
      $this->objModelFolders->setLanguageId($this->objRequest->getParam("languageId", $this->core->sysConfig->languages->default->id));
    }

    return $this->objModelFolders;
  }

  /**
   * getModelFiles
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelFiles(){
    if (null === $this->objModelFiles) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/Files.php';
      $this->objModelFiles = new Model_Files();
      $this->objModelFiles->setLanguageId($this->objRequest->getParam("languageId", $this->core->sysConfig->languages->default->id));
    }

    return $this->objModelFiles;
  }

  /**
   * getModelContacts
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelContacts(){
    if (null === $this->objModelContacts) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/Contacts.php';
      $this->objModelContacts = new Model_Contacts();
      $this->objModelContacts->setLanguageId($this->objRequest->getParam("languageId", $this->core->sysConfig->languages->default->id));
    }

    return $this->objModelContacts;
  }

  /**
   * getModelTemplates
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelTemplates(){
    if (null === $this->objModelTemplates) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/Templates.php';
      $this->objModelTemplates = new Model_Templates();
    }

    return $this->objModelTemplates;
  }

  /**
   * getModelGenericForm
   * @return Model_GenericForms
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelGenericForm(){
    if (null === $this->objModelGenericForm) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/GenericForms.php';
      $this->objModelGenericForm = new Model_GenericForms();
      $this->objModelGenericForm->setLanguageId($this->objRequest->getParam("languageId", $this->core->sysConfig->languages->default->id));
    }

    return $this->objModelGenericForm;
  }
}

?>
