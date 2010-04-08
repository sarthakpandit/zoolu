<?php

/**
 * SearchController
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-20: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class SearchController extends Zend_Controller_Action {

  /**
   * @var Core
   */
  private $core;
  
  /**
   * @var integer
   */
  protected $intLanguageId;
  
  /**
   * @var string
   */
  protected $strLanguageCode;
   
  /**
   * init index controller and get core obj
   */
  public function init(){
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * indexAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){
    $this->core->logger->debug('website->controllers->SearchController->indexAction()');    
    
    $request = $this->getRequest();
    $strSearchValue = $request->getParam('searchfield');
    
    $this->intLanguageId = $this->core->intLanguageId;
    $this->strLanguageCode = $this->core->strLanguageCode;
    
    /**
     * set for output
     */
    $this->view->strLanguageCode = $this->strLanguageCode;
   
    /**
     * set translation object
     */
    $this->view->translate = $this->core->translate;
    
    $objSearch = New Search();
    $objSearch->setSearchValue($strSearchValue);    
    $this->view->objHits = $objSearch->search();
    
    $this->view->setScriptPath(GLOBAL_ROOT_PATH.'public/website/themes/inet/'); // TODO : theme
    $this->renderScript('search.php');
  }
  
  /**
   * livesearchAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function livesearchAction(){
    $this->core->logger->debug('website->controllers->SearchController->livesearchAction()');
    
    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
            
      $request = $this->getRequest();
      $strSearchValue = $request->getParam('search');
      
      $objSearch = New Search();
      $objSearch->setSearchValue($strSearchValue);
      $objSearch->setLimitLiveSearch(5);
      
      $this->view->objHits = $objSearch->livesearch();
    }
  }
}
?>