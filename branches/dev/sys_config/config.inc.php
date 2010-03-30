<?php

/**
 * Constants & Settings for the project zoolu
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-05-28: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package
 */

/**
 * include class Zend_Config_Xml
 */
require_once('Zend/Config/Xml.php');

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'staging'));
    
$sysConfig = new Zend_Config_Xml(dirname(__FILE__).'/config.xml', APPLICATION_ENV);
$zooConfig = new Zend_Config_Xml(dirname(__FILE__).'/../application/zoolu/app_config/config.xml', APPLICATION_ENV);
$webConfig = new Zend_Config_Xml(dirname(__FILE__).'/../application/website/app_config/config.xml', APPLICATION_ENV);

/**
 * include class Zend_Registry
 */
require_once('Zend/Registry.php');

Zend_Registry::set('SysConfig', $sysConfig);
Zend_Registry::set('ZooConfig', $zooConfig);
Zend_Registry::set('WebConfig', $webConfig);

/**
 * GLOBAL_ROOT_PATH
 */
define('GLOBAL_ROOT_PATH', dirname(__FILE__).'/../');

/**
 * define MAGIC for finfo (yum install php-pecl-Fileinfo)
 */
define('MAGIC', '/usr/share/misc/magic.mgc');
?>
