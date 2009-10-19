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

  /**
   * @var Core
   */
  private $core;

  /**
   * @var Model_Users
   */
  protected $objModelUsers;

  /**
   * @var Acl
   */
  private $objAcl;

  /**
   * Constructor
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }

  /**
   * buildAcl
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   * @return void
   */
  public function buildAcl(){
    try{
      $this->objAcl = new Acl();

      /**
       * add groups
       */
      $arrGroups = $this->getModelUsers()->getGroups();
      foreach($arrGroups as $objGroup){
        $this->objAcl->addRole(new Zend_Acl_Role($objGroup->key));
        //$this->core->logger->debug('$this->objAcl->addRole(new Zend_Acl_Role('.$objGroup->key.'));');
      }

      /**
       * add resources & groups & privileges
       */
      $arrResources = $this->getModelUsers()->getResourcesGroups();
      foreach($arrResources as $objResource){
        if(!$this->objAcl->has($objResource->key)){
          $this->objAcl->add(new Zend_Acl_Resource($objResource->key));
        }

        $this->objAcl->allow($objResource->groupKey, $objResource->key, $objResource->permissionTitle);
        //$this->core->logger->debug('$this->objAcl->allow('.$objResource->groupKey.', '.$objResource->key.', '.$objResource->permissionTitle.');');
      }

    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * getModelUsers
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  protected function getModelUsers(){
    if (null === $this->objModelUsers) {
      /**
       * autoload only handles "library" compoennts.
       * Since this is an application model, we need to require it
       * from its modules path location.
       */
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'users/models/Users.php';
      $this->objModelUsers = new Model_Users();
    }

    return $this->objModelUsers;
  }
}

?>