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
 * @package    application.zoolu.modules.core.views.helpers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */
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
  public function getVideoSelect($objVideos, $mixedSelectedId, $strElementId){
    //$this->core->logger->debug('core->views->helpers->VideoHelper->getFolderTree()');

    $intCounter = 0;
     $strOutput='';
 /*   $strOutput='<div class="videoItem bg1" id="div_'.$strElementId.'_0"   >
            <div class="videoThumb"><img src="/zoolu/images/icons/icon_novideo.png" witdh="100" style="border-right:1px solid #ccc;"/></div>
            <input type="hidden" id="thumb_'.$strElementId.'_0" name="thumb_'.$strElementId.'_0" value=""/>
            <div class="videoInfos"><strong>Kein Video</strong></div> 
             <div id="videoUnselectButton" style="cursor:pointer; position:relative; float:right; margin-right:5px;" onclick="myForm.selectVideo(\''.$strElementId.'\', \'0\');">
                      <div>
                        <div class="button25leftOn"></div>
                        <div class="button25centerOn">
                          <img class="iconsave" height="13" width="13" src="/zoolu/images/icons/icon_save_black.png"/>
                          <div>Auswählen</div>
                        </div>
                        <div class="button25rightOn"></div>
                        <div class="clear"></div>
                      </div>
                 </div>
              <div class="clear"></div>
          </div>';*/
        
    foreach($objVideos as $objVideo){
     $intCounter++;
            
           // Vimeo Controller
      if($objVideo instanceof VimeoVideoEntity){
	      $objThumbnails = $objVideo->getThumbnails();
	      $objThumbnail = current(current($objThumbnails));
	     
	      // Get Tags
	     /* $arrTags = array();
	      foreach($objVideo->getTags() as $objTag) {
	        $arrTags[] = $objTag->getTag();
	      }*/
	      
	      $strBgClass = ($intCounter % 2) ? ' bg2' : ' bg1';
	     // $strSelected = ($objVideo->getID() === $mixedSelectedId) ? ' selected' : '';
	     
	           
    	  $strOutput .='<div class="videoItem'.$strBgClass.'" id="div_'.$strElementId.'_'.$objVideo->getID().'"   >
    	            <div class="videoThumb"><img src="'.$objThumbnail->getContent().'" width="100"/></div>
    	            <input type="hidden" id="thumb_'.$strElementId.'_'.$objVideo->getID().'" name="thumb_'.$strElementId.'_'.$objVideo->getID().'" value="'.$objThumbnail->getContent().'"/>
    	            <div class="videoInfos">
    	            
    	             <div id="videoUnselectButton" style="cursor:pointer; position:relative; float:right; padding-right:5px; padding-top:20px;" onclick="myForm.selectVideo(\''.$strElementId.'\', \''.$objVideo->getID().'\');">
                      <div>
                        <div class="button25leftOn"></div>
                        <div class="button25centerOn">
                          <img class="iconsave" height="13" width="13" src="/zoolu/images/icons/icon_save_black.png"/>
                          <div>Auswählen</div>
                        </div>
                        <div class="button25rightOn"></div>
                        <div class="clear"></div>
                      </div>
    	            </div>
    	             <strong>'.$objVideo->getTitle().'</strong><br/><span class="gray666">('.date('d.m.Y H:i', $objVideo->getUploadTimestamp()).')</span>

    	            
                 
    	            </div>
    	           <div class="clear"></div>
    	          </div>';   	
  	   
      } 
      // Youtube Controller
      else {
             
      	$objThumbnails = $objVideo->getVideoThumbnails();
      	$arrThumbnail = current($objThumbnails);
      	$arrTags = array();
      	
      	$strBgClass = ($intCounter % 2) ? ' bg2' : ' bg1';
	      //$strSelected = ($objVideo->getVideoId() === $mixedSelectedId) ? ' selected' : '';
	      $strOutput .= '
	          <div class="videoItem'.$strBgClass.'" id="div_'.$strElementId.'_'.$objVideo->getVideoId ().'"   >
	            <div class="videoThumb"><img src="'.$arrThumbnail['url'].'" width="100"/></div>
	            <input type="hidden" id="thumb_'.$strElementId.'_'.$objVideo->getVideoId ().'" name="thumb_'.$strElementId.'_'.$objVideo->getVideoId ().'" value="'.$arrThumbnail['url'].'"/>
	            <div class="videoInfos">
	            
	            <div id="videoUnselectButton" style="cursor:pointer; position:relative; float:right; padding-right:5px; padding-top:20px;" onclick="myForm.selectVideo(\''.$strElementId.'\', \''.$objVideo->getVideoId ().'\');">
                      
                        <div class="button25leftOn"></div>
                        <div class="button25centerOn">
                          <img class="iconsave" height="13" width="13" src="/zoolu/images/icons/icon_save_black.png"/>
                          <div>Auswählen</div>
                        </div>
                        <div class="button25rightOn"></div>
                        <div class="clear"></div>
                      
                 </div>
	           
	            <strong>'.$objVideo->getTitle().'</strong>';
	      
	      // Check if VideoRecorded Date isnt null
      	if($objVideo->getVideoRecorded() != null) {
      		$strVideoUploadDate = date('d.m.Y H:i', strtotime($objVideo->getVideoRecorded()));
      		$strOutput .= '<br/><span class="gray666">('.$strVideoUploadDate.')</span>';
      	}
      	
      	
	      $strOutput .='
	          
                 <div class="clear"></div>
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
  
  /**
   * getVideoEntity 
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  public function getSelectedVideo($objVideoEntity, $intIdVideoType, $strValue , $strElementId, $strVideoTypeName, $strChannelUserId){
    
    $strBgClass = ' bg2';
    $strOutput='';
    $strOutput .='<div class="field-12"><b>Video Service:</b>&nbsp;';
        $strOutput .= $strVideoTypeName;
        $strOutput .='&nbsp;&nbsp;&nbsp;<b>Benutzer:</b>&nbsp;';
        $strOutput .= $strChannelUserId;
        $strOutput .='</div>';
    
           // Vimeo Controller
      if($objVideoEntity instanceof VimeoVideoEntity){
        $objThumbnails = $objVideoEntity->getThumbnails();
        $objThumbnail = current(current($objThumbnails));
        
        
        
       
       
        
       
                   
        $strOutput .='<div class="selectedVideo'.$strBgClass.'"><div id="div_selected'.$strElementId.'" >
                  <div class="videoThumb"><img src="'.$objThumbnail->getContent().'" width="100"/></div>
                  <input type="hidden" id="thumb_'.$strElementId.'_'.$objVideoEntity->getID().'" name="thumb_'.$strElementId.'_'.$objVideoEntity->getID().'" value="'.$objThumbnail->getContent().'"/>
                  <div class="videoInfos"> 
                  
                    <div id="videoUnselectButton" style="cursor:pointer; position:relative; float:right; padding-right:5px; padding-top:20px;">
                      
                        <div class="button25leftOff"></div>
                        <div class="button25centerOff">
                          <img class="icondelete" height="14" width="11" src="/zoolu/images/icons/icon_delete_white.png"/>
                          <div>Löschen</div>
                        </div>
                        <div class="button25rightOff"></div>
                        <div class="clear"></div>
                      
                    </div>
                   </div>
                    <strong>'.$objVideoEntity->getTitle().'</strong><br/><span class="gray666">('.date('d.m.Y H:i', $objVideoEntity->getUploadTimestamp()).')</span>
                
                    
                   
                    
                  
                  </div></div>';    
       
      } 
      // Youtube Controller
      else {
             
        $objThumbnails = $objVideoEntity->getVideoThumbnails();
        $arrThumbnail = current($objThumbnails);
        $arrTags = $objVideoEntity->getVideoTags();
   
        $strOutput .= '<div class="selectedVideo'.$strBgClass.'"><div id="div_selected'.$strElementId.'">
              <div class="videoThumb"><img src="'.$arrThumbnail['url'].'" width="100"/></div>
              <input type="hidden" id="thumb_'.$strElementId.'_'.$objVideoEntity->getVideoId ().'" name="thumb_'.$strElementId.'_'.$objVideoEntity->getVideoId ().'" value="'.$arrThumbnail['url'].'"/>
              <div class="videoInfos">
                
          <div id="videoUnselectButton" style="cursor:pointer; position:relative; float:right; padding-right:5px; padding-top:20px;">
                      
                        <div class="button25leftOff"></div>
                        <div class="button25centerOff">
                          <img class="icondelete" height="14" width="11" src="/zoolu/images/icons/icon_delete_white.png"/>
                          <div>Löschen</div>
                        </div>
                        <div class="button25rightOff"></div>
                        <div class="clear"></div>
                      
                 </div>
              
              <strong>'.$objVideoEntity->getTitle().'</strong>';
        
        // Check if VideoRecorded Date isnt null
        if($objVideoEntity->getVideoRecorded() != null) {
          $strVideoUploadDate = date('d.m.Y H:i', strtotime($objVideoEntity->getVideoRecorded()));
          $strOutput .= '<br/><span class="gray666">('.$strVideoUploadDate.')</span>';
        }
        
        $strOutput .='</div>
                    
                
                </div>
              <div class="clear"></div>
              
           </div> </div>';  

      }  
     
    
    /**
     * return html output
     */
    return $strOutput;
  }
}

?>