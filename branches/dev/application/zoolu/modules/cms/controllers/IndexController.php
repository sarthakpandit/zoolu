<?php

/**
 * IndexController
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-14: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Cms_IndexController extends AuthControllerAction {
  
  /**
   * The default action - show the home page
   */
  public function indexAction(){
   
    $this->_helper->viewRenderer->setNoRender();
    
    Zend_Layout::startMvc(array(
      'layout' => 'cms',
      'layoutPath' => '../application/zoolu/layouts'
    ));
    
    $objLayout = Zend_Layout::getMvcInstance();  
    $objLayout->assign('navigation', $this->view->action('index','Navigation','cms'));
    $objLayout->assign('userinfo', $this->view->action('userinfo','User','core'));
    
    $this->view->assign('jsVersion', $this->core->sysConfig->version->js);
    $this->view->assign('cssVersion', $this->core->sysConfig->version->css);
    $this->view->assign('module', $this->core->sysConfig->modules->cms);
  } 

}
