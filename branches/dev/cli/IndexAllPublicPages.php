<?php
/**
 * include general (autoloader, config)
 */
require_once(dirname(__FILE__).'/../sys_config/general.inc.php');

try{
  $objIndex = new Index();
  $objIndex->indexAllPublicPages();
    
}catch (Exception $exc) {
  $core->logger->err($exc);
  exit();
}
?>