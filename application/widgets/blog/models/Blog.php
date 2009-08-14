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
 * @package    application.widgets.blog.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_Blog
 *
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-11: Florian Mathis
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.1
 */

class Model_Blog {
	/**
	 * @var arrFields
	 */
	protected $arrFields;
	protected $objBlogEntries;
	
	public function __construct() {
		$this->arrFields['default'] = array('title');
	}
	
	/**
	 * getFormFields
	 * @param $strName
	 * @return array Field
	 */
	public function getFormFields($strName='') { // make new class -> zoolu based, not widget!
		if($strName != '') {
			return $this->arrFields[$strName];
		}
		return $this->arrFields;
	}
	
	/**
	 * getBlogEntries
	 * @return Zend_Db_Table_Rowset_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
	 */
	public function getBlogEntries($strWidgetInstanceId, $intCount=5) {
		$objSelectForm = $this->getBlogEntriesTable()->select();
		$objSelectForm->setIntegrityCheck(false);
		$objSelectForm->from($this->objBlogEntries, array('id', 'title'));
		$objSelectForm->where("widgetInstanceId=?",$strWidgetInstanceId);
		$objSelectForm->limit($intCount,0);
		
		return $this->objBlogEntries->fetchAll($objSelectForm);
	}
	
 /**
   * addBlogEntry
   * @return number The new Id
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function addBlogEntry($arrValues) {
    return $this->getBlogEntriesTable()->insert($arrValues);
  }
	
	/**
   * getBlogEntriesTable
   * @return Zend_Db_Table_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function getBlogEntriesTable(){

    if($this->objBlogEntries === null) {
      require_once GLOBAL_ROOT_PATH.'application/widgets/blog/models/tables/BlogEntries.php';
      $this->objBlogEntries = new Model_Table_BlogEntries();
    }

    return $this->objBlogEntries;
  }
}

?>