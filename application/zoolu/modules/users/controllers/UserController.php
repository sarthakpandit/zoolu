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
 * Core_UserController
 *
 * Login, Logout, ...
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-03: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Users_UserController extends Zend_Controller_Action {

  /**
   * @var Zend_Form
   */
  var $objForm;

  /**
   * @var Core
   */
  private $core;

  /**
   * @var Model_Users
   */
  protected $objModelUsers;

  /**
   * init
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function init(){
    $this->core = Zend_Registry::get('Core');
    $this->initView();
  }

  /**
   * preDispatch
   * Called before action method.
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function preDispatch(){
    /**
     * set default encoding to view
     */
    $this->view->setEncoding($this->core->sysConfig->encoding->default);

    /**
     * set translate obj
     */
    $this->view->translate = $this->core->translate;
  }

  /**
   * indexAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){

    $objAuth = Zend_Auth::getInstance();

    if(!$objAuth->hasIdentity()){
      $this->_redirect('/zoolu/users/user/login');
    } else {
      $this->_redirect('/zoolu/cms');
    }
  }

  /**
   * listAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function listAction(){
    $this->core->logger->debug('users->controllers->UserController->listAction()');

    $strOrderColumn = $this->getRequest()->getParam('order', 'sname');
    $strSortOrder = $this->getRequest()->getParam('sort', 'asc');

    $objSelect = $this->getModelUsers()->getUserTable()->select();
    $objSelect->from($this->getModelUsers()->getUserTable(), array('fname', 'sname'))
              ->joinInner('users AS editor', 'editor.id = users.idUsers', array('CONCAT(`editor`.`fname`, \' \', `editor`.`sname`) AS editor', 'changed'))
              ->order($strOrderColumn.' '.strtoupper($strSortOrder));

    $objAdapter = new Zend_Paginator_Adapter_DbTableSelect($objSelect);
    $objUsersPaginator = new Zend_Paginator($objAdapter);
    $objUsersPaginator->setItemCountPerPage((int) $this->getRequest()->getParam('itemsPerPage', 20));
    $objUsersPaginator->setCurrentPageNumber($this->getRequest()->getParam('page'));
    $objUsersPaginator->setView($this->view);

    $this->view->assign('userPaginator', $objUsersPaginator);
    $this->view->assign('orderColumn', $strOrderColumn);
    $this->view->assign('sortOrder', $strSortOrder);
  }

  /**
   * addformAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addformAction(){
    $this->core->logger->debug('users->controllers->UserController->addformAction()');

    try{

      $this->initForm();
      $this->objForm->setAction('/zoolu/users/user/add');

      $this->view->form = $this->objForm;
      $this->view->formTitle = $this->core->translate->_('New_User');

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
    $this->core->logger->debug('users->controllers->UserController->addformAction()');

    try{

      $this->initForm();

      if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
        $arrFormData = $this->getRequest()->getPost();
        if($this->objForm->isValid($arrFormData)){
          /**
           * set action
           */
          $this->objForm->setAction('/zoolu/users/user/edit');

          $arrFormData['idLanguages'] = $arrFormData['language'];
          unset($arrFormData['language']);
          unset($arrFormData['passwordConfirmation']);
          $this->getModelUsers()->addUser($arrFormData);

          $this->view->assign('blnShowFormAlert', true);
        }else{
          /**
           * set action
           */
          $this->objForm->setAction('/zoolu/users/user/add');
          $this->view->assign('blnShowFormAlert', false);
        }
      }

      $this->view->form = $this->objForm;
      $this->view->formTitle = $this->core->translate->_('New_User');

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

    $arrLanguageOptions = array();
    $arrLanguageOptions[''] = 'Bitte wählen';
    $sqlStmt = $this->core->dbh->query("SELECT `id`, `title` FROM `languages`")->fetchAll();
    foreach($sqlStmt as $arrSql){
      $arrLanguageOptions[$arrSql['id']] = $arrSql['title'];
    }

    $this->objForm->addElement('text', 'fname', array('label' => $this->core->translate->_('fname', false), 'decorators' => array('Input'), 'columns' => 6, 'class' => 'text keyfield', 'required' => true));
    $this->objForm->addElement('text', 'sname', array('label' => $this->core->translate->_('sname', false), 'decorators' => array('Input'), 'columns' => 6, 'class' => 'text keyfield', 'required' => true));
    $this->objForm->addElement('text', 'username', array('label' => $this->core->translate->_('username', false), 'decorators' => array('Input'), 'columns' => 6, 'class' => 'text keyfield', 'required' => true));
    $this->objForm->addElement('select', 'language', array('label' => $this->core->translate->_('language', false), 'decorators' => array('Input'), 'columns' => 6, 'class' => 'select keyfield', 'required' => true, 'MultiOptions' => $arrLanguageOptions));

    $this->objForm->addDisplayGroup(array('fname', 'sname', 'username', 'language'), 'main-group');
    $this->objForm->getDisplayGroup('main-group')->setLegend('Allgemeine Bentuzer Informationen');
    $this->objForm->getDisplayGroup('main-group')->setDecorators(array('FormElements', 'Region'));

    $this->objForm->addElement('password', 'password', array('label' => $this->core->translate->_('password', false), 'decorators' => array('Input'), 'columns' => 6, 'class' => 'password'));
    $this->objForm->addElement('password', 'passwordConfirmation', array('label' => $this->core->translate->_('Confirm_password', false), 'decorators' => array('Input'), 'columns' => 6, 'class' => 'password'));

    $this->objForm->addDisplayGroup(array('password', 'passwordConfirmation'), 'password-group');
    $this->objForm->getDisplayGroup('password-group')->setLegend('Passwort neu setzen');
    $this->objForm->getDisplayGroup('password-group')->setDecorators(array('FormElements', 'Region'));
  }

  /**
   * userinfoAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function userinfoAction(){
    $this->initView();
    $this->view->user = Zend_Auth::getInstance()->getIdentity();
    $this->view->translate = Zend_Registry::get('Core')->translate;
  }

  /**
   * loginAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loginAction() {

    $objAuth = Zend_Auth::getInstance();
    //$objAuth->setStorage(new Zend_Auth_Storage_Session('UserAuth'));

    if($objAuth->hasIdentity()){
      $this->_redirect('/zoolu/cms');
    }

    $this->view->strErrMessage = '';
    $this->view->strErrUsername = '';
    $this->view->strErrPassword = '';

    if ($this->_request->isPost()) {

      /**
       * data from the user
       * strip all HTML and PHP tags from the data
       */
      $objFilter = new Zend_Filter_StripTags();
      $username = $objFilter->filter($this->_request->getPost('username'));
      $password = md5($objFilter->filter($this->_request->getPost('password')));

      if (empty($username)) {
        $this->view->strErrUsername = 'Bitte Username eingeben';
      } else {

        $this->core = Zend_Registry::get('Core');

        /**
         * setup Zend_Auth for database authentication
         */
        $objDbAuthAdapter = new Zend_Auth_Adapter_DbTable($this->core->dbh);
        $objDbAuthAdapter->setTableName('users');
        $objDbAuthAdapter->setIdentityColumn('username');
        $objDbAuthAdapter->setCredentialColumn('password');

        /**
         * set the input credential values to authenticate against
         */
        $objDbAuthAdapter->setIdentity($username);
        $objDbAuthAdapter->setCredential($password);

        /**
         * do the authentication
         */
        $result = $objAuth->authenticate($objDbAuthAdapter);

        switch ($result->getCode()) {

          case Zend_Auth_Result::FAILURE_IDENTITY_NOT_FOUND:
            /**
             * do stuff for nonexistent identity
             */
            $this->view->strErrUsername = 'Username nicht gefunden!';
            break;

          case Zend_Auth_Result::FAILURE_CREDENTIAL_INVALID:
            /**
             * do stuff for invalid credential
             */
            $this->view->strErrPassword = 'Falsches Passwort!';
            break;

          case Zend_Auth_Result::SUCCESS:
            /**
             * store database row to auth's storage system but not the password
             */
            $objUsersData = $objDbAuthAdapter->getResultRowObject(array('id', 'idLanguages', 'username', 'fname', 'sname'));
            $objUsersData->languageId = $objUsersData->idLanguages;
            unset($objUsersData->idLanguages);
            $objAuth->getStorage()->write($objUsersData);
            $_SESSION['sesTestMode'] = true;
            $this->_redirect('/zoolu/cms');
            break;

          default:
            /**
             * do stuff for other failure
             */
            $this->view->strErrMessage = 'Sonstiger Fehler!';
            break;
        }
      }
    }
  }

  /**
   * logoutAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function logoutAction(){
    $auth = Zend_Auth::getInstance();
    $auth->clearIdentity();
    unset($_SESSION['sesTestMode']);
    $this->_redirect('/zoolu');
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