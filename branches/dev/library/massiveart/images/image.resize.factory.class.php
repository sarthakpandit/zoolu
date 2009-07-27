<?php
/**
 * Image Resize Factory Class - implementing the Factory Method for Actions
 *
 * Version history (please keep backward compatible):
 * 1.0, 2008-04-01: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.images
 * @subpackage ImageResizeFactory
 */

/**
 * require image resize classes
 */
require_once(dirname(__FILE__).'/image.resize.class.php');


class ImageResizeFactory{
  
  /**
   * Method ImageResizeFactory::getInstanceOf()
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public static function getInstanceOf($strImageName, $arrImageSizes){
    $arrExtension = explode(".", $strImageName);
    
    if(preg_match("/jpg|JPG|jpeg|JPEG/", end($arrExtension)))    {
      return new ImageResizeJpeg($strImageName, $arrImageSizes);      
    }elseif(preg_match("/png|PNG/", end($arrExtension))){
      return new ImageResizePng($strImageName, $arrImageSizes);
    }elseif(preg_match("/gif|GIF/", end($arrExtension))){
      return new ImageResizeGif($strImageName, $arrImageSizes);
    }
  }
}
?>