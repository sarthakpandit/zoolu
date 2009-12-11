<?php
/**
 * ZOOLU - Content Management System
 * Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 *
 * LICENSE
 *
 * This file is part of ZOOLU.
 *
 * ZOOLU is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ZOOLU is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ZOOLU. If not, see http://www.gnu.org/licenses/gpl-3.0.html.
 *
 * For further information visit our website www.getzoolu.org 
 * or contact us at zoolu@getzoolu.org
 *
 * @category   ZOOLU
 * @package    application.widgets.blog.controllers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Blog_IndexController
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-11: Florian Mathis
 *  
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

class Blog_IndexController extends WidgetControllerAction  {
  /*
   * @var object $objBlogEntries
   */
	protected $objBlogEntries;
  
	/**
	 * Initialize WidgetController and add 
	 * default css and js widget theme files
	 * @see library/massiveart/controllers/WidgetControllerAction#init()
	 * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
	 */
	public function init() {
		parent::init();
		$this->addThemeCss('view');
		//$this->addThemeJs('test');
	}
	
  /**
   * IndexAction
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
	public function indexAction() {
		$this->strTemplateFile = 'index.php';
		$objEntries = $this->getBlogEntries();
		
		$objEntry = $objEntries->getBlogEntries($this->objWidget->getWidgetInstanceId());
		
		// view pagination
		$page=$this->_getParam('page',1);
    $paginator = Zend_Paginator::factory($objEntry);
    $paginator->setItemCountPerPage(2);
    $paginator->setCurrentPageNumber($page);
    $this->view->paginator=$paginator;
		
		$this->view->assign('objEntries',$objEntry);
	}
	
	public function getViewActionForm() {
		$form = new Zend_Form();
		$form->setMethod('post');
		
		// Ein username Element erstellen und konfigurieren:
		$username = $form->createElement('text', 'username');
		$username->setRequired(true)
		         ->addFilter('StringToLower');
		
		// Ein Passwort Element erstellen und konfigurieren:
		$password = $form->createElement('password', 'password');
		$password->setRequired(true);
		
		// Elemente dem Formular hinzufügen:
		$form->addElement($username)
		     ->addElement($password)
		     // addElement() als Factory verwenden um den 'Login' Button zu erstellen:
		     ->addElement('submit', 'login', array('label' => 'Login'));
		     
		return $form;
	}
	
  /**
   * viewAction
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function viewAction() {

  	$objBlogEntries = $this->getBlogEntries();
		
  	$arrParams = $this->objRequest->getParams();
  	$strDate = $arrParams[1].'-'.$arrParams[2].'-'.$arrParams[3];
  	$strTitle = $arrParams[4];
  	
  	$objEntry = $objBlogEntries->getBlogEntryByDateAndTitle($strDate, $strTitle);
  	$this->view->assign('objEntry',$objEntry);
  	
  	$form = $this->getViewActionForm();
  	if ($this->getRequest()->isPost()) {
		  if (!$form->isValid($_POST)) {
	      $this->view->form = $form;
		 	} else {
		 		//$this->_redirect('/widget/blog/comment/add/asdsdf');
		 	}
  	} else {
  		$this->view->form = $form;
  	}
  }
  
  /**
   * rssAction
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function rssAction(){
  	header('Content-type: application/rss+xml');
  	$this->blnRenderMaster = false;
  	
  	require_once(dirname(__FILE__).'/../helpers/FeedBuilder.php');
  	
  	$objFeed = Zend_Feed::importBuilder(new Blog_FeedBuilder(Zend_Registry::get('Widget')), 'rss');
  	$this->view->assign('text', $objFeed->saveXml());
  }
  
	/**
   * getBlogEntries
   * @return Model_BlogEntry
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  protected function getBlogEntries(){
    if (null === $this->objBlogEntries) {
      /**
       * autoload only handles "library" components.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_widgets.'blog/models/BlogEntry.php';
      $this->objBlogEntries = new Model_BlogEntry();
    }
    return $this->objBlogEntries;
  }
}

?>