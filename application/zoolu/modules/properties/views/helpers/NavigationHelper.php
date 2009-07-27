<?php

/**
 * NavigationHelper
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-15: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class NavigationHelper {
  
	/**
   * @var Core
   */
  private $core;
  
  /**
   * Constructor 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }
	
	/**
   * getRootLevels 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  function getRootLevels($rowset) {
    $this->core->logger->debug('properties->views->helpers->NavigationHelper->getRootLevels()');
  	
  	$strOutput = '';
  	
    foreach ($rowset as $row) {      
      /**
       * get values of the row and create output
       */
      $strJsClickFunc = '';
      $strRootLevelIconCss = '';
      
    	switch ($row->idRootLevelTypes) {
				case $this->core->sysConfig->root_level_types->contacts:
				    $strJsClickFunc = 'myNavigation.selectContacts('.$row->id.'); ';
				    $strRootLevelIconCss = 'usericon';
				    break;
				case $this->core->sysConfig->root_level_types->categories:
				    $strJsClickFunc = 'myNavigation.selectCategories('.$row->id.', '.$this->core->sysConfig->category_types->default.'); ';
				    $strRootLevelIconCss = 'categoryicon';					
				    break;
		    case $this->core->sysConfig->root_level_types->labels:
            $strJsClickFunc = 'myNavigation.selectCategories('.$row->id.', '.$this->core->sysConfig->category_types->label.'); ';
            $strRootLevelIconCss = 'labelicon';          
            break;
        case $this->core->sysConfig->root_level_types->systeminternals:
            $strJsClickFunc = 'myNavigation.selectCategories('.$row->id.', '.$this->core->sysConfig->category_types->system.'); ';
            $strRootLevelIconCss = 'sysinternicon';          
            break;				
    	}
    	
      $strOutput .= '<div class="portalcontainer">
        <div id="portal'.$row->id.'top" class="portaltop"><img src="/zoolu/images/main/bg_box_230_top.png" width="230" height="4"/></div>
        <div id="portal'.$row->id.'" class="portal" onclick="'.$strJsClickFunc.'return false;">
          <div class="'.$strRootLevelIconCss.'"></div>
          <div id="divRootLevelTitle_'.$row->id.'" class="portaltitle">'.htmlentities($row->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
          <div class="clear"></div>
        </div>
        <div id="portal'.$row->id.'bottom" class="portalbottom"><img src="/zoolu/images/main/bg_box_230_bottom.png" width="230" height="4"/></div>
        <div class="clear"></div>
      </div>';
    }
       
    return $strOutput;	
  	
  }
  
  /**
   * getCatNavElements 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  function getCatNavElements($rowset, $currLevel) {
  	$this->core->logger->debug('properties->views->helpers->NavigationHelper->getCatNavElements()');
  	
    $strOutput = '';
    
    foreach ($rowset as $row){
      
      /**
       * get values of the row and create output
       */
      $strIconCss = '';
      switch ($row->idCategoryTypes) {
        case $this->core->sysConfig->category_types->default:
            $strIconCss = 'img_category_on';
            break;
        case $this->core->sysConfig->category_types->label:
            $strIconCss = 'img_label_on';          
            break;
        case $this->core->sysConfig->category_types->system:
            $strIconCss = 'img_sysintern_on';          
            break;
      }
    	
    	$strOutput .= '<div id="category'.$row->id.'" class="category hoveritem">
							         <div class="icon '.$strIconCss.'" ondblclick="myNavigation.getEditForm('.$row->id.', \'category\', null , null, '.$row->idCategoryTypes.'); return false;"></div>
							         <div class="title" onclick="myNavigation.selectNavigationItem('.$currLevel.', \'category\', '.$row->id.', '.$row->idCategoryTypes.'); return false;">
							           '.htmlentities($row->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'
							         </div>
							       </div>';
    }
    return $strOutput; 
  }
  
  /**
   * getContactNavElements 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  function getContactNavElements($objRowset, $currLevel) {
    $this->core->logger->debug('properties->views->helpers->NavigationHelper->getContactNavElements()');
    
    $strOutput = '';
    $strOutputStartpage = '';
    
    $counter = 1;
    
    if(count($objRowset) > 0){
      foreach ($objRowset as $objRow){
        switch($objRow->type){
          case 'unit':
            $strOutput .= '
              <div id="'.$objRow->type.$objRow->id.'" class="'.$objRow->type.' hoveritem">
                <div id="divNavigationEdit_'.$objRow->id.'" class="icon img_'.$objRow->type.'" ondblclick="myNavigation.getEditForm('.$objRow->id.', \''.$objRow->type.'\', \''.$objRow->genericFormId.'\','.$objRow->version.'); return false;"></div>
                <div id="divNavigationTitle_'.$objRow->type.$objRow->id.'" class="title" onclick="myNavigation.selectNavigationItem('.$currLevel.', \''.$objRow->type.'\', '.$objRow->id.'); return false;">'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
              </div>';
            break;
          case 'contact':
            $strOutput .= '
              <div id="'.$objRow->type.$objRow->id.'" class="'.$objRow->type.' hoveritem">
                <div class="icon img_'.$objRow->type.'"></div>
                <div id="divNavigationTitle_'.$objRow->type.$objRow->id.'" class="title" onclick="myNavigation.getEditForm('.$objRow->id.',\''.$objRow->type.'\',\''.$objRow->genericFormId.'\','.$objRow->version.'); return false;">'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
              </div>';
            break;
        }
      }
    }
     
    return $strOutput;  
  }
}

?>