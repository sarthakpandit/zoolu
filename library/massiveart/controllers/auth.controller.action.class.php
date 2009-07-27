<?php

/**
 * AuthControllerAction
 * 
 * Check authentification before starting controller actions
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-10: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class AuthControllerAction extends Zend_Controller_Action {
  
  /**
   * @var Core
   */
  protected $core;  
  
  /**
   * Init 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function init(){
    $this->core = Zend_Registry::get('Core');
  }
	
	/**
   * ensure that no other actions are accessible if you are not logged in
   */
  public function preDispatch(){
  	
  	/**
  	 * set default encoding to view
  	 */
  	$this->view->setEncoding($this->core->sysConfig->encoding->default);
  	
  	/**
     * check if user is authenticated, else redirect to login form
     */
    $auth = Zend_Auth::getInstance();
    
    if(!$auth->hasIdentity()){
      if($this->getRequest()->isXmlHttpRequest()){
        echo '<script type="text/javascript">
              //<![CDATA[
                window.location.reload();
              //]]>
              </script>';
        exit();
      }else{
        $this->_redirect('/zoolu/core/user/login');   
      }
    }
    
  }
}
?>