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
	
	/**
	 * @var Model_Table_BlogEntries
	 */
	protected $objBlogEntries;
	
	/**
	 * @var Core
	 */
	protected $core;
	
	public function __construct() {
		$this->core = Zend_Registry::get('Core');
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
   * getBlogEntry
   * @param integer $intBlogEntryId
   * @return array
   * @author Daniel Rotter
   * @version 1.0
   */
  public function getBlogEntry($intBlogEntryId) {
  	$objSelect = $this->getBlogEntriesTable()->select();
  	$objSelect->setIntegrityCheck(false);
  	$objSelect->from($this->objBlogEntries, array('id', 'widgetInstanceId', 'title', 'text'));
  	$objSelect->where('id = ?', $intBlogEntryId);
  	$objSelect->limit(1);
  	
  	return $this->objBlogEntries->fetchRow($objSelect)->toArray();
  }
  
  /**
   * editBlogEntry
   * @param array $arrValues
   * @param integer $intBlogEntry
   */
  public function editBlogEntry($arrValues, $intBlogEntry) {
  	$this->core->logger->debug('widgets->blog->Model_Blog->editBlogEntry('.$arrValues.', '.$intBlogEntry.')');
  	
  	$strWhere = $this->getBlogEntriesTable()->getAdapter()->quoteInto('id = ?', $intBlogEntry);
  	$this->getBlogEntriesTable()->update($arrValues, $strWhere);
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