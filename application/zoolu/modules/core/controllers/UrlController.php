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
 * @package    application.zoolu.modules.core.controllers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */
/**
 * UrlHistoryController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-11-06: Dominik Mößlang
 * 1.1, 2009-12-07: Thomas Schedler
 *
 * @author Dominik Mößlang <dmo@massiveart.com>
 * @version 1.0
 */

class Core_UrlController extends AuthControllerAction {

	/**
	 * @var Model_Urls
	 */
	protected $objModelUrls;
	
  /**
   * @var Model Page
   */
  protected $objModelPage;
    
  /**
   * indexAction
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){
  }

  /**
   * geturlhistory
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  public function geturlhistoryAction(){
   // $this->_helper->viewRenderer->setNoRender();
    $this->core->logger->debug('core->controllers->UrlController->geturlhistoryAction()');

    try{
      $objRequest = $this->getRequest();
      $strElementId = $objRequest->getParam('elementId');
      $intPageId = $objRequest->getParam('pageId');
      $intLanguageId = $objRequest->getParam('languageId');
            
      $this->getModelPage = $this->getModelPage();
      
      $this->getModelPage->loadPageUrlHistory($intPageId,$intLanguageId);
          
      $this->view->objUrls = $this->getModelPage->loadPageUrlHistory($intPageId,$intLanguageId);
      $this->view->strElementId = $strElementId;
            
    }catch (Exception $exc){
      $this->core->logger->err($exc);
      exit();
    }
  }
  
  /**
   * removeUrlHistoryEntry
   * @return Model_Modules
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  public function removeurlhistoryentryAction(){
    $this->core->logger->debug('core->controllers->UrlController->removeUrlHistoryEntry()');

    $this->_helper->viewRenderer->setNoRender();
    try{
      $objRequest = $this->getRequest();
      $intUrlId = $objRequest->getParam('urlId');
      $strPageId = $objRequest->getParam('pageId');
            
      return $this->getModelUrls()->removeUrlHistoryEntry($intUrlId, $strPageId);
               
    }catch (Exception $exc){
      $this->core->logger->err($exc);
      exit();
    }
  }
  
  /**
   * getModelUrls
   * @return Model_Urls
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.1
   */
  protected function getModelUrls(){
    if (null === $this->objModelUrls) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/Urls.php';
      $this->objModelUrls = new Model_Urls();      
    }

    return $this->objModelUrls;
  }
  
  /**
   * getModelModules
   * @return Model_Modules
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  protected function getModelPage(){
    if (null === $this->objModelPage) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/Pages.php';
      $this->objModelPage = new Model_Pages();
    }

    return $this->objModelPage;
  }
  
}

?>
