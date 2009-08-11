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
 *  *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

class Blog_IndexController extends AuthControllerAction  {
	/**
   * @var GenericForm
   */
  var $objForm;
  
	/**
   * request object instance
   * @var Zend_Controller_Request_Abstract
   */
  protected $objRequest;
  
	/**
   * init
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   * @return void
   */
  public function init(){
    parent::init();
    $this->objRequest = $this->getRequest();
  }
  
	/**
   * geteditformAction
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
	public function geteditformAction() {
		$this->core->logger->debug('widget->blog->controllers->IndexController->geteditformAction()');

		$this->renderScript('form.phtml');
	}
	
	/**
   * addAction
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
	public function addAction() {
		$this->core->logger->debug('widget->blog->controllers->IndexController->addAction()');
		
		/**
		 * Get Form Data
		 */
		$strTitle = $this->objRequest->getParam("blog_title");
		$arrFormData = $this->objRequest->getPost();
		
		$objStaticFormHandler = StaticFormHandler::getInstance();
		$objStaticFormHandler->setModuleName('blog');
		$objStaticFormHandler->setHandlerDirectory('application/widgets/blog/models');
		
		$objStaticFormHandler->save($arrFormData);
		// -> loadAllFields
		// -> set Form Data
		// -> save
		
		/**
		 * Debug
		 */
		//$this->core->logger->debug('BlogTitle: '.$strTitle);
		$this->renderScript('form.phtml');
	}
}

?>