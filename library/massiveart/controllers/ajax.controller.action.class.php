<?php

/**
 * AjaxControllerAction
 * 
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-14: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class AjaxControllerAction extends AuthControllerAction {
	
	/**
   * chek if this is an ajax-request
   */
  public function preDispatch(){		

		if(!isset($_SERVER['HTTP_X_REQUESTED_WITH']) && !($_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest')){
		  header ('Location: http://'.$_SERVER['HTTP_HOST']);
		  exit();
		}	

		parent::preDispatch();
  }	  
}

?>