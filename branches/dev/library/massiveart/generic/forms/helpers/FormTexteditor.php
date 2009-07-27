<?php

/**
 * Form_Helper_FormTexteditor
 * 
 * Helper to generate a "texteditor" element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-12: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormTexteditor
 */

class Form_Helper_FormTexteditor extends Zend_View_Helper_FormElement {

  /**
   * formTexteditor
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function formTexteditor($name, $value = null, $attribs = null, $options = null, $regionId = null){
    $info = $this->_getInfo($name, $value, $attribs);
    extract($info); // name, value, attribs, options, listsep, disable
    
    /**
     * is it disabled?
     */ 
    $disabled = '';
    if ($disable) {
      $disabled = ' disabled="disabled"';
    }
    
    /**
     * is empty element
     */
    $blnIsEmpty = false;
    if(array_key_exists('isEmptyField', $attribs) && $attribs['isEmptyField'] == 1){
      $blnIsEmpty = true;  
    }

    /**
     * build the element
     */
    $strOutput = '<textarea name="'.$this->view->escape($name).'" id="'.$this->view->escape($id).'"'.$disabled.' '. $this->_htmlAttribs($attribs).'>'.$this->view->escape($value).'</textarea>';
    
    if($blnIsEmpty == true){
      $strOutput .= '<script type="text/javascript">//<![CDATA[ 
          myForm.addTexteditor("'.$this->view->escape($id).'","'.$this->view->escape($regionId).'");
        //]]>
        </script>';
    }else{
      $strOutput .= '<script type="text/javascript">//<![CDATA[ 
          myForm.initTexteditor("'.$this->view->escape($id).'");
        //]]>
        </script>';
    }
    
    
    
    return $strOutput;
  }
}

?>