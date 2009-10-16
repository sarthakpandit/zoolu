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
 * @package    application.zoolu.modules.users.controllers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Users_ResourceController
 *
 * Login, Logout, ...
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-03: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Users_ResourceController extends AuthControllerAction {

  /**
   * @var Zend_Form
   */
  var $objForm;

  /**
   * @var Model_Users
   */
  protected $objModelUsers;

  /**
   * indexAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){
    $this->_helper->viewRenderer->setNoRender();
  }

  /**
   * listAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function listAction(){
    $this->core->logger->debug('users->controllers->ResourceController->listAction()');

    $strOrderColumn = $this->getRequest()->getParam('order', 'title');
    $strSortOrder = $this->getRequest()->getParam('sort', 'asc');

    $objSelect = $this->getModelUsers()->getResourceTable()->select();
    $objSelect->setIntegrityCheck(false);
    $objSelect->from($this->getModelUsers()->getResourceTable(), array('id', 'title', 'key'))
              ->joinInner('users', 'users.id = resources.idUsers', array('CONCAT(`users`.`fname`, \' \', `users`.`sname`) AS editor', 'resources.changed'))
              ->order($strOrderColumn.' '.strtoupper($strSortOrder));

    $objAdapter = new Zend_Paginator_Adapter_DbTableSelect($objSelect);
    $objResourcesPaginator = new Zend_Paginator($objAdapter);
    $objResourcesPaginator->setItemCountPerPage((int) $this->getRequest()->getParam('itemsPerPage', 20));
    $objResourcesPaginator->setCurrentPageNumber($this->getRequest()->getParam('page'));
    $objResourcesPaginator->setView($this->view);

    $this->view->assign('resourcePaginator', $objResourcesPaginator);
    $this->view->assign('orderColumn', $strOrderColumn);
    $this->view->assign('sortOrder', $strSortOrder);
  }

  /**
   * addformAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addformAction(){
    $this->core->logger->debug('users->controllers->ResourceController->addformAction()');

    try{

      $this->initForm();
      $this->objForm->setAction('/zoolu/users/resource/add');

      $this->view->form = $this->objForm;
      $this->view->formTitle = $this->core->translate->_('New_Resource');

      $this->renderScript('form.phtml');
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * addAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addAction(){
    $this->core->logger->debug('users->controllers->ResourceController->addformAction()');

    try{

      $this->initForm();

      if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
        $arrFormData = $this->getRequest()->getPost();
        if($this->objForm->isValid($arrFormData)){
          /**
           * set action
           */
          $this->objForm->setAction('/zoolu/users/resource/edit');

          $arrFormData['idLanguages'] = $arrFormData['language'];
          unset($arrFormData['language']);
          unset($arrFormData['passwordConfirmation']);
          $this->getModelUsers()->addResource($arrFormData);

          $this->view->assign('blnShowFormAlert', true);
        }else{
          /**
           * set action
           */
          $this->objForm->setAction('/zoolu/users/resource/add');
          $this->view->assign('blnShowFormAlert', false);
        }
      }

      $this->view->form = $this->objForm;
      $this->view->formTitle = $this->core->translate->_('New_Resource');

      $this->renderScript('form.phtml');
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * initForm
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function initForm(){

    $this->objForm = new Zend_Form();

    /**
     * Use our own PluginLoader
     */
    $objLoader = new PluginLoader();
    $objLoader->setPluginLoader($this->objForm->getPluginLoader(PluginLoader::TYPE_FORM_ELEMENT));
    $objLoader->setPluginType(PluginLoader::TYPE_FORM_ELEMENT);
    $this->objForm->setPluginLoader($objLoader, PluginLoader::TYPE_FORM_ELEMENT);

    /**
     * clear all decorators
     */
    $this->objForm->clearDecorators();

    /**
     * add standard decorators
     */
    $this->objForm->addDecorator('TabContainer');
    $this->objForm->addDecorator('FormElements');
    $this->objForm->addDecorator('Form');

    /**
     * add form prefix path
     */
    $this->objForm->addPrefixPath('Form_Decorator', GLOBAL_ROOT_PATH.'library/massiveart/generic/forms/decorators/', 'decorator');

    /**
     * elements prefixes
     */
    $this->objForm->addElementPrefixPath('Form_Decorator', GLOBAL_ROOT_PATH.'library/massiveart/generic/forms/decorators/', 'decorator');

    /**
     * regions prefixes
     */
    $this->objForm->addDisplayGroupPrefixPath('Form_Decorator', GLOBAL_ROOT_PATH.'library/massiveart/generic/forms/decorators/');

    $this->objForm->setAttrib('id', 'genForm');
    $this->objForm->setAttrib('onsubmit', 'return false;');

    $this->objForm->addElement('text', 'title', array('label' => $this->core->translate->_('title', false), 'decorators' => array('Input'), 'columns' => 12, 'class' => 'text keyfield', 'required' => true));

    $this->objForm->addDisplayGroup(array('title'), 'main-resource');
    $this->objForm->getDisplayGroup('main-resource')->setLegend('Allgemeine Resourcepen Informationen');
    $this->objForm->getDisplayGroup('main-resource')->setDecorators(array('FormElements', 'Region'));
  }

  /**
   * getModelUsers
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  protected function getModelUsers(){
    if (null === $this->objModelUsers) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'users/models/Users.php';
      $this->objModelUsers = new Model_Users();
    }

    return $this->objModelUsers;
  }
}

?>