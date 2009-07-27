<?php
/**
 * include general (autoloader, config)
 */
require_once(dirname(__FILE__).'/../sys_config/general.inc.php');

try{
  $objConsoleOpts = new Zend_Console_Getopt(
      array(
          'pageId|p=s'      => 'Page Id',
          'version|v=i'     => 'Page Version',
          'languageId|l=i'  => 'Language Id',
      )
  );
  
  if(isset($objConsoleOpts->pageId) && isset($objConsoleOpts->version) && isset($objConsoleOpts->languageId)){
    $objIndex = new Index();
    $core->logger->debug('index page now ...');
    $objIndex->indexPage($objConsoleOpts->pageId, $objConsoleOpts->version, $objConsoleOpts->languageId);
    $core->logger->debug('... finished!');
  }
    
}catch (Exception $exc) {
  $core->logger->err($exc);
  exit();
}
?>