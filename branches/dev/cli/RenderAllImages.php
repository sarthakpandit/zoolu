<?php
/**
 * include general (autoloader, config)
 */
require_once(dirname(__FILE__).'/../sys_config/general.inc.php');

try{
  /** 
   * @var Image
   */
	$objImage = new Image();  
  
  $objImage->setUploadPath(GLOBAL_ROOT_PATH.$core->sysConfig->upload->images->path->local->private);
  $objImage->setPublicFilePath(GLOBAL_ROOT_PATH.$core->sysConfig->upload->images->path->local->public);
  $objImage->setDefaultImageSizes($core->sysConfig->upload->images->default_sizes->default_size->toArray());  
	
  $core->logger->debug('start render all images ...');
  $objImage->renderAllImages();	
	$core->logger->debug('... finished render all images!');
    
}catch (Exception $exc) {
  $core->logger->err($exc);
  exit();
}
?>