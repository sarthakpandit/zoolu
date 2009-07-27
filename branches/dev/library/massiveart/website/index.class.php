<?php

/**
 * Index
 * 
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-15: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.website
 * @subpackage Index
 */

class Index {
   
  /**
   * @var Core
   */
  protected $core;
  
  /**
   * @var Model_Pages
   */
  private $objModelPages;
    
  /**
   * Constructor
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * getModelPages
   * @param string $strPageId
   * @param integer $intPageVersion
   * @param integer $intLanguageId
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function indexPage($strPageId, $intPageVersion, $intLanguageId){
    try{
      $objPage = new Page();
      $objPage->setPageId($strPageId);
      $objPage->setPageVersion($intPageVersion);
      $objPage->setLanguageId($intLanguageId);
      
      $objPage->loadPage();  
      $objPage->indexPage();
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }
  
  /**
   * indexAllPublicPages
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function indexAllPublicPages(){
    try{
      $this->getModelPages();
      
      $objPagesData = $this->objModelPages->loadAllPublicPages();
      foreach($objPagesData as $objPageData){
        $this->indexPage($objPageData->pageId, $objPageData->version, $objPageData->idLanguages);
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }
  
  /**
   * getModelPages
   * @return Model_Pages
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelPages(){
    if (null === $this->objModelPages) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/Pages.php';
      $this->objModelPages = new Model_Pages();
    }

    return $this->objModelPages;
  }
}

?>