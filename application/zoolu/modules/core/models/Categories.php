<?php

/**
 * Model_Categories
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-20: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 */

class Model_Categories {
  
	private $intLanguageId;
	
  /**
   * @var Model_Table_Categories 
   */
  protected $objCategoriesTable;
  
  /**
   * @var Model_Table_RootLevels 
   */
  protected $objRootLevelTable;
  
  /**
   * @var Core
   */
  private $core;  
  
  /**
   * Constructor 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * loadCatNavigation
   * @param integer $intItemId
   * @param integer $intCategoryTypeId 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadCatNavigation($intItemId, $intCategoryTypeId){
    $this->core->logger->debug('core->models->Folders->loadCatNavigation('.$intItemId.','.$intCategoryTypeId.')');	
  	
    $objSelect = $this->getCategoriesTable()->select();   
    $objSelect->setIntegrityCheck(false);
    
    /**
     * SELECT categories.*, categoryTitles.title 
     * FROM categories 
     * INNER JOIN categoryTitles ON categoryTitles.idCategories = categories.id 
     *   AND categoryTitles.idLanguages = ?
     * WHERE categories.idCategoryTypes = ? AND
     *   categories.idParentCategory = ?
     * ORDER BY categories.lft    
     */    
    $objSelect->from('categories');
    $objSelect->join('categoryTitles', 'categoryTitles.idCategories = categories.id AND categoryTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->where('categories.idCategoryTypes = '.$intCategoryTypeId);
    $objSelect->where('categories.idParentCategory = '.$intItemId);
    $objSelect->order(array('categories.lft'));
    
    return $this->getCategoriesTable()->fetchAll($objSelect);
  }
  
  /**
   * loadCategory 
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function loadCategory($intElementId){
    $this->core->logger->debug('core->models->Folders->loadCategory('.$intElementId.')');
    
    $objSelect = $this->getCategoriesTable()->select();   
    $objSelect->setIntegrityCheck(false);
    
    /**
     * SELECT categories.*, categoryTitles.title 
     * FROM categories 
     * INNER JOIN categoryTitles ON categoryTitles.idCategories = categories.id AND 
     *   categoryTitles.idLanguages = ?
     * WHERE categories.id = ?   
     */
    $objSelect->from('categories');
    $objSelect->join('categoryTitles', 'categoryTitles.idCategories = categories.id AND categoryTitles.idLanguages = '.$this->intLanguageId, array('title'));
    $objSelect->where('categories.id = ?', $intElementId);
        
    return $this->getCategoriesTable()->fetchAll($objSelect);    
  }
  
  /**
   * loadCategoriesMatchCode
   * @param integer|string $mixedIds
   * @param boolean $retAsArray = false 
   * @return Zend_Db_Table_Rowset_Abstract|array
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadCategoriesMatchCode($mixedIds, $retAsArray = false){
    $this->core->logger->debug('core->models->Folders->loadCategoriesMatchCode('.$mixedIds.','.$retAsArray.')');

    $objSelect = $this->getCategoriesTable()->select();   
    $objSelect->setIntegrityCheck(false);
    
    /**
     * SELECT categories.id, categories.matchCode 
     * FROM categories 
     * WHERE categories.id = ? | WHERE categories.id IN (?,?)   
     */    
    $objSelect->from('categories', array('id', 'matchCode'));
    if(strpos($mixedIds, ',') === false){
      $objSelect->where('categories.id = ?', $mixedIds);	
    }else{
      $objSelect->where('categories.id IN ('.$mixedIds.')');	
    }    
    
    $mixedCatMatchCodes = $this->getCategoriesTable()->fetchAll($objSelect);
    
    if($retAsArray){
       $mixedCatMatchCodes = $mixedCatMatchCodes->toArray(); 
    }    
    return $mixedCatMatchCodes;
  }
    
  /**
   * deleteCategory 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function deleteCategory($intElementId){
    $this->core->logger->debug('core->models->Folders->deleteCategory('.$intElementId.')');
    
    $this->getCategoriesTable();
    
    /**
     * delete categories
     */
    $strWhere = $this->objCategoriesTable->getAdapter()->quoteInto('id = ?', $intElementId);
    $strWhere .= $this->objCategoriesTable->getAdapter()->quoteInto('OR idParentCategory = ?', $intElementId);    
    
    return $this->objCategoriesTable->delete($strWhere);
  }
  
  /**
   * addCategoryNode   
   * @param integer $intParentId
   * @param array $arrData
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0 
   */
  public function addCategoryNode($intParentId, $arrData = array()){
   try{ 
      $intCategoryId = null;
            
      $this->getCategoriesTable();
      
      $objNestedSet = new NestedSet($this->objCategoriesTable);
      $objNestedSet->setDBFParent('idParentCategory');
      $objNestedSet->setDBFRoot('idRootCategory');
      
      /**
       * if $intParentId == 0, this is a root category node
       */
      if($intParentId == 0){
        $intCategoryId = $objNestedSet->newRootNode($arrData);
      }else{
        $intCategoryId = $objNestedSet->newLastChild($intParentId, $arrData);
      }
      
      return $intCategoryId;
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }
  
  /**
   * deleteCategoryNode
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param integer $intElementId
   * @version 1.0
   */
  public function deleteCategoryNode($intCategoryId){
    $this->core->logger->debug('core->models->Categories->deleteCategoryNode('.$intCategoryId.')');
    
    $this->getCategoriesTable();
    
    $objNestedSet = new NestedSet($this->objCategoriesTable);
    $objNestedSet->setDBFParent('idParentCategory');
    $objNestedSet->setDBFRoot('idRootCategory');
      
    $objNestedSet->deleteNode($intCategoryId);
  }
  
  /**
   * getCategoriesTable
   * @return Model_Table_Categories $objCategoriesTable
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0 
   */
  public function getCategoriesTable(){
    
    if($this->objCategoriesTable === null){
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/Categories.php';
      $this->objCategoriesTable = new Model_Table_Categories();
    }
    
    return $this->objCategoriesTable;
  }
  
  /**
   * getRootLevelTable 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getRootLevelTable(){
    
    if($this->objRootLevelTable === null){
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/RootLevels.php';
      $this->objRootLevelTable = new Model_Table_RootLevels();
    }
    
    return $this->objRootLevelTable;
  }
  
  /**
   * setLanguageId
   * @param integer $intLanguageId
   */
  public function setLanguageId($intLanguageId){
    $this->intLanguageId = $intLanguageId;  
  }
  
  /**
   * getLanguageId
   * @param integer $intLanguageId
   */
  public function getLanguageId(){
    return $this->intLanguageId;  
  } 
}

?>