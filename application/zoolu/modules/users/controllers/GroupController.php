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
 * Users_GroupController
 *
 * Login, Logout, ...
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-03: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Users_GroupController extends AuthControllerAction {

  /**
   * @var Zend_Form
   */
  var $objForm;

  /**
   * @var Model_Users
   */
  protected $objModelUsers;

  /**
   * @var Zend_Db_Table_Row
   */
  protected $objGroup;

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
    $this->core->logger->debug('users->controllers->GroupController->listAction()');

    $strOrderColumn = $this->getRequest()->getParam('order', 'title');
    $strSortOrder = $this->getRequest()->getParam('sort', 'asc');

    $objSelect = $this->getModelUsers()->getGroupTable()->select();
    $objSelect->setIntegrityCheck(false);
    $objSelect->from($this->getModelUsers()->getGroupTable(), array('id', 'title'))
              ->joinInner('users', 'users.id = groups.idUsers', array('CONCAT(`users`.`fname`, \' \', `users`.`sname`) AS editor', 'changed'))
              ->order($strOrderColumn.' '.strtoupper($strSortOrder));

    $objAdapter = new Zend_Paginator_Adapter_DbTableSelect($objSelect);
    $objGroupsPaginator = new Zend_Paginator($objAdapter);
    $objGroupsPaginator->setItemCountPerPage((int) $this->getRequest()->getParam('itemsPerPage', 20));
    $objGroupsPaginator->setCurrentPageNumber($this->getRequest()->getParam('page'));
    $objGroupsPaginator->setView($this->view);

    $this->view->assign('groupPaginator', $objGroupsPaginator);
    $this->view->assign('orderColumn', $strOrderColumn);
    $this->view->assign('sortOrder', $strSortOrder);
  }

  /**
   * addformAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addformAction(){
    $this->core->logger->debug('users->controllers->GroupController->addformAction()');

    try{

      $this->initForm();
      $this->objForm->setAction('/zoolu/users/group/add');

      $this->view->form = $this->objForm;
      $this->view->formTitle = $this->core->translate->_('New_Group');

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
    $this->core->logger->debug('users->controllers->GroupController->addformAction()');

    try{

      $this->initForm();

      if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
        $arrFormData = $this->getRequest()->getPost();
        if($this->objForm->isValid($arrFormData)){
          /**
           * set action
           */
          $this->objForm->setAction('/zoolu/users/group/edit');

          $arrFormData['idLanguages'] = $arrFormData['language'];
          unset($arrFormData['language']);
          unset($arrFormData['passwordConfirmation']);
          $this->getModelUsers()->addGroup($arrFormData);

          $this->view->assign('blnShowFormAlert', true);
        }else{
          /**
           * set action
           */
          $this->objForm->setAction('/zoolu/users/group/add');
          $this->view->assign('blnShowFormAlert', false);
        }
      }

      $this->view->form = $this->objForm;
      $this->view->formTitle = $this->core->translate->_('New_Group');

      $this->renderScript('form.phtml');
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * editformAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function editformAction(){
    $this->core->logger->debug('users->controllers->GroupController->editformAction()');

    try{

      $this->initForm();
      $this->objForm->setAction('/zoolu/users/group/edit');

      $this->objGroup = $this->getModelUsers()->getGroupTable()->find($this->getRequest()->getParam('id'))->current();

      foreach($this->objForm->getElements() as $objElement){
        $name = $objElement->getName();
        if(isset($this->objGroup->$name)){
          $objElement->setValue($this->objGroup->$name);
        }
      }

      $this->view->form = $this->objForm;
      $this->view->formTitle = $this->core->translate->_('Edit_Group');

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
    $this->objForm->addElement('hidden', 'id', array('decorators' => array('Hidden')));

    $this->objForm->addElement('text', 'title', array('label' => $this->core->translate->_('title', false), 'decorators' => array('Input'), 'columns' => 12, 'class' => 'text keyfield', 'required' => true));

    $this->objForm->addElement('textarea', 'description', array('label' => $this->core->translate->_('description', false), 'decorators' => array('Input'), 'columns' => 12, 'class' => 'text'));

    $this->objForm->addDisplayGroup(array('title', 'description'), 'main-group', array('columns' => 9));
    $this->objForm->getDisplayGroup('main-group')->setLegend('Allgemeine Informationen');
    $this->objForm->getDisplayGroup('main-group')->setDecorators(array('FormElements', 'Region'));

    $arrPermissionOptions = array();
    $sqlStmt = $this->core->dbh->query("SELECT `id`, UCASE(`title`) AS title FROM `permissions`")->fetchAll();
    foreach($sqlStmt as $arrSql){
      $arrPermissionOptions[$arrSql['id']] = $arrSql['title'];
    }
    $this->objForm->addElement('multiCheckbox', 'permissions', array('label' => $this->core->translate->_('permissions', false), 'decorators' => array('Input'), 'columns' => 12, 'class' => 'multiCheckbox', 'MultiOptions' => $arrPermissionOptions));

     $arrLanguageOptions = array();
    $arrLanguageOptions[''] = 'Bitte wählen';
    $arrLanguageOptions['all'] = 'Alle Sprachen';
    $sqlStmt = $this->core->dbh->query("SELECT `id`, `title` FROM `languages`")->fetchAll();
    foreach($sqlStmt as $arrSql){
      $arrLanguageOptions[$arrSql['id']] = $arrSql['title'];
    }
    $this->objForm->addElement('select', 'language', array('label' => $this->core->translate->_('language', false), 'decorators' => array('Input'), 'columns' => 12, 'class' => 'select', 'MultiOptions' => $arrLanguageOptions));

    $this->objForm->addDisplayGroup(array('permissions', 'language'), 'permission-group', array('columns' => 3));
    $this->objForm->getDisplayGroup('permission-group')->setLegend('Gruppen-Rechte');
    $this->objForm->getDisplayGroup('permission-group')->setDecorators(array('FormElements', 'Region'));

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