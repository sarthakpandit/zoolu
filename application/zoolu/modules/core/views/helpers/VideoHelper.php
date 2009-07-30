<?php

/**
 * VideoHelper
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-03-04: Thomas Schedler
 * 1.1, 2009-07-30: Florian Mathis, Youtube Service
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class VideoHelper {
  
  /**
   * @var Core
   */
  private $core;
    
  /**
   * Constructor 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * getVideoTree 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getVideoSelect($objVideos, $mixedSelectedId, $strElementId) {
    $this->core->logger->debug('core->views->helpers->VideoHelper->getFolderTree()');
    
    $strOutput = '';
    
    $intCounter = 0;
    
    $strOutput .= '
          <div class="videoItem bg1" id="div_'.$strElementId.'_0" onclick="myForm.selectVideo(\''.$strElementId.'\', \'0\');"  >
            <div class="videoThumb"><img src="/zoolu/images/icons/icon_novideo.png" with="100" style="border-right:1px solid #ccc;"/></div>
            <input type="hidden" id="thumb_'.$strElementId.'_0" name="thumb_'.$strElementId.'_0" value=""/>
            <div class="videoInfos"><strong>Kein Video</strong></div>
            <div class="clear"></div>
          </div>';  
    
    foreach($objVideos as $objVideo){
     $intCounter++;
      
      // Vimeo Controller
      if($objVideos instanceof VimeoVideoList) {
	      $objThumbnails = $objVideo->getThumbnails();
	      $objThumbnail = current(current($objThumbnails));
	      
	      // Get Tags
	      $arrTags = array();
	      foreach($objVideo->getTags() as $objTag) {
	        $arrTags[] = $objTag->getTag();
	      }
	      
	      $strBgClass = ($intCounter % 2) ? ' bg2' : ' bg1';
	      $strSelected = ($objVideo->getID() === $mixedSelectedId) ? ' selected' : '';
	      
	      $strOutput .= '
	          <div class="videoItem'.$strBgClass.$strSelected.'" id="div_'.$strElementId.'_'.$objVideo->getID().'" onclick="myForm.selectVideo(\''.$strElementId.'\', \''.$objVideo->getID().'\');"  >
	            <div class="videoThumb"><img src="'.$objThumbnail->getContent().'" with="100"/></div>
	            <input type="hidden" id="thumb_'.$strElementId.'_'.$objVideo->getID().'" name="thumb_'.$strElementId.'_'.$objVideo->getID().'" value="'.$objThumbnail->getContent().'"/>
	            <div class="videoInfos">
	              <strong>'.$objVideo->getTitle().'</strong> <span class="gray666">('.date('d.m.Y H:i', $objVideo->getUploadTimestamp()).')</span><br/>
	              '.((count($arrTags) > 0) ? '<div class="smaller"><span class="gray666">Tags:</span> '.implode(', ', $arrTags).'</div>' : '').'
	            </div>
	            <div class="clear"></div>
	          </div>';   
      } 
      // Youtube Controller
      else {
      	$objThumbnails = $objVideo->getVideoThumbnails();
      	$arrThumbnail = current($objThumbnails);
      	$arrTags = $objVideo->getVideoTags();
      	
      	$strBgClass = ($intCounter % 2) ? ' bg2' : ' bg1';
	      $strSelected = ($objVideo->getVideoId() === $mixedSelectedId) ? ' selected' : '';
	      $strOutput .= '
	          <div class="videoItem'.$strBgClass.$strSelected.'" id="div_'.$strElementId.'_'.$objVideo->getVideoId ().'" onclick="myForm.selectVideo(\''.$strElementId.'\', \''.$objVideo->getVideoId ().'\');"  >
	            <div class="videoThumb"><img src="'.$arrThumbnail['url'].'" with="100"/></div>
	            <input type="hidden" id="thumb_'.$strElementId.'_'.$objVideo->getVideoId ().'" name="thumb_'.$strElementId.'_'.$objVideo->getVideoId ().'" value="'.$arrThumbnail['url'].'"/>
	            <div class="videoInfos">
	              <strong>'.$objVideo->getTitle().'</strong>';
	      
	      // Check if VideoRecorded Date isnt null
      	if($objVideo->getVideoRecorded() != null) {
      		$strVideoUploadDate = date('d.m.Y H:i', strtotime($objVideo->getVideoRecorded()));
      		$strOutput .= '<span class="gray666">('.$strVideoUploadDate.')</span>';
      	}
      	
	      $strOutput .='<br/>
	              '.((count($arrTags) > 0) ? '<div class="smaller"><span class="gray666">Tags:</span> '.implode(', ', $arrTags).'</div>' : '').'
	            </div>
	            <div class="clear"></div>
	          </div>';      
      }  
    }
    
    /**
     * return html output
     */
    return $strOutput;
  }
}

?>