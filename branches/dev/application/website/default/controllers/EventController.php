<?php

/**
 * EventController
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-20: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class EventController extends Zend_Controller_Action {

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
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0   
   */
  public function preDispatch(){
    //$this->_helper->viewRenderer->setNoRender();
    $this->core = Zend_Registry::get('Core');    
    $this->request = $this->getRequest();
  }
  
  /**
   * indexAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){
    $this->core->logger->debug('website->controllers->EventController->indexAction()');
    $this->_helper->viewRenderer->setNoRender();
  }
  
  /**
   * listAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function listAction(){
    $this->core->logger->debug('website->controllers->EventController->listAction()');
    
    $intQuarter = $this->request->getParam('quarter');
    $intYear = $this->request->getParam('year');
    
    $arrEventContainer = array();
    
    $objPage = new Page();
    $objPage->setLanguageId(1); // TODO : languageId
    $arrEventContainer = $objPage->getEventsContainer($intQuarter, $intYear);
    
    $this->view->assign('events', $arrEventContainer);
    $this->view->assign('quarter', $intQuarter);
    $this->view->assign('year', $intYear);
  }
}
?>