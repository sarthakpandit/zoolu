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
 * @package    library.massiveart.generic.data.types
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * GenericDataTypeSubwidget
 *
 * Version history (please keep backward compatible):
 * 1.0, 2010-01-04: Daniel Rotter
 *
 * @author Daniel Rotter <daniel.rotter@massiveart.com>
 * @version 1.0
 * @package generic.data.type.interface.php
 * @subpackage GenericDataTypeSubwidget
 */

require_once(dirname(__FILE__).'/generic.data.type.abstract.class.php');

class GenericDataTypeSubwidget extends GenericDataTypeAbstract {
	/**
	 * save
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function save() {
		$this->core->logger->debug('massiveart->generic->data->GenericDataTypeSubwidget->save()');
		
		$intSubwidgetVersion = 0;
		$strSubwidgetId = $this->Setup()->getSubwidgetId();
		
		switch($this->setup->getActionType()) {
			case $this->core->sysConfig->generic->actions->add:
				//FIXME Categories have to work!
				$this->insertCoreData('subwidget', $strSubwidgetId, $intSubwidgetVersion);
				break;
			case $this->core->sysConfig->generic->actions->edit:
				$this->updateCoreData('subwidget', $strSubwidgetId, $intSubwidgetVersion);
				break;
		}
		
		if(count($this->setup->SpecialFields()) > 0) {
			foreach($this->setup->SpecialFields() as $objField) {
				$objField->setGenericSetup($this->setup);
				$objField->save($this->setup->getElementId(), 'subwidget', $strSubwidgetId, $intSubwidgetVersion);
			}
		}
	}
	
	/**
	 * load
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function load() {
	  $this->core->logger->debug('massiveart->generic->data->GenericDataTypeSubwidget->load()');
		
	  $intSubwidgetVersion = 0;
			
		if(count($this->setup->SpecialFields()) > 0){
	    foreach($this->setup->SpecialFields() as $objField){
	      $objField->setGenericSetup($this->setup);
	      $objField->load($this->setup->getElementId(), 'subwidget', $this->Setup()->getSubwidgetId(), $intSubwidgetVersion);
	    }
	  }
	    
	  if(count($this->setup->CoreFields()) > 0){
		  /**
		   * for each core field, try to select the secondary table
		   */
		  foreach($this->setup->CoreFields() as $strField => $objField){
		
      $objGenTable = $this->getModelGenericData()->getGenericTable('subwidget'.((substr($strField, strlen($strField) - 1) == 'y') ? ucfirst(rtrim($strField, 'y')).'ies' : ucfirst($strField).'s'));
	    $objSelect = $objGenTable->select();
	
	    $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), array($strField));
	    $objSelect->where('subwidgetId = ?', $this->Setup()->getSubwidgetId());
	    $objSelect->where('version = ?', $intSubwidgetVersion);
	    $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());
		
	    $arrGenFormsData = $objGenTable->fetchAll($objSelect)->toArray();
		
		  if(count($arrGenFormsData) > 0){
		    $objField->blnHasLoadedData = true;
		    if(count($arrGenFormsData) > 1){
		      $arrFieldData = array();
		      foreach ($arrGenFormsData as $arrRowGenFormData) {
		        foreach ($arrRowGenFormData as $column => $value) {
		          array_push($arrFieldData, $value);
		        }
		      }
		      if($column == $strField){
		        $objField->setValue($arrFieldData);
		      }else{
		        $objField->$column = $arrFieldData;
		      }
		    }else{
		      foreach ($arrGenFormsData as $arrRowGenFormData) {
		        foreach ($arrRowGenFormData as $column => $value) {
		          if($column == $strField){
		            $objField->setValue($value);
		          }else{
		            $objField->$column = $value;
		            }
		          }
		        }
		      }
		    }
	    }
	  }
	}
}
?>