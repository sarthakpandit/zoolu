<?php

/**
 * Core_UserController
 *
 * Login, Logout
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-10: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Core_UserController extends Zend_Controller_Action {

  /**
   * @var Core
   */
  private $core;

	/**
   * init
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
	function init(){
		$this->initView();
	}

	/**
   * indexAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
	public function indexAction(){

    $objAuth = Zend_Auth::getInstance();

    if(!$objAuth->hasIdentity()){
		  $this->_redirect('/zoolu/core/user/login');
		} else {
      $this->_redirect('/zoolu/cms');
		}

  }

  /**
   * userinfoAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function userinfoAction(){
  	$this->initView();
    $this->view->user = Zend_Auth::getInstance()->getIdentity();
  }

  /**
   * loginAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
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
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function logoutAction(){
  	$auth = Zend_Auth::getInstance();
	  $auth->clearIdentity();
	  unset($_SESSION['sesTestMode']);
	  $this->_redirect('/zoolu');
  }
}

?>