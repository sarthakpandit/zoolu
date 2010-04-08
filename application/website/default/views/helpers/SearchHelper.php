<?php

/**
 * SearchHelper
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-09-03: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class SearchHelper {

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
   * getLiveSearchList
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getLiveSearchList($objHits){
    $this->core->logger->debug('website->views->helpers->SearchHelper->getLiveSearchList()');

    $strHtmlOutput = '';

    if(count($objHits) > 0){
      $strHtmlOutput .= '<ul id="search_list">';
      foreach($objHits as $objHit){
        $objDoc = $objHit->getDocument();
        $arrDocFields = $objDoc->getFieldNames();
        
        if(array_search('url', $arrDocFields) && array_search('title', $arrDocFields)){
          $strTitle = '';
          if(array_search('articletitle', $arrDocFields) && $objHit->articletitle != ''){
            $strTitle = htmlentities($objHit->articletitle, ENT_COMPAT, $this->core->sysConfig->encoding->default);
          }else{
            $strTitle = htmlentities($objHit->title, ENT_COMPAT, $this->core->sysConfig->encoding->default);
          }
          $strHtmlOutput .= '<li><a href="'.$objHit->url.'">'.$strTitle.'</a></li>';
        }
      }
      $strHtmlOutput .= '</ul>';
    }else{
      $strHtmlOutput .= '<ul id="search_list"><li>Sorry, no search result.</li><ul>';
    }

    echo $strHtmlOutput;
  }
}