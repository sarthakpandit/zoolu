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
 * @package    application.zoolu.modules.cms.controllers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * WidgetController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-06: Florian Mathis
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

class Cms_WidgetController extends AuthControllerAction {
	
	/**
	 * @var PARENT_TYPE_ROOTLEVEL
	 */
	const PARENT_TYPE_ROOTLEVEL = 1;
	
	/**
	 * @var PARENT_TYPE_FOLDER
	 */
	const PARENT_TYPE_FOLDER = 2;
	
	/**
	 * @var Model_Widgets
	 */
	protected $objModelWidgets;
	
	/**
	 * 
	 * @var GenericForm
	 */
	private $objForm;
	
	/**
   * init
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   * @return void
   */
  public function init(){
    parent::init();
    $this->objRequest = $this->getRequest();
  }
  
	/**
	 * widgettreeAction
	 * @author Florian Mathis <flo@massiveart.com
	 * @version 1.0
	 */
	public function widgettreeAction() {
		$this->core->logger->debug('core->controllers->WidgetController->widgettreeAction()');
		
		$intPortalId = $this->objRequest->getParam('portalId');
    $intFolderId = $this->objRequest->getParam('folderId');
    
    /**
     * Widget is in Roottree
     */
    if($intFolderId == '') {
    	$intParentId = $intPortalId;
    	$intParentType = self::PARENT_TYPE_ROOTLEVEL; 
    } else {
    	$intParentId = $intFolderId;
    	$intParentType = self::PARENT_TYPE_FOLDER;
    }

    $this->getModelWidget();
 		$objWidgets = $this->objModelWidgets->loadWidgets();

 		$this->view->assign('overlaytitle', 'Widget wählen');
 		$this->view->assign('elements', $objWidgets);
    $this->view->assign('parentId', $intParentId);
    $this->view->assign('parentType', $intParentType);
	}
	/**
	 * addAction
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function addAction() {
		$this->core->logger->debug('cms->controllers->WidgetController->addAction()');
		
		try {
			$this->getForm($this->core->sysConfig->generic->actions->add);
			
			if($this->objRequest->isPost() && $this->objRequest->isXmlHttpRequest()) {
				$arrFormData = $this->objRequest->getPost();
				$this->objForm->Setup()->setFieldValues($arrFormData);
				
				$this->objForm->prepareForm();
				
				if($this->objForm->isValid($arrFormData)) {
					$intWidgetId = $this->objForm->saveFormData();
					$this->objForm->Setup()->setElementId($intWidgetId);
          $this->objForm->Setup()->setActionType($this->core->sysConfig->generic->actions->edit);
          $this->objForm->getElement('id')->setValue($intWidgetId);
          
          $this->view->assign('blnShowFormAlert', true);
				}
			}
		}catch(Exception $exc) {
			$this->core->logger->err($exc);
		}
	}
	
	/**
	 * getaddformAction
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function getaddformAction() {
		$this->core->logger->debug('cms->controllers->WidgetController->getaddformAction()');
		
		try {
			$this->getForm($this->core->sysConfig->generic->actions->add);
			
			$this->objForm->setAction('/zoolu/cms/widget/add');
			
			$this->objForm->prepareForm();
			
			$this->view->formtitle = $this->objForm->Setup()->getFormTitle();
      
      $this->view->form = $this->objForm;
      
      $this->renderScript('page/form.phtml');
		}catch(Exception $exc) {
			$this->core->logger->err($exc);
			exit();
		}
	}
	
	/**
	 * getForm
	 * @param number $intActionType
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	private function getForm($intActionType = null) {
		$this->core->logger->debug('cms->controllers->WidgetController->getForm('.$intActionType.')');
		
		try {
			/**
			 * Get GenericFormId
			 */      
			$objRow = $this->getModelWidget()->getGenericFormByWidgetId($this->objRequest->getParam('idWidget'));
      $objFormHandler = FormHandler::getInstance();
      $objFormHandler->setFormId($objRow->genericFormId);
      $objFormHandler->setFormVersion($objRow->version);
      $objFormHandler->setActionType($intActionType);
      $objFormHandler->setFormLanguageId(Zend_Auth::getInstance()->getIdentity()->languageId);
      
      $this->objForm = $objFormHandler->getGenericForm();
      
      $this->objForm->addElement('hidden', 'parentId', array('value' => $this->objRequest->getParam('parentId')));
      $this->objForm->addElement('hidden', 'parentType', array('value' => $this->objRequest->getParam('parentType')));
		}catch(Exception $exc) {
			$this->core->logger->err($exc);
		}
	}
	
	/**
   * getModelWidget
   * @return Model_Widget
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  protected function getModelWidget(){
    if (null === $this->objModelWidgets) {
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
}

?>