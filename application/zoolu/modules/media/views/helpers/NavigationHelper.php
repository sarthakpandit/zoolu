<?php

/**
 * NavigationHelper
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-16: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class NavigationHelper {
  
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
   * getMediaTypes 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  function getMediaTypes($objRowset) {
    $this->core->logger->debug('media->views->helpers->NavigationHelper->getMediaTypes()');
    
    $strOutput = '';
    
    $strRootLevelIconCss = '';
    foreach ($objRowset as $objRow) {      
      
    	switch($objRow->idRootLevelTypes){    		
    		case $this->core->sysConfig->root_level_types->images: 
    		  $strRootLevelIconCss = 'imageicon';
    		  break;
    		
    		case $this->core->sysConfig->root_level_types->documents: 
          $strRootLevelIconCss = 'documenticon';
          break;
    	}
    	
      /**
       * get values of the row and create output
       */ 
      $strOutput .= '<div class="portalcontainer">
        <div id="portal'.$objRow->id.'top" class="portaltop"><img src="/zoolu/images/main/bg_box_230_top.png" width="230" height="4"/></div>
        <div id="portal'.$objRow->id.'" class="portal" onclick="myNavigation.selectMediaType('.$objRow->id.'); return false;">
          <div class="'.$strRootLevelIconCss.'"></div>
          <div id="divRootLevelTitle_'.$objRow->id.'" class="portaltitle">'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
          <div class="clear"></div>
        </div>
        <div id="portal'.$objRow->id.'bottom" class="portalbottom"><img src="/zoolu/images/main/bg_box_230_bottom.png" width="230" height="4"/></div>
        <div class="clear"></div>
      </div>';
    }
       
    return $strOutput;
  }
	
	/**
   * getNavigationElements 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  function getNavigationElements($objRowset, $currLevel) {
    $this->core->logger->debug('media->views->helpers->NavigationHelper->getNavigationElements()');
    
    $strOutput = '';
    
    if(count($objRowset) > 0){
      foreach ($objRowset as $strField => $objRow){
                
        /**
         * get values of the row and create default output
         */
        $strOutput .= '<div id="'.$objRow->type.$objRow->id.'" class="'.$objRow->type.'">
          <div id="divNavigationEdit_'.$objRow->id.'" class="icon img_'.$objRow->type.'_on" ondblclick="myNavigation.getEditForm('.$objRow->id.',\''.$objRow->type.'\',\''.$objRow->genericFormId.'\','.$objRow->version.'); return false;"></div>
          <div id="divNavigationTitle_'.$objRow->type.$objRow->id.'" class="title" onclick="myNavigation.selectNavigationItem('.$currLevel.', \''.$objRow->type.'\','.$objRow->id.'); myMedia.getMediaFolderContent('.$objRow->id.'); return false;">'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
        </div>';
      }
    }
     
    return $strOutput;
  }
  
}

?>