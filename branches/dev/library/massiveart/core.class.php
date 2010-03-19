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
 * @package    library.massiveart
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Core Class - based on Singleton Pattern
 *
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-10-09: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart
 * @subpackage Core
 */

class Core {

  /**
   * object instance
   */
  private static $instance = null;

  /**
	 * @var Zend_Db_Adapter_Abstract
	 */
  public $dbh;

  /**
	 * @var Zend_Log
	 */
  public $logger;

  /**
	 * @var Zend_Config_Xml
	 */
  public $sysConfig;
  public $zooConfig;
  public $webConfig;

  /**
   * @var HtmlTranslate
   */
  public $translate;
  
  /**
   * @var Zend_Session_Namespace
   */
  public $objCoreSession;
  
  /**
   * @var integer
   */
  public $intLanguageId;

  /**
   * @var string
   */
  public $strLanguageCode;

  /**
   * Constructor
   */
  protected function __construct($blnWithDbh = true, Zend_Config_Xml &$sysConfig, Zend_Config_Xml &$zooConfig, Zend_Config_Xml &$webConfig){
    /**
     * set sys config object
     */
    $this->sysConfig = $sysConfig;

    /**
     * set modules config object
     */
    $this->zooConfig = $zooConfig;

    /**
     * set website config object
     */
    $this->webConfig = $webConfig;

    /**
     * initialize Zend_Log
     */
    $this->logger = new Zend_Log();
    
    /**
     * initialize Zend_Session_Namespace
     */
    $this->objCoreSession = new Zend_Session_Namespace('Core');
    
    /**
     * get language and set translate object
     */
    if(isset($_GET['language'])){
      $this->strLanguageCode = trim($_GET['language'], '/');
      foreach($this->webConfig->languages->language->toArray() as $arrLanguage){
        if(array_key_exists('code', $arrLanguage) && $arrLanguage['code'] == strtolower($this->strLanguageCode)){
          $this->intLanguageId = $arrLanguage['id'];
          break;
        }
      }
      if($this->intLanguageId == null){
        $this->intLanguageId = $this->sysConfig->languages->default->id;
        $this->strLanguageCode = $this->sysConfig->languages->default->code;
      }
    }else if(isset($_SERVER['REQUEST_URI']) && preg_match('/^\/[a-zA-Z\-]{2,5}\//', $_SERVER['REQUEST_URI'])){
      preg_match('/^\/[a-zA-Z\-]{2,5}\//', $_SERVER['REQUEST_URI'], $arrMatches);
      $this->strLanguageCode = trim($arrMatches[0], '/');
      foreach($this->webConfig->languages->language->toArray() as $arrLanguage){
        if(array_key_exists('code', $arrLanguage) && $arrLanguage['code'] == strtolower($this->strLanguageCode)){
          $this->intLanguageId = $arrLanguage['id'];
          break;
        }
      }
      if($this->intLanguageId == null){
        $this->intLanguageId = $this->sysConfig->languages->default->id;
        $this->strLanguageCode = $this->sysConfig->languages->default->code;
      }
    }else if(isset($this->objCoreSession->languageId)){
      $this->intLanguageId = $this->objCoreSession->languageId;
      $this->strLanguageCode = $this->objCoreSession->languageCode;
    }else if(file_exists(GLOBAL_ROOT_PATH.'/library/IP2Location/IP-COUNTRY.BIN')){

      require_once(GLOBAL_ROOT_PATH.'/library/IP2Location/IP2Location.inc.php');
      $ip = IP2Location_open(GLOBAL_ROOT_PATH.'/library/IP2Location/IP-COUNTRY.BIN', IP2LOCATION_STANDARD);
      $record = IP2Location_get_all($ip, $_SERVER['REMOTE_ADDR']);

      if($record->country_short == 'DE' || $record->country_short == 'AT' || $record->country_short == 'CH' || $record->country_short == 'FL'){
        $this->intLanguageId = $this->sysConfig->languages->language->de->id;
        $this->strLanguageCode = $this->sysConfig->languages->language->de->code;
      }else{
        $this->intLanguageId = $this->sysConfig->languages->language->en->id;
        $this->strLanguageCode = $this->sysConfig->languages->language->en->code;
      }
      IP2Location_close($ip);
    }else{
      $this->intLanguageId = $this->sysConfig->languages->default->id;
      $this->strLanguageCode = $this->sysConfig->languages->default->code;
    }    
        
    /**
     * set up zoolu translate obj
     */
    if(file_exists(GLOBAL_ROOT_PATH.'application/zoolu/language/zoolu-'.$this->strLanguageCode.'.mo')){
      $this->translate = new HtmlTranslate('gettext', GLOBAL_ROOT_PATH.'application/zoolu/language/zoolu-'.$this->strLanguageCode.'.mo');  
    }else{
      $this->translate = new HtmlTranslate('gettext', GLOBAL_ROOT_PATH.'application/zoolu/language/zoolu-'.$this->sysConfig->languages->default->code.'.mo');
    }
    
    /**
     * write language to session
     */
    $this->objCoreSession->languageId = $this->intLanguageId;
    $this->objCoreSession->languageCode = $this->strLanguageCode;

    /**
     * create logfile extension for file writer
     */
    $strLogFileExtension = '';
    if($this->sysConfig->logger->priority > Zend_Log::ERR){
      if(isset($_SESSION["sesUserName"]) && isset($_SERVER['REMOTE_ADDR'])){
        $strLogFileExtension = '_'.$_SESSION["sesUserName"].'_'.$_SERVER['REMOTE_ADDR'];
      }else
      if(isset($_SERVER['REMOTE_ADDR'])){
        $strLogFileExtension = '_'.$_SERVER['REMOTE_ADDR'];
      }else{
        $strLogFileExtension = '_local';
      }
    }

    /**
     * create log file writer
     */
    $writer = new Zend_Log_Writer_Stream(GLOBAL_ROOT_PATH.$this->sysConfig->logger->path.'log_'.date('Ymd').$strLogFileExtension.'.log');
    $this->logger->addWriter($writer);

    /**
     * set log priority
     */
    $filter = new Zend_Log_Filter_Priority((int) $this->sysConfig->logger->priority);
    $this->logger->addFilter($filter);

    /**
     * set up zoolu translate obj
     */
    $this->translate = new HtmlTranslate('gettext', GLOBAL_ROOT_PATH.'application/zoolu/language/zoolu-de.mo', 'de');


    if($blnWithDbh == true){
      /**
       * initialize the ZEND DB Connection
       * do lazy connection binding, so db connection will be established on first use with dbh->getConnection()
       */
      try {

        $pdoParams = array(
          PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
          PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true
        );

      	$dbhParameters = array(
          'host'             => $this->sysConfig->database->params->host,
    			'username'         => $this->sysConfig->database->params->username,
    			'password'         => $this->sysConfig->database->params->password,
    			'dbname'           => $this->sysConfig->database->params->dbname,
      		'driver_options'   => $pdoParams
    		);

       	$this->dbh = Zend_Db::factory($this->sysConfig->database->adapter, $dbhParameters);

       	if($this->sysConfig->logger->priority == Zend_Log::DEBUG) $this->dbh->getProfiler()->setEnabled(true);

       	$this->dbh->getConnection();

       	$this->dbh->exec('SET CHARACTER SET '.$this->sysConfig->encoding->db);
       	
       	Zend_Db_Table::setDefaultAdapter($this->dbh);

       	/**
       	 * using a default metadata cache for all table objects
       	 *
       	 * set up the cache
       	 */
        $arrFrontendOptions = array(
          'automatic_serialization' => true
        );

        /**
         * memcache server configuration
         */
        $arrServer = array(
          'host' => Zend_Cache_Backend_Memcached::DEFAULT_HOST,
          'port' => Zend_Cache_Backend_Memcached::DEFAULT_PORT,
          'persistent' => Zend_Cache_Backend_Memcached::DEFAULT_PERSISTENT
        );

        $arrBackendOptions  = array(
          'cache_dir' => GLOBAL_ROOT_PATH.$this->sysConfig->path->cache->tables // Directory where to put the cache files
          //'server' => $arrServer
        );

        $objCache = Zend_Cache::factory('Core',
                                        'File',//Memcached
                                        $arrFrontendOptions,
                                        $arrBackendOptions);

        /**
         * set the cache to be used with all table objects
         */
        Zend_Db_Table_Abstract::setDefaultMetadataCache($objCache);

      } catch (Zend_Db_Adapter_Exception $exc) {
        $this->logger->err($exc);
        header ('Location: http://'.$this->sysConfig->hostname);
        die();
      } catch (Zend_Exception $exc) {
        $this->logger->err($exc);
        header ('Location: http://'.$this->sysConfig->hostname);
        die();
      }

    }
  }

  private function __clone(){}

  /**
   * getInstance
   * @return object instance of the class
   */
  public static function getInstance($blnWithDbh = true, Zend_Config_Xml &$sysConfig, Zend_Config_Xml &$zooConfig, Zend_Config_Xml &$webConfig){
    if(self::$instance == null){
      self::$instance = new Core($blnWithDbh, $sysConfig, $zooConfig, $webConfig);
    }
    return self::$instance;
  }
}
?>