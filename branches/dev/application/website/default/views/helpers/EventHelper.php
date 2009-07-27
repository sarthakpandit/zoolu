<?php

/**
 * EventHelper
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-20: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class EventHelper {
  
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
   * getList 
   * @param object $objRowset
   * @return string $strOutput
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getList($arrEvents, $quarter, $year, $strImageFolder = '80x80'){
    $this->core->logger->debug('website->views->helpers->EventHelper->getList()');
    
    $arrDaysShort = array('So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa');
    
    $strOutput = '';
    if(count($arrEvents) > 0){
    	foreach($arrEvents as $key => $objPageContainer){
        if(count($objPageContainer) > 0){
        
	        $arrEventEntries = $objPageContainer->getEntries();
	        
	        foreach($arrEventEntries as $objEventEntry){
	          $datetime = strtotime($objEventEntry->datetime);
	        	
		        $strDescription = '';
	          if($objEventEntry->shortdescription != ''){
	            $strDescription = htmlentities($objEventEntry->shortdescription, ENT_COMPAT, $this->core->sysConfig->encoding->default); 
	          }else if($objEventEntry->description != ''){
	            if(strlen($objEventEntry->description) > 120){
	              $strDescription = strip_tags(substr($objEventEntry->description, 0, strpos($objEventEntry->description, ' ', 120))).' ...'; 
	            }else{
	              $strDescription = strip_tags($objEventEntry->description); 
	            }   
	          }
	          
		        $strEventStatus = '';
	          if($objEventEntry->event_status == $this->core->webConfig->eventstatus->full->id){
	            $strEventStatus = '
	                    <div class="divEventCalItemShortInfo smaller">Leider keine Pl&auml;tze mehr verf&uuml;gbar.</div>
	            ';  
	          }else if($objEventEntry->event_status == $this->core->webConfig->eventstatus->rest->id){
	            $strEventStatus = '
	                    <div class="divEventCalItemShortInfo smaller">Achtung: Nur noch wenige Restpl&auml;tze verf&uuml;gbar.</div>
	                    <a href="'.$objEventEntry->url.'" class="red smaller">Jetzt Anmelden!</a>'; 
	          }else{
	            $strEventStatus = '
	                    <a href="'.$objEventEntry->url.'" class="red smaller">Jetzt Anmelden!</a>'; 
	          }
	          
	          $strOutput .= '
	                <div class="divEventCalItem">
	                  <div class="divEventCalItemLeft">
	                    <div class="divEventCalItemDateBoxTop"></div>
	                    <div class="divEventCalItemDateBoxMiddle">
	                      <div class="divEventCalDate">'.$arrDaysShort[date('w', $datetime)].', '.date('d.m.', $datetime).'</div>
	                      <div class="divEventCalTime">Beginn: '.date('H:i', $datetime).' Uhr</div>
	                    </div>
	                    <div class="divEventCalItemDateBoxBottom"></div>
	                    <div class="clear"></div>
	                  </div>
	                  <div class="divEventCalItemCenter">
	                    <div class="divEventCalItemText">                      
	                      <h2 class="padding0"><a href="'.$objEventEntry->url.'">'.htmlentities($objEventEntry->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</a></h2>
	                      '.$strDescription.'
	                      <div><a href="'.$objEventEntry->url.'">Mehr Informationen</a></div>
	                    </div>';
            if($objEventEntry->filename != ''){
                  $strOutput .= '
                      <div class="divEventCalItemImage">
                        <a href="'.$objEventEntry->url.'">
                          <img title="'.$objEventEntry->filetitle.'" alt="'.$objEventEntry->filetitle.'" src="'.$this->core->sysConfig->media->paths->imgbase.$strImageFolder.'/'.$objEventEntry->filename.'"/>
                        </a>
                      </div>';
            }        
            $strOutput .= '
	                    <div class="clear"></div>
	                  </div>
	                  <div class="divEventCalItemRight">
	                    '.$strEventStatus.'
	                    <div class="clear"></div>
	                  </div>
	                  <div class="clear"></div>
	                </div>';
	        } 
	      }
	    }	    	
    }else{
      $strOutput = '<div class="divEventCalListEmpty">In diesem Zeitraum finden keine Veranstaltungen statt.</div>';	
    }
    return $strOutput.$this->getQuarterHeadline($quarter, $year);
  }
  
  /**
   * getQuarterHeadline 
   * @param integer $intQuarter
   * @param integer $intYear
   * @return string $strHtmlOutput
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  private function getQuarterHeadline($intQuarter = 0, $intYear = 0){
    $timestamp = time();
    $year = ($intYear > 0) ? $intYear : date('Y', $timestamp);
    $quarter = ($intQuarter > 0 && $intQuarter <= 4) ? $intQuarter : ceil(date('m', $timestamp) / 3);
    
    $arrQuarterText = array(1 => 'Jänner '.$year.' bis März '.$year,
                            2 => 'April '.$year.' bis Juni '.$year,
                            3 => 'Juli '.$year.' bis September '.$year,
                            4 => 'Oktober '.$year.' bis Dezember '.$year);
  
    $strHeadline = utf8_encode($arrQuarterText[$quarter]);
    
    $strHtmlOutput = '<div id="divQuarterHeadline_Q'.$quarter.'_'.$year.'" style="display:none;">'.$strHeadline.'</div>';
    
    return $strHtmlOutput;
  }
}