<?php
/**
 * ZOOLU - Content Management System
 * Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 *
 * LICENSE
 *
 * This file is part of ZOOLU.
 *
 * ZOOLU is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ZOOLU is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ZOOLU. If not, see http://www.gnu.org/licenses/gpl-3.0.html.
 *
 * For further information visit our website www.getzoolu.org
 * or contact us at zoolu@getzoolu.org
 *
 * @category   ZOOLU
 * @package    library.massiveart.generic.data.types
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * GenericFormTypePage im
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-16: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.generic.data.types
 * @subpackage GenericFormTypePage
 */

require_once(dirname(__FILE__).'/generic.data.type.interface.php');

abstract class GenericDataTypeAbstract implements GenericDataTypeInterface {

  /**
   * @var Core
   */
  protected $core;

  /**
   * @var GenericSetup
   */
  protected $setup;
  /**
   * property of the generic setup object
   * @return GenericSetup $setup
   */
  public function Setup(){
    return $this->setup;
  }

  /**
   * @var Zend_Search_Lucene
   */
  protected $objIndex;

  /**
   * @var Model_GenericData
   */
  protected $objModelGenericData;

  /**
   * Constructor
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }

  /**
   * save
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  abstract public function save();

  /**
   * load
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  abstract public function load();

  /**
   * insertCoreData
   * @param string $strType, string $strTypeId, integer $intTypeVersion
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  final protected function insertCoreData($strType, $strTypeId, $intTypeVersion){

    if(count($this->setup->CoreFields()) > 0){

      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

      /**
       * for each core field, try to insert into the secondary table
       */
      foreach($this->setup->CoreFields() as $strField => $objField){

      	$objGenTable = $this->getModelGenericData()->getGenericTable($strType.((substr($strField, strlen($strField) - 1) == 'y') ? ucfirst(rtrim($strField, 'y')).'ies' : ucfirst($strField).'s'));

      	if($objField->getValue() != ''){
	        /**
	         * if field has already been loaded, update data ( -> e.g. change template)
	         */
	        if($objField->blnHasLoadedData === true){
	          if(is_array($objField->getValue())){

	          	/**
	             * start transaction
	             */
		          $this->core->dbh->beginTransaction();
		          try {
		          	$strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $strTypeId);
	              $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $intTypeVersion);
	              $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());

	              /**
		             * delete data
		             */
		            $objGenTable->delete($strWhere);

		            /**
		             * insert data
		             */
			          foreach($objField->getValue() as $key => $value){
	                $arrCoreData = array($strType.'Id' => $strTypeId,
	                                     'version'     => $intTypeVersion,
	                                     'idLanguages' => $this->setup->getLanguageId(),
	                                     $strField     => $value,
	                                     'idUsers'     => $intUserId,
	                                     'creator'     => $intUserId,
	                                     'created'     => date('Y-m-d H:i:s'));

	                $objGenTable->insert($arrCoreData);
	              }

		            /**
	               * commit transaction
	               */
		            $this->core->dbh->commit();
		          }catch (Exception $exc) {
		            /**
		             * roll back
		             */
		            $this->core->dbh->rollBack();
		            $this->core->logger->err($exc);
		          }
	          }else{
	            $arrCoreData = array($strField     => $objField->getValue(),
	                                 'idUsers'     => $intUserId);

	            $strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $strTypeId);
	            $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $intTypeVersion);
	            $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());

	            $objGenTable->update($arrCoreData, $strWhere);
	          }
	        }else{
	          if(is_array($objField->getValue())){
	          	foreach($objField->getValue() as $key => $value){
	          	  $arrCoreData = array($strType.'Id' => $strTypeId,
	                                   'version'     => $intTypeVersion,
	          	                       'idLanguages' => $this->setup->getLanguageId(),
	                                   $strField     => $value,
	                                   'idUsers'     => $intUserId,
	                                   'creator'     => $intUserId,
	                                   'created'     => date('Y-m-d H:i:s'));

	          	  $objGenTable->insert($arrCoreData);
	          	}
	          }else{
	          	$arrCoreData = array($strType.'Id' => $strTypeId,
	                                 'version'     => $intTypeVersion,
	                                 'idLanguages' => $this->setup->getLanguageId(),
	                                 $strField     => $objField->getValue(),
	                                 'idUsers'     => $intUserId,
	                                 'creator'     => $intUserId,
	                                 'created'     => date('Y-m-d H:i:s'));

	            $objGenTable->insert($arrCoreData);
	          }
	        }
      	}
      }
    }
  }

  /**
   * insertFileData
   * @param array $arrTypeProperties
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  final protected function insertFileData($strType, $arrTypeProperties){

    if(count($this->setup->FileFields()) > 0){

      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

      /**
       * insert into the file instances table
       */
      foreach($this->setup->FileFields() as $strFieldName => $objField){

        $intFieldId = $objField->id;

        $strTmpFileIds = trim($objField->getValue(), '[]');
        $arrFileIds = array();
        $arrFileIds = split('\]\[', $strTmpFileIds);

        if(count($arrFileIds) > 0){
          foreach($arrFileIds as $intSortPosition => $intFileId){
            if($intFileId != ''){
              if(isset($arrTypeProperties['Version'])){
                $arrFileData = array($strType.'id'  => $arrTypeProperties['Id'],
                                     'version'      => $arrTypeProperties['Version'],
                                     'idLanguages'  => $this->setup->getLanguageId(),
                                     'sortPosition' => $intSortPosition + 1,
                                     'idFiles'      => $intFileId,
                                     'idFields'     => $intFieldId);
              }else{
                $arrFileData = array('id'.((substr($strType, strlen($strType) - 1) == 'y') ? ucfirst(rtrim($strType, 'y')).'ies' : ucfirst($strType).'s') => $arrTypeProperties['Id'],
                                     'idFiles'      => $intFileId,
                                     'idFields'     => $intFieldId,
                                     'sortPosition' => $intSortPosition + 1);
              }

              $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-InstanceFiles')->insert($arrFileData);
            }
          }
        }
      }
    }
  }

  /**
   * insertMultiFieldData
   * @param array $arrTypeProperties
   * @author Thomas Shedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function insertMultiFieldData($strType, $arrTypeProperties){

    if(count($this->setup->MultiFields()) > 0){

      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

      /**
       * insert into the multi fields instances table
       */
      foreach($this->setup->MultiFields() as $strFieldName => $objField){

        $intFieldId = $objField->id;

        if(is_array($objField->getValue()) && count($objField->getValue()) > 0){
          foreach($objField->getValue() as $intRelationId){
            if($intRelationId != ''){
              if(isset($arrTypeProperties['Version'])){
                $arrFileData = array($strType.'id' => $arrTypeProperties['Id'],
                                     'version'     => $arrTypeProperties['Version'],
                                     'idLanguages' => $this->setup->getLanguageId(),
                                     'idRelation'  => $intRelationId,
                                     //'value'       => '', TODO ::  load value, if copyValue is true
                                     'idFields'    => $intFieldId);
              }else{
                $arrFileData = array('id'.((substr($strType, strlen($strType) - 1) == 'y') ? ucfirst(rtrim($strType, 'y')).'ies' : ucfirst($strType).'s') => $arrTypeProperties['Id'],
                                     'idRelation'  => $intRelationId,
                                     //'value'       => '', TODO ::  load value, if copyValue is true
                                     'idFields'    => $intFieldId);
              }

              $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-InstanceMultiFields')->insert($arrFileData);
            }
          }
        }
      }
    }
  }

  /**
   * insertInstanceData
   * @param string $strType
   * @param array $arrTypeProperties
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  final protected function insertInstanceData($strType, $arrTypeProperties){

    if(count($this->setup->InstanceFields()) > 0){

      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

      if(isset($arrTypeProperties['Version'])){
        $arrInstanceData = array($strType.'Id'  => $arrTypeProperties['Id'],
                                 'version'      => $arrTypeProperties['Version'],
                                 'idLanguages'  => $this->setup->getLanguageId(),
                                 'idUsers'      => $intUserId,
                                 'creator'      => $intUserId,
                                 'created'      => date('Y-m-d H:i:s'));
      }else{
        $arrInstanceData = array('id'.((substr($strType, strlen($strType) - 1) == 'y') ? ucfirst(rtrim($strType, 'y')).'ies' : ucfirst($strType).'s') => $arrTypeProperties['Id'],
                                 'idUsers'      => $intUserId,
                                 'creator'      => $intUserId,
                                 'created'      => date('Y-m-d H:i:s'));
      }


      /**
       * for each instance field, add to instance data array
       */
      foreach($this->setup->InstanceFields() as $strField => $objField){
        if(is_array($objField->getValue())){
          $arrInstanceData[$strField] = json_encode($objField->getValue());
        }else{
          $arrInstanceData[$strField] = $objField->getValue();
        }
      }

      $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Instances')->insert($arrInstanceData);
    }
  }

  /**
   * insertMultiplyRegionData
   * @param string $strType,
   * @param string $strTypeId,
   * @param integer $intTypeVersion
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function insertMultiplyRegionData($strType, $strTypeId, $intTypeVersion){
    try{
      if(count($this->setup->MultiplyRegionIds()) > 0){
        /**
         * start transaction
         */
        $this->core->dbh->beginTransaction();
        try {
          /**
           * for each multiply region, insert data
           */
          foreach($this->setup->MultiplyRegionIds() as $intRegionId){
            $objRegion = $this->setup->getRegion($intRegionId);

            if($objRegion instanceof GenericElementRegion){
              $intRegionPosition = 0;
              foreach($objRegion->RegionInstanceIds() as $intRegionInstanceId){
                $intRegionPosition++;
                $this->insertMultiplyRegionInstanceData($objRegion, $intRegionInstanceId, $intRegionPosition, $strType, $strTypeId, $intTypeVersion);
              }
            }
          }

          /**
           * commit transaction
           */
          $this->core->dbh->commit();
        }catch (Exception $exc) {
          /**
           * roll back
           */
          $this->core->dbh->rollBack();
          $this->core->logger->err($exc);
        }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * updateCoreData
   * @param string $strType, string $strTypeId, integer $intTypeVersion
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  final protected function updateCoreData($strType, $strTypeId, $intTypeVersion){

    if(count($this->setup->CoreFields()) > 0){

      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

      /**
       * for each core field, try to insert into the secondary table
       */
      foreach($this->setup->CoreFields() as $strField => $objField){

      	$objGenTable = $this->getModelGenericData()->getGenericTable($strType.((substr($strField, strlen($strField) - 1) == 'y') ? ucfirst(rtrim($strField, 'y')).'ies' : ucfirst($strField).'s'));

      	if($objField->getValue() != ''){
	        if(is_array($objField->getValue())){

	        	/**
	           * start transaction
	           */
	          $this->core->dbh->beginTransaction();
	          try {
	          	$strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $strTypeId);
	            $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $intTypeVersion);
              $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());

	            /**
	          	 * delete
	          	 */
	            $objGenTable->delete($strWhere);

	            /**
	             * insert data
	             */
	            foreach($objField->getValue() as $key => $value){
	              $arrCoreData = array($strType.'Id' => $strTypeId,
	                                   'version'     => $intTypeVersion,
	                                   'idLanguages' => $this->setup->getLanguageId(),
	                                   $strField     => $value,
	                                   'idUsers'     => $intUserId,
	                                   'creator'     => $intUserId,
	                                   'created'     => date('Y-m-d H:i:s'));

	              $objGenTable->insert($arrCoreData);
	            }

		          /**
		           * commit transaction
		           */
		          $this->core->dbh->commit();
		        }catch (Exception $exc) {
		          /**
		           * roll back
		           */
		          $this->core->dbh->rollBack();
		          $this->core->logger->err($exc);
		        }
	        }else{
	        	$arrCoreData = array($strField     => $objField->getValue(),
	                               'idUsers'     => $intUserId,
	        	                     'changed'     => date('Y-m-d H:i:s'));

	        	$strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $strTypeId);
	          $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $intTypeVersion);
	          $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());

	          $intNumOfEffectedRows = $objGenTable->update($arrCoreData, $strWhere);

            if($intNumOfEffectedRows == 0 && $objField->getValue() != ''){
	            $arrCoreData = array($strType.'Id' => $strTypeId,
                                   'version'     => $intTypeVersion,
                                   'idLanguages' => $this->setup->getLanguageId(),
                                   $strField     => $objField->getValue(),
                                   'idUsers'     => $intUserId,
                                   'creator'     => $intUserId,
                                   'created'     => date('Y-m-d H:i:s'));

              $objGenTable->insert($arrCoreData);
	          }
	        }
      	}else{
      	  $strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $strTypeId);
          $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $intTypeVersion);
          $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());

          /**
           * delete
           */
          $objGenTable->delete($strWhere);
      	}
      }
    }
  }

  /**
   * updateFileData
   * @param array $arrTypeProperties
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  final protected function updateFileData($strType, $arrTypeProperties){

    if(count($this->setup->FileFields()) > 0){

      $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-InstanceFiles');

      if(isset($arrTypeProperties['Version'])){
        $strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $arrTypeProperties['Id']);
        $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $arrTypeProperties['Version']);
        $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());
      }else{
        $strWhere = $objGenTable->getAdapter()->quoteInto('id'.((substr($strType, strlen($strType) - 1) == 'y') ? ucfirst(rtrim($strType, 'y')).'ies' : ucfirst($strType).'s').' = ?', $arrTypeProperties['Id']);
      }

      $objGenTable->delete($strWhere);

      /**
       * update the file instances table
       */
      foreach($this->setup->FileFields() as $strField => $objField){
        $intFieldId = $objField->id;

        $strTmpFileIds = trim($objField->getValue(), '[]');
        $arrFileIds = array();
        $arrFileIds = split('\]\[', $strTmpFileIds);

        if(count($arrFileIds) > 0){
          foreach($arrFileIds as $intSortPosition => $intFileId){
            if($intFileId != ''){
              if(isset($arrTypeProperties['Version'])){
                $arrFileData = array($strType.'id' => $arrTypeProperties['Id'],
                                     'version'     => $arrTypeProperties['Version'],
                                     'idLanguages' => $this->setup->getLanguageId(),
                                     'sortPosition' => $intSortPosition+1,
                                     'idFiles'     => $intFileId,
                                     'idFields'    => $intFieldId);
              }else{
                $arrFileData = array('id'.((substr($strType, strlen($strType) - 1) == 'y') ? ucfirst(rtrim($strType, 'y')).'ies' : ucfirst($strType).'s') => $arrTypeProperties['Id'],
                                     'idFiles'     => $intFileId,
                                     'idFields'    => $intFieldId,
                                     'sortPosition' => $intSortPosition+1);
              }

              $objGenTable->insert($arrFileData);
            }
          }
        }
      }
    }
  }

  /**
   * updateMultiFieldData
   * @param string $strType, string $strTypeId, integer $intTypeVersion
   * @author Thomas Schedler <cha@massiveart.com>
   * @version 1.0
   */
  final protected function updateMultiFieldData($strType, $strTypeId, $intTypeVersion){

    if(count($this->setup->MultiFields()) > 0){

      $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-InstanceMultiFields');

      $strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $strTypeId);
      $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $intTypeVersion);
      $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());
      $objGenTable->delete($strWhere);

      /**
       * update the file instances table
       */
      foreach($this->setup->MultiFields() as $strField => $objField){

        $intFieldId = $objField->id;

        if(is_array($objField->getValue()) && count($objField->getValue()) > 0){
          foreach($objField->getValue() as $intRelationId){
            if($intRelationId != ''){
              $arrFileData = array($strType.'id' => $strTypeId,
                                   'version'     => $intTypeVersion,
                                   'idLanguages' => $this->setup->getLanguageId(),
                                   'idRelation'  => $intRelationId,
                                   //'value'       => '', TODO ::  load value, if copyValue is true
                                   'idFields'    => $intFieldId);

              $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-InstanceMultiFields')->insert($arrFileData);
            }
          }
        }
      }
    }
  }


  /**
   * updateInstanceData
   * @param string $strType, string $strTypeId, integer $intTypeVersion
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  final protected function updateInstanceData($strType, $strTypeId, $intTypeVersion){

    if(count($this->setup->InstanceFields()) > 0){

      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;

      $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Instances');

      $arrInstanceData = array('idUsers'  => $intUserId,
                               'changed'  => date('Y-m-d H:i:s'));

      /**
       * for each instance field, add to instance data array
       */
      foreach($this->setup->InstanceFields() as $strField => $objField){
        if(is_array($objField->getValue())){
          $arrInstanceData[$strField] = json_encode($objField->getValue());
        }else{
          $arrInstanceData[$strField] = $objField->getValue();
        }
      }

      $strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $strTypeId);
      $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $intTypeVersion);
      $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());

      $intNumOfEffectedRows = $objGenTable->update($arrInstanceData, $strWhere);

      if($intNumOfEffectedRows == 0){
        $this->insertInstanceData($strType, array('Id' => $strTypeId, 'Version' => $intTypeVersion));
      }
    }
  }

  /**
   * updateMultiplyRegionData
   * @param string $strType,
   * @param string $strTypeId,
   * @param integer $intTypeVersion
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function updateMultiplyRegionData($strType, $strTypeId, $intTypeVersion){
    try{
      if(count($this->setup->MultiplyRegionIds()) > 0){
        /**
         * start transaction
         */
        $this->core->dbh->beginTransaction();
        try {
          /**
           * for each multiply region, insert data
           */
          foreach($this->setup->MultiplyRegionIds() as $intRegionId){
            $objRegion = $this->setup->getRegion($intRegionId);

            $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-Instances');

            $strWhere = $objGenTable->getAdapter()->quoteInto($strType.'Id = ?', $strTypeId);
            $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND version = ?', $intTypeVersion);
            $strWhere .= $objGenTable->getAdapter()->quoteInto(' AND idLanguages = ?', $this->setup->getLanguageId());
            $objGenTable->delete($strWhere);


            if($objRegion instanceof GenericElementRegion){
              $intRegionPosition = 0;
              foreach($objRegion->RegionInstanceIds() as $intRegionInstanceId){
                $intRegionPosition++;
                $this->insertMultiplyRegionInstanceData($objRegion, $intRegionInstanceId, $intRegionPosition, $strType, $strTypeId, $intTypeVersion);
              }
            }
          }

          /**
           * commit transaction
           */
          $this->core->dbh->commit();
        }catch (Exception $exc) {
          /**
           * roll back
           */
          $this->core->dbh->rollBack();
          $this->core->logger->err($exc);
        }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * insertMultiplyRegionInstanceData
   * @param GenericElementRegion $objRegion
   * @param integer $intRegionInstanceId
   * @param integer $intRegionPosition
   * @param string $strType,
   * @param string $strTypeId,
   * @param integer $intTypeVersion
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function insertMultiplyRegionInstanceData(GenericElementRegion &$objRegion, $intRegionInstanceId, $intRegionPosition, $strType, $strTypeId, $intTypeVersion){
    try{

      $arrInstanceData = array($strType.'Id'  => $strTypeId,
                               'version'      => $intTypeVersion,
                               'idLanguages'  => $this->setup->getLanguageId(),
                               'sortPosition' => $intRegionPosition);

      /**
       * for each instance field, add to instance data array
       */
      foreach($objRegion->InstanceFieldNames() as $strFieldName){
        if(is_array($objRegion->getField($strFieldName)->getInstanceValue($intRegionInstanceId))){
          $arrInstanceData[$strFieldName] = json_encode($objRegion->getField($strFieldName)->getInstanceValue($intRegionInstanceId));
        }else{
          $arrInstanceData[$strFieldName] = $objRegion->getField($strFieldName)->getInstanceValue($intRegionInstanceId);
        }
      }

      $idRegionInstance = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-Instances')->insert($arrInstanceData);

      if(count($objRegion->FileFieldNames()) > 0){

        /**
         * insert into the file instances table
         */
        foreach($objRegion->FileFieldNames() as $strFieldName){
          $objField = $objRegion->getField($strFieldName);

          $intFieldId = $objField->id;

          $strTmpFileIds = trim($objField->getInstanceValue($intRegionInstanceId), '[]');

          $arrFileIds = array();
          $arrFileIds = explode('][', $strTmpFileIds);

          if(count($arrFileIds) > 0){
            foreach($arrFileIds as $intFileId){
              if($intFileId != ''){
                $arrFileData = array($strType.'id'        => $strTypeId,
                                     'version'            => $intTypeVersion,
                                     'idLanguages'        => $this->setup->getLanguageId(),
                                     'idRegionInstances'  => $idRegionInstance,
                                     'idFiles'            => $intFileId,
                                     'idFields'           => $intFieldId);

                $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-InstanceFiles')->insert($arrFileData);
              }
            }
          }
        }
      }

      if(count($objRegion->FileFilterFieldNames()) > 0){

        /**
         * insert into the file filter instances table
         */
        foreach($objRegion->FileFilterFieldNames() as $strFieldName){
          $objField = $objRegion->getField($strFieldName);

          $intFieldId = $objField->id;

          $objFilters = $objField->getInstanceValue($intRegionInstanceId);

          foreach($objFilters->filters as $objFilter){
            if(!is_array($objFilter->referenceIds)){
              $objFilter->referenceIds = array($objFilter->referenceIds);
            }

            foreach($objFilter->referenceIds as $intReferenceId){
              if(is_numeric($intReferenceId)){
                $arrFileFilterData = array($strType.'id'        => $strTypeId,
                                           'version'            => $intTypeVersion,
                                           'idLanguages'        => $this->setup->getLanguageId(),
                                           'idRegionInstances'  => $idRegionInstance,
                                           'idFilterTypes'      => $objFilter->typeId,
                                           'referenceId'        => $intReferenceId,
                                           'idFields'           => $intFieldId);
                $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-InstanceFileFilters')->insert($arrFileFilterData);
              }
            }
          }
        }
      }

      if(count($objRegion->MultiFieldNames()) > 0){

        /**
         * insert into the multi fields instances table
         */
        foreach($objRegion->MultiFieldNames() as $strFieldName){
          $objField = $objRegion->getField($strFieldName);

          $intFieldId = $objField->id;

          if(is_array($objField->getInstanceValue($intRegionInstanceId)) && count($objField->getInstanceValue($intRegionInstanceId)) > 0){
            foreach($objField->getInstanceValue($intRegionInstanceId) as $intRelationId){
              if($intRelationId != ''){
                $arrFileData = array($strType.'id'        => $strTypeId,
                                     'version'            => $intTypeVersion,
                                     'idLanguages'        => $this->setup->getLanguageId(),
                                     'idRegionInstances'  => $idRegionInstance,
                                     'idRelation'         => $intRelationId,
                                     //'value'            => '', TODO ::  load value, if copyValue is true
                                     'idFields'           => $intFieldId);

                $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-InstanceMultiFields')->insert($arrFileData);
              }
            }
          }
        }
      }

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * loadCoreData
   * @param string $strType
   * @param array $arrTypeProperties
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function loadGenericData($strType, $arrTypeProperties){
    
    /**
     * laod all generic data
     */
    $this->loadCoreData($strType, $arrTypeProperties);
    $this->loadFileData($strType, $arrTypeProperties);
    $this->loadMultiFieldData($strType, $arrTypeProperties);
    $this->loadInstanceData($strType, $arrTypeProperties);
    $this->loadMultiplyRegionData($strType, $arrTypeProperties);
        
  }

  /**
   * loadCoreData
   * @param string $strType
   * @param array $arrTypeProperties
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function loadCoreData($strType, $arrTypeProperties){
    try{
      /**
       * generic form core fields
       */
      if(count($this->setup->CoreFields()) > 0){
        /**
         * for each core field, try to select the secondary table
         */
        foreach($this->setup->CoreFields() as $strField => $objField){

          $objGenTable = $this->getModelGenericData()->getGenericTable($strType.((substr($strField, strlen($strField) - 1) == 'y') ? ucfirst(rtrim($strField, 'y')).'ies' : ucfirst($strField).'s'));
          $objSelect = $objGenTable->select();

          $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), array($strField));
          $objSelect->where($strType.'Id = ?', $arrTypeProperties['Id']);
          $objSelect->where('version = ?', $arrTypeProperties['Version']);
          $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());

          $arrGenFormsData = $objGenTable->fetchAll($objSelect)->toArray();

          if(count($arrGenFormsData) > 0){
            $objField->blnHasLoadedData = true;
            if(count($arrGenFormsData) > 1){
              $arrFieldData = array();
              foreach ($arrGenFormsData as $arrRowGenFormData) {
                foreach ($arrRowGenFormData as $column => $value) {
                  array_push($arrFieldData, $value);
                }
              }
              if($column == $strField){
                $objField->setValue($arrFieldData);
              }else{
                $objField->$column = $arrFieldData;
              }
            }else{
              foreach ($arrGenFormsData as $arrRowGenFormData) {
                foreach ($arrRowGenFormData as $column => $value) {
                  if($column == $strField){
                    $objField->setValue($value);
                  }else{
                    $objField->$column = $value;
                  }
                }
              }
            }
          }
        }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * loadFileData
   * @param string $strType
   * @param array $arrTypeProperties
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function loadFileData($strType, $arrTypeProperties){
    try{
      /**
       * generic form file fields
       */
      if(count($this->setup->FileFields()) > 0){

        $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-InstanceFiles');
        $strTableName = $objGenTable->info(Zend_Db_Table_Abstract::NAME);

        $objSelect = $objGenTable->select();
        $objSelect->setIntegrityCheck(false);

        $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), array('idFiles', 'sortPosition'));
        $objSelect->join('fields', 'fields.id = `'.$objGenTable->info(Zend_Db_Table_Abstract::NAME).'`.idFields', array('name'));
        $objSelect->where($strType.'Id = ?', $arrTypeProperties['Id']);
        $objSelect->where('version = ?', $arrTypeProperties['Version']);
        $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());
        $objSelect->order(array('sortPosition ASC'));

        $arrGenFormsData = $objGenTable->fetchAll($objSelect)->toArray();

        if(count($arrGenFormsData) > 0){
          $this->blnHasLoadedFileData = true;
          foreach($arrGenFormsData as $arrGenRowFormsData){
            $strFileIds = $this->setup->getFileField($arrGenRowFormsData['name'])->getValue().'['.$arrGenRowFormsData['idFiles'].']';
            $this->setup->getFileField($arrGenRowFormsData['name'])->setValue($strFileIds);
          }
        }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * loadMultiFieldData
   * @param string $strType
   * @param array $arrTypeProperties
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function loadMultiFieldData($strType, $arrTypeProperties){
    try{
      /**
       * generic form multi fields
       */
      if(count($this->setup->MultiFields()) > 0){

        $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-InstanceMultiFields');
        $strTableName = $objGenTable->info(Zend_Db_Table_Abstract::NAME);

        $objSelect = $objGenTable->select();
        $objSelect->setIntegrityCheck(false);

        $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), array('idRelation', 'value'));
        $objSelect->join('fields', 'fields.id = `'.$objGenTable->info(Zend_Db_Table_Abstract::NAME).'`.idFields', array('name'));
        $objSelect->where('pageId = ?', $arrTypeProperties['Id']);
        $objSelect->where('version = ?', $arrTypeProperties['Version']);
        $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());

        $arrGenFormsData = $objGenTable->fetchAll($objSelect);

        if(count($arrGenFormsData) > 0){
          $this->blnHasLoadedMultiFieldData = true;
          foreach($arrGenFormsData as $arrGenRowFormsData){
            $arrTmpRelationIds = $this->setup->getMultiField($arrGenRowFormsData->name)->getValue();
            if(is_array($arrTmpRelationIds)){
              array_push($arrTmpRelationIds, $arrGenRowFormsData->idRelation);
            }else{
              $arrTmpRelationIds = array($arrGenRowFormsData->idRelation);
            }
            $this->setup->getMultiField($arrGenRowFormsData->name)->setValue($arrTmpRelationIds);
          }
        }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * loadInstanceData
   * @param string $strType
   * @param array $arrTypeProperties
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function loadInstanceData($strType, $arrTypeProperties){
    try{
      /**
       * generic form instance fields
       */
      if(count($this->setup->InstanceFields()) > 0){
        $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Instances');
        $objSelect = $objGenTable->select();

        $arrSelectFields = array();

        /**
         * for each instance field, add to select array data array
         */
        foreach($this->setup->InstanceFields() as $strField => $objField){
          $arrSelectFields[] = $strField;
        }

        $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), $arrSelectFields);
        $objSelect->where($strType.'Id = ?', $arrTypeProperties['Id']);
        $objSelect->where('version = ?', $arrTypeProperties['Version']);
        $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());

        $arrGenFormsData = $objGenTable->fetchAll($objSelect)->toArray();

        if(count($arrGenFormsData) > 0){
          $this->blnHasLoadedInstanceData = true;
          foreach ($arrGenFormsData as $arrRowGenFormData) {
            foreach ($arrRowGenFormData as $column => $value) {
              if(is_array(json_decode($value))){
                $this->setup->getInstanceField($column)->setValue(json_decode($value));
              }else{
                $this->setup->getInstanceField($column)->setValue($value);
              }
            }
          }
        }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * loadMultiplyRegionData
   * @param string $strType
   * @param array $arrTypeProperties
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function loadMultiplyRegionData($strType, $arrTypeProperties){
    try{

      /**
       * if the generic form, has multiply regions
       */
      if(count($this->setup->MultiplyRegionIds()) > 0){

        /**
         * for each multiply region, load region data
         */
        foreach($this->setup->MultiplyRegionIds() as $intRegionId){
          $objRegion = $this->setup->getRegion($intRegionId);

          $arrRegionInstanceIds = array();
          $intRegionInstanceCounter = 0;

          $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-Instances');
          $objSelect = $objGenTable->select();

          $arrSelectFields = array('id');
          /**
           * for each instance field, add to select array data array
           */
          foreach($objRegion->InstanceFieldNames() as $strField){
            $arrSelectFields[] = $strField;
          }

          $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), $arrSelectFields);
          $objSelect->where($strType.'Id = ?', $arrTypeProperties['Id']);
          $objSelect->where('version = ?', $arrTypeProperties['Version']);
          $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());
          $objSelect->order(array('sortPosition'));

          $arrGenFormsData = $objGenTable->fetchAll($objSelect)->toArray();

          if(count($arrGenFormsData) > 0){
            //$this->blnHasLoadedInstanceData = true;

            foreach ($arrGenFormsData as $arrRowGenFormData) {
              $intRegionInstanceCounter++;
              $intRegionInstanceId = $arrRowGenFormData['id'];
              $arrRegionInstanceIds[$intRegionInstanceCounter] = $intRegionInstanceId;

              $objRegion->addRegionInstanceId($intRegionInstanceCounter);
              foreach ($arrRowGenFormData as $column => $value) {
                if($column != 'id'){
                  if(is_array(json_decode($value))){
                    $objRegion->getField($column)->setInstanceValue($intRegionInstanceCounter, json_decode($value));
                  }else{
                    $objRegion->getField($column)->setInstanceValue($intRegionInstanceCounter, $value);
                  }
                }
              }
            }
          }

          /**
           * generic multipy region file fields
           */
          if(count($objRegion->FileFieldNames()) > 0){

            $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-InstanceFiles');
            $strTableName = $objGenTable->info(Zend_Db_Table_Abstract::NAME);

            $objSelect = $objGenTable->select();
            $objSelect->setIntegrityCheck(false);

            $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), array('idFiles', 'idRegionInstances'));
            $objSelect->join('fields', 'fields.id = `'.$objGenTable->info(Zend_Db_Table_Abstract::NAME).'`.idFields', array('name'));
            $objSelect->where($strType.'Id = ?', $arrTypeProperties['Id']);
            $objSelect->where('version = ?', $arrTypeProperties['Version']);
            $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());

            $arrGenFormsData = $objGenTable->fetchAll($objSelect)->toArray();

            if(count($arrGenFormsData) > 0){
              //$this->blnHasLoadedFileData = true;
              foreach($arrGenFormsData as $arrGenRowFormsData){
                $intRegionInstanceId = $arrGenRowFormsData['idRegionInstances'];
                $intRegionPos = array_search($intRegionInstanceId, $arrRegionInstanceIds);
                if($intRegionPos !== false){
                  $strFileIds = $objRegion->getField($arrGenRowFormsData['name'])->getInstanceValue($intRegionPos).'['.$arrGenRowFormsData['idFiles'].']';
                  $objRegion->getField($arrGenRowFormsData['name'])->setInstanceValue($intRegionPos, $strFileIds);
                }
              }
            }
          }

          /**
           * generic multipy region file filter fields
           */
          if(count($objRegion->FileFilterFieldNames()) > 0){

            $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-InstanceFileFilters');
            $strTableName = $objGenTable->info(Zend_Db_Table_Abstract::NAME);

            $objSelect = $objGenTable->select();
            $objSelect->setIntegrityCheck(false);

            $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), array('idFilterTypes', 'referenceId', 'idRegionInstances'));
            $objSelect->join('fields', 'fields.id = `'.$objGenTable->info(Zend_Db_Table_Abstract::NAME).'`.idFields', array('name'));
            $objSelect->where($strType.'Id = ?', $arrTypeProperties['Id']);
            $objSelect->where('version = ?', $arrTypeProperties['Version']);
            $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());

            $arrGenFormsData = $objGenTable->fetchAll($objSelect)->toArray();

            if(count($arrGenFormsData) > 0){
              //$this->blnHasLoadedFileData = true;
              foreach($arrGenFormsData as $arrGenRowFormsData){
                $intRegionInstanceId = $arrGenRowFormsData['idRegionInstances'];
                $intRegionPos = array_search($intRegionInstanceId, $arrRegionInstanceIds);
                if($intRegionPos !== false){
                  $objFilters = $objRegion->getField($arrGenRowFormsData['name'])->getInstanceValue($intRegionPos);
                  if(!($objFilters instanceof stdClass)){
                    $objFilters = new stdClass();
                    $objFilters->filters = array();
                  }

                  if(array_key_exists('ft'.$arrGenRowFormsData['idFilterTypes'], $objFilters->filters)){
                    $objFilter = $objFilters->filters['ft'.$arrGenRowFormsData['idFilterTypes']];
                  }else{
                    $objFilter = new stdClass();
                    $objFilter->typeId = $arrGenRowFormsData['idFilterTypes'];
                    $objFilter->referenceIds = array();
                  }

                  $objFilter->referenceIds[] = $arrGenRowFormsData['referenceId'];
                  $objFilters->filters['ft'.$arrGenRowFormsData['idFilterTypes']] = $objFilter;

                  $objRegion->getField($arrGenRowFormsData['name'])->setInstanceValue($intRegionPos, $objFilters);
                }
              }
            }
          }

          /**
           * generic multipy region multi fields
           */
          if(count($objRegion->MultiFieldNames()) > 0){

            $objGenTable = $this->getModelGenericData()->getGenericTable($strType.'-'.$this->setup->getFormId().'-'.$this->setup->getFormVersion().'-Region'.$objRegion->getRegionId().'-InstanceMultiFields');
            $strTableName = $objGenTable->info(Zend_Db_Table_Abstract::NAME);

            $objSelect = $objGenTable->select();
            $objSelect->setIntegrityCheck(false);

            $objSelect->from($objGenTable->info(Zend_Db_Table_Abstract::NAME), array('idRelation', 'value', 'idRegionInstances'));
            $objSelect->join('fields', 'fields.id = `'.$objGenTable->info(Zend_Db_Table_Abstract::NAME).'`.idFields', array('name'));
            $objSelect->where($strType.'Id = ?', $arrTypeProperties['Id']);
            $objSelect->where('version = ?', $arrTypeProperties['Version']);
            $objSelect->where('idLanguages = ?', $this->Setup()->getLanguageId());

            $arrGenFormsData = $objGenTable->fetchAll($objSelect);

            if(count($arrGenFormsData) > 0){
              //$this->blnHasLoadedMultiFieldData = true;
              foreach($arrGenFormsData as $arrGenRowFormsData){
                $intRegionInstanceId = $arrGenRowFormsData->idRegionInstances;
                $intRegionPos = array_search($intRegionInstanceId, $arrRegionInstanceIds);

                $arrTmpRelationIds = $objRegion->getField($arrGenRowFormsData->name)->getInstanceValue($intRegionPos);
                if(is_array($arrTmpRelationIds)){
                  array_push($arrTmpRelationIds, $arrGenRowFormsData->idRelation);
                }else{
                  $arrTmpRelationIds = array($arrGenRowFormsData->idRelation);
                }
                $objRegion->getField($arrGenRowFormsData->name)->setInstanceValue($intRegionPos, $arrTmpRelationIds);
              }
            }
          }
        }
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * addToIndex
   * @param string $strIndexPath
   * @param string $strKey
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function addToIndex($strIndexPath, $strKey){
    try{

      if(!is_object($this->objIndex) || !($this->objIndex instanceof Zend_Search_Lucene)){
        if(count(scandir($strIndexPath)) > 2){
          $this->objIndex = Zend_Search_Lucene::open($strIndexPath);
        }else{
          $this->objIndex = Zend_Search_Lucene::create($strIndexPath);
        }
      }

      $objDoc = new Zend_Search_Lucene_Document();

      $objDoc->addField(Zend_Search_Lucene_Field::keyword('key', $strKey));
      $objDoc->addField(Zend_Search_Lucene_Field::unIndexed('date', $this->setup->getPublishDate('d.m.Y')));
      $objDoc->addField(Zend_Search_Lucene_Field::unIndexed('rootLevelId', $this->setup->getRootLevelId()));

      /**
       * index fields
       */
      foreach($this->setup->FieldNames() as $strField => $intFieldType){
        $objField = $this->setup->getField($strField);
        if(is_object($objField) && $objField->idSearchFieldTypes != Search::FIELD_TYPE_NONE){

          $strValue = '';
          if(is_array($objField->getValue()) && $objField->sqlSelect != ''){
            $arrIds = $objField->getValue();
            $sqlSelect = $objField->sqlSelect;

            if(is_array($arrIds)){
              if(count($arrIds) > 0){
                $strReplaceWhere = '';
                foreach($arrIds as $strId){
                  $strReplaceWhere .= $strId.',';
                }
                $strReplaceWhere = trim($strReplaceWhere, ',');

                $objReplacer = new Replacer();
                $sqlSelect = $objReplacer->sqlReplacer($sqlSelect, $this->setup->getLanguageId(), $this->setup->getRootLevelId(),' AND tbl.id IN ('.$strReplaceWhere.')');
                $objCategoriesData = $this->core->dbh->query($sqlSelect)->fetchAll(Zend_Db::FETCH_OBJ);

                if(count($objCategoriesData) > 0){
                  foreach($objCategoriesData as $objCategories){
                    $strValue .= $objCategories->title.', ';
                  }
                  $strValue = rtrim($strValue, ', ');
                }
              }
            }
          }else{
            $strValue = $objField->getValue();
          }

          if($strValue != ''){
            switch ($objField->idSearchFieldTypes){
              case Search::FIELD_TYPE_KEYWORD:
                $objDoc->addField(Zend_Search_Lucene_Field::keyword($strField, $strValue, $this->core->sysConfig->encoding->default));
                break;
              case Search::FIELD_TYPE_UNINDEXED:
                $objDoc->addField(Zend_Search_Lucene_Field::unIndexed($strField, $strValue, $this->core->sysConfig->encoding->default));
                break;
              case Search::FIELD_TYPE_BINARY:
                $objDoc->addField(Zend_Search_Lucene_Field::binary($strField, $strValue, $this->core->sysConfig->encoding->default));
                break;
              case Search::FIELD_TYPE_TEXT:
                $objDoc->addField(Zend_Search_Lucene_Field::text($strField, $strValue, $this->core->sysConfig->encoding->default));
                break;
              case Search::FIELD_TYPE_UNSTORED:
                $objDoc->addField(Zend_Search_Lucene_Field::unStored($strField, strip_tags($strValue), $this->core->sysConfig->encoding->default));
                break;
            }
          }
        }
      }

      // Add document to the index.
      $this->objIndex->addDocument($objDoc);

      $this->objIndex->optimize();
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * updateIndex
   * @param string $strIndexPath
   * @param string $strKey
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final public function updateIndex($strIndexPath, $strKey){
    try{
      if(count(scandir($strIndexPath)) > 2){
        $this->objIndex = Zend_Search_Lucene::open($strIndexPath);

        $objTerm = new Zend_Search_Lucene_Index_Term($strKey, 'key');
        $objQuery = new Zend_Search_Lucene_Search_Query_Term($objTerm);

        $objHits = $this->objIndex->find($objQuery);

        foreach($objHits as $objHit){
          $this->objIndex->delete($objHit->id);
        }

        $this->objIndex->commit();
      }

      $this->addToIndex($strIndexPath, $strKey);

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * removeFromIndex
   * @param string $strIndexPath
   * @param string $strKey
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  final protected function removeFromIndex($strIndexPath, $strKey){
    try{
      if(count(scandir($strIndexPath)) > 2){
        $this->objIndex = Zend_Search_Lucene::open($strIndexPath);

        $objTerm = new Zend_Search_Lucene_Index_Term($strKey, 'key');
        $objQuery = new Zend_Search_Lucene_Search_Query_Term($objTerm);

        $objHits = $this->objIndex->find($objQuery);

        foreach($objHits as $objHit){
          $this->objIndex->delete($objHit->id);
        }

        $this->objIndex->commit();

        $this->objIndex->optimize();
      }
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * getModelGenericData
   * @return Model_GenericData
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelGenericData(){
    if (null === $this->objModelGenericData) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/GenericData.php';
      $this->objModelGenericData = new Model_GenericData();
    }

    return $this->objModelGenericData;
  }

  /**
   * setGenericSetup
   * @param GenericSetup $objGenericSetup
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function setGenericSetup(GenericSetup &$objGenericSetup){
    $this->setup = $objGenericSetup;
  }
}

?>