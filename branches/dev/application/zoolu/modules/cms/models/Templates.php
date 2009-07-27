<?php

/**
 * Model_Templates
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-14: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Templates {
  
	private $intLanguageId;
	
	/**
   * @var Model_Table_Templates 
   */
  protected $objTemplateTable;
	
  /**
   * @var Model_Table_TemplateExcludedFields
   */
  protected $objTemplateExcludedFieldsTable;
  
  /**
   * @var Model_Table_TemplateExcludedRegions
   */
  protected $objTemplateExcludedRegionsTable;
  
  /**
   * @var Model_Table_TemplateRegionProperties
   */
  protected $objTemplateRegionPropertiesTable;
  
  /**
   * @var Core
   */
  private $core;  
  
  /**
   * Constructor 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * loadTemplateById 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset
   * @version 1.0
   */
  public function loadTemplateById($intTemplateId){
    $this->core->logger->debug('cms->models->Model_Templates->loadTemplateById('.$intTemplateId.')');
    
    $objSelect = $this->getTemplateTable()->select();   
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from('templates', array('id', 
                                        'genericFormId',
                                        'filename', 
                                        '(SELECT version FROM genericForms WHERE genericForms.genericFormId = templates.genericFormId ORDER BY version DESC LIMIT 1) AS version',
                                        '(SELECT idGenericFormTypes FROM genericForms WHERE genericForms.genericFormId = templates.genericFormId ORDER BY version DESC LIMIT 1) AS formTypeId'));
    $objSelect->where('templates.id = ?', $intTemplateId);
 
    return $this->getTemplateTable()->fetchAll($objSelect);
  }
  
  /**
   * loadTemplateExcludedRegions   * 
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadTemplateExcludedRegions($intTemplateId){
    $this->core->logger->debug('cms->models->Model_Templates->loadTemplateExcludedRegions('.$intTemplateId.')');
    
    $objSelect = $this->getTemplateExcludedRegionsTable()->select();   
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from($this->objTemplateExcludedRegionsTable, array('idRegions'));
    $objSelect->where('idTemplates = ?', $intTemplateId);
 
    return $this->objTemplateExcludedRegionsTable->fetchAll($objSelect);
  }
  
  /**
   * loadTemplateExcludedFields 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset
   * @version 1.0
   */
  public function loadTemplateExcludedFields($intTemplateId){
    $this->core->logger->debug('cms->models->Model_Templates->loadTemplateExcludedFields('.$intTemplateId.')');
    
    $objSelect = $this->getTemplateExcludedFieldsTable()->select();   
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from('templateExcludedFields', array('idFields'));
    $objSelect->where('idTemplates = ?', $intTemplateId);
 
    return $this->objTemplateExcludedFieldsTable->fetchAll($objSelect);
  }

  /**
   * loadTemplateRegionProperties 
   * @param integer $intElementId
   * @return Zend_Db_Table_Rowset
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function loadTemplateRegionProperties($intTemplateId){
    $this->core->logger->debug('cms->models->Model_Templates->loadTemplateRegionProperties('.$intTemplateId.')');
    
    $objSelect = $this->getTemplateRegionPropertiesTable()->select();   
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from($this->objTemplateRegionPropertiesTable, array('idRegions', 'order', 'collapsable', 'isCollapsed'));
    $objSelect->where('idTemplates = ?', $intTemplateId);
 
    return $this->objTemplateRegionPropertiesTable->fetchAll($objSelect);
  }
  
  /**
   * loadActiveTemplates
   * @param boolean $blnIsStartPage
   * @param integer $intPageTypeId
   * @paran integer $intParentTypeId 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return Zend_Db_Table_Rowset
   * @version 1.0
   */
  public function loadActiveTemplates($blnIsStartPage = false, $intPageTypeId, $intParentTypeId){
    $this->core->logger->debug('cms->models->Model_Templates->loadTemplates()');
    
    $objSelect = $this->getTemplateTable()->select();   
    $objSelect->setIntegrityCheck(false);
    
    $objSelect->from('templates', array('id', 
                                        'genericFormId',
                                        '(SELECT version FROM genericForms WHERE genericForms.genericFormId = templates.genericFormId ORDER BY version DESC LIMIT 1) AS version', 
                                        'filename', 
                                        'thumbnail'));
    $objSelect->join('templateTypes', 'templateTypes.idTemplates = templates.id', array());
    $objSelect->join('types', 'types.id = templateTypes.idTypes', array());
    $objSelect->joinLeft('templateTitles', 'templateTitles.idTemplates = templates.id AND templateTitles.idLanguages = '.$this->intLanguageId, array('title'));    
    $objSelect->where('templates.active = ?', 1);
        
    switch ($intPageTypeId){
      case $this->core->sysConfig->page_types->page->id:      	
        if($blnIsStartPage && $intParentTypeId == $this->core->sysConfig->parent_types->rootlevel){
          $objSelect->where('types.id = ?', $this->core->sysConfig->types->portal_startpage);  
        }else if($blnIsStartPage){
          $objSelect->where('types.id = ?', $this->core->sysConfig->types->startpage);  
        }else{
          $objSelect->where('types.id = ?', $this->core->sysConfig->types->page);
        }
        break;
      case $this->core->sysConfig->page_types->overview->id:
        $objSelect->where('types.id = ?', $this->core->sysConfig->types->overview);
        break;
    }
 
    return $this->getTemplateTable()->fetchAll($objSelect);
  }
    
  /**
   * getTemplateTable 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getTemplateTable(){
    
    if($this->objTemplateTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/Templates.php';
      $this->objTemplateTable = new Model_Table_Templates();
    }
    
    return $this->objTemplateTable;
  }
  
  /**
   * getTemplateExcludedRegionsTable 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getTemplateExcludedRegionsTable(){
    
    if($this->objTemplateExcludedRegionsTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/TemplateExcludedRegions.php';
      $this->objTemplateExcludedRegionsTable = new Model_Table_TemplateExcludedRegions();
    }
    
    return $this->objTemplateExcludedRegionsTable;
  }
  
  /**
   * getTemplateExcludedFieldsTable 
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getTemplateExcludedFieldsTable(){
    
    if($this->objTemplateExcludedFieldsTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/TemplateExcludedFields.php';
      $this->objTemplateExcludedFieldsTable = new Model_Table_TemplateExcludedFields();
    }
    
    return $this->objTemplateExcludedFieldsTable;
  }
  
  /**
   * getTemplateRegionPropertiesTable 
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getTemplateRegionPropertiesTable(){
    
    if($this->objTemplateRegionPropertiesTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'cms/models/tables/TemplateRegionProperties.php';
      $this->objTemplateRegionPropertiesTable = new Model_Table_TemplateRegionProperties();
    }
    
    return $this->objTemplateRegionPropertiesTable;
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