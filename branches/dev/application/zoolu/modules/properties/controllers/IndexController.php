<?php

/**
 * IndexController
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-15: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Properties_IndexController extends AuthControllerAction {
  
  /**
   * The default action - show the home page
   */
  public function indexAction(){
   
    $this->_helper->viewRenderer->setNoRender();
    
    Zend_Layout::startMvc(array(
      'layout' => 'properties',
      'layoutPath' => '../application/zoolu/layouts'
    )); 
    
    $objLayout = Zend_Layout::getMvcInstance();  
    $objLayout->assign('navigation',$this->view->action('index','Navigation','properties'));
    $objLayout->assign('userinfo',$this->view->action('userinfo','User','core'));
    
    $this->view->assign('jsVersion', $this->core->sysConfig->version->js);
    $this->view->assign('cssVersion', $this->core->sysConfig->version->css);
    $this->view->assign('module', $this->core->sysConfig->modules->properties);
  } 

}
