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
 * WidgetControllerAction
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-09: Florian Mathis
 *  *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

class WidgetControllerAction extends Zend_Controller_Action  {
	
	/**
	 * @var Core
	 */
	protected $core;
	
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
   * @var Model_Widgets
   */
  protected $objModelWidgets;
  
  /**
   * @var Model_Folders
   */
  protected $objModelFolders;  
  protected $strTemplateFile;
  
  /**
   * @var Object objTheme
   */
  protected $objTheme;
  protected $strWidgetArgs;
  protected $strWidgetParams;
  static $objWidgetCss = array();
  
	/**
   * init
   * 
   * Add PageReplacer Filter and get language out of url string.
   * Also assign url to zend view and load widget object by url.
   * 
   * @return void
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function init(){
    parent::init();
    
    // Add Default FilterPath and PageReplacer Filter
    $this->view->addBasePath('../application/website/default/views','Zend_View');
    $this->view->addFilter('PageReplacer');
    
    $this->objRequest = $this->getRequest();
    $this->core = Zend_Registry::get('Core');
    
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
    
    $this->view->assign('strWidgetUrl', $strUrl);
    
    // Get Widget Arguments
  	$this->strWidgetArgs = substr($strUrl,strlen(Zend_Registry::get('Widget')->getNavigationUrl()));
  	$this->strWidgetParams = explode('/',ltrim($this->strWidgetArgs,'/'));
    
    /**
     * Get the theme for this domain
     */
    $this->getModelFolders();
    $this->objTheme = $this->objModelFolders->getThemeByDomain($strDomain)->current();
    
  	$this->getModelWidgets();
    $this->objUrlsData = $this->objModelWidgets->loadWidgetByUrl($this->objTheme->idRootLevels, Zend_Registry::get('Widget')->getNavigationUrl());
    foreach($this->objUrlsData as $objPageData){
      $this->objUrlsData = $objPageData;
    }
    
    $this->objWidget = new Widget();    
    $this->objWidget->setWidgetInstanceId($this->objUrlsData->urlId);
  }
  
  /**
   * getWidgetObject
   * @return Zend_Registry object 
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function getWidgetObject(){
  	return Zend_Registry::get('Widget');
  }
  
  /**
   * postDispatch
   * 
   * Post-dispatch routines. Called before action method
   * and is used to set widget specific information and script path correction.
   * 
   * @return void
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function postDispatch(){  
    
    //FIXME: Front- and Backend-Options? Cache?
  	$objNavigation = new Navigation();
    $objNavigation->setRootLevelId($this->objTheme->idRootLevels);
    $objNavigation->setLanguageId($this->intLanguageId);
    
    require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_website.'default/helpers/navigation.inc.php';
    Zend_Registry::set('Navigation', $objNavigation);

    $this->objWidget->setRootLevelId($this->objTheme->idRootLevels);
    $this->objWidget->setRootLevelTitle($this->objTheme->title);
    $this->objWidget->setWidgetVersion($this->objUrlsData->version);
    $this->objWidget->setLanguageId($this->objUrlsData->idLanguages);
    $this->objWidget->setTemplateFile($this->strTemplateFile);
    $this->objWidget->setAction($this->strWidgetParams[0]);
    $this->objWidget->setWidgetName(Zend_Registry::get('Widget')->getWidgetName());
    
    /**
     * set values for replacers
     */
    Zend_Registry::set('WidgetCss', $this->getCssFiles());
    Zend_Registry::set('Widget', $this->objWidget);
    
  	require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_website.'default/helpers/widget.inc.php';
  	$this->view->setScriptPath(GLOBAL_ROOT_PATH.'public/website/themes/'.$this->objTheme->path.'/');
    $this->renderScript('master.php');
  }
  
	/**
	 * addCssFile
	 * @param string strPath
	 * @param string strMedia
	 * @return array objWidgetCss
	 * @author Florian Mathis <flo@massiveart.com>
	 * @version 1.0
	 */
	public function addCssFile($strPath = NULL, $strMedia = 'all'){
		$strWidgetPath = '/widgets/'.Zend_Registry::get('Widget')->getWidgetName().'/css/'.$strPath.'.css';
		if(isset($strPath)) { $this->objWidgetCss[$strMedia][] = $strWidgetPath; }
		
		return $this->objWidgetCss;
	}
	
	/**
	 * getCssFiles
	 * @return strOutput
	 * @author Florian Mathis <flo@massiveart.com>
	 * @version 1.0
	 */
	public function getCssFiles() {
		$strOutput='';		
		if(isset($this->objWidgetCss)) {
			foreach ($this->objWidgetCss AS $media => $files) {
				foreach($files AS $path) {
					if(file_exists(GLOBAL_ROOT_PATH.'public'.$path)) {
						$strOutput .= '<link type="text/css" rel="stylesheet" media="'. $media .'" href="'. $path .'" />';
					}
				}
			}
		}
		
		return $strOutput;
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
  
  /**
   * getModelWidgets
   * @return Model_Widgets
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  protected function getModelWidgets(){
    if (null === $this->objModelWidgets) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/Widgets.php';
      $this->objModelWidgets = new Model_Widgets();
      $this->objModelWidgets->setLanguageId($this->intLanguageId);
    }

    return $this->objModelWidgets;
  }
}

?>