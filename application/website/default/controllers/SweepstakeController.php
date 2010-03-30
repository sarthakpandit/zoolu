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
 * @package    application.website.default.controllers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * SweepstakeController
 *
 * Version history (please keep backward compatible):
 * 1.0, 2010-03-30: Cornelius Hansjakob

 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

require_once(GLOBAL_ROOT_PATH.'/library/IP2Location/ip2location.class.php');

class SweepstakeController extends Zend_Controller_Action {

  /**
   * @var Core
   */
  private $core;   

  /**
   * @var integer
   */
  private $intLanguageId;

  /**
   * @var string
   */
  private $strLanguageCode;

  /**
   * @var HtmlTranslate
   */
  private $translate;
  
  /**
   * @var Zend_Config_Xml
   */
  protected $sweepstakeConfig;
  
  protected $intSweepstakeId = 0;
  
  protected $strBasePath;
  protected $strSweepstakeFile;
  protected $strFormFile;
  
  /**
   * init index controller and get core obj
   */
  public function init(){
    $this->core = Zend_Registry::get('Core');
    $this->sweepstakeConfig = new Zend_Config_Xml(GLOBAL_ROOT_PATH.'/sys_config/sweepstakes.xml', APPLICATION_ENV);
  }  

  /**
	 * indexAction
	 * @author Cornelius Hansjakob <cha@massiveart.com>
	 * @version 1.0
	 */
  public function indexAction(){ 
    $this->_helper->viewRenderer->setNoRender();    
  }

  /**
   * checkAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function checkAction(){
    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
      $arrSweepstakes = array();
      $arrSweepstakes = $this->sweepstakeConfig->sweepstakes->sweepstake->toArray();
      
      $arrCurrSweepstake = array();
      
      if(count($arrSweepstakes) > 0){
        $strCountryShort = $this->getCountryShortByIP();

        foreach($arrSweepstakes as $arrSweepstake){        
          if(array_key_exists('countries', $arrSweepstake)){
            foreach($arrSweepstake['countries'] as $key => $arrCountry){
              if(strtoupper($arrSweepstake['countries'][$key]['code']) === strtoupper($strCountryShort)){                
                $this->intSweepstakeId = $arrSweepstake['id']; 
                if(array_key_exists('language', $arrSweepstake['countries'][$key])){
                  $this->strLanguageCode = $arrSweepstake['countries'][$key]['language'];  
                }
                $arrCurrSweepstake = $arrSweepstake;
                unset($arrCurrSweepstake['countries']);                             
              }    
            }  
          }
        }
        
        if($this->intSweepstakeId > 0 && count($arrCurrSweepstake) > 0){          
          $this->strBasePath = $arrSweepstake['path'];
          $this->strSweepstakeFile = $arrSweepstake['files']['sweepstake'];
          $this->strFormFile = $arrSweepstake['files']['form']; 
          
          /**
           * check if portals exists and if the sweepstake should appear in the current portal
           */
          if(array_key_exists('portals', $arrCurrSweepstake)){
            $arrPortals = array();
            $arrPortals = $arrCurrSweepstake['portals'];
            
            // TODO : Portal validation  
          }
          
          /**
           * check if period exists and if the sweepstake should appear
           */
          if(array_key_exists('period', $arrCurrSweepstake)){
            $arrPeriod = array();
            $arrPeriod = $arrCurrSweepstake['period'];            
            $intCurrTime = time();
            
            $intStart = 0;
            if(array_key_exists('start', $arrPeriod)){
              $intStart = strtotime($arrPeriod['start']);  
            }
            $intEnd = 0;
            if(array_key_exists('end', $arrPeriod)){
              $intEnd = strtotime($arrPeriod['start']);  
            }
            
            if((($intStart > 0 && $intEnd > 0) && ($intCurrTime >= $intStart && $intCurrTime <= $intEnd)) 
                  || (($intStart > 0 && $intEnd == 0) && $intCurrTime >= $intStart) 
                  || (($intEnd > 0 && $intStart == 0) && $intCurrTime <= $intEnd)) {
              
            }else{
              // don't show the sweepstake
            }
          }else{
            // no period - manual switching sweepstake online/offline
          }
        }
        
      }else{
        // No sweepstake available
      }
    }
    $this->_helper->viewRenderer->setNoRender();
  }
  
  /**
   * getCountryShortByIP
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  private function getCountryShortByIP($strIPAddress = ''){
    if(file_exists(GLOBAL_ROOT_PATH.'library/IP2Location/IP-COUNTRY.BIN')){      
      
      $ip = new ip2location;
      $ip->open(GLOBAL_ROOT_PATH.'library/IP2Location/IP-COUNTRY.BIN');
      
      $ipAddress = ((strpos($_SERVER['HTTP_HOST'], 'area51') === false) ? $_SERVER['REMOTE_ADDR'] : '84.72.245.26');
      if($strIPAddress != ''){
        $ipAddress = $strIPAddress;
      }
      $countryShort = $ip->getCountryShort($ipAddress);
      
      return $countryShort;
    }
  }
 
}
?>