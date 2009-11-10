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
 * Products_NavigationController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-28: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Products_NavigationController extends AuthControllerAction {

	private $intRootLevelId;
  private $intFolderId;

	private $intParentId;
	private $intParentTypeId;

	private $intLanguageId;

  /**
   * @var Model_Folders
   */
  protected $objModelFolders;

  /**
   * init
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   * @return void
   */
  public function init(){
    parent::init();
    Security::get()->addFoldersToAcl($this->getModelFolders());
  }

  /**
   * indexAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){
    $this->_helper->viewRenderer->setNoRender(true);
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
   * listAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function listAction(){

    $this->getModelFolders();
    $objRootLevels = $this->objModelFolders->loadAllRootLevels($this->core->sysConfig->modules->products);

    $this->view->assign('rootLevels', $objRootLevels);
    $this->view->assign('folderFormDefaultId', $this->core->sysConfig->form->ids->folders->default);
    $this->view->assign('productFormDefaultId', $this->core->sysConfig->product_types->product->default_formId);
    $this->view->assign('productTemplateDefaultId', $this->core->sysConfig->product_types->product->default_templateId);
    $this->view->assign('productTypeDefaultId', $this->core->sysConfig->product_types->product->id);
  }

  /**
   * rootnavigationAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function rootnavigationAction(){
    $this->core->logger->debug('products->controllers->NavigationController->rootnavigationAction()');

    $objRequest = $this->getRequest();
    $intCurrLevel = $objRequest->getParam("currLevel");
    $this->setRootLevelId($objRequest->getParam("rootLevelId"));

    /**
     * get navigation
     */
    $this->getModelFolders();
    $objRootelements = $this->objModelFolders->loadProductRootNavigation($this->intRootLevelId);

    $this->view->assign('rootelements', $objRootelements);
    $this->view->assign('currLevel', $intCurrLevel);

  }

  /**
   * childnavigationAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function childnavigationAction(){
    $this->core->logger->debug('products->controllers->NavigationController->childnavigationAction()');

    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
	    $objRequest = $this->getRequest();
	    $intCurrLevel = $objRequest->getParam("currLevel");
	    $this->setFolderId($objRequest->getParam("folderId"));

	    /**
	     * get childnavigation
	     */
	    $this->getModelFolders();
	    $objChildelements = $this->objModelFolders->loadProductChildNavigation($this->intFolderId);

	    $this->view->assign('childelements', $objChildelements);
	    $this->view->assign('currLevel', $intCurrLevel);
    }
  }

  /**
   * treeAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0

  public function treeAction(){
    $this->core->logger->debug('products->controllers->NavigationController->treeAction()');

    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
      $objRequest = $this->getRequest();

      /**
       * get navigation tree
       *
      $this->getModelFolders();
      $objNavigationTree = $this->objModelFolders();
    }
  }   */

  /**
   * updatepositionAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function updatepositionAction(){
    $this->core->logger->debug('products->controllers->NavigationController->updatepositionAction()');

    $this->getModelFolders();

    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
      $objRequest = $this->getRequest();
      $intElementId = $objRequest->getParam("id");
      $strElementType = $objRequest->getParam("elementType");
      $intSortPosition = $objRequest->getParam("sortPosition");
      $this->setRootLevelId($objRequest->getParam("rootLevelId"));
      $this->setParentId($objRequest->getParam("parentId"));

      $this->objModelFolders->updateSortPosition($intElementId, $strElementType, $intSortPosition, $this->intRootLevelId, $this->intParentId);
    }

    /**
     * no rendering
     */
    $this->_helper->viewRenderer->setNoRender();
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
      $this->objModelFolders->setLanguageId(1); // TODO : get language id
    }

    return $this->objModelFolders;
  }

  /**
   * setRootLevelId
   * @param integer $intRootLevelId
   */
  public function setRootLevelId($intRootLevelId){
    $this->intRootLevelId = $intRootLevelId;
  }

  /**
   * getRootLevelId
   * @param integer $intRootLevelId
   */
  public function getRootLevelId(){
    return $this->intRootLevelId;
  }

  /**
   * setFolderId
   * @param integer $intFolderId
   */
  public function setFolderId($intFolderId){
    $this->intFolderId = $intFolderId;
  }

  /**
   * getFolderId
   * @param integer $intFolderId
   */
  public function getFolderId(){
    return $this->intFolderId;
  }

  /**
   * setParentId
   * @param integer $intParentId
   */
  public function setParentId($intParentId){
    $this->intParentId = $intParentId;
  }

  /**
   * getParentId
   * @param integer $intParentId
   */
  public function getParentId(){
    return $this->intParentId;
  }

  /**
   * setParentTypeId
   * @param integer $intParentTypeId
   */
  public function setParentTypeId($intParentTypeId){
    $this->intParentTypeId = $intParentTypeId;
  }

  /**
   * getParentTypeId
   * @param integer $intParentTypeId
   */
  public function getParentTypeId(){
    return $this->intParentTypeId;
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
