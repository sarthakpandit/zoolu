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
 * @package    library.massiveart.website
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Navigation
 *
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-09: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.website
 * @subpackage Navigation
 */

require_once(dirname(__FILE__).'/navigation/tree.class.php');
require_once(dirname(__FILE__).'/navigation/item.class.php');

class Navigation {
  
  /**
   * @var Core
   */
  protected $core;

  /**
   * @var Model_Folders
   */
  protected $objModelFolders;

  /**
   * @var Page
   */
  protected $objPage;
  /**
   * @return Page
   */
  public function Page(){
    return $this->objPage;
  }
  
  /**
   * @var Zend_Db_Table_Row_Abstract
   */
  protected $objBaseUrl;

  /**
   * @var Zend_Db_Table_Rowset_Abstract
   */
  protected $objMainNavigation;
  public function MainNavigation(){
    return $this->objMainNavigation;
  }

  /**
   * @var NavigationTree
   */
  protected $objSubNavigation;
  public function SubNavigation(){
    return $this->objSubNavigation;
  }

  /**
   * @var Zend_Db_Table_Rowset_Abstract
   */
  protected $objParentFolders;
  public function ParentFolders(){
    return $this->objParentFolders;
  }
  
  /**
   * @var Zend_Db_Table_Rowset_Abstract
   */
  protected $objProductParentFolders;
  public function ProductParentFolders(){
    return $this->objProductParentFolders;
  }  

  protected $intRootLevelId;
  protected $intRootFolderId = 0;
  protected $strRootFolderId = '';
  protected $intLanguageId;

  /**
   * Constructor
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }

  /**
   * loadMainNavigation
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadMainNavigation(){
    try{
      $this->getModelFolders();

      $this->evaluateRootFolderId();

      $this->objMainNavigation = $this->objModelFolders->loadWebsiteRootNavigation($this->intRootLevelId);

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * loadNavigation
   * @param integer $intDepth
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadNavigation($intDepth = 1){
    try{
      $this->getModelFolders();

      $this->evaluateRootFolderId();

      $objNavigationTree = new NavigationTree();
      $objNavigationTree->setId(0);

      if($this->intRootLevelId > 0){
        $objNavigationData = $this->objModelFolders->loadWebsiteRootLevelChilds($this->intRootLevelId, $intDepth);

        $intTreeId = 0;
        foreach($objNavigationData as $objNavigationItem){

	        if($objNavigationItem->isStartPage == 1 && $objNavigationItem->depth == 0){

	         /**
            * add to parent tree
            */
            if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
              $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
            }

	        	$objTree = new NavigationTree();
            $objTree->setTitle($objNavigationItem->folderTitle);
            $objTree->setId($objNavigationItem->idFolder);
            $objTree->setParentId(0);
            $objTree->setItemId($objNavigationItem->folderId);
            $objTree->setOrder($objNavigationItem->folderOrder);
            $objTree->setUrl(($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->external->id) ? $objNavigationItem->external : '/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);

            $intTreeId = $objNavigationItem->idFolder;

	        }else{
	        	if($intTreeId != $objNavigationItem->idFolder){

	        	  /**
               * add to parent tree
               */
              if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
                $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
              }

              $objTree = new NavigationTree();
              $objTree->setTitle($objNavigationItem->folderTitle);
              $objTree->setId($objNavigationItem->idFolder);
              $objTree->setParentId($objNavigationItem->parentId);
              $objTree->setItemId($objNavigationItem->folderId);
              $objTree->setOrder($objNavigationItem->folderOrder);
              $objTree->setUrl(($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->external->id) ? $objNavigationItem->external : '/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);

              $intTreeId = $objNavigationItem->idFolder;
	        	}

	          if($objNavigationItem->pageId != null){
              if($objNavigationItem->isStartPage == 1){
                $objTree->setUrl(($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->external->id) ? $objNavigationItem->external : '/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);
              }else{
                $objItem = new NavigationItem();
                $objItem->setTitle($objNavigationItem->title);
                $objItem->setUrl(($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->external->id) ? $objNavigationItem->external : '/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);
                $objItem->setId($objNavigationItem->idPage);
                $objItem->setParentId($objNavigationItem->idFolder);
                $objItem->setItemId($objNavigationItem->pageId);
                $objItem->setOrder($objNavigationItem->pageOrder);
                $objTree->addItem($objItem, 'item_'.$objItem->getId());
              }
            }
	        }
        }
      }

      /**
       * add to parent tree
       */
      if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
        $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
      }

      $this->objMainNavigation = $objNavigationTree;
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }
  
  /**
   * loadNavigationByDisplayOption
   * @param integer $intDisplayOptionId
   * @param integer $intDepth
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function loadNavigationByDisplayOption($intDisplayOptionId, $intDepth = 99){
    try{
      
      $this->getModelFolders();

      $this->evaluateRootFolderId();

      $objNavigationTree = new NavigationTree();
      $objNavigationTree->setId(0);

      if($this->intRootLevelId > 0){
        
        $objNavigationData = $this->objModelFolders->loadWebsiteRootLevelChilds($this->intRootLevelId, $intDepth, $intDisplayOptionId);
        
        $intTreeId = 0;
        foreach($objNavigationData as $objNavigationItem){

          if($objNavigationItem->isStartPage == 1 && $objNavigationItem->depth == 0){
           /**
            * add to parent tree
            */
            if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
              $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
            }

            $objTree = new NavigationTree();
            $objTree->setTitle($objNavigationItem->folderTitle);
            $objTree->setId($objNavigationItem->idFolder);
            $objTree->setParentId(0);
            $objTree->setTypeId($objNavigationItem->idPageTypes);
            $objTree->setItemId($objNavigationItem->folderId);
            $objTree->setOrder($objNavigationItem->folderOrder);            
            $objTree->setUrl(($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->external->id) ? $objNavigationItem->external : '/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);

            if($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->product_tree->id && $this->objPage instanceof Page && $this->objPage->getElementId() == $objNavigationItem->idPage){
              $this->addProductTree($objTree);              
            }
              
            $intTreeId = $objNavigationItem->idFolder;

          }else{
            if($intTreeId != $objNavigationItem->idFolder){

              /**
               * add to parent tree
               */
              if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
                $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
              }

              $objTree = new NavigationTree();
              $objTree->setTitle($objNavigationItem->folderTitle);
              $objTree->setId($objNavigationItem->idFolder);
              $objTree->setTypeId($objNavigationItem->idPageTypes);
              $objTree->setParentId($objNavigationItem->parentId);
              $objTree->setItemId($objNavigationItem->folderId);
              $objTree->setOrder($objNavigationItem->folderOrder);
              $objTree->setUrl(($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->external->id) ? $objNavigationItem->external : '/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);
                            
              if($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->product_tree->id && $this->objPage instanceof Page && $this->objPage->getElementId() == $objNavigationItem->idPage){
                $this->addProductTree($objTree);
              }
            
              $intTreeId = $objNavigationItem->idFolder;
            }

            if($objNavigationItem->pageId != null){
              if($objNavigationItem->isStartPage == 1){
                $objTree->setUrl(($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->external->id) ? $objNavigationItem->external : '/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);
              }else{
                $objItem = new NavigationItem();
                $objItem->setTitle($objNavigationItem->title);
                $objItem->setUrl(($objNavigationItem->idPageTypes == $this->core->sysConfig->page_types->external->id) ? $objNavigationItem->external : '/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);
                $objItem->setId($objNavigationItem->idPage);
                $objTree->setTypeId($objNavigationItem->idPageTypes);
                $objItem->setParentId($objNavigationItem->idFolder);
                $objItem->setItemId($objNavigationItem->pageId);
                $objItem->setOrder($objNavigationItem->pageOrder);
                $objTree->addItem($objItem, 'item_'.$objItem->getId());
              }
            }
          }
        }
      }

      /**
       * add to parent tree
       */
      if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
        $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
      }

      $this->objMainNavigation = $objNavigationTree;
            
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    } 
  }
  
  /**
   * addProductTree
   * @param NavigationTree $objNavigationTree
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  private function addProductTree(NavigationTree &$objNavigationTree){
    try{
      if($this->objPage instanceof Page){
        
        $intParentId = $this->objPage->getFieldValue('entry_product_point');
        $arrFilterOptions = array('CategoryId'  => $this->objPage->getFieldValue('entry_category'),
                                  'LabelId'     => $this->objPage->getFieldValue('entry_label'));
                       
        $objNavigationData = $this->getModelFolders()->loadWebsiteProductTree($intParentId, $arrFilterOptions);
        
        if(count($objNavigationData) > 0){
          
          $intTreeId = 0;
          
          foreach($objNavigationData as $objNavigationItem){
            if($intTreeId != $objNavigationItem->idFolder){

              /**
               * add to parent tree
               */
              if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
                $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
              }

              $objTree = new NavigationTree();
              $objTree->setTitle($objNavigationItem->folderTitle);
              $objTree->setId($objNavigationItem->idFolder);
              $objTree->setTypeId($objNavigationItem->idProductTypes);
              $objTree->setParentId(($objNavigationItem->parentId == $intParentId) ? $objNavigationTree->getId() : $objNavigationItem->parentId);
              $objTree->setItemId($objNavigationItem->folderId);
              $objTree->setOrder($objNavigationItem->folderOrder);
              //$objTree->setUrl('/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);
              $objTree->setUrl($objNavigationTree->getUrl().$objNavigationItem->url);
                           
              $intTreeId = $objNavigationItem->idFolder;
            }
            
            if($objNavigationItem->productId != null){
              if($objNavigationItem->isStartProduct == 1){
                //$objTree->setUrl('/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);
                $objTree->setUrl($objNavigationTree->getUrl().$objNavigationItem->url);
              }else{
                $objItem = new NavigationItem();
                $objItem->setTitle($objNavigationItem->productTitle);
                //$objItem->setUrl('/'.strtolower($objNavigationItem->languageCode).'/'.$objNavigationItem->url);
                $objItem->setUrl($objNavigationTree->getUrl().$objNavigationItem->url);
                $objItem->setId($objNavigationItem->idProduct);
                $objTree->setTypeId($objNavigationItem->idProductTypes);
                $objTree->setParentId(($objNavigationItem->parentId == $intParentId) ? $objNavigationTree->getId() : $objNavigationItem->parentId);
                $objItem->setItemId($objNavigationItem->productId);
                $objItem->setOrder($objNavigationItem->productOrder);
                $objTree->addItem($objItem, 'item_'.$objItem->getId());
              }
            }
          } 

          /**
           * add to parent tree
           */
          if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
            $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
          }
        }
      }
            
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }     
  }  

  /**
   * loadStaticSubNavigation
   * @param integer $intDepth
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadStaticSubNavigation($intDepth = 2){
    try{
      $this->getModelFolders();

      $this->evaluateRootFolderId();

      $objNavigationTree = new NavigationTree();
      $objNavigationTree->setId($this->intRootFolderId);

      if($this->intRootFolderId > 0){
        $objSubNavigationData = $this->objModelFolders->loadWebsiteStaticSubNavigation($this->intRootFolderId, $intDepth);

        $intTreeId = 0;
        foreach($objSubNavigationData as $objSubNavigationItem){

          if($this->intRootFolderId == $objSubNavigationItem->idFolder){
            if($objSubNavigationItem->isStartPage == 1){
              $objNavigationTree->setTitle($objSubNavigationItem->folderTitle);
              $objNavigationTree->setUrl('/'.strtolower($objSubNavigationItem->languageCode).'/'.$objSubNavigationItem->url);
            }else{
              if($objSubNavigationItem->pageId != null){
                $objItem = new NavigationItem();
                $objItem->setTitle($objSubNavigationItem->pageTitle);
                $objItem->setUrl('/'.strtolower($objSubNavigationItem->languageCode).'/'.$objSubNavigationItem->url);
                $objItem->setId($objSubNavigationItem->idPage);
                $objItem->setParentId($objSubNavigationItem->idFolder);
                $objItem->setOrder($objSubNavigationItem->pageOrder);
                $objItem->setItemId($objSubNavigationItem->pageId);
                $objNavigationTree->addItem($objItem, 'item_'.$objItem->getId());
              }
            }
          }else{
            if($intTreeId != $objSubNavigationItem->idFolder){
              /**
               * add to parent tree
               */
              if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
                $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
              }

              $objTree = new NavigationTree();
              $objTree->setTitle($objSubNavigationItem->folderTitle);
              $objTree->setId($objSubNavigationItem->idFolder);
              $objTree->setParentId($objSubNavigationItem->parentId);
              $objTree->setOrder($objSubNavigationItem->folderOrder);
              $objTree->setItemId($objSubNavigationItem->folderId);

              $intTreeId = $objSubNavigationItem->idFolder;
            }

            if($objSubNavigationItem->pageId != null){
              if($objSubNavigationItem->isStartPage == 1){
                $objTree->setUrl('/'.strtolower($objSubNavigationItem->languageCode).'/'.$objSubNavigationItem->url);
                //$objTree->setItemId($objSubNavigationItem->pageId);
              }else{
                $objItem = new NavigationItem();
                $objItem->setTitle($objSubNavigationItem->pageTitle);
                $objItem->setUrl('/'.strtolower($objSubNavigationItem->languageCode).'/'.$objSubNavigationItem->url);
                $objItem->setId($objSubNavigationItem->idPage);
                $objItem->setParentId($objSubNavigationItem->idFolder);
                $objItem->setOrder($objSubNavigationItem->pageOrder);
                $objItem->setItemId($objSubNavigationItem->pageId);
                $objTree->addItem($objItem, 'item_'.$objItem->getId());
              }
            }
          }
        }
      }

      /**
       * add to parent tree
       */
      if(isset($objTree) && is_object($objTree) && $objTree instanceof NavigationTree){
        $objNavigationTree->addToParentTree($objTree, 'tree_'.$objTree->getId());
      }

      $this->objSubNavigation = $objNavigationTree;
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * evaluateRootFolderId
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function evaluateRootFolderId(){
    if(isset($this->objPage) && is_object($this->objPage) && $this->intRootFolderId == 0){
      if($this->objPage->getParentTypeId() == $this->core->sysConfig->parent_types->folder){
        $this->objParentFolders = $this->getModelFolders()->loadParentFolders($this->objPage->getNavParentId());

        if(count($this->objParentFolders) > 0){
          $this->intRootFolderId = $this->objParentFolders[count($this->objParentFolders) - 1]->id;
          $this->strRootFolderId = $this->objParentFolders[count($this->objParentFolders) - 1]->folderId;
        }
      }
    }
  }

  /**
   * getParentFolderIds
   * @return array $arrParentFolderIds
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getParentFolderIds(){
    $arrParentFolderIds = array();
    if(count($this->objParentFolders) > 0){
      foreach($this->objParentFolders as $objParentFolder){
        $arrParentFolderIds[] = $objParentFolder->folderId;  
        
      }
    }
    
    return $arrParentFolderIds;
  }
  
  /**
   * getProductParentFolderIds
   * @return array $arrProductParentFolderIds
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductParentFolderIds(){
    $arrProductParentFolderIds = array();
    if($this->objProductParentFolders === null && $this->objPage instanceof Page && $this->objPage->ChildPage() !== null){
      $this->objProductParentFolders = $this->getModelFolders()->loadProductParentFolders($this->objPage->ChildPage()->getNavParentId());
    }
    
    if(count($this->objProductParentFolders) > 0){
      foreach($this->objProductParentFolders as $objProductParentFolder){
        $arrProductParentFolderIds[] = $objProductParentFolder->folderId; 
      }
    }
    
    return $arrProductParentFolderIds;
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
      $this->objModelFolders->setLanguageId($this->intLanguageId);
    }

    return $this->objModelFolders;
  }

  /**
   * setPage
   * @param Page $objPage
   */
  public function setPage(Page &$objPage){
    $this->objPage = $objPage;
  }
  
  /**
   * setBaseUrl
   * @param $objBaseUrl
   */
  public function setBaseUrl(Zend_Db_Table_Row_Abstract $objBaseUrl){
    $this->objBaseUrl = $objBaseUrl;
  }

  /**
   * setRootLevelId
   * @param integer $intRootLevelId
   */
  public function setRootLevelId($intRootLevelId){
    $this->intRootLevelId = $intRootLevelId;
  }

  /**
   * getRootLevelId
   * @param integer $intRootLevelId
   */
  public function getRootLevelId(){
    return $this->intRootLevelId;
  }

  /**
   * getRootFolderId
   * @param string $strRootFolderId
   */
  public function getRootFolderId(){
    return $this->strRootFolderId;
  }

  /**
   * setLanguageId
   * @param integer $intLanguageId
   */
  public function setLanguageId($intLanguageId){
    $this->intLanguageId = $intLanguageId;
  }

  /**
   * getLanguageId
   * @param integer $intLanguageId
   */
  public function getLanguageId(){
    return $this->intLanguageId;
  }
}
?>