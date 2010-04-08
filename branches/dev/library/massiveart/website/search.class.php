<?php

/**
 * Search
 *
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-09: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.website
 * @subpackage Search
 */

class Search {

  /**
   * @var Core
   */
  protected $core;

  const FIELD_TYPE_NONE = 1;
  const FIELD_TYPE_KEYWORD = 2;
  const FIELD_TYPE_UNINDEXED = 3;
  const FIELD_TYPE_BINARY = 4;
  const FIELD_TYPE_TEXT = 5;
  const FIELD_TYPE_UNSTORED = 6;

  /**
   * @var string
   */
  protected $strSearchValue;

  /**
   * @var integer
   */
  protected $intLimitSearch;

  /**
   * @var integer
   */
  protected $intLimitLiveSearch;

  /**
   * Constructor
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }

  /**
   * search
   * @return object $objHits
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function search(){
    $this->core->logger->debug('massiveart->website->search->search()');

    if($this->strSearchValue != '' && count(scandir(GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->page)) > 2){
      if($this->intLimitSearch > 0 && $this->intLimitSearch != ''){
        Zend_Search_Lucene::setResultSetLimit($this->intLimitSearch);
      }
      $objIndex = Zend_Search_Lucene::open(GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->page);
      $strQuery = '';
      if(strlen($this->strSearchValue) < 3){
        $strQuery = $this->strSearchValue;
      }else{
        $strQuery = $this->strSearchValue.'*';
      }
      $objHits = $objIndex->find($strQuery);
    }
    return $objHits;
  }

  /**
   * livesearch
   * @return object $objHits
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function livesearch(){
    $this->core->logger->debug('massiveart->website->search->livesearch()');

    if(count(scandir(GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->page)) > 2){
      $objHits = $this->findByPath(GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->page);
    }
    
    if(count(scandir(GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->global)) > 2){
      $objGlobalHits = $this->findByPath(GLOBAL_ROOT_PATH.$this->core->sysConfig->path->search_index->global);
      $objHits = array_merge($objHits, $objGlobalHits);
      array_multisort($objHits);
    }    
    
    return $objHits;
  }
  
  /**
   * findByPath
   * @param string $strIndexPath
   * @return Zend_Search_Lucene_Search_QueryHit
   */
  private function findByPath($strIndexPath){
    if($this->intLimitLiveSearch > 0 && $this->intLimitLiveSearch != ''){
      Zend_Search_Lucene::setResultSetLimit($this->intLimitLiveSearch);
    }
    $objIndex = Zend_Search_Lucene::open($strIndexPath);
    $strQuery = '';
    if(strlen($this->strSearchValue) < 3){
      $strQuery = $this->strSearchValue;
    }else{
      $arrSearchValue = split(' ',  $this->strSearchValue);
      foreach($arrSearchValue as $strSearchValue){
        if(strlen($strSearchValue) < 3 || preg_match('/([^A-za-z0-9\s-_])/', $strSearchValue)){
          $strQuery .= 'title:'.$strSearchValue.' OR articletitle:'.$strSearchValue.' OR';
        }else{
          $strQuery .= 'title:'.$strSearchValue.'* OR articletitle:'.$strSearchValue.'* OR';
        }
      }
      $strQuery = trim($strQuery, ' OR');
    }
    
    $strQuery = '(languageId:'.$this->core->intLanguageId.') AND ('.$strQuery.')';
    $this->core->logger->debug($strQuery);
    $objQuery = Zend_Search_Lucene_Search_QueryParser::parse($strQuery, $this->core->sysConfig->encoding->default);
    
    return $objIndex->find($objQuery);
  }

  /**
   * setSearchValue
   * @param string $strSearchValue
   */
  public function setSearchValue($strSearchValue){
    $this->strSearchValue = $strSearchValue;
  }

  /**
   * getSearchValue
   * @return string $strSearchValue
   */
  public function getSearchValue(){
    return $this->strSearchValue;
  }

  /**
   * setLimitSearch
   * @param integer $intLimitSearch
   */
  public function setLimitSearch($intLimitSearch){
    $this->intLimitSearch = $intLimitSearch;
  }

  /**
   * getLimitSearch
   * @return integer $intLimitSearch
   */
  public function getLimitSearch(){
    return $this->intLimitSearch;
  }

  /**
   * setLimitLiveSearch
   * @param integer $intLimitLiveSearch
   */
  public function setLimitLiveSearch($intLimitLiveSearch){
    $this->intLimitLiveSearch = $intLimitLiveSearch;
  }

  /**
   * getLimitLiveSearch
   * @return integer $intLimitLiveSearch
   */
  public function getLimitLiveSearch(){
    return $this->intLimitLiveSearch;
  }
}
?>