<?php

/**
 * Client_Dispatcher
 *
 * Ivoclar Vivadent Dispater
 * 
 * on pre dispatch make IP based redirecting
 * 
 * on post dispatch update body fontSize from the session if exists
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2010-04-22: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package client.plugins
 * @subpackage Client_Dispatcher
 */

require_once(GLOBAL_ROOT_PATH.'/library/IP2Location/ip2location.class.php');

class Client_Dispatcher implements ClientHelperInterface  {

  /**
   * @var Core
   */
  protected $core;
  
  /**
   * __construct
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function __construct() {
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * preDispatch
   * @param $objController Zend_Controller_Action
   * @return void
   */
  public function preDispatch($objController){
    $objWebSession = new Zend_Session_Namespace('Website');    
    
    $strCountryShort = strtoupper($this->getCountryShortByIP($objController->getRequest()->getParam('ip')));
    $this->core->objCoreSession->countryshort = (($strCountryShort != '') ? $strCountryShort : null);
    
    if($objController->getRequest()->getParam('re', 'true') == 'true' && !isset($objWebSession->redirect) && strpos('http://www.ivoclarvivadent.com/', parse_url($_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'], PHP_URL_PATH)) !== false){
      $objWebSession->redirect = true; // redirect only for the first time
      
      $strCountryShort = strtoupper($this->getCountryShortByIP($objController->getRequest()->getParam('ip')));
      $strContinentShort = $this->getContinentShortByCountryShort($strCountryShort);
      
      /**
       * redirects
       * 
       * AF = Africa
       * AN = Antarctica
       * AS = Asia
       * EU = Europe
       * ME = Middle & Near East
       * NA = North America
       * OC = Oceania
       * SA = South America       
       */
      $strRedirectUrl = 'http://www.ivoclarvivadent.com';
      switch($strContinentShort){
        case 'NA':
          if($strCountryShort == 'CA' || $strCountryShort == 'US') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.us';          
          else if($strCountryShort == 'MX') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.com.mx';
          else
            $strRedirectUrl = 'http://www.ivoclarvivadent.com/en/';
          break;
        case 'SA':
          if($strCountryShort == 'CO') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.com/es/';
          else if($strCountryShort == 'BR') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.com.br';
          else
            $strRedirectUrl = 'http://www.ivoclarvivadent.com/es/';
          break;
        case 'EU':
          if($strCountryShort == 'DE') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.de';
          else if($strCountryShort == 'IT') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.it';
          else if($strCountryShort == 'RU') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.ru';
          else if($strCountryShort == 'ES') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.es';
          else if($strCountryShort == 'SE' || $strCountryShort == 'NO' || $strCountryShort == 'DK' || $strCountryShort == 'FI') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.se';
          else if($strCountryShort == 'PL') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.pl';
          else
            $strRedirectUrl = 'http://www.ivoclarvivadent.com/en/';
          break;
        case 'AF':
          $strRedirectUrl = 'http://www.ivoclarvivadent.com/en/';
          break;
        case 'ME':
          $strRedirectUrl = 'http://icubus.ivoclarvivadent.com/?portal=me&re=false';
          break;
        case 'AS':
          if($strCountryShort == 'JP') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.jp';
          else
            $strRedirectUrl = 'http://icubus.ivoclarvivadent.com/?portal=as&re=false';
          break;
        case 'OC':
          if($strCountryShort == 'AU') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.com.au';
          else if($strCountryShort == 'NZ') 
            $strRedirectUrl = 'http://www.ivoclarvivadent.co.nz';
          else
            $strRedirectUrl = 'http://icubus.ivoclarvivadent.com/en/';
          break;          
      }
      
      if(strpos('http://'.$_SERVER['SERVER_NAME'].$_SERVER['REQUEST_URI'], $strRedirectUrl) === false){
        // clean the output buffer
        ob_clean();
        header('Location: '.$strRedirectUrl);
      }
    }
  }
  
  /**
   * getCountryShortByIP
   * @param string $strIPAddress
   * @return string
   */
  private function getCountryShortByIP($strIPAddress = ''){
    if(file_exists(GLOBAL_ROOT_PATH.'library/IP2Location/IP-COUNTRY.BIN')){      
      
      $ip = new ip2location();
      $ip->open(GLOBAL_ROOT_PATH.'library/IP2Location/IP-COUNTRY.BIN');
      
      $ipAddress = ((strpos($_SERVER['HTTP_HOST'], 'area51') === false) ? $_SERVER['REMOTE_ADDR'] : '84.72.245.26');
      if($strIPAddress != ''){
        $ipAddress = $strIPAddress;
      }
      $countryShort = $ip->getCountryShort($ipAddress);
      
      return $countryShort;
    }
  }
  
  /**
   * 
   * @param string $strCountryShort
   * @return string
   */
  private function getContinentShortByCountryShort($strCountryShort){
    $objSelect = $this->core->dbh->select();
    $objSelect->from('countries', 'continentCode')
              ->where('countries.isoCode2 = ?', $strCountryShort);    
    return $this->core->dbh->fetchOne($objSelect);
  }
  
  /**
   * postDispatch
   * @param $objController Zend_Controller_Action
   * @return void
   */
  public function postDispatch($objController){ 
    $objWebSession = new Zend_Session_Namespace('Website');
    if(isset($objWebSession->fontSize) && $objWebSession->fontSize != ''){
      $objController->getResponse()->setBody(preg_replace('/\$\(\'body\'\)\.style\.fontSize = \'(\d{2})px\';/', '$(\'body\').style.fontSize = \''.$objWebSession->fontSize.'\';', $objController->getResponse()->getBody()));
    }      
  }
}