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
 * @package    application.zoolu.modules.users.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_Users
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-06: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Model_Users {

  /**
   * @var Model_Table_Users
   */
  protected $objUserTable;

  /**
   * @var Model_Table_Groups
   */
  protected $objGroupTable;

  /**
   * @var Model_Table_Resources
   */
  protected $objResourceTable;

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
   * getUserTable
   * @return Zend_Db_Table_Rowset_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function loadUsers(){
    $this->core->logger->debug('users->models->Model_Users->loadUsers()');

    $objSelect = $this->getUserTable()->select();
    $objSelect->setIntegrityCheck(false);

    $objSelect->from($this->objUserTable, array('fname', 'sname'));

    return $this->objUserTable->fetchAll($objSelect);

  }

  /**
   * addUser
   * @param array $arrData
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function addUser($arrData){
   try{
      $intUserId = Zend_Auth::getInstance()->getIdentity()->id;
      $arrData['idUsers'] = $intUserId;
      $arrData['creator'] = $intUserId;
      $arrData['created'] = date('Y-m-d H:i:s');
      $arrData['password'] = md5($arrData['password']);

      return $this->getUserTable()->insert($arrData);
    }catch (Exception $exc) {
      $this->core->logger->err($exc);
    }
  }

  /**
   * getUserTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getUserTable(){

    if($this->objUserTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'users/models/tables/Users.php';
      $this->objUserTable = new Model_Table_Users();
    }

    return $this->objUserTable;
  }

  /**
   * getGroupTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getGroupTable(){

    if($this->objGroupTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'users/models/tables/Groups.php';
      $this->objGroupTable = new Model_Table_Groups();
    }

    return $this->objGroupTable;
  }

  /**
   * getResourceTable
   * @return Zend_Db_Table_Abstract
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getResourceTable(){

    if($this->objResourceTable === null) {
      require_once GLOBAL_ROOT_PATH.$this->core->sysConfig->path->zoolu_modules.'users/models/tables/Resources.php';
      $this->objResourceTable = new Model_Table_Resources();
    }

    return $this->objResourceTable;
  }
}

?>