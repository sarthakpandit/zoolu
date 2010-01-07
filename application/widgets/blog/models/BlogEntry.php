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
 * Model_BlogEntry
 *
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-11: Florian Mathis
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.1
 */

class Model_BlogEntry {	
	/**
	 * @var Model_Table_BlogEntries
	 */
	protected $objBlogEntryTable;
	
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
		$this->core->logger->debug('widgets->blog->Model_BlogEntry->getBlogEntries('.$strWidgetInstanceId.', '.$intCount.')');
		
		$objSelectForm = $this->getBlogEntryTable()->select();
		$objSelectForm->setIntegrityCheck(false);
		$objSelectForm->from($this->objBlogEntryTable, array('id', 'title', 'users.username', 'widget_BlogEntries.created', 'created_ts' => 'UNIX_TIMESTAMP(widget_BlogEntries.created)', 'text'));
		$objSelectForm->join('users','widget_BlogEntries.idUsers = users.id', array('idLanguages', 'username', 'password', 'fname', 'sname'));
		$objSelectForm->join('urls','urls.relationId = widget_BlogEntries.widgetInstanceId', array('url'));
		$objSelectForm->where("widgetInstanceId = ?", $strWidgetInstanceId);
		$objSelectForm->limit($intCount, 0);

		return $this->objBlogEntryTable->fetchAll($objSelectForm);
	}
	
 /**
   * addBlogEntry
   * @return number The new Id
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function addBlogEntry($arrValues) {
  	$this->core->logger->debug('widgets->blog->Model_BlogEntry->addBlogEntry(array)');
  	
    return $this->getBlogEntryTable()->insert($arrValues);
  }
  
  /**
   * getBlogEntry
   * @param number $intBlogEntryId
   * @return array
   * @author Daniel Rotter
   * @version 1.0
   */
  public function getBlogEntry($intBlogEntryId) {
  	$objSelect = $this->getBlogEntryTable()->select();
  	$objSelect->setIntegrityCheck(false);
  	$objSelect->from($this->objBlogEntryTable, array('id', 'widgetInstanceId', 'title', 'text', 'subwidgetId'));
  	$objSelect->where('id = ?', $intBlogEntryId);
  	$objSelect->limit(1);
  	
  	return $this->objBlogEntryTable->fetchRow($objSelect)->toArray();
  }
  
  /**
   * getBlogEntryByDateAndTitle
   * @param $strDate
   * @param $strTitle
   * @return array
   * @author Florian Mathis
   * @version 1.0
   */
  public function getBlogEntryByDateAndTitle($strDate, $strTitle){
  	$this->core->logger->debug('widgets->blog->Model_BlogEntry->getBlogEntryByDateAndTitle('.$strDate.', '.$strTitle.')');
  	
  	$objSelect = $this->getBlogEntryTable()->select();
  	$objSelect->setIntegrityCheck(false);
  	$objSelect->from($this->objBlogEntryTable, array('id', 'title', 'users.username', 'created', 'text'));
  	$objSelect->joinInner('users','widget_blogentries.idUsers = users.id');
  	$objSelect->where('created LIKE ?', $strDate.'%');
  	$objSelect->where('title = ?', ereg_replace('-',' ',$strTitle));

  	return $this->objBlogEntryTable->fetchRow($objSelect);
  }
  
  /**
   * editBlogEntry
   * @param array $arrValues
   * @param number $intBlogEntry
   */
  public function editBlogEntry($arrValues, $intBlogEntry) {
  	$this->core->logger->debug('widgets->blog->Model_Blog->editBlogEntry(array, '.$intBlogEntry.')');
  	
  	$strWhere = $this->getBlogEntryTable()->getAdapter()->quoteInto('id = ?', $intBlogEntry);
  	$this->getBlogEntryTable()->update($arrValues, $strWhere);
  }
  
  /**
   * deleteBlogEntry
   * @param number $intBlogEntry
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function deleteBlogEntry($intBlogEntry) {
  	$this->core->logger->debug('widgets->blog->Model_Blog->deleteBlogEntry('.$intBlogEntry.')');
  	
  	$strWhere = $this->getBlogEntryTable()->getAdapter()->quoteInto('id = ?', $intBlogEntry);
  	return $this->getBlogEntryTable()->delete($strWhere);
  }
	
	/**
   * getBlogEntryTable
   * @return Zend_Db_Table_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function getBlogEntryTable(){
    if($this->objBlogEntryTable === null) {
      require_once GLOBAL_ROOT_PATH.'application/widgets/blog/models/tables/BlogEntries.php';
      $this->objBlogEntryTable = new Model_Table_BlogEntries();
    }

    return $this->objBlogEntryTable;
  }
}

?>