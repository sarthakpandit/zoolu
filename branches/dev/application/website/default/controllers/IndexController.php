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
 * @package    application.website.default.controllers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * IndexController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-15: Cornelius Hansjakob

 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class IndexController extends Zend_Controller_Action {

  /**
   * @var Core
   */
  private $core;

  /**
   * @var Model_Pages
   */
  private $objModelPages;

  /**
   * @var Model_Folders
   */
  private $objModelFolders;

  /**
   * @var Model_Urls
   */
  private $objModelUrls;

  /**
   * @var Zend_Cache_Frontend_Output
   */
  private $objCache;

  /**
   * @var Page
   */
  private $objPage;

  private $blnCachingStart = false;

  private $blnSearch = false;
  
  private $blnCachingOutput = false;
   
  /**
   * @var integer
   */
  private $intLanguageId;

  /**
   * @var string
   */
  private $strLanguageCode;

  /**
   * @var HtmlTranslate
   */
  private $translate;
  
  /**
   * init index controller and get core obj
   */
  public function init(){
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * preDispatch
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function preDispatch(){
    // trigger client specific dispatch helper
    if($this->core->sysConfig->helpers->client->dispatcher === 'enabled') ClientHelper::get('Dispatcher')->preDispatch($this);
    parent::preDispatch();
  }

  /**
   * postDispatch
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function postDispatch(){
    // trigger client specific dispatch helper
    if($this->core->sysConfig->helpers->client->dispatcher === 'enabled') ClientHelper::get('Dispatcher')->postDispatch($this);
    
    if(function_exists('tidy_parse_string') && $this->blnCachingOutput == false){
      /**
       * Tidy is a binding for the Tidy HTML clean and repair utility which allows 
       * you to not only clean and otherwise manipulate HTML documents, 
       * but also traverse the document tree. 
       */
      $arrConfig = array(
          'indent'        => TRUE,
          'output-xhtml'  => TRUE,
          'wrap'          => 200
      );
      
      $objTidy = tidy_parse_string($this->getResponse()->getBody(), $arrConfig, $this->core->sysConfig->encoding->db);    
      $objTidy->cleanRepair();
      
      $this->getResponse()->setBody($objTidy);
    }
     
    if(isset($this->objCache) && $this->objCache instanceof Zend_Cache_Frontend_Output){
      if($this->blnCachingStart === true){
        $response = $this->getResponse()->getBody();        
        $this->getResponse()->setBody(str_replace("<head>", "<head>
    <!-- This is a ZOOLU cached page (".date('d.m.Y H:i:s').") -->", $response));
        $this->getResponse()->outputBody();

        $arrTags = array();

        if($this->objPage->getIsStartElement(false) == true)
          $arrTags[] = 'Start'.ucfirst($this->objPage->getType());

        $arrTags[] = ucfirst($this->objPage->getType()).'Type_'.$this->objPage->getTypeId();
        $arrTags[] = ucfirst($this->objPage->getType()).'Id_'.$this->objPage->getPageId().'_'.$this->objPage->getLanguageId();

        $this->core->logger->debug(var_export($arrTags, true));
        $this->objCache->end($arrTags);
        $this->core->logger->debug('... end caching!');
        exit();
      }
    }
    parent::postDispatch();
  }

  /**
	 * indexAction
	 * @author Cornelius Hansjakob <cha@massiveart.com>
	 * @version 1.0
	 */
  public function indexAction(){
    $this->view->addFilter('PageReplacer');

    /**
     * get domain
     */
    $strDomain = $_SERVER['SERVER_NAME'];
    
    /**
     * get uri
     */
    $strUrl = $_SERVER['REQUEST_URI'];
    
    if(preg_match('/^\/[a-zA-Z\-]{2,5}\//', $strUrl)){
      $strUrl = preg_replace('/^\/[a-zA-Z\-]{2,5}\//', '', $strUrl);
    }else{
      $strUrl = preg_replace('/^\//', '', $strUrl);      
    }
    
    $this->intLanguageId = $this->core->intLanguageId;
    $this->strLanguageCode = $this->core->strLanguageCode;
    
    $this->getModelFolders();
    $objTheme = $this->objModelFolders->getThemeByDomain($strDomain)->current();
    if($this->core->blnIsDefaultLanguage === true){
      $this->core->intLanguageId = $objTheme->idLanguages;
      $this->core->strLanguageCode = strtolower($objTheme->languageCode);
      $this->intLanguageId = $this->core->intLanguageId;
      $this->strLanguageCode = $this->core->strLanguageCode;
    }
    $this->view->analyticsKey = $objTheme->analyticsKey;  
    $this->view->analyticsDomain = $strDomain;
    $this->view->mapsKey = $objTheme->mapsKey;
    
    $this->view->languageId = $this->intLanguageId;
    $this->view->languageCode = $this->strLanguageCode;
    
    /**
     * set up zoolu translate obj
     */
    if(file_exists(GLOBAL_ROOT_PATH.'application/website/default/language/website-'.$this->strLanguageCode.'.mo')){
       $this->translate = new HtmlTranslate('gettext', GLOBAL_ROOT_PATH.'application/website/default/language/website-'.$this->strLanguageCode.'.mo');  
    }else{
       $this->translate = new HtmlTranslate('gettext', GLOBAL_ROOT_PATH.'application/website/default/language/website-'.$this->core->sysConfig->languages->default->code.'.mo');
    }
    
    $this->view->translate = $this->translate;
      
    $strCacheId = 'page_'.$objTheme->idRootLevels.'_'.$this->strLanguageCode.'_'.preg_replace('/[^a-zA-Z0-9_]/', '_', $strUrl);
    
    $arrFrontendOptions = array(
      'lifetime' => 604800, // cache lifetime (in seconds), if set to null, the cache is valid forever.
      'automatic_serialization' => true
    );

    $arrBackendOptions = array(
      'cache_dir' => GLOBAL_ROOT_PATH.$this->core->sysConfig->path->cache->pages // Directory where to put the cache files
    );

    // getting a Zend_Cache_Core object
    $this->objCache = Zend_Cache::factory('Output',
                                          'File',
                                          $arrFrontendOptions,
                                          $arrBackendOptions);

    /**
     * check if "q" param is in the url for the search
     */
    if(strpos($strUrl, '?q=') !== false){
      $this->blnSearch = true;
      $strUrl = '';
    }
    
    if($this->core->sysConfig->cache->page == 'false' ||
       ($this->core->sysConfig->cache->page == 'true' && $this->objCache->test($strCacheId) == false) ||
       ($this->core->sysConfig->cache->page == 'true' && isset($_SESSION['sesTestMode']))){

      $this->getModelUrls();

      $this->getModelPages();

      $objNavigation = new Navigation();
      $objNavigation->setRootLevelId($objTheme->idRootLevels);
      $objNavigation->setLanguageId($this->intLanguageId);

      if(file_exists(GLOBAL_ROOT_PATH.'public/website/themes/'.$objTheme->path.'/helpers/NavigationHelper.php')){
        require_once(GLOBAL_ROOT_PATH.'public/website/themes/'.$objTheme->path.'/helpers/NavigationHelper.php');
        $strNavigationHelper = ucfirst($objTheme->path).'_NavigationHelper';
        $objNavigationHelper = new $strNavigationHelper();
      }else{
        require_once(dirname(__FILE__).'/../helpers/NavigationHelper.php');
        $objNavigationHelper = new NavigationHelper();        
      }
      
      $objNavigationHelper->setNavigation($objNavigation);
      $objNavigationHelper->setTranslate($this->translate);      
      Zend_Registry::set('NavigationHelper', $objNavigationHelper);
      
      Zend_Registry::set('Navigation', $objNavigation); //FIXME need of registration navigation object??      

      $objUrl = $this->objModelUrls->loadByUrl($objTheme->idRootLevels, (parse_url($strUrl, PHP_URL_PATH) === null) ? '' : parse_url($strUrl, PHP_URL_PATH));

      if(isset($objUrl->url) && count($objUrl->url) > 0){
       
        $objUrlData = $objUrl->url->current();

        $this->core->logger->debug('Cache: '.$this->core->sysConfig->cache->page);
        if($this->core->sysConfig->cache->page == 'true' && !isset($_SESSION['sesTestMode']) && $this->blnSearch == false){
          $this->core->logger->debug('Start caching...');
          $this->objCache->start($strCacheId);
          $this->blnCachingStart = true;
        }

        $this->objPage = new Page();
        $this->objPage->setRootLevelId($objTheme->idRootLevels);
        $this->objPage->setRootLevelTitle(($this->core->blnIsDefaultLanguage === true ? $objTheme->defaultTitle : $objTheme->title));
        $this->objPage->setRootLevelGroupId($objTheme->idRootLevelGroups);        
        $this->objPage->setPageId($objUrlData->relationId);
        $this->objPage->setPageVersion($objUrlData->version);
        $this->objPage->setLanguageId($objUrlData->idLanguages);
                
        switch($objUrlData->idUrlTypes){
          case $this->core->sysConfig->url_types->page:
            $this->objPage->setType('page');
            $this->objPage->setModelSubPath('cms/models/');
            break;
          case $this->core->sysConfig->url_types->global:
            $this->objPage->setType('global');
            $this->objPage->setModelSubPath('global/models/');
            $this->objPage->setElementLinkId($objUrlData->idLink);
            $this->objPage->setNavParentId($objUrlData->idLinkParent);
            $this->objPage->setPageLinkId($objUrlData->linkId);
            break;
        }        

        /**
         * preset navigation parent properties
         * e.g. is a collection page
         */
        if($objUrlData->idParent !== null){
          $this->objPage->setNavParentId($objUrlData->idParent);
          $this->objPage->setNavParentTypeId($objUrlData->idParentTypes);
        }
        
        /**
         * has base url object 
         * e.g. prduct tree
         */
        if(isset($objUrl->baseUrl)){
          $objNavigation->setBaseUrl($objUrl->baseUrl);
          $this->objPage->setBaseUrl($objUrl->baseUrl);
          $this->objPage->setNavParentId($objUrlData->idLinkParent);
        }

        $this->objPage->loadPage();
        
        /**
         * set values for replacers
         */
        Zend_Registry::set('TemplateCss', ($this->objPage->getTemplateId() == $this->core->sysConfig->page_types->page->portal_startpage_templateId) ? '' : '');
        Zend_Registry::set('TemplateJs', ($this->objPage->getTemplateId() == $this->core->sysConfig->page_types->page->headquarters_templateId) ? '<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key='.$this->view->mapsKey.'" type="text/javascript"></script>' : '');

        if($this->objPage->ParentPage() instanceof Page){
          $objNavigation->setPage($this->objPage->ParentPage());
        }else{
          $objNavigation->setPage($this->objPage); 
        }  
        
        if(file_exists(GLOBAL_ROOT_PATH.'public/website/themes/'.$objTheme->path.'/helpers/PageHelper.php')){
          require_once(GLOBAL_ROOT_PATH.'public/website/themes/'.$objTheme->path.'/helpers/PageHelper.php');
          $strPageHelper = ucfirst($objTheme->path).'_PageHelper';
          $objPageHelper = new $strPageHelper();
        }else{
          require_once(dirname(__FILE__).'/../helpers/PageHelper.php');
          $objPageHelper = new PageHelper();
        }
        
        $objPageHelper->setPage($this->objPage);
        $objPageHelper->setTranslate($this->translate);
        Zend_Registry::set('PageHelper', $objPageHelper);
        
        Zend_Registry::set('Page', $this->objPage); //FIXME need of registration navigation object??  

        /**
         * forward to SearchController
         */
        if($this->blnSearch == true){
          $this->_forward('index', 'Search', null, array('rootLevelId' => $this->objPage->getRootLevelId(), 'theme' => $objTheme->path));
        }else{
          /**
           * get page template filename
           */
          $this->view->template = $this->objPage->getTemplateFile();
  
          $this->view->rootLevelId = $this->objPage->getRootLevelId();
          //$this->view->strRootLevelUrl = $this->core->sysConfig->url->base;
          $this->view->publisher = $this->objPage->getPublisherName();
          $this->view->publishdate = $this->objPage->getPublishDate();
        
          $this->view->setScriptPath(GLOBAL_ROOT_PATH.'public/website/themes/'.$objTheme->path.'/');
          $this->renderScript('master.php');
        }
      }else{
      	$this->view->setScriptPath(GLOBAL_ROOT_PATH.'public/website/themes/'.$objTheme->path.'/');
      	$this->getResponse()->setHeader('HTTP/1.1', '404 Not Found');
        $this->getResponse()->setHeader('Status', '404 File not found');
        $this->getResponse()->setHttpResponseCode(404);
        $this->renderScript('error-404.php');
      }
    }else{
      $this->blnCachingOutput = true;
      $this->getResponse()->setBody($this->objCache->load($strCacheId));
      $this->_helper->viewRenderer->setNoRender();
    }
  }

  /**
   * fontsizeAction
   * @author Michael Trawetzky <mtr@massiveart.com>
   * @version 1.0
   */
  public function fontsizeAction(){
  	$request = $this->getRequest();
  	$strFontSize = $request->getParam('fontsize');

    $objWebSession = new Zend_Session_Namespace('Website');
    $objWebSession->fontSize = $strFontSize;
    
  	$this->_helper->viewRenderer->setNoRender();
  }
  
  /**
   * getModelPages
   * @return Model_Pages
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  protected function getModelPages(){
    if (null === $this->objModelPages) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/Pages.php';
      $this->objModelPages = new Model_Pages();
      $this->objModelPages->setLanguageId($this->intLanguageId);
    }

    return $this->objModelPages;
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
   * getModelUrls
   * @return Model_Urls
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
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
      $this->objModelUrls->setLanguageId($this->intLanguageId);
    }

    return $this->objModelUrls;
  }
}
?>