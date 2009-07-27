<?php

/**
 * Media_UploadController
 *
 * php-pecl-Fileinfo has to be installed
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-10: Thomas Schedler
 * 1.1, 2009-05-14: Cornelius Hansjakob
 *
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Media_UploadController extends AuthControllerAction  {

	protected $intParentId;

	/**
   * @var Zend_File_Transfer_Adapter_Http
   */
  protected $objUpload;

  const UPLOAD_FIELD = 'Filedata';

  /**
   * indexAction
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){
    try{
      $this->core->logger->debug('media->controllers->UploadController->indexAction()');

      $this->objUpload = new Zend_File_Transfer_Adapter_Http();

      /**
       * validators for upload of media
       */
      $arrExcludedExtensions = $this->core->sysConfig->upload->excluded_extensions->extension->toArray();

      $this->objUpload->addValidator('Size', false, array('min' => 1, 'max' => $this->core->sysConfig->upload->max_filesize));
      $this->objUpload->addValidator('ExcludeExtension', false, $arrExcludedExtensions);

      /**
       * check if medium is uploaded
       */
      if (!$this->objUpload->isUploaded(self::UPLOAD_FIELD)) {
      	$this->core->logger->warn('isUploaded: '.implode('\n', $this->objUpload->getMessages()));
      	throw new Exception('File is not uploaded!');
      }

      /**
       * check if upload is valid
       */
      if (!$this->objUpload->isValid(self::UPLOAD_FIELD)) {
        $this->core->logger->warn('isValid: '.implode('\n', $this->objUpload->getMessages()));
      	throw new Exception('Uploaded file is not valid!');
      }

      if($this->getRequest()->isPost()){
  	    $objRequest = $this->getRequest();
  	    $this->intParentId = $objRequest->getParam('folderId');

  	    /**
  	     * check if is image or else document
  	     */
  	    if($this->intParentId > 0 && $this->intParentId != ''){
  	      if (strpos($this->objUpload->getMimeType(self::UPLOAD_FIELD), 'image/') !== false) {
  	        $this->handleImageUpload();
  	      }else{
  	        $this->handleFileUpload();
  	      }
  	    }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * saveAction
   * @author Cornelius Hansjakob <cha@massiveart.at>
   * @version 1.0
   */
  public function saveAction(){
    $this->core->logger->debug('media->controllers->UploadController->saveAction()');

    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()){

    	$arrFormData = $this->getRequest()->getPost();

    	$objFile = new File();
    	$objFile->setFileDatas($arrFormData);
    	$objFile->saveFileData();
    }

    /**
     * no rendering
     */
    $this->_helper->viewRenderer->setNoRender();
  }

  /**
   * handleImageUpload
   * @author Cornelius Hansjakob <cha@massiveart.at>
   * @version 1.0
   */
  private function handleImageUpload(){
    $this->core->logger->debug('media->controllers->UploadController->handleImageUpload()');

  	$objImage = new Image();
  	$objImage->setUpload($this->objUpload);
    $objImage->setParentId($this->intParentId);
    $objImage->setParentTypeId($this->core->sysConfig->parent_types->folder);
    $objImage->setUploadPath(GLOBAL_ROOT_PATH.$this->core->sysConfig->upload->images->path->local->private);
    $objImage->setPublicFilePath(GLOBAL_ROOT_PATH.$this->core->sysConfig->upload->images->path->local->public);
    $objImage->setDefaultImageSizes($this->core->sysConfig->upload->images->default_sizes->default_size->toArray());
    $objImage->add('Filedata');

  	$this->writeViewData($objImage);
  }

  /**
   * handleDocumentUpload
   * @author Cornelius Hansjakob <cha@massiveart.at>
   * @version 1.0
   */
  private function handleFileUpload(){
    $this->core->logger->debug('media->controllers->UploadController->handleFileUpload()');

    $objFile = new File();
    $objFile->setUpload($this->objUpload);
    $objFile->setParentId($this->intParentId);
    $objFile->setParentTypeId($this->core->sysConfig->parent_types->folder);
    $objFile->setUploadPath(GLOBAL_ROOT_PATH.$this->core->sysConfig->upload->documents->path->local->private);
    $objFile->setPublicFilePath(GLOBAL_ROOT_PATH.$this->core->sysConfig->upload->documents->path->local->public);
    $objFile->add(self::UPLOAD_FIELD);


    $this->writeViewData($objFile);
  }

  /**
   * writeViewData
   * @param File $objFile
   * @author Cornelius Hansjakob <cha@massiveart.at>
   * @version 1.0
   */
  private function writeViewData(File &$objFile){
  	$this->core->logger->debug('media->controllers->UploadController->writeViewData()');

  	$this->view->assign('fileId', $objFile->getId());
    $this->view->assign('fileFileId', $objFile->getFileId());
    $this->view->assign('fileExtension', $objFile->getExtension());
    $this->view->assign('fileTitle', $objFile->getTitle());
    $this->view->assign('mimeType', $objFile->getMimeType());
    $this->view->assign('strDefaultDescription', 'Beschreibung hinzufügen...'); // TODO : guiTexts
    $this->view->assign('languageId', 1); // TODO : language
  }
}

?>