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
 * OverlayController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-12-17: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Products_OverlayController extends AuthControllerAction {

	private $intRootLevelId;
  private $intFolderId;

	/**
   * @var Model_Folders
   */
  protected $objModelFolders;

	/**
   * indexAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){ }

  /**
   * producttreeAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function producttreeAction(){
    $this->core->logger->debug('products->controllers->OverlayController->producttreeAction()');

    $objRequest = $this->getRequest();
    $intPortalId = $objRequest->getParam('portalId');
    $strItemAction = $objRequest->getParam('itemAction', 'myOverlay.selectProduct');

    $strProductIds = $objRequest->getParam('itemIds');

    $strTmpProductIds = trim($strProductIds, '[]');
    $arrProductIds = split('\]\[', $strTmpProductIds);


    $this->loadProductTreeForPortal($intPortalId);
    $this->view->assign('overlaytitle', 'Produkt wählen');
    $this->view->assign('itemAction', $strItemAction);
    $this->view->assign('productIds', $arrProductIds);
  }


  /**
   * loadProductTreeForPortal
   * @param integer $intPortalId
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function loadProductTreeForPortal($intPortalId){
    $this->core->logger->debug('products->controllers->OverlayController->loadProductTreeForPortal('.$intPortalId.')');

    $this->getModelFolders();
    $objProductTree = $this->objModelFolders->loadProductRootLevelChilds($intPortalId);

    $this->view->assign('elements', $objProductTree);
    $this->view->assign('portalId', $intPortalId);
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

}

?>