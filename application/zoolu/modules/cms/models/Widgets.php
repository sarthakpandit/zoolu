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
 * @package    application.zoolu.modules.cms.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_Widgets
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-06: Daniel Rotter
 * 
 * @author Daniel Rotter <daniel.rotter@massiveart.com>
 * @version 1.0
 *
 */
class Model_Widgets {
	/**
	 * @var Core
	 */
	private $core;
	
	/**
	 * @var Model_Table_Widgets
	 */
	protected $objWidgetsTable;
	
	/**
	 * @var Model_Table_GenericForms
	 */
	protected $objGenericFormsTable;
	
	/**
	 * Constructor
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function __construct() {
		$this->core = Zend_Registry::get('Core');
	}
	
	/**
	 * getWidgetsTable
	 * @return Zend_Db_Table_Abstract
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function getWidgetsTable() {
		if($this->objWidgetsTable === NULL) {
			require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/Widgets.php';
      $this->objWidgetsTable = new Model_Table_Widgets();
		}
		
		return $this->objWidgetsTable;
	}
	
	/**
   * getGenericFormsTable
   * @return Zend_Db_Table_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function getGenericFormsTable(){

    if($this->objGenericFormsTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/GenericForms.php';
      $this->objGenericFormsTable = new Model_Table_GenericForms();
    }

    return $this->objGenericFormsTable;
  }
	
  /**
   * getGenericFormByWidgetId
   * @param $intIdWidget
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
	public function getGenericFormByWidgetId($intIdWidget){
		$this->core->logger->debug('cms->models->Model_Widgets->getGenericFormByWidgetId()');
		
		$objSelect = $this->getGenericFormsTable()->select();
		$objSelect->setIntegrityCheck(false);
		
		$objSelect->from($this->objGenericFormsTable, array('id'));
		
		return $this->objGenericFormsTable->fetchAll($objSelect);
	}
	
	/**
	 * loadWidgets
	 * @return Zend_Db_Table_Rowset_Abstract
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function loadWidgets() {
		$this->core->logger->debug('cms->models->Model_Widgets->loadWidgets()');
		
		$objSelect = $this->getWidgetsTable()->select();
		$objSelect->setIntegrityCheck(false);
		
		$objSelect->from($this->objWidgetsTable, array('id', 'name'));
		$objSelect->order('name ASC');
		
		return $this->objWidgetsTable->fetchAll($objSelect);
	}
}
?>