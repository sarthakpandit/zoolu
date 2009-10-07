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
  public $modConfig;
  public $webConfig;

  /**
   * @var HtmlTranslate
   */
  public $translate;

  /**
   * Constructor
   */
  protected function __construct($blnWithDbh = true, Zend_Config_Xml &$sysConfig, Zend_Config_Xml &$modConfig, Zend_Config_Xml &$webConfig){
    /**
     * set sys config object
     */
    $this->sysConfig = $sysConfig;

    /**
     * set modules config object
     */
    $this->modConfig = $modConfig;

    /**
     * set website config object
     */
    $this->webConfig = $webConfig;

    /**
     * initialize Zend_Log
     */
    $this->logger = new Zend_Log();

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
  public static function getInstance($blnWithDbh = true, Zend_Config_Xml &$sysConfig, Zend_Config_Xml &$modConfig, Zend_Config_Xml &$webConfig){
    if(self::$instance == null){
      self::$instance = new Core($blnWithDbh, $sysConfig, $modConfig, $webConfig);
    }
    return self::$instance;
  }
}
?>