<?php

/**
 * Client_Dispatcher
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2010-04-22: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package client.plugins
 * @subpackage Client_Dispatcher
 */

require_once(GLOBAL_ROOT_PATH.'/library/IP2Location/ip2location.class.php');

class Client_Dispatcher implements ClientHelperInterface  {

  /**
   * @var Core
   */
  protected $core;
  
  /**
   * __construct
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function __construct() {
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * preDispatch
   * @param $objController Zend_Controller_Action
   * @return void
   */
  public function preDispatch($objController){
    
  }
  
  /**
   * postDispatch
   * @param $objController Zend_Controller_Action
   * @return void
   */
  public function postDispatch($objController){ 
        
  }
}