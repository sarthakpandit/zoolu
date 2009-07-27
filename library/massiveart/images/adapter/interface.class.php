<?php

/**
 * ImageAdapterInterface
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-05-14: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.images
 * @subpackage ImageAdapterInterface
 */

interface ImageAdapterInterface {

  /**
   * setSource
   * @param string $strSourceFile
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  function setSource($strSourceFile);

  /**
   * getSource
   * @param string $strSourceFile
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  function getSource();

  /**
   * resize
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function resize($intWidth, $intHeight = 0, $blnExactDimentions = false);

  /**
   * crop
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function crop($intWidth, $intHeight, $intTop = 0, $intLeft = 0, $strGravity = 'center');

  /**
   * scale
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function scale($intWidth, $intHeight);

/*
  /**
   * roundCorners
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function roundCorners();

  /**
   * rotate
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function rotate();

  /**
   * flipHorizontal
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function flipHorizontal();

  /**
   * flipVertical
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function flipVertical();

  /**
   * grayscale
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function grayscale();

  /**
   * brighten
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function brighten();

  /**
   * brighten
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function darken();

  /**
   * shadow
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function shadow();

  /**
   * fakePolaroid
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function fakePolaroid();

  /**
   * polaroid
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function polaroid();

  /**
   * invert
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function invert();

  /**
   * watermark
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   *
  public function watermark();
*/
}

?>