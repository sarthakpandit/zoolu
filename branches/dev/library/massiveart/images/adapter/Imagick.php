<?php

/**
 * ImageAdapter_Imagick
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-05-14: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.images
 * @subpackage ImageAdapter_Imagick
 */

require_once(dirname(__FILE__).'/interface.class.php');

class ImageAdapter_Imagick extends phMagick implements ImageAdapterInterface {

  protected $intRawWidth;
  protected $intRawHeight;

  /**
   * Constructor
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function __construct($strSourceFile = ''){
    parent::__construct($strSourceFile);
  }

  /**
   * scale
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function scale($intWidth, $intHeight){

    if($this->intRawWidth == null || $this->intRawHeight == null){
      $arrDimention = $this->getDimentions();
      $this->setRawHeight($arrDimention[0]);
      $this->setRawWidth($arrDimention[1]);
    }

    $dblXFact = $this->intRawWidth / $intWidth;
    $dblYFact = $this->intRawHeight / $intHeight;


    if($dblXFact < $dblYFact){
      $this->resize($intWidth);
    }else{
      $this->resize('', $intHeight);
    }

    $this->crop($intWidth, $intHeight);
  }

  /**
   * grayscale
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function grayscale(){
    parent::toGrayScale();
  }

  /**
   * shadow
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function shadow(){
    parent::dropShaddow();
  }

  /**
   * invert
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function invert(){
    parent::invertColors();
  }

  /**
   * setRawWidth
   * @param integer $intRawWidth
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function setRawWidth($intRawWidth){
    $this->intRawWidth = $intRawWidth;
  }

  /**
   * setRawHeight
   * @param integer $intRawHeight
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function setRawHeight($intRawHeight){
    $this->intRawHeight = $intRawHeight;
  }
}

?>