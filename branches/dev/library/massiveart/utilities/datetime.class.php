<?php

/**
 * DateTime Class - static function container
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-12: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.utilities
 * @subpackage DateTime
 */

class DateTimeHelper {
	
	/**
	 * getDateObject
	 * @return Zend_Date
	 * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
	 */
	public static function getDateObject(){
		return new Zend_Date(Zend_Registry::get('Location'));
	}
	
	/**
   * getStrDate
   * @return string date  e.g. 01.Jan. 2009
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
	public static function getStrDate(){
	  $date = self::getDateObject();
		return $date->get(Zend_Date::DAY).'.'.$date->get(Zend_Date::MONTH_NAME_SHORT).'. '.$date->get(Zend_Date::YEAR);	
	}
	
	/**
   * getStrTime
   * @return string time  e.g. 06:00
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
	public static function getStrTime(){
	  $date = self::getDateObject();
		return $date->get(Zend_Date::HOUR).':'.$date->get(Zend_Date::MINUTE);	
	}
	
  /**
   * getDateTimeArray
   * @param date
   * @return array
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public static function getDateTimeArray($date){
    $arrDateTime = array();
  	
    // year
    if(strlen($date) >= 4){
      $arrDateTime['year'] = substr($date, 0, 4);  	
    }
    // month
    if(strlen($date) >= 7){
      $arrDateTime['month'] = substr($date, 5, 2);    
    }
    // day
    if(strlen($date) >= 10){
      $arrDateTime['day'] = substr($date, 8, 2);    
    }
    // hour
    if(strlen($date) >= 13){
      $arrDateTime['hour'] = substr($date, 11, 2);    
    }
    // minute
    if(strlen($date) >= 16){
      $arrDateTime['minute'] = substr($date, 14, 2);   
    }
    // second
    if(strlen($date) >= 19){
      $arrDateTime['second'] = substr($date, 17, 2);  
    }
    
    return $arrDateTime;
  }
	
	/**
   * getDateTimeArrayNow
   * @return array
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
	public static function getDateTimeArrayNow(){
		return self::getDateObject()->toArray();
	}
	
	/**
   * getDateTimeArray
   * @param boolean $blnActSelected
   * @param integer $intSelMonth    
   * @return string $strHtmlOutput
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
	public static function getOptionsMonth($blnActSelected = true, $intSelMonth = 0){
  	$core = Zend_Registry::get('Core'); 
    $date = self::getDateObject();
    
    $strHtmlOutput = '';
    
    try {      
      for($counter = 1; $counter <= 12; $counter++) {
      	if($blnActSelected && $date->get(Zend_Date::MONTH_SHORT) == $counter && $intSelMonth == 0){
			    $strSelected = ' selected';	
			  }else if($intSelMonth > 0 && $intSelMonth == $counter){
			    $strSelected = ' selected';	
			  }else{
			    $strSelected = '';	
			  }
      	$strHtmlOutput .= '<option value="'.date('m', mktime(0, 0, 0, $counter, 1, 2009)).'"'.$strSelected.'>'.date('M', mktime(0, 0, 0, $counter, 1, 2009)).'</option>';  
			}
    } catch (Exception $exc) {
      $core->logger->err($exc);
    }
    return $strHtmlOutput;		
	}
	
}

?>