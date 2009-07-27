<?php

/**
 * TestmodeController
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-15: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class TestmodeController extends Zend_Controller_Action {

  /**
   * core object instance (logger, dbh, ...)
   * @var Core
   */
  protected $core; 
  
  /**
   * request object instacne
   * @var Zend_Controller_Request_Abstract
   */
  protected $request; 
    
  /**
   * preDispatch
   * Called before action method.
   * 
   * @return void  
   * @author Thomas Schedler <cha@massiveart.com>
   * @version 1.0   
   */
  public function preDispatch(){
    $this->_helper->viewRenderer->setNoRender();
    $this->core = Zend_Registry::get('Core');    
    $this->request = $this->getRequest();
  }
  
  /**
   * indexAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){
  	$this->core->logger->debug('website->controllers->TestmodeController->indexAction()');
  }
  
  /**
   * changeAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function changeAction(){
    $this->core->logger->debug('website->controllers->TestmodeController->changeAction()');
    
    $objAuth = Zend_Auth::getInstance();
    
    if($objAuth->hasIdentity()){
      if($this->request->getParam('TestMode') == 'on'){
        $_SESSION['sesTestMode'] = true;
      }else{
        $_SESSION['sesTestMode'] = false;
      }
    }
  }
}
?>