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
 * template.php
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-11: Florian Mathis
 *  *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

class Blog_IndexController extends WidgetControllerAction  {
  /*
   * @var object $objBlogEntries
   */
	protected $objBlogEntries;
  
  /**
   * IndexAction
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
	public function indexAction() {
		$this->strTemplateFile = 'template.php';
		$objEntries = $this->getBlogEntries();
		$objEntries->getBlogEntries($this->objWidget->getWidgetInstanceId());
		$this->view->assign('test', 'hey hey hey');
	}
	
  /**
   * archiveAction
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function archiveAction() {
  	//$this->strTemplateFile = 'template.php';
  	//echo var_dump($this->objRequest->getParams());
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