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
 * @package    application.zoolu.modules.core.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_Urls
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-12-04: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Urls {

  private $intLanguageId;

  /**
   * @var Model_Table_Urls
   */
  protected $objUrlTable;
  
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
   * loadUrl
   * @param string $strRelationId
   * @param integer $intVersion
   * @param integer $intUrlTypeId
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadUrl($strRelationId, $intVersion, $intUrlTypeId){
    $this->core->logger->debug('core->models->Model_Urls->loadUrl('.$strRelationId.', '.$intVersion.','.$intUrlTypeId.')');

    $objSelect = $this->getUrlTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objUrlTable, array('url'));
    $objSelect->join('pages', 'pages.pageId = urls.relationId', array('isStartPage'));
    $objSelect->joinleft('folders', 'pages.idParent = folders.id AND pages.idParentTypes = '.$this->core->sysConfig->parent_types->folder, array('depth','idParentFolder'));
    $objSelect->join('languages', 'languages.id = urls.idLanguages', array('languageCode'));
    $objSelect->where('urls.relationId = ?', $strRelationId)
              ->where('urls.version = ?', $intVersion)
              ->where('urls.idUrlTypes = ?', $intUrlTypeId)
              ->where('urls.idLanguages = ?', $this->intLanguageId)
              ->where('urls.isMain = 1')
              ->where('urls.idParent IS NULL');

    return $this->objUrlTable->fetchAll($objSelect);
  }
  
   /**
   * getUrlTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getUrlTable(){

    if($this->objUrlTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'core/models/tables/Urls.php';
      $this->objUrlTable = new Model_Table_Urls();
    }

    return $this->objUrlTable;
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