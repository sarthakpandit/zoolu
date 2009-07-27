<?php

/**
 * ImageAdapter_Gd2
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-05-14: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.images
 * @subpackage ImageAdapter_Gd2
 */

require_once(dirname(__FILE__).'/interface.class.php');

class ImageAdapter_Gd2 implements ImageAdapterInterface {

  /**
   * @var string
   */
  protected $strSourceFile;

  /**
   * Constructor
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function __construct($strSourceFile = ''){
    $this->strSourceFile = $strSourceFile;
  }

  /**
   * resize
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function resize(){

  }

  /**
   * crop
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function crop(){

  }

  /**
   * scale
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function scale(){

  }

  /**
   * roundCorners
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function roundCorners(){

  }

  /**
   * rotate
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function rotate(){

  }

  /**
   * flipHorizontal
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function flipHorizontal(){

  }

  /**
   * flipVertical
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function flipVertical(){

  }

  /**
   * grayscale
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function grayscale(){

  }

  /**
   * brighten
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function brighten(){

  }

  /**
   * brighten
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function darken(){

  }

  /**
   * shadow
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function shadow(){

  }

  /**
   * fakePolaroid
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function fakePolaroid(){

  }

  /**
   * polaroid
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function polaroid(){

  }

  /**
   * invert
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function invert(){

  }

  /**
   * watermark
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function watermark(){

  }

}

?>