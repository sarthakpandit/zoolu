<?php

/**
 * Document Class extends File
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-27: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.documents
 * @subpackage Document
 */

class Document extends File {
          
  public function __construct(){
    parent::__construct();
    $this->blnIsDoc = true;
  }
  
  /**
   * upload
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function upload(){
    $this->core->logger->debug('massiveart.documents.Document->upload()');
    
    try{
      if(isset($_FILES[$this->_FILE_NAME]) && $_FILES[$this->_FILE_NAME]['name'] != ''){        
        $arrDocument = $_FILES[$this->_FILE_NAME];       
        
        /**
         * first check DocumentUploadPath
         */
        $this->checkUploadPath();
        
        $arrFileInfos = pathinfo($arrDocument['name']);
        $this->strExtension = strtolower($arrFileInfos['extension']);
        $this->strTitle = $arrFileInfos['filename'];
        $this->dblSize = $arrDocument['size'];
        $this->strMimeType = $arrDocument['type'];
        
        if(is_uploaded_file($arrDocument['tmp_name'])){
        	/**
	         * first check DocumentPublicPath
	         */
	        $this->checkPublicFilePath();
	        copy($arrDocument['tmp_name'], $this->getPublicFilePath().$this->strFileId.'.'.$this->strExtension);
        	move_uploaded_file($arrDocument['tmp_name'], $this->getUploadPath().$this->strFileId.'.'.$this->strExtension);
         
        }        
      }     
    }catch(Exception $exc){
      $this->core->logger->err($exc);
    }
  }

  /**
   * checkPublicFilePath
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  protected function checkPublicFilePath(){
    $this->core->logger->debug('massiveart.documents.Document->checkPublicFilePath('.$this->getPublicFilePath().')');

    if (!is_dir($this->getPublicFilePath())){
      mkdir($this->getPublicFilePath(), 0775, true);
    }
  }
}

?>