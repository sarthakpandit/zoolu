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
   * @var Zend_Session_Namespace
   */
  public $objSweepstakeSession;
  
  /**
   * @var Zend_Config_Xml
   */
  protected $sweepstakeConfig;
  
  protected $intSweepstakeId = 0;
  
  protected $strBasePath;
  protected $strSweepstakeFile;
  protected $strFormFile;
  
  protected $arrCurrSweepstake = array();
  
  protected $arrFormData = array();
  protected $arrMailRecipients = array();
  
  private $arrFormFields = array();
  
  protected $blnOnlySweepstake = false;
  protected $intRootLevelId = 0;
  protected $strLanguage = '';
  protected $intSweepstakeCounter = 0;
  
  /**
   * init index controller and get core obj
   */
  public function init(){
    $this->core = Zend_Registry::get('Core');
    $this->sweepstakeConfig = new Zend_Config_Xml(GLOBAL_ROOT_PATH.'/sys_config/sweepstakes.xml', APPLICATION_ENV);
    /**
     * initialize Zend_Session_Namespace
     */
    $this->objSweepstakeSession = new Zend_Session_Namespace('Sweepstake');
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
    $blnShowSweepstake = true;
    
    $intRootLevelId = (($this->_hasParam('rootLevelId')) ? $this->getRequest()->getParam('rootLevelId') : $this->objSweepstakeSession->rootLevelId);
    $strIPAddress = $this->getRequest()->getParam('ipaddress');
    $strLanguage = $this->getRequest()->getParam('language');
    $intSweepstakeCounter = (($this->_hasParam('counter')) ? $this->getRequest()->getParam('counter') : $this->objSweepstakeSession->sweepstakeCounter);
        
    $arrSweepstakes = array();
    $arrSweepstakes = $this->sweepstakeConfig->sweepstakes->sweepstake->toArray();
    
    if(count($arrSweepstakes) > 0){
      $strCountryShort = $this->getCountryShortByIP($strIPAddress);
      $this->objSweepstakeSession->strCountryShort = $strCountryShort;

      foreach($arrSweepstakes as $arrSweepstake){        
        if(array_key_exists('countries', $arrSweepstake)){
          foreach($arrSweepstake['countries'] as $key => $arrCountry){
            if(strtoupper($arrSweepstake['countries'][$key]['code']) === strtoupper($strCountryShort)){                
              $this->intSweepstakeId = $arrSweepstake['id'];
              // write id to session
              $this->objSweepstakeSession->intSweepstakeId = $this->intSweepstakeId;  
              if(array_key_exists('language', $arrSweepstake['countries'][$key])){                  
                $this->strLanguageCode = $arrSweepstake['countries'][$key]['language'];  
              }
              if($strLanguage != ''){
                $this->strLanguageCode = $strLanguage;   
              }            
              $this->arrCurrSweepstake = $arrSweepstake;
              $this->objSweepstakeSession->arrCurrSweepstake = $this->arrCurrSweepstake;
              $this->objSweepstakeSession->strLanguageCode = $this->strLanguageCode;                              
            }    
          }  
        }
      }
      
      if($this->intSweepstakeId > 0 && count($this->arrCurrSweepstake) > 0){          
        $this->strBasePath = $this->arrCurrSweepstake['path'];
        $this->strSweepstakeFile = $this->arrCurrSweepstake['files']['sweepstake'];
        $this->strFormFile = $this->arrCurrSweepstake['files']['form'];
        // write path and file to session
        $this->objSweepstakeSession->strBasePath = $this->strBasePath;          
        $this->objSweepstakeSession->strFormFile = $this->strFormFile;
        
        /**
         * check if portals exists and if the sweepstake should appear in the current portal
         */
        if(array_key_exists('portals', $this->arrCurrSweepstake)){
          $arrPortals = array();
          $arrPortals = $this->arrCurrSweepstake['portals'];            
          if(array_search($intRootLevelId, $arrPortals) === false){
            $blnShowSweepstake = false;  
          }
        }
        
        /**
         * check if period exists and if the sweepstake should appear
         */
        if(array_key_exists('period', $this->arrCurrSweepstake)){
          $arrPeriod = array();
          $arrPeriod = $this->arrCurrSweepstake['period'];            
          $intCurrTime = time();
          
          $intStart = 0;
          if(array_key_exists('start', $arrPeriod)){
            $intStart = strtotime($arrPeriod['start']);  
          }
          $intEnd = 0;
          if(array_key_exists('end', $arrPeriod)){
            $intEnd = strtotime($arrPeriod['end']);  
          }
          
          if((($intStart > 0 && $intEnd > 0) && ($intCurrTime >= $intStart && $intCurrTime <= $intEnd)) || (($intStart > 0 && $intEnd == 0) && $intCurrTime >= $intStart) || (($intEnd > 0 && $intStart == 0) && $intCurrTime <= $intEnd)) {
            // do nothing
          }else{
            $blnShowSweepstake = false;
          }
        }
        
        /**
         * check if mode is live/test
         */
        if(!isset($_SESSION['sesTestMode']) || (isset($_SESSION['sesTestMode']) && $_SESSION['sesTestMode'] == false)){
          if(array_key_exists('mode', $this->arrCurrSweepstake)){
            if($this->arrCurrSweepstake['mode'] == 'test'){
              $blnShowSweepstake = false; 
            } 
          }
        }
        
        /**
         * check appearance counter
         */
        if(array_key_exists('appear_counter', $this->arrCurrSweepstake)){
          if($this->arrCurrSweepstake['appear_counter'] <= $intSweepstakeCounter){
            $blnShowSweepstake = false; 
          } 
        }
        
        /**
         * set up translate obj for sweepstake
         */
        if(isset($this->strLanguageCode) && $this->strLanguageCode != ''){            
          if(file_exists(GLOBAL_ROOT_PATH.'application/website/default/language/website-'.$this->strLanguageCode.'.mo')){
            $this->translate = new HtmlTranslate('gettext', GLOBAL_ROOT_PATH.'application/website/default/language/website-'.$this->strLanguageCode.'.mo');
          }
          $this->view->assign('language', $this->strLanguageCode);
           $this->view->assign('translate', $this->translate);  
        }
        
        
                  
        $this->view->assign('basePath', $this->strBasePath);
        $this->view->assign('file', $this->strSweepstakeFile);
        $this->view->assign('hasAppearCounter', ((array_key_exists('appear_counter', $this->arrCurrSweepstake)) ? true : false));
        
        if($this->objSweepstakeSession->onlySweepstake != null){
          $this->blnOnlySweepstake = $this->objSweepstakeSession->onlySweepstake;
        }
        $this->view->assign('onlySweepstake', $this->blnOnlySweepstake);
        $this->objSweepstakeSession->onlySweepstake = null;
      }else{
        $blnShowSweepstake = false;
      }
    }else{
      $blnShowSweepstake = false;
    }
    
    if(!$blnShowSweepstake){
      $this->_helper->viewRenderer->setNoRender();
      $this->objSweepstakeSession->onlySweepstake = null;  
    }
  }
  
  /**
   * formAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function formAction(){
    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {      
            
      $this->view->assign('basePath', $this->objSweepstakeSession->strBasePath);
      $this->view->assign('form', $this->objSweepstakeSession->strFormFile);
      /**
       * set up translate obj for sweepstake
       */
      if(isset($this->objSweepstakeSession->strLanguageCode) && $this->objSweepstakeSession->strLanguageCode != ''){            
        if(file_exists(GLOBAL_ROOT_PATH.'application/website/default/language/website-'.$this->objSweepstakeSession->strLanguageCode.'.mo')){
          $this->translate = new HtmlTranslate('gettext', GLOBAL_ROOT_PATH.'application/website/default/language/website-'.$this->objSweepstakeSession->strLanguageCode.'.mo');
          
          $this->arrFormFields = array('salutation'         => $this->translate->_('Salutation'),
                                       'title'              => $this->translate->_('Title'),
                                       'fname'              => $this->translate->_('Firstname'),
                                       'sname'              => $this->translate->_('Surname'),
                                       'company'            => $this->translate->_('Company'),
                                       'email'              => $this->translate->_('Email'),
                                       'phone'              => $this->translate->_('Phone'),
                                       'fax'                => $this->translate->_('Fax'),
                                       'function'           => $this->translate->_('Function'),
                                       'type'               => $this->translate->_('Type_of_company'),
                                       'street'             => $this->translate->_('Street'),
                                       'zip'                => $this->translate->_('ZipCode'),
                                       'city'               => $this->translate->_('City'),
                                       'state'              => $this->translate->_('State'),
                                       'country'            => $this->translate->_('Country'),
                                       'checkLegalnotes'    => $this->translate->_('Check_Legalnotes'));
          
          $this->objSweepstakeSession->arrFormFields = $this->arrFormFields;
        }
        $this->view->assign('language', $this->objSweepstakeSession->strLanguageCode);
        $this->view->assign('translate', $this->translate);  
      }
    }  
  }
  
  /**
   * maldivesAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function maldivesAction(){
    $this->_helper->viewRenderer->setNoRender();
    
    $this->objSweepstakeSession->rootLevelId = 1;
    $this->objSweepstakeSession->sweepstakeCounter = 0;
    $this->objSweepstakeSession->onlySweepstake = true;
     
    $this->_forward('check', 'Sweepstake');
  }
  
  /**
   * datareceiverAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function datareceiverAction(){
    if($this->getRequest()->isPost()){
      $this->arrFormData = $this->getRequest()->getPost();

      if(count($this->arrFormData) > 0){
        /**
         * send mail
         */
        $this->sendMail();
      }
    }  
  }
  
  /**
   * sendMail
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  private function sendMail(){
    $arrMail = array();
    $arrFromMail = array();
    $arrFromTo = array();
    
    $mail = new Zend_Mail();
    
    /**
     * config for SMTP with auth
     */
    $config = array('auth'     => 'login',
                    'username' => $this->core->webConfig->mail->params->username,
                    'password' => $this->core->webConfig->mail->params->password);
    
    /**
     * SMTP
     */
    $transport = new Zend_Mail_Transport_Smtp($this->core->webConfig->mail->params->host, $config);
    
    /**
     * standard mail sender and recipients
     */
    if(array_key_exists('mail', $this->objSweepstakeSession->arrCurrSweepstake)){      
      $arrMail = $this->objSweepstakeSession->arrCurrSweepstake['mail'];
      
      $arrFromMail = ((array_key_exists('from', $arrMail)) ? $arrMail['from'] : array());
      $arrFromTo = ((array_key_exists('from', $arrMail)) ? $arrMail['to'] : array());

      $this->arrMailRecipients = array('Name'  => $arrFromTo['name'],
                                       'Email' => $arrFromTo['email']);
      
      if(array_key_exists('mail', $this->objSweepstakeSession->arrCurrSweepstake['countries'][strtolower($this->objSweepstakeSession->strCountryShort)])){
        $arrToMail = $this->objSweepstakeSession->arrCurrSweepstake['countries'][strtolower($this->objSweepstakeSession->strCountryShort)]['mail'];
        
        $this->arrMailRecipients = array('Name'  => $arrToMail['to']['name'],
                                         'Email' => $arrToMail['to']['email']);  
      }
    }
      
    $strHtmlBody = '';     
    if(count($this->arrFormData) > 0){
      $this->arrFormFields = $this->objSweepstakeSession->arrFormFields;
      
      $strHtmlBody = '
        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "DTD/xhtml1-transitional.dtd">
        <html>
        <head>
          <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
          <title></title>
          <style type="text/css">
            body { margin:0; padding:20px; color:#333333; width:100%; height:100%; font-size:12px; font-family:Arial, Sans-Serif; background-color:#ffffff; line-height:16px;}
            h1 { color:#333333; font-weight:bold; font-size:16px; font-family:Arial, Sans-Serif; padding:0; margin: 20px 0 15px 0; }
            h2 { color:#333333; font-weight:bold; font-size:14px; font-family:Arial, Sans-Serif; padding:0; margin: 20px 0 15px 0; }
            h3 { color:#333333; font-weight:bold; font-size:12px; font-family:Arial, Sans-Serif; padding:0; margin: 20px 0 15px 0; }
            a { color:#000; font-size:12px; text-decoration:underline; margin:0; padding:0; }
            a:hover { color:#000; font-size:12px; text-decoration:none; margin:0; padding:0; }
            p { margin:0 0 16px 0; padding:0;}
          </style>
        </head>
        <body>        
           <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr>
                 <td>
                  <h1>'.$arrMail['title'].'</h1>
                  <p>'.$arrMail['intro'].'</p>';
      foreach($this->arrFormData as $key => $value){
        if($value != ''){         
          $strHtmlBody .= '<strong>'.((array_key_exists($key, $this->arrFormFields)) ? $this->arrFormFields[$key] : ucfirst(utf8_decode($key))).':</strong> '.utf8_decode($value).'<br/>';  
        }          
      }   
      $strHtmlBody .= '
                </td>
              </tr>
           </table>
        </body>
        </html>';
    }

    /**
     * set mail subject
     */
    $mail->setSubject($arrMail['subject']);
    /**
     * set html body
     */
    $mail->setBodyHtml($strHtmlBody);
    /**
     * set default FROM address
     */
    $mail->setFrom($arrFromMail['email'], $arrFromMail['name']);
      
    if(count($this->arrMailRecipients) > 0){
      $mail->clearRecipients();
      $mail->addTo($this->arrMailRecipients['Email'], $this->arrMailRecipients['Name']);
      /**
       * send mail if mail body is not empty
       */
      if($strHtmlBody != ''){
        $mail->send($transport);
      } 
    }
  } 
  
  /**
   * sessionAction
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function sessionAction(){
    if($this->getRequest()->isPost() && $this->getRequest()->isXmlHttpRequest()) {
      $strValue = $this->getRequest()->getParam('value');
      $strSessionName = $this->getRequest()->getParam('session');
      $this->objSweepstakeSession->$strSessionName = $strValue;
      echo 'true';
    }else{
      echo 'false';
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
      $this->core->logger->debug('IP2Location->getCountryShort: ip - '.$ipAddress.' / '.$countryShort);
      
      return $countryShort;
    }
  }
 
}
?>