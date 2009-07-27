<?php

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
	 * @var GuiTexts
	 */
  public $guiTexts;

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
    if(isset($_SESSION["sesUserName"]) && isset($_SERVER['REMOTE_ADDR'])){
      $strLogFileExtension = $_SESSION["sesUserName"].'_'.$_SERVER['REMOTE_ADDR'];
    }else
    if(isset($_SERVER['REMOTE_ADDR'])){
      $strLogFileExtension = $_SERVER['REMOTE_ADDR'];
    }else{
      $strLogFileExtension = 'local';
    }

    /**
     * create log file writer
     */
    $writer = new Zend_Log_Writer_Stream(GLOBAL_ROOT_PATH.$this->sysConfig->logger->path.'log_'.date('Ymd').'_'.$strLogFileExtension.'.log');
    $this->logger->addWriter($writer);

    /**
     * set log priority
     */
    $filter = new Zend_Log_Filter_Priority((int) $this->sysConfig->logger->priority);
    $this->logger->addFilter($filter);

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

      //$this->initGuiTexts();
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

  /**
   * initGuiTexts
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function initGuiTexts($blnGuiTextsClassSession = true){

    /**
     * initialize the guiTexts object && the security object
     */
    try {
      //$this->guiTexts = GuiTexts::getInstance($this->logger, $this->dbh);

      if(GUI_TEXTS_CLASS_SESSION == true && $blnGuiTextsClassSession == true){
        if(isset($_SESSION['sesGuiTextsObject'])){
          $this->logger->debug('load guiTexts object from session');
          $this->guiTexts = unserialize($_SESSION['sesGuiTextsObject']);
        }else{
          $this->logger->debug('load guiTexts object from engine db and write to the session');
          $this->guiTexts = GuiTexts::getInstance($this->logger);
          $_SESSION['sesGuiTextsObject'] = serialize($this->guiTexts);
        }
      }else{
        $this->logger->debug('load guiTexts object from engine db');
        $this->guiTexts = GuiTexts::getInstance($this->logger);
      }
    } catch (Exception $exc) {
       $this->logger->err($exc);
    }
  }

}
?>