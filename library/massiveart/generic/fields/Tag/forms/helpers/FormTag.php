<?php

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
  public function formTag($name, $value = null, $attribs = null, $options = null, $objMostUsedTags, $arrTagIds = array()){
    $info = $this->_getInfo($name, $value, $attribs);
    extract($info); // name, value, attribs, options, listsep, disable
    
    // XHTML or HTML end tag
    $endTag = ' />';
    if (($this->view instanceof Zend_View_Abstract) && !$this->view->doctype()->isXhtml()) {
      $endTag= '>';
    }
    
    $strMostUsedTags = $this->getMostUsedTags($name, $objMostUsedTags, $arrTagIds, $value);
       
    // build the element
    $strOutput = '<div class="tagswrapper">
                    <span class="smaller gray666">Bitte geben sie ihre Tags durch Komma getrennt an.</span>
                    <input type="text" value="'.$this->view->escape($value).'" id="'.$this->view->escape($id).'" name="'.$this->view->escape($name).'" '.$this->_htmlAttribs($attribs).$endTag;
    
    if($strMostUsedTags != ''){
      $strOutput .= '
                    <div class="mostused">
                      <span class="smaller gray666">Beliebte Tags</span><br/>
                      <div class="mostusedcontainer">
                      '.$strMostUsedTags.'
                      </div> 
                    </div>';
    } 
    $strOutput .= '     
                  </div>';

    return $strOutput;
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