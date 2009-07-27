<?php

/**
 * Media_FileController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-21: Cornelius Hansjakob
 *  *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Media_FileController extends AuthControllerAction  {

	/**
   * @var Model_Folders
   */
  protected $objModelFiles;

  /**
   * indexAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){

  }

  /**
   * geteditformAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function geteditformAction(){
    $this->core->logger->debug('media->controllers->FileController->geteditformAction()');

    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()){

      $this->getModelFiles();

      $objRequest = $this->getRequest();
      $strFileIds = $objRequest->getParam('fileIds');
      $objFiles = $this->objModelFiles->loadFilesById($strFileIds);

      $this->view->assign('strEditFormAction', '/zoolu/media/file/edit');
      $this->view->assign('strFileIds', $strFileIds);
      $this->view->assign('objFiles', $objFiles);
    }

    $this->renderScript('file/form.phtml');
  }

  /**
   * editAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function editAction(){
    $this->core->logger->debug('media->controllers->FileController->editAction()');

    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()){

    	$arrFormData = $this->getRequest()->getPost();

      $objFile = new File();
      $objFile->setFileDatas($arrFormData);
      $objFile->updateFileData();
    }

    /**
     * no rendering
     */
    $this->_helper->viewRenderer->setNoRender();
  }

  /**
   * deleteAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function deleteAction(){
    $this->core->logger->debug('media->controllers->FileController->deleteAction()');

    //FIXME where is the file delete ????

    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()){

    	$this->getModelFiles();

      $objRequest = $this->getRequest();
      $strFileIds = $objRequest->getParam('fileIds');

      $this->objModelFiles->deleteFiles($strFileIds);
    }
  }

  /**
   * getModelFiles
   * @return Model_Files
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  protected function getModelFiles(){
    if (null === $this->objModelFiles) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/Files.php';
      $this->objModelFiles = new Model_Files();
      $this->objModelFiles->setLanguageId(1); // TODO : get language id
    }

    return $this->objModelFiles;
  }

}

?>