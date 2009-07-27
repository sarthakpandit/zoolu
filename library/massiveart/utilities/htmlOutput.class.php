<?php

/**
 * HtmlOutput Class - static function container
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-17: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.utilities
 * @subpackage HtmlOutput
 */

class HtmlOutput {
  
  /**
   * getOptionsOfSQL
	 * returns the result of a SQL-Statement in the valid output form
	 * <option value=[VALUE] >[DISPLAY]</option>
	 *
	 * Version history (please keep backward compatible):
   * 1.0, 2008-11-17: Cornelius Hansjakob
   *
   * @param Core $core
	 * @param string $strSQL SQL statment
	 * @param string $strSelectedValue
	 * @return string $strHtmlOutput
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
	 */
	public static function getOptionsOfSQL(Core &$core, $strSQL, $strSelectedValue = ''){
    $core->logger->debug('massiveart->utilities->HtmlOutput->getOptionsOfSQL: '.$strSQL);
    $strHtmlOutput = '';

    try {
    	
    	foreach($core->dbh->query($strSQL)->fetchAll() as $arrSQLRow) {
      	
      	if($arrSQLRow['VALUE'] == $strSelectedValue){
          $strSelected = ' selected';
        }else{
          $strSelected = '';
        }
        $strHtmlOutput .= '<option value="'.$arrSQLRow['VALUE'].'"'.$strSelected.'>'.htmlentities($arrSQLRow['DISPLAY'], ENT_COMPAT, $core->sysConfig->encoding->default).'</option>'.chr(13);
      }

    } catch (Exception $exc) {
      $core->logger->err($exc);
    }

    return $strHtmlOutput;
	}
	
/**
   * getOptionsOfSQLByGuiTexts
   * returns the result of a SQL-Statement in the valid output form
   * <option value=[VALUE] >$core->guiTexts->getText([DISPLAY])</option>
   *
   * Version history (please keep backward compatible):
   * 1.0, 2008-11-17: Cornelius Hansjakob
   *
   * @param Core $core
   * @param string $strSQL SQL statment
   * @param string $strSelectedValue
   * @return string $strHtmlOutput
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public static function getOptionsOfSQLByGuiTexts(Core &$core, $strSQL, $strSelectedValue = ''){
    $core->logger->debug('massiveart->utilities->HtmlOutput->getOptionsOfSQLByGuiTexts: '.$strSQL);
    $strHtmlOutput = '';

    try{
      foreach($core->dbh->query($strSQL)->fetchAll() as $arrSQLRow) {
        if($arrSQLRow['VALUE'] == $strSelectedValue){
          $strSelected = ' selected';
        }else{
          $strSelected = '';
        }
        
        $strDisplayTitle = $core->guiTexts->getText(trim($arrSQLRow['DISPLAY']));
        
        if($strDisplayTitle != ''){
          $strHtmlOutput .= '<option value="'.$arrSQLRow['VALUE'].'"'.$strSelected.'>'.$strDisplayTitle.'</option>'.chr(13); 
        }          
      }

    }catch (Exception $exc) {
      $core->logger->err($exc);
    }

    return $strHtmlOutput;
  }
	
}

?>