<?php

/**
 * Form_Helper_FormUrl
 * 
 * Helper to generate a "tag" element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-27: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormUrl
 */

class Form_Helper_FormUrl extends Zend_View_Helper_FormElement {
  
  /**
   * formUrl
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param string $name
   * @param string $value
   * @param array $attribs
   * @param mixed $options   
   * @version 1.0
   */
  public function formUrl($name, $value = null, $attribs = null, $options = null){
    $info = $this->_getInfo($name, $value, $attribs);
    extract($info); // name, value, attribs, options, listsep, disable
    
    // XHTML or HTML end tag
    $endTag = ' />';
    if (($this->view instanceof Zend_View_Abstract) && !$this->view->doctype()->isXhtml()) {
      $endTag= '>';
    }
    
    $strOutput = '';
    if($value != ''){
      // build the element
      $strOutput = '
                  <div class="urlwrapper">
                    <span class="gray666 bold">Adresse: </span><span class="gray666">'.$this->view->escape($value).'</span>
                    <input type="hidden" value="'.$this->view->escape($value).'" id="'.$this->view->escape($id).'" name="'.$this->view->escape($name).'" '.$endTag.'
                  </div>';
    }
    
    return $strOutput;
  }
}

?>