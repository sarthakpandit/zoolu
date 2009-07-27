<?php

/**
 * FolderHelper
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-23: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class FolderHelper {
  
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
   * getFolderTree 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getFolderTree($objRowset, $intFolderId) {
    $this->core->logger->debug('core->views->helpers->FolderHelper->getFolderTree()');
    
    $strOutput = '';
    
    if(count($objRowset) > 0){
      $blnFolderChilds = false;
      $intMainFolderDepth = 0;
      $strOutput .= '<div id="olnavitem'.$objRowset[0]->idRootLevels.'" class="olnavrootitem">
                       <div style="position:relative;">
                         <a href="#" onclick="myFolder.selectParentRootFolder('.$objRowset[0]->idRootLevels.'); return false;"><div class="icon img_folder_on"></div>'.htmlentities($objRowset[0]->rootLevelTitle, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</a>
                       </div>
                     </div>';
     
      foreach ($objRowset as $objRow){           
        if($objRow->id == $intFolderId){
          $intMainFolderDepth = $objRow->depth;
          $blnFolderChilds = true;
        }else if($blnFolderChilds == false || $objRow->depth <= $intMainFolderDepth){
          $blnFolderChilds = false;
          $intFolderDepth = $objRow->depth + 1;
          $strOutput .= '<div id="olnavitem'.$objRow->id.'" class="olnavrootitem">
                           <div style="position:relative; padding-left:'.(20*$intFolderDepth).'px">
                             <a href="#" onclick="myFolder.selectParentFolder('.$objRow->id.'); return false;"><div class="icon img_folder_'.(($objRow->idStatus == $this->core->sysConfig->status->live) ? 'on' : 'off').'"></div>'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</a>
                           </div>
                         </div>';
        }
      }
    }
    
    /**
     * return html output
     */
    return $strOutput;
  }
  
  /**
   * getFolderContentList
   * @param object $objRowset
   * @param integer $intFolderId 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getFolderContentList($objRowset, $intFolderId){
    $this->core->logger->debug('core->views->helpers->FolderHelper->getFolderContentList()');
    
    $strOutput = '';
    
    if(count($objRowset) > 0){
      foreach($objRowset as $objRow){
        
      	$strStatus = ($objRow->pageStatus == $this->core->sysConfig->status->live) ? 'on' : 'off' ;
      	
        if($objRow->isStartPage){
          $strOutput .= '
                      <tr class="listrow" id="Row'.$objRow->idPage.'">
                        <td class="rowcheckbox" colspan="2"><input type="checkbox" class="listSelectRow" value="'.$objRow->idPage.'" name="listSelect'.$objRow->idPage.'" id="listSelect'.$objRow->idPage.'"/></td>
                        <td class="rowicon"><div class="img_startpage_'.$strStatus.'"></div></td>
                        <td class="rowtitle">'.htmlentities($objRow->pageTitle, ENT_COMPAT, $this->core->sysConfig->encoding->default).' (Startseite)</td>
                        <td class="rowauthor" colspan="2"></td>
                      </tr>';	
        }else{
          $strOutput .= '
                      <tr class="listrow" id="Row'.$objRow->idPage.'">
                        <td class="rowcheckbox" colspan="2"><input type="checkbox" class="listSelectRow" value="'.$objRow->idPage.'" name="listSelect'.$objRow->idPage.'" id="listSelect'.$objRow->idPage.'"/></td>
                        <td class="rowicon"><div class="img_page_'.$strStatus.'"></div></td>
                        <td class="rowtitle">'.htmlentities($objRow->pageTitle, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</td>
                        <td class="rowauthor" colspan="2"></td>
                      </tr>';	
        }
      	  	
      }	
    }
    
    /**
     * return html output
     */
    return $strOutput;
  	
  	
  }
}

?>