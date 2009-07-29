<?php

/**
 * GenericSubForm
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-07-22: Florian Mathis
 * 1.1, 2009-07-23: Thomas Schedler
 * 1.2, 2009-07-28: Daniel Rotter - changed the used plugin loader to our own
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.forms
 * @subpackage GenericSubForm
 */

class GenericSubForm extends Zend_Form_SubForm {

  /**
   * @var Core
   */
  protected $core;

  /**
   * @var GenericForm Object
   */
  protected $objGenericForm;

  protected $intId;
  protected $strTitle;
  protected $blnHide;

  /**
   * set generic form object
   * @param GenericForm &$objGenericForm
   */
  public function setGenericForm(GenericForm &$objGenericForm) {
    $this->objGenericForm = $objGenericForm;
  }

  public static $FIELD_PROPERTIES_TO_IMPART = array('tagIds',
                                                    'isRegionTitle',
                                                    'strLinkedPageId',
                                                    'intLinkedPageVersion',
                                                    'strLinkedPageTitle',
                                                    'strLinkedPageUrl',
                                                    'intLinkedPageId',
                                                    'strLinkedPageBreadcrumb',
                                                    'intVideoTypeId',
                                                    'strVideoUserId',
                                                    'strVideoThumb');

  /**
   * Constructor
   */
  public function __construct($options = null){
    $this->core = Zend_Registry::get('Core');

    /**
     * Zend_Form_SubForm
     */
    parent::__construct($options);
    
    /**
     * Use our own PluginLoader
     */
    $objLoader = new PluginLoader();
    $objLoader->setPluginLoader($this->getPluginLoader(PluginLoader::TYPE_FORM_ELEMENT));
    $objLoader->setPluginType(PluginLoader::TYPE_FORM_ELEMENT);
    $this->setPluginLoader($objLoader, PluginLoader::TYPE_FORM_ELEMENT);

    /**
     * clear all decorators
     */
    $this->clearDecorators();

    /**
     * add standard decorators
     */
    $this->addDecorator('FormElements')
         ->addDecorator('Tab');

    /**
     * add prefix path to own elements
     */
    //$this->addPrefixPath('Form_Element', '', 'element');

    /**
     * elements prefixes
     */
    $this->addElementPrefixPath('Form_Decorator', dirname(__FILE__).'/decorators/', 'decorator');

    /**
     * regions prefixes
     */
    $this->addDisplayGroupPrefixPath('Form_Decorator', dirname(__FILE__).'/decorators/');
  }

  /**
   * addField
   * @param GenericElementField $objField
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.2
   */
  public function addField(GenericElementField &$objField, $intRegionId, $strNameExtension = '', $intRegionInstanceId = null, $blnEmpty = false){
    try{
      $sqlStmt = array();
      $arrOptions = array();

      /**
       * get array options for select output if sqlSelect is in database
       */
      if($objField->sqlSelect != '' && $objField->sqlSelect){
        $objReplacer = new Replacer();
        $sqlSelect = $objReplacer->sqlReplacer($objField->sqlSelect, $this->objGenericForm->Setup()->getLanguageId(), $this->objGenericForm->Setup()->getRootLevelId());
        $sqlStmt = $this->core->dbh->query($sqlSelect)->fetchAll();
        if(in_array($objField->type, GenericSetup::$FIELD_TYPE_SELECTS)){
          $arrOptions[''] = 'Bitte wählen';
        }
        foreach($sqlStmt as $arrSql){
          if(array_key_exists('depth', $arrSql)){
            $arrOptions[$arrSql['id']] = array('title' => $arrSql['title'],
                                               'depth' => $arrSql['depth']);
          }else{
            $arrOptions[$arrSql['id']] = $arrSql['title'];
          }
        }
      }

      if($objField->type == GenericSetup::FIELD_TYPE_TEMPLATE){
        $objField->defaultValue = $this->objGenericForm->Setup()->getTemplateId();
      }

      if(!is_null($intRegionInstanceId)){
        $mixedValue = $objField->getInstanceValue($intRegionInstanceId);
      }else{
        $mixedValue = $objField->getValue();
      }

      if($blnEmpty == true){
        $mixedValue = null;
      }

      $strCssClass = '';
      if($objField->isKeyField){
        $strCssClass = ' keyfield';
      }

      /**
       * add field to form
       */
      $this->addElement($objField->type, $objField->name.$strNameExtension, array(
        'value' => $mixedValue,
        'label' => $objField->title,
        'description' => $objField->description,
        'decorators' => array($objField->decorator),
        'fieldId' => $objField->id,
        'columns' => $objField->columns,
        'class' => $objField->type.$strCssClass,
        'height' => $objField->height,
        'isGenericSaveField' => $objField->isSaveField,
        'isCoreField' => $objField->isCoreField,
        'MultiOptions' => $arrOptions,
        'LanguageId' => $this->objGenericForm->Setup()->getLanguageId(),
        'isEmptyField' => (($blnEmpty == true) ? 1 : 0),
        'required' =>  (($objField->isKeyField == 1) ? true : false)
      ));

      $this->getElement($objField->name.$strNameExtension)->regionId = $intRegionId;
      $this->getElement($objField->name.$strNameExtension)->regionExtension = $strNameExtension;
      $this->getElement($objField->name.$strNameExtension)->formTypeId = $this->objGenericForm->Setup()->getFormTypeId();

      if(count($objField->getProperties()) > 0){
        foreach($objField->getProperties() as $strProperty => $mixedPropertyValue){
          if(in_array($strProperty, self::$FIELD_PROPERTIES_TO_IMPART)){
            $this->getElement($objField->name.$strNameExtension)->$strProperty = $mixedPropertyValue;
          }
        }
      }

      /**
       * template specific addons
       */
      if($objField->type == GenericSetup::FIELD_TYPE_TEMPLATE){
        $this->getElement($objField->name.$strNameExtension)->isStartPage = $this->objGenericForm->Setup()->getIsStartPage(false);
        $this->getElement($objField->name.$strNameExtension)->intElementTypeId = $this->objGenericForm->Setup()->getElementTypeId();
        $this->getElement($objField->name.$strNameExtension)->intParentTypeId = $this->objGenericForm->Setup()->getParentTypeId();
      }

      $this->objGenericForm->fieldAddedToSubform($this->intId, $objField->name);

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * setId
   * @param integer $intId
   */
  public function setId($intId){
    $this->intId = $intId;
  }

  /**
   * getId
   * @return integer $intId
   */
  public function getId(){
    return $this->intId;
  }

  /**
   * setTitle
   * @param string $strTitle
   */
  public function setTitle($strTitle){
    $this->strTitle = $strTitle;
  }

  /**
   * getTitle
   * @return string $strTitle
   */
  public function getTitle(){
    return $this->strTitle;
  }

  /**
   * setHide
   * @param boolean $blnHide
   */
  public function setHide($blnHide){
    $this->blnHide = $blnHide;
  }

  /**
   * getHide
   * @return boolean $blnHide
   */
  public function getHide(){
    return $this->blnHide;
  }
}

?>