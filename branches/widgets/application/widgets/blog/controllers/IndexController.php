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
 * Blog_IndexController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-11: Florian Mathis
 *  *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

class Blog_IndexController extends AuthControllerAction  {
  
	/**
   * request object instance
   * @var Zend_Controller_Request_Abstract
   */
  protected $objRequest;
  protected $strLanguageCode;
  protected $intLanguageId;
  
  /**
   * @var Widget
   */
  protected $objWidget;
  
  /**
   * @var Model_Folders
   */
  protected $objModelFolders;
  
	/**
   * init
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   * @return void
   */
  public function init(){
    parent::init();
    $this->objRequest = $this->getRequest();
  }
	
  /**
   * indexAction
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){    
  	$objTheme->path = 'default';
  	
  	$strUrl = $_SERVER['REQUEST_URI'];
  	
  	$strDomain = $_SERVER['SERVER_NAME'];
  	
  	/**
  	 * Save language-prefix and remove it from the Url
  	 */
    if(preg_match('/^\/[a-zA-Z]{2}\//', $strUrl)){
      preg_match('/^\/[a-zA-Z]{2}\//', $strUrl, $arrMatches);
      $this->strLanguageCode = trim($arrMatches[0], '/');
      foreach($this->core->webConfig->languages->language->toArray() as $arrLanguage){
        if(array_key_exists('code', $arrLanguage) && $arrLanguage['code'] == strtolower($this->strLanguageCode)){
          $this->intLanguageId = $arrLanguage['id'];
          break;
        }
      }
      if($this->intLanguageId == null){
        $this->intLanguageId = $this->core->sysConfig->languages->default->id;
        $this->strLanguageCode = $this->core->sysConfig->languages->default->code;
      }
      $strUrl = preg_replace('/^\/[a-zA-Z]{2}\//', '', $strUrl);
    }else{
      $strUrl = preg_replace('/^\//', '', $strUrl);
      $this->intLanguageId = $this->core->sysConfig->languages->default->id;
      $this->strLanguageCode = $this->core->sysConfig->languages->default->code;
    }
    
    /**
     * Get the theme for this domain
     */
    $this->getModelFolders();
    $objTheme = $this->objModelFolders->getThemeByDomain($strDomain)->current();
    
    //FIXME: Front- and Backend-Options? Cache?
  	
  	require_once(dirname(__FILE__).'/../../../website/default/helpers/widget.inc.php');
  	$this->view->setScriptPath(GLOBAL_ROOT_PATH.'public/website/themes/'.$objTheme->path.'/');
    $this->renderScript('master.php');
  }
  
  /**
   * getModelFolders
   * @return Model_Folders
   * @author Cornelius Hansjakob <cha@massiveart.com>
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
      $this->objModelFolders->setLanguageId($this->intLanguageId);
    }

    return $this->objModelFolders;
  }
}

?>