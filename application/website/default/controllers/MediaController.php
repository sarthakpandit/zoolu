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
 * MediaController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-12-02: Cornelius Hansjakob

 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class MediaController extends Zend_Controller_Action {

  /**
   * @var Core
   */
  private $core;
  
  /**
   * @var Model_Files
   */
  protected $objModelFiles;
  
  /**
   * preDispatch
   * Called before action method.
   * 
   * @return void  
   * @author Thomas Schedler <cha@massiveart.com>
   * @version 1.0   
   */
  public function preDispatch(){
    $this->_helper->viewRenderer->setNoRender();
    $this->core = Zend_Registry::get('Core'); 
  }

  /**
	 * indexAction
	 * @author Cornelius Hansjakob <cha@massiveart.com>
	 * @version 1.0
	 */
  public function indexAction(){
    
  }
  
  /**
   * imageAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function imageAction(){
    $this->core->logger->debug('website->controllers->MediaController->imageAction()');
    
    $this->getModelFiles();
    
    $intMediaId = $this->_getParam('id', 0);
    
    if($intMediaId > 0){
      $objFile = $this->objModelFiles->loadFileById($intMediaId);

      if(count($objFile) > 0){
        $objFileData = $objFile->current();
        
        $strFilePath = GLOBAL_ROOT_PATH.$this->core->sysConfig->upload->images->path->local->private.$objFileData->filename;
        
        if(file_exists($strFilePath)){
          if(isset($objFileData->mimeType) && $objFileData->mimeType != ''){
            header('Content-Type: '.$objFileData->mimeType);
            readfile($strFilePath); 	
          }else if(isset($objFileData->extension) && $objFileData->extension != ''){
          	header('Content-Type: image/'.$objFileData->extension);
          	readfile($strFilePath); 
          }else{
          	// no mimetype and no extension
          }           	
        }else{
        	// file doesn't exist        	
        }
      }
    }else{
      // no file id in url	
    }
  }
  
  /**
   * documentAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function documentAction(){
    $this->core->logger->debug('website->controllers->MediaController->documentAction()');
    
    $this->getModelFiles();
    
    $intMediaId = $this->_getParam('id', 0);
    
    if($intMediaId > 0){
      $objFile = $this->objModelFiles->loadFileById($intMediaId);

      if(count($objFile) > 0){
        $objFileData = $objFile->current();
        
        $strFilePath = GLOBAL_ROOT_PATH.$this->core->sysConfig->upload->documents->path->local->private.$objFileData->filename;
        
        if(file_exists($strFilePath)){
          if(isset($objFileData->mimeType) && $objFileData->mimeType != ''){
            
          	// fix for IE catching or PHP bug issue
            header("Pragma: public");
            header("Expires: 0"); // set expiration time
            header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
            // browser must download file from server instead of cache
            
            // Passenden Dateinamen im Download-Requester vorgeben,
            header("Content-Disposition: attachment; filename=\"".$objFileData->filename."\"");
                      	
          	header('Content-Type: '.$objFileData->mimeType);
            readfile($strFilePath);   
          }else{
            // no mimetype and no extension
          }             
        }else{
          // file doesn't exist         
        }
      }
    }else{
      // no file id in url  
    }
  
  }
  
  /**
   * downloadAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function downloadAction(){
    $this->core->logger->debug('website->controllers->MediaController->downloadAction()');
    
    $this->getModelFiles();
    
    $intMediaId = $this->_getParam('id', 0);    
    
    if($intMediaId > 0){
      $objFile = $this->objModelFiles->loadFileById($intMediaId);

      if(count($objFile) > 0){
        $objFileData = $objFile->current();
        
        $strFilePath = '';
        If($objFileData->isImage){
          $strFilePath = GLOBAL_ROOT_PATH.$this->core->sysConfig->upload->images->path->local->private.$objFileData->filename;	
        }else{
          $strFilePath = GLOBAL_ROOT_PATH.$this->core->sysConfig->upload->documents->path->local->private.$objFileData->filename;	
        }

        if(file_exists($strFilePath)){
        	
        	// fix for IE catching or PHP bug issue
			    header("Pragma: public");
			    header("Expires: 0"); // set expiration time
			    header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
			    // browser must download file from server instead of cache
			
			    // force download dialog
			    header("Content-Type: application/force-download");
			    header("Content-Type: application/octet-stream");
			    header("Content-Type: application/download");
			
			    // Passenden Dateinamen im Download-Requester vorgeben,
			    header("Content-Disposition: attachment; filename=\"".$objFileData->filename."\"");
			    
			    header("Content-Transfer-Encoding: binary");
			    header("Content-Length: ".$objFileData->size);
			
			    // Datei ausgeben.
			    readfile($strFilePath);
			    exit(); 
                
        }else{
          // file doesn't exist         
        }
      }
    }
  }
  
  /**
   * getModelFiles
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  protected function getModelFiles(){
    if (null === $this->objModelFiles) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it 
       * from its modules path location.
       */ 
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/Files.php';
      $this->objModelFiles = new Model_Files();
      $this->objModelFiles->setLanguageId($this->core->intLanguageId); // TODO : get language id
    }
    
    return $this->objModelFiles;
  }
}
?>