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
	 * @var Model_Table_WidgetInstances
	 */
	protected $objWidgetInstancesTable;
	
	/**
	 * @var Model_Table_Url
	 */
	protected $objUrlTable;
	
	/**
	 * @var number
	 */
	private $intLanguageId;
	
	/**
	 * UrlType Widget
	 */
	const URL_TYPE_WIDGET=2;
	
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
   * getWidgetInstancesTable
   * @return Zend_Db_Table_Abstract
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function getWidgetInstancesTable() {
    if($this->objWidgetsTable === NULL) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/WidgetInstances.php';
      $this->objWidgetInstancesTable = new Model_Table_WidgetInstances();
    }
    
    return $this->objWidgetInstancesTable;
  }
  
	/**
	 * insertUrl
	 * @param $strUrl
	 * @param $strPageId
	 * @param $intVersion
	 * @author Florian Mathis <flo@massiveart.com>
	 * @version 1.0
	 */
  public function insertUrl($strUrl, $strUrlId, $intVersion){
		$this->core->logger->debug('application->zoolu->modules->cms->models->Widgets->insertUrl('.$strUrl.', '.$strUrlId.', '.$intVersion.')');

    $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

    $arrData = array('urlId'       => $strUrlId,
                     'version'     => $intVersion,
                     'idLanguages' => $this->intLanguageId,
                     'url'         => $strUrl,
                     'idUsers'     => $intUserId,
                     'creator'     => $intUserId,
                     'created'     => date('Y-m-d H:i:s'),
                     'idUrlTypes'  => self::URL_TYPE_WIDGET);

    return $objSelect = $this->getUrlTable()->insert($arrData);
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
   * getUrlTable
   * @return Zend_Db_Table_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function getUrlTable(){

    if($this->objUrlTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/PageUrls.php';
      $this->objUrlTable = new Model_Table_Urls();
    }

    return $this->objUrlTable;
  }
	
  /**
   * getGenericFormByWidgetId
   * @param $intIdWidget
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
	public function getGenericFormByWidgetId($intIdWidget){
		$this->core->logger->debug('cms->models->Model_Widgets->getGenericFormByWidgetId('.$intIdWidget.')');
		
		$objSelect = $this->getWidgetsTable()->select();
		$objSelect->setIntegrityCheck(false);
		$objSelect->from($this->objWidgetsTable, array('name'));
		$objSelect->where('id=?', $intIdWidget);
		$objRowWidget = $this->objWidgetsTable->fetchRow($objSelect);
		
		$strGenericFormId = 'W_'.strtoupper($objRowWidget->name).'_DEFAULT';
		$this->core->logger->debug('cms->models->Model_Widgets->getGenericFormByWidgetId(), GenericFormId: '.$strGenericFormId);
		
		$objSelectForm = $this->getGenericFormsTable()->select();
		$objSelectForm->setIntegrityCheck(false);
		$objSelectForm->from($this->objGenericFormsTable, array('id', 'genericFormId', 'version'));
		$objSelectForm->where('genericFormId=?', $strGenericFormId);
		
		return $this->objGenericFormsTable->fetchRow($objSelectForm);
	}
	
	/**
	 * getGenericFormById
	 * @param $strId
	 * @return Zend_Db_Table_Rowset_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
	 */
	public function getGenericFormById($strId) {
		$this->core->logger->debug('cms->models->Model_Widgets->getGenericFormById('.$strId.')');
		
		$objSelectForm = $this->getGenericFormsTable()->select();
		$objSelectForm->setIntegrityCheck(false);
		$objSelectForm->from($this->objGenericFormsTable, array('id', 'genericFormId', 'version'));
		if(is_numeric($strId)) {
			$objSelectForm->where('id=?', $strId);
		} else {
			$objSelectForm->where('genericFormId=?', $strId);
		}
		
		return $this->objGenericFormsTable->fetchRow($objSelectForm);
	}
	
	/**
	 * getWidgetByWidgetInstanceId
	 * @param string $strWidgetInstanceId
	 * @return Zend_Db_Table_Rowset_Abstract
	 * @author Daniel Rotter <daniel.rotter@massvieart.com>
	 * @version 1.0
	 */
	public function getWidgetByWidgetInstanceId($strWidgetInstanceId) {
		$this->core->logger->debug('cms->models->Model_Widgets->getWidgetByWidgetInstanceId('.$strWidgetInstanceId.')');
		
		$objSelect = $this->getWidgetsTable()->select();
		$objSelect->setIntegrityCheck(false);
		$objSelect->from($this->objWidgetsTable, array('name'));
		$objSelect->join('widgetInstances', 'widgetInstances.idWidgets = widgets.id');
		$objSelect->where('widgetInstances.widgetInstanceId = ?', $strWidgetInstanceId);
		
		return $this->objWidgetsTable->fetchRow($objSelect);
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
	
  /**
   * loadWidgetInstance
   * @param number $intWidgetId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Daniel Rotter <daniel.rotter@massiveart.com>
   * @version 1.0
   */
  public function loadWidgetInstance($intWidgetInstanceId) {
    $this->core->logger->debug('cms->models->Model_Widgets->loadWidgetInstance('.$intWidgetInstanceId.')');
    
    $objSelect = $this->getWidgetInstancesTable()->select();
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from($this->objWidgetInstancesTable, array('id', 'idGenericForms', 'sortPosition', 'idParent', 'idParentTypes', 'created', 'changed', 'published', 'idStatus', 'sortTimestamp', 'creator', 'publisher', 'idWidgets', 'widgetInstanceId', 'version'));
    $objSelect->where('id = ?', $intWidgetInstanceId);
    
    return $this->objWidgetInstancesTable->fetchAll($objSelect);
  }
  
  /**
   * deleteWidgetInstance
   * @param number $intElementId
   * @return number
   */
  public function deleteWidgetInstance($intElementId) {
  	$this->core->logger->debug('cms->models->Model_Widgets->deleteWidgetInstance('.$intElementId.')');
  	
  	$this->getWidgetInstancesTable();
  	
  	$strWhere = $this->objWidgetInstancesTable->getAdapter()->quoteInto('id = ?', $intElementId);
  	
  	return $this->objWidgetInstancesTable->delete($strWhere);
  }
	
	/**
	 * setLanguage
	 * @param number $intLanguageId
	 */
	public function setLanguage($intLanguageId) {
		$this->intLanguageId = $intLanguageId;
	}
}
?>