<?php

/**
 * ImageManipulation
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-05-14: Cornelius Hansjakob
 *
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.images
 * @subpackage ImageManipulation
 */

class ImageManipulation {

	/**
   * @var Core
   */
  protected $core;

	/**
   * @var ImageAdapterInterface
   */
	protected $objAdapter;

	/**
   * @var Zend_Loader_PluginLoader_Interface
   */
  protected static $objAdapterLoader;

  /**
   * @var string
   */
  protected $strAdapterType;

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
    $this->core = Zend_Registry::get('Core');
  }

  /**
   * getAdapter
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getAdapter(){
    try{
      if(!$this->objAdapter instanceof ImageAdapterInterface){

        try {
          $class = $this->getAdapterLoader()->load($this->strAdapterType);
        } catch (Zend_Loader_PluginLoader_Exception $e) {
          throw new Exception('Image Manipulation Adapter by type ' . $this->strAdapterType . ' not found');
        }

        $this->objAdapter = new $class();

        if (!$this->objAdapter instanceof ImageAdapterInterface) {
            throw new Exception('Image Manipulation Adapter type ' . $this->strAdapterType . ' -> class ' . $class . ' is not of type ImageAdapterInterface');
        }
      }
      return $this->objAdapter;
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * getAdapterLoader
   * @return Zend_Loader_PluginLoader
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public static function getAdapterLoader(){
    if(null === self::$objAdapterLoader){
      require_once 'Zend/Loader/PluginLoader.php';
      self::$objAdapterLoader = new Zend_Loader_PluginLoader(array(
          'ImageAdapter' => dirname(__FILE__).'/adapter/',
      ));
    }
    return self::$objAdapterLoader;
  }

  /**
   * setAdapterType
   * @param string $strAdapterType
   */
  public function setAdapterType($strAdapterType){
    $this->strAdapterType = $strAdapterType;
  }

  /**
   * getAdapterType
   * @param string $strAdapterType
   */
  public function getAdapterType(){
    return $this->strAdapterType;
  }
}

?>