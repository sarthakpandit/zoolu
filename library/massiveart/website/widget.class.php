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
 * @package    library.massiveart.website
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Widget
 *
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-08-19: Florian Mathis
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 * @package massiveart.website
 * @subpackage Widget
 */

class Widget{
	/**
   * @var Core
   */
  protected $core;
  
  protected $intRootLevelId;
  protected $strRootLevelTitle;
  protected $intWidgetId;
  protected $intWidgetVersion;
  protected $intLanguageId;
  
  protected $intTemplateId;
  protected $strNavigationUrl;
  protected $strTemplateFile;
  
  protected $strWidgetInstanceId;
  protected $strActionName;
  
  /**
   * setRootLevelId
   * @param $intRootLevelId
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function setRootLevelId($intRootLevelId){
  	$this->intRootLevelId = $intRootLevelId;
  }
  
  /**
   * setRootLevelTitle
   * @param $strRootLevelTitle
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function setRootLevelTitle($strRootLevelTitle){
  	$this->strRootLevelTitle = $strRootLevelTitle;
  }
  
  /**
   * getRootLevelTitle
   * @return strRootLevelTitle
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
	public function getRootLevelTitle(){
  	return $this->strRootLevelTitle;
  }
  
  /**
   * setWidgetVersion
   * @param $intVersion
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function setWidgetVersion($intVersion){
  	$this->intWidgetVersion = $intVersion;
  }
  
  /**
   * setLanguageId
   * @param $intLanguageId
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function setLanguageId($intLanguageId){
  	$this->intLanguageId = $intLanguageId;
  }  
  
  /**
   * setWidgetInstanceId
   * @param $strWidgetInstanceId
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function setWidgetInstanceId($strWidgetInstanceId){
  	$this->strWidgetInstanceId = $strWidgetInstanceId;
  }
  
  /**
   * getWidgetInstanceId
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function getWidgetInstanceId(){
  	return $this->strWidgetInstanceId;
  }
  
  /**
   * setTemplateId
   * @param integer $intTemplateId
   */
  public function setTemplateId($intTemplateId){
    $this->intTemplateId = $intTemplateId;
  }

  /**
   * getTemplateId
   * @return integer $intTemplateId
   */
  public function getTemplateId(){
    return $this->intTemplateId;
  }
  
  /**
   * setNavigationUrl
   * @param string $strNavigationUrl
   */
  public function setNavigationUrl($strNavigationUrl){
  	$this->strNavigationUrl = $strNavigationUrl;
  }
  
  /**
   * getNavigationUrl
   * @return string $strNavigationUrl
   */
  public function getNavigationUrl(){
  	return $this->strNavigationUrl;
  }
  
	/**
   * setTemplateFile
   * @param string $strTemplateFile
   */
  public function setTemplateFile($strTemplateFile){
    $this->strTemplateFile = $strTemplateFile;
  }

  /**
   * getTemplateFile
   * @param string $strTemplateFile
   */
  public function getTemplateFile(){
    return $this->strTemplateFile;
  }
 
  /**
   * setAction
   * @param $strActionname
   * @return string $strActionname
   */
  public function setAction($strActionName){
  	$this->strActionName = $strActionName;
  }
  
  /**
   * getAction
   * @return string $strActionName
   */
  public function getAction() {
  	return $this->strActionName;
  }
}
 
?>