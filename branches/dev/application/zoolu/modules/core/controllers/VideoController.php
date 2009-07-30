<?php

/**
 * VideoController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-14: Thomas Schedler
 * 1.1, 2009-07-30: Florian Mathis, Youtube Service
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

      $objRequest = $this->getRequest();
      $intChannelId = $objRequest->getParam('channelId');
      $strChannelUserId = $objRequest->getParam('channelUserId', '');
      $strElementId = $objRequest->getParam('elementId');
      $strValue = $objRequest->getParam('value');
      $strSearchQuery = $objRequest->getParam('searchString');

      switch($intChannelId){
      	/*
      	 * Vimeo Controller
      	 */
        case $this->core->sysConfig->video_channels->vimeo->id :
          /**
           * Requires simplevimeo base class
           */
          require_once(GLOBAL_ROOT_PATH.'library/vimeo/vimeo.class.php');

          $arrChannelUser = $this->core->sysConfig->video_channels->vimeo->users->user->toArray();
          $intIdVideoType = 1;
          
          if(array_key_exists('id', $arrChannelUser)){
            // Now lets do the user search query. We will get an response object containing everything we need
            $objResponse = VimeoVideosRequest::getList($this->core->sysConfig->video_channels->vimeo->users->user->id);

            // We want the result videos as an array of objects
            $arrVideos = $objResponse->getVideos();
          }else if($strChannelUserId !== ''){
          	if(is_array($arrChannelUser)) {
	          	foreach($arrChannelUser AS $chUser){
	          		if($chUser['id'] == $strChannelUserId) {
	          			// Now lets do the user search query. We will get an response object containing everything we need
			            $objResponse = VimeoVideosRequest::getList($strChannelUserId);
			
			            // We want the result videos as an array of objects
			            $arrVideos = $objResponse->getVideos();
	          		}
	          	}      
          	}      
          }
          
          // Set Channel Users
          $this->view->channelUsers = (array_key_exists('id', $arrChannelUser)) ? array() : $this->core->sysConfig->video_channels->vimeo->users->user->toArray();
      	break;
      	
      	/**
      	 * Youtube Controller
      	 */
      	case $this->core->sysConfig->video_channels->youtube->id :
      		$arrChannelUser = $this->core->sysConfig->video_channels->youtube->users->user->toArray();
          $intIdVideoType = 2;
          	
          $objResponse = new Zend_Gdata_YouTube();
				  $objResponse->setMajorProtocolVersion(2);
					  
				  if(array_key_exists('id', $arrChannelUser) && $strSearchQuery === ''){
				  	$arrVideos = $objResponse->getuserUploads($this->core->sysConfig->video_channels->youtube->users->user->id);
				  }else if($strChannelUserId !== ''){
				  	$arrVideos = $objResponse->getuserUploads($strChannelUserId);
				  }else if($strSearchQuery !== ''){
				  	$query = $objResponse->newVideoQuery();
					  $query->setOrderBy('viewCount');
					  $query->setSafeSearch('none');
					  $query->setVideoQuery($strSearchQuery);
					  $arrVideos = $objResponse->getVideoFeed($query->getQueryUrl(2));
				  }
					  
				  // Set Channel Users
				  $this->view->channelUsers = (array_key_exists('id', $arrChannelUser)) ? array() : $this->core->sysConfig->video_channels->youtube->users->user->toArray();
      	break;
          
      }
      $this->view->idVideoType = $intIdVideoType;
      $this->view->elements = $arrVideos;
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
