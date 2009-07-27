<?php

/**
 * VideoController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-14: Thomas Schedler
 *
 * @author Thomas Schedler <ths@massiveart.com>
 * @version 1.0
 */

class Core_VideoController extends AuthControllerAction {

  /**
   * indexAction
   * @author Thomas Schedler <ths@massiveart.com>
   * @version 1.0
   */
  public function indexAction(){

  }

  /**
   * getvideoselectAction
   * @author Thomas Schedler <ths@massiveart.com>
   * @version 1.0
   */
  public function getvideoselectAction(){
    $this->core->logger->debug('core->controllers->VideoController->getvideoselectAction()');

    try{

      $arrVideos = array();
       $arrChannelUser = $this->core->sysConfig->video_channels->vimeo->users->user->toArray();

      $objRequest = $this->getRequest();
      $intChannelId = $objRequest->getParam('channelId');
      $strChannelUserId = $objRequest->getParam('channelUserId', '');
      $strElementId = $objRequest->getParam('elementId');
      $strValue = $objRequest->getParam('value');

      switch($intChannelId){
        case $this->core->sysConfig->video_channels->vimeo->id :
          /**
           * Requires simplevimeo base class
           */
          require_once(GLOBAL_ROOT_PATH.'library/vimeo/vimeo.class.php');

          if(array_key_exists('id', $arrChannelUser)){
            // Now lets do the user search query. We will get an response object containing everything we need
            $objResponse = VimeoVideosRequest::getList($this->core->sysConfig->video_channels->vimeo->users->user->id);

            // We want the result videos as an array of objects
            $arrVideos = $objResponse->getVideos();
          }else if($strChannelUserId !== ''){
            // Now lets do the user search query. We will get an response object containing everything we need
            $objResponse = VimeoVideosRequest::getList($strChannelUserId);

            // We want the result videos as an array of objects
            $arrVideos = $objResponse->getVideos();
          }
          break;
      }

      $this->view->elements = $arrVideos;
      $this->view->channelUsers = (array_key_exists('id', $arrChannelUser)) ? array() : $this->core->sysConfig->video_channels->vimeo->users->user->toArray();
      $this->view->channelUserId = $strChannelUserId;
      $this->view->value = $strValue;
      $this->view->elementId = $strElementId;

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
      exit();
    }
  }
}

?>
