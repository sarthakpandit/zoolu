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
 * @package    library.massiveart.security
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Security
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-19: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.security
 * @subpackage Security
 */

class Security {

  const RESOURCE_FOLDER_PREFIX = 'folder_';

  /**
   * @var Security
   */
  private static $objInstance;

  /**
   * @var Acl
   */
  private $objAcl;

  /**
   * @var RoleProvider
   */
  private $objRoleProvider;

  /**
   * Constructor
   */
  public function __construct(){ }

  /**
   * buildAcl
   * @param Model_Users $objModelUsers
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function buildAcl(Model_Users $objModelUsers){
    try{
      $this->objAcl = new Acl();

      /**
       * add groups
       */
      $arrGroups = $objModelUsers->getGroups();
      foreach($arrGroups as $objGroup){
        $this->objAcl->addRole(new Zend_Acl_Role($objGroup->key));
      }

      /**
       * add resources & groups & privileges
       */
      $arrResources = $objModelUsers->getResourcesGroups();
      foreach($arrResources as $objResource){
        if(!$this->objAcl->has($objResource->key)){
          $this->objAcl->add(new Zend_Acl_Resource($objResource->key));
        }

        $this->objAcl->allow($objResource->groupKey, $objResource->key, $objResource->permissionTitle);
      }

    }catch (Exception $exc) {
      Zend_Registry::get('Core')->logger->err($exc);
    }
  }

  /**
   * addFoldersToAcl
   * @param Model_Folders $objModelFolders
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addFoldersToAcl(Model_Folders $objModelFolders){
    try{
      if(!$this->objAcl instanceof Acl) $this->objAcl = new Acl();

      /**
       * add resources & groups & privileges
       */
      $arrResources = $objModelFolders->getFoldersPermissions();
      foreach($arrResources as $objResource){
        if(!$this->objAcl->has(Security::RESOURCE_FOLDER_PREFIX.$objResource->id)){
          $this->objAcl->add(new Zend_Acl_Resource(Security::RESOURCE_FOLDER_PREFIX.$objResource->id));
        }

        $this->objAcl->allow($objResource->groupKey, Security::RESOURCE_FOLDER_PREFIX.$objResource->id, $objResource->permissionTitle);
      }

    }catch (Exception $exc) {
      Zend_Registry::get('Core')->logger->err($exc);
    }
  }

  /**
   * setRoleProvider
   * @param RoleProvider $objRoleProvider
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function setRoleProvider(RoleProvider $objRoleProvider){
    $this->objRoleProvider = $objRoleProvider;
  }

  /**
   * isAllowed
   * @param string $strResourceKey
   * @param string $strPrivilege
   * @see library/Zend/Zend_Acl#isAllowed()
   * @return boolean
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function isAllowed($strResourceKey, $strPrivilege = null){
    if($this->objAcl->has($strResourceKey)){
      return $this->objAcl->isAllowed($this->objRoleProvider, $strResourceKey, $strPrivilege);
    }else{
      return true;
    }
  }

  /**
   * save
   * @param Security $objSecurity
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public static function save(Security &$objSecurity){
    self::clearInstance();
    $objSecuritySesNam = new Zend_Session_Namespace('Security');
    $objSecuritySesNam->security = $objSecurity;
  }

  /**
   * get
   * @return Security
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public static function get(){
    if(self::$objInstance === null){
      $objSecuritySesNam = new Zend_Session_Namespace('Security');
      if(isset($objSecuritySesNam->security)){
        self::$objInstance = $objSecuritySesNam->security;
      }else{
        throw new Exception('There is no security object stored in the the session namespace!');
      }
    }
    return self::$objInstance;
  }

  /**
   * clearInstance
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private static function clearInstance(){
    self::$objInstance = null;
  }

}

?>