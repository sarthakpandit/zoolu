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
 * GenericDataTypeWidget
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-07: Daniel Rotter
 *
 * @author Daniel Rotter <daniel.rotter@massiveart.com>
 * @version 1.0
 * @package generic.data.type.interface.php
 * @subpackage GenericFormTypeWidget
 */

require_once(dirname(__FILE__).'/generic.data.type.abstract.class.php');

class GenericDataTypeWidget extends GenericDataTypeAbstract
{
	/**
	 * @var Model_Widgets
	 */
	protected $objModelWidgets;
	
	/**
	 * @var Model_Folders
	 */
	protected $objModelFolders;
	
	/**
	 * @var Model_WidgetInstances
	 */
	protected $objModelWidgetInstances;
	
	/**
	 * save
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function save() {
		$this->core->logger->debug('massiveart->generic->data->GenericDataTypeWidget->save()');
		try {
			$this->getModelWidgets()->setLanguage($this->setup->getLanguageId());
			
			$intUserId = Zend_Auth::getInstance()->getIdentity()->id;
			
			switch($this->setup->getActionType()) {
				case $this->core->sysConfig->generic->actions->add:
					$strWidgetId = uniqid();
					$intWidgetVersion = 1;
					$intSortPosition = GenericSetup::DEFAULT_SORT_POSITION;
					
					/**
					 * check if parent element is rootlevel or folder
					 */
			    if($this->setup->getParentId() != '' && $this->setup->getParentId() > 0){
            if($this->setup->getParentTypeId() == '') $this->setup->setParentTypeId($this->core->sysConfig->parent_types->folder);
            $objNaviData = $this->getModelFolders()->loadChildNavigation($this->setup->getParentId());
          }else{
            if($this->setup->getRootLevelId() != '' && $this->setup->getRootLevelId() > 0){
              $this->setup->setParentId($this->setup->getRootLevelId());
            }else{
              $this->core->logger->err('massiveart->generic->data->GenericDataTypeWidget->save(): intRootLevelId is empty!');
            }
            $this->setup->setParentTypeId($this->core->sysConfig->parent_types->rootlevel);
            $objNaviData = $this->getModelFolders()->loadRootNavigation($this->setup->getRootLevelId());
          }
          $intSortPosition = count($objNaviData);

          $this->core->logger->debug('$this->setup->getParentId(): '.$this->setup->getParentId());
          $arrMainData = array( 'idGenericForms'  => $this->setup->getGenFormId(),
                                'sortPosition'    => $intSortPosition,
                                'idParent'        => $this->setup->getParentId(),
                                'idParentTypes'   => $this->setup->getParentTypeId(),
                                'created'         => date('Y-m-d H:i:s'),
                                'idStatus'        => $this->setup->getStatusId(),
                                'sortTimestamp'   => date('Y-m-d H:i:s'),
                                'creator'         => $this->setup->getCreatorId(),
                                'idWidgets'       => $this->setup->getElementTypeId(),
                                'widgetInstanceId'=> $strWidgetId);
          
          $this->setup->setElementId($this->objModelWidgets->getWidgetInstancesTable()->insert($arrMainData));
          
          $this->insertCoreData('widgetInstance', $strWidgetId, $intWidgetVersion);
          break;
			}
			return $this->setup->getElementId();
		}catch(Exception $exc) {
			$this->core->logger->err($exc);
		}
	}
	
	/**
	 * load
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function load(){
		
	}
	
	/**
	 * getModelWidgets
	 * @return Model_Widgets
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	protected function getModelWidgets() {
		if($this->objModelWidgets === NULL) {
			/**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/Widgets.php';
      $this->objModelWidgets = new Model_Widgets();
		}
		return $this->objModelWidgets;
	}
	
  /**
   * getModelFolders
   * @return Model_Folders
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelFolders(){
    if (null === $this->objModelFolders) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/Folders.php';
      $this->objModelFolders = new Model_Folders();
    }

    return $this->objModelFolders;
  }
}
?>