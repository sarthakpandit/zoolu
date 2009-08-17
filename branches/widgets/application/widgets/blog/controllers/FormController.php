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
 * Blog_FormController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-13: Daniel Rotter
 *  *
 * @author Daniel Rotter <daniel.rotter@massiveart.com>
 * @version 1.0
 */
class Blog_FormController extends AuthControllerAction {
	/**
	 * @var GenericForm
	 */
	private $objForm;
	
	/**
	 * @var Model_Blog
	 */
	private $objModelBlog;
	
	/**
	 * init
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function init() {
		parent::init();
		$this->objRequest = $this->getRequest();
	}
	
	/**
	 * getaddsubwidgetAction
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function getaddsubwidgetformAction() {
		$this->core->logger->debug('widgets->blog->FormController->getaddsubwidgetformAction()');
		
		try {
			$this->getForm($this->core->sysConfig->generic->actions->add);
			$this->objForm->setAction('/../widget/blog/form/addsubwidget');
			$this->objForm->prepareForm();
			$this->view->form = $this->objForm;
			$this->view->formtitle = $this->objForm->Setup()->getFormTitle();
			$this->setViewMetaInfos();
			$this->renderScript('page/form.phtml');
		} catch(Exception $exc) {
			$this->core->logger->err($exc);
			exit();
		}
	}
	
	/**
	 * getaddsubwidgetAction
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function addsubwidgetAction() {
		$this->core->logger->debug('widgets->blog->FormController->addsubwidgetAction()');
		
		try {
			$this->getForm($this->core->sysConfig->generic->actions->add);
			if($this->objRequest->getPost() && $this->objRequest->isXmlHttpRequest()) {
				$arrFormData = $this->objRequest->getPost();
				$this->objForm->Setup()->setFieldValues($arrFormData);
				
				$this->objForm->prepareForm();
				
				if($this->objForm->isValid($arrFormData)) {
					$this->objForm->setAction('/../widget/blog/form/editsubwidget');
					$arrData = array('widgetInstanceId' => $arrFormData['widgetInstanceId'],
					                 'title' => $arrFormData['title'],
					                 'text' => $arrFormData['text']);
					$intSubWidgetId = $this->getModelBlog()->addBlogEntry($arrData);
					$this->objForm->Setup()->setElementId($intSubWidgetId);
					$this->objForm->Setup()->setActionType($this->core->sysConfig->generic->actions->edit);
					$this->objForm->getElement('id')->setValue($intSubWidgetId);
					$this->core->logger->debug($this->objForm->Setup()->getElementId());
					$this->view->assign('blnShowFormAlert', true);
				} else {
					$this->objForm->setAction('widget/blog/form/addsubwidget');
					$this->view->assign('blnShowFormAlert', false);
				}
			} else {
				$this->objForm->prepareForm();
			}
			
			$this->objForm->updateSpecialFieldValues();
      
      $this->view->formtitle = $this->objForm->Setup()->getFormTitle();
      
      $this->setViewMetaInfos();
      
      $this->view->form = $this->objForm;
      $this->renderScript('page/form.phtml');
		} catch(Exception $exc) {
			$this->core->logger->err($exc);
			exit();
		}
	}
	
	/**
	 * getsubwidgeteditformAction
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	public function geteditsubwidgetformAction() {
		$this->core->logger->debug('widgets->blog->FormController->getsubwidgeteditformAction()');
		
		try {
			$this->getForm($this->core->sysConfig->generic->actions->edit);

			$arrData = $this->getModelBlog()->getBlogEntry($this->objRequest->getParam('subWidgetId'));

			$this->objForm->Setup()->setFieldValues($arrData);
			$this->objForm->setAction('/../widget/blog/form/editsubwidget');
			$this->objForm->prepareForm();
			$this->objForm->Setup()->setElementId($arrData['id']);
			$this->view->formtitle = $this->objForm->Setup()->getFormTitle();
      
      $this->setViewMetaInfos();
      $this->view->form = $this->objForm;
      
      $this->renderScript('page/form.phtml');
		}catch(Exception $exc){
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
		$this->core->logger->debug('widgets->blog->FormController->getForm('.$intActionType.')');
		
		try {
			$objFormHandler = FormHandler::getInstance();
			$objFormHandler->setFormId('W_BLOG_ARTICLE');
			$objFormHandler->setFormVersion(1);
			$objFormHandler->setActionType($intActionType);
			$objFormHandler->setLanguageId($this->core->sysConfig->languages->default->id);
      $objFormHandler->setFormLanguageId(Zend_Auth::getInstance()->getIdentity()->languageId);
			
			$this->objForm = $objFormHandler->getGenericForm();
			
			$this->objForm->Setup()->setCreatorId((($this->objRequest->getParam("creator") != '') ? $this->objRequest->getParam("creator") : Zend_Auth::getInstance()->getIdentity()->id));
      $this->objForm->Setup()->setStatusId((($this->objRequest->getParam("idStatus") != '') ? $this->objRequest->getParam("idStatus") : $this->core->sysConfig->form->status->default));
      $this->objForm->Setup()->setRootLevelId((($this->objRequest->getParam("rootLevelId") != '') ? $this->objRequest->getParam("rootLevelId") : null));
      $this->objForm->Setup()->setParentId((($this->objRequest->getParam("parentId") != '') ? $this->objRequest->getParam("parentId") : null));
      $this->objForm->Setup()->setIsStartPage((($this->objRequest->getParam("isStartPage") != '') ? $this->objRequest->getParam("isStartPage") : 0));
      $this->objForm->Setup()->setPublishDate((($this->objRequest->getParam("publishDate") != '') ? $this->objRequest->getParam("publishDate") : date('Y-m-d H:i:s')));
      $this->objForm->Setup()->setShowInNavigation((($this->objRequest->getParam("showInNavigation") != '') ? $this->objRequest->getParam("showInNavigation") : 0));
      $this->objForm->Setup()->setParentTypeId((($this->objRequest->getParam("parentTypeId") != '') ? $this->objRequest->getParam("parentTypeId") : (($this->objRequest->getParam("parentFolderId") != '') ? $this->core->sysConfig->parent_types->folder : $this->core->sysConfig->parent_types->rootlevel)));
      $this->objForm->Setup()->setElementTypeId($this->objRequest->getParam('idWidget'));
      $this->objForm->Setup()->setElementId($this->objRequest->getParam('widgetInstanceId'));
      $this->objForm->Setup()->setWidgetInstanceId($this->objRequest->getParam('widgetInstanceId'));
      $this->objForm->Setup()->setModelSubPath('cms/models/');

      $this->objForm->addElement('hidden', 'currLevel', array('value' => $this->objRequest->getParam('currLevel'), 'decorators' => array('Hidden'), 'ignore' => true));
			$this->objForm->addElement('hidden', 'elementType', array('value' => $this->objRequest->getParam('elementType'), 'decorators' => array('Hidden'), 'ignore' => true));
			$this->objForm->addElement('hidden', 'parentId', array('value' => $this->objRequest->getParam('parentId'), 'decorators' => array('Hidden'), 'ignore' => true));
			$this->objForm->addElement('hidden', 'idWidget', array('value' => $this->objRequest->getParam('idWidget'), 'decorators' => array('Hidden'), 'ignore' => true));
			$this->objForm->addElement('hidden', 'widgetInstanceId', array('value' => $this->objRequest->getParam('widgetInstanceId'), 'decorators' => array('Hidden'), 'ignore' => true));
			$this->objForm->addElement('hidden', 'rootLevelId', array('value' => $this->objRequest->getParam('rootLevelId'), 'decorators' => array('Hidden'), 'ignore' => true));
			$this->objForm->addElement('hidden', 'elementType', array('value' => 'widget', 'decorators' => array('Hidden'), 'ignore' => true));
      $this->objForm->addElement('hidden', 'isStartPage', array('value' => $this->objRequest->getParam('isStartPage'), 'decorators' => array('Hidden')));
		} catch(Exception $exc) {
			$this->core->logger->err($exc);
			exit();
		}
	}
	
	/**
	 * setViewMetaInfos
	 * @author Daniel Rotter <daniel.rotter@massiveart.com>
	 * @version 1.0
	 */
	private function setViewMetaInfos() {
		if(is_object($this->objForm) && $this->objForm instanceof GenericForm) {
			$this->view->version = $this->objForm->Setup()->getFormVersion();
      $this->view->publisher = $this->objForm->Setup()->getPublisherName();
      $this->view->showinnavigation = $this->objForm->Setup()->getShowInNavigation();
      $this->view->changeUser = $this->objForm->Setup()->getChangeUserName();
      $this->view->publishDate = $this->objForm->Setup()->getPublishDate('d. M. Y, H:i');
      $this->view->changeDate = $this->objForm->Setup()->getChangeDate('d. M. Y, H:i');
      $this->view->statusOptions = HtmlOutput::getOptionsOfSQL($this->core, 'SELECT id AS VALUE, (SELECT statusTitles.title AS DISPLAY FROM statusTitles WHERE statusTitles.idStatus = status.id AND statusTitles.idLanguages = '.$this->objForm->Setup()->getFormLanguageId().') AS DISPLAY FROM status', $this->objForm->Setup()->getStatusId());
      $this->view->creatorOptions = HtmlOutput::getOptionsOfSQL($this->core, 'SELECT id AS VALUE, CONCAT(fname, \' \', sname) AS DISPLAY FROM users', $this->objForm->Setup()->getCreatorId());

      $this->view->arrPublishDate = DateTimeHelper::getDateTimeArray($this->objForm->Setup()->getPublishDate());
      $this->view->monthOptions = DateTimeHelper::getOptionsMonth(false, $this->objForm->Setup()->getPublishDate('n'));
      
      $this->view->blnIsStartPage = $this->objForm->Setup()->getIsStartPage(false);

      if($this->objForm->Setup()->getField('url')) $this->view->pageurl = $this->objForm->Setup()->getField('url')->getValue();

      if($this->objForm->Setup()->getActionType() == $this->core->sysConfig->generic->actions->edit && $this->objForm->Setup()->getElementTypeId() != $this->core->sysConfig->page_types->link->id) $this->view->languageOptions = HtmlOutput::getOptionsOfSQL($this->core, 'SELECT id AS VALUE, languageCode AS DISPLAY FROM languages', $this->objForm->Setup()->getFormLanguageId());
		}
	}
	
 /**
   * getModelBlog
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  protected function getModelBlog(){
    if (null === $this->objModelBlog) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it 
       * from its modules path location.
       */ 
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_widgets.'blog/models/Blog.php';
      $this->objModelBlog = new Model_Blog();
    }
    
    return $this->objModelBlog;
  }
}
?>