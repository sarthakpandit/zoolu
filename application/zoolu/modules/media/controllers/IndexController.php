<?php

/**
 * Media_IndexController
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-06: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Media_IndexController extends AuthControllerAction {
  
  /**
   * The default action - show the home page
   */
  public function indexAction(){
   
    $this->_helper->viewRenderer->setNoRender();
    
    Zend_Layout::startMvc(array(
      'layout' => 'media',
      'layoutPath' => '../application/zoolu/layouts'
    )); 
    
    $objLayout = Zend_Layout::getMvcInstance();  
    $objLayout->assign('navigation',$this->view->action('index', 'Navigation', 'media'));
    $objLayout->assign('userinfo',$this->view->action('userinfo', 'User', 'core'));
    
    $this->view->assign('jsVersion', $this->core->sysConfig->version->js);
    $this->view->assign('cssVersion', $this->core->sysConfig->version->css);
    $this->view->assign('module', $this->core->sysConfig->modules->media);
  } 
}

?>