<?php

/**
 * IndexController
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-09: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Zoolu_IndexController extends AuthControllerAction {
  
  /**
	 * The default action - show the home page
	 */
  public function indexAction(){
   
  	$this->_helper->viewRenderer->setNoRender();
  	
  	Zend_Layout::startMvc(array(
		  'layout' => 'index',
		  'layoutPath' => '../application/zoolu/layouts'
		)); 
		
		$layout = Zend_Layout::getMvcInstance();  
		$layout->assign('navigation', '');
    $layout->assign('userinfo',$this->view->action('userinfo','User','core'));
    
    $this->view->assign('jsVersion', $this->core->sysConfig->version->js);
    $this->view->assign('cssVersion', $this->core->sysConfig->version->css);    
  }

}
