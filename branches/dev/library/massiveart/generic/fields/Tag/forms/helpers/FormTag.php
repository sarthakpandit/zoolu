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
 * @package    library.massiveart.generic.fields.Tag.forms.helpers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */
/**
 * Form_Helper_FormTag
 * 
 * Helper to generate a "tag" element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-27: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormTag
 */

class Form_Helper_FormTag extends Zend_View_Helper_FormElement {
  
  /**
   * formTag
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param string $name
   * @param string $value
   * @param array $attribs
   * @param mixed $options
   * @param Zend_Db_Table_Rowset $objMostUsedTags
   * @param array $arrTagIds
   * @version 1.0
   */
  public function formTag($name, $value = null, $attribs = null, $options = null, $objAllTags, $arrTagIds = array()){
    $info = $this->_getInfo($name, $value, $attribs);
    extract($info); // name, value, attribs, options, listsep, disable
    
    // XHTML or HTML end tag
    $endTag = ' />';
   
    if (($this->view instanceof Zend_View_Abstract) && !$this->view->doctype()->isXhtml()) {
      $endTag= '>';
    }
       
    // build the element
    $strSelTags = '';
    $strTags = '';
    
   if(is_object($value) || is_array($value)){
      foreach($value as $objTag){
        $strTags .= '<div id="'.$this->view->escape($id).'_'.$objTag->title.'" class="tagpill"><div class="tagdelete" onclick="myTags.removeTag(\''.$this->view->escape($id).'\',\''.$objTag->title.'\')">[x]</div><div class="tagtitle">'.$objTag->title.'</div><div class="clear"></div></div>';
        $strSelTags .= '['.$objTag->title.']';
      }
    }else{
      $strTmpTagTitles = trim($value, '[]');
      $arrTags = split('\]\[', $strTmpTagTitles);
      
      foreach($arrTags as $key => $strTagTitle){
        $strTags .= '<div id="'.$this->view->escape($id).'_'.$strTagTitle.'" class="tagpill"><div class="tagdelete" onclick="myTags.removeTag(\''.$this->view->escape($id).'\',\''.$strTagTitle.'\')">[x]</div><div class="tagtitle">'.$strTagTitle.'</div><div class="clear"></div></div>';
        $strSelTags .= '['.$strTagTitle.']';
      }
    }
    
    $strOutput = '<div class="tagswrapper">
                    <div class="field"><input type="text"  value="" id="'.$this->view->escape($id).'_Inp" name="'.$this->view->escape($name).'Inp" '.$this->_htmlAttribs($attribs).$endTag.
                    '<a href="#" onclick="myTags.addTag(\''.$this->view->escape($id).'\'); return false;" id="'.$this->view->escape($id).'Add" name="'.$this->view->escape($name).'Add">Hinzufügen</a>
                    </div><input type="hidden" value="'.$strSelTags.'" id="'.$this->view->escape($id).'" name="'.$this->view->escape($name).'" '.$this->_htmlAttribs($attribs).$endTag.
                    '<div class="autocomplete" id="'.$this->view->escape($id).'_Suggest" style="display:none"></div>';
    
    $strOutput .= '<div id="'.$this->view->escape($id).'SelectedTags" class="selectedtagwrapper">';
    $strOutput .= $strTags;
   
    $strAllTags = $this->getAllTags($objAllTags,$this->view->escape($id));
       
    $strOutput .= '<div id="'.$this->view->escape($id).'_WrapperClear" class="clear"></div></div><div class="clear"></div></div>';
    
    $arrReturn = array($strOutput,$strAllTags);
  
    return $arrReturn;
  }
    
  /**
   * getAllTags
   * @return string $strAllTags
   * @author Dominik Mößlang <dmo@massiveart.com>
   * @version 1.0
   */
  public function getAllTags($objAllTags,$intElementId){
    $strAllTags = '';
    if(count($objAllTags) > 0){
      $strAllTags .= 'var arr'.$intElementId.'TagList =[ ';
      foreach($objAllTags as $intKey => $objTag){
        $strAllTags .= '"'.$objTag->title.'",';
      }
      $strAllTags = trim($strAllTags, ',');
      $strAllTags .= '];';   
    }
    return $strAllTags;
  }
  
/**
   * getMostUsedTags
   * @return string $strMostUsedTags
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function getMostUsedTags($strFieldName, $objMostUsedTags, $arrTagIds, $value){
    $strMostUsedTags = '';
    
    if(count($objMostUsedTags) > 0){
      
      foreach($objMostUsedTags as $objTag){
        $strTagCssClass = '';
        if((is_array($arrTagIds) && array_search($objTag->id, $arrTagIds) !== false) || (strpos($value, $objTag->title) !== false)){
          $strTagCssClass = ' class="selectedtag"';
        }
        $strMostUsedTags.= '<a href="#"'.$strTagCssClass.' onclick="myTags.addOrRemoveTag(\''.addslashes($objTag->title).'\', this,\''.$strFieldName.'\'); return false;">'.$this->view->escape($objTag->title).'</a> ';
      }
    }
    
    return $strMostUsedTags;
  }
  
}

?>