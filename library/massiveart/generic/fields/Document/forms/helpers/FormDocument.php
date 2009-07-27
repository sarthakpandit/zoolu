<?php

/**
 * Form_Helper_FormDocument
 * 
 * Helper to generate a "add document" element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-28: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormDocument
 */

class Form_Helper_FormDocument extends Zend_View_Helper_FormElement {

  /**
   * formDocument
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function formDocument($name, $value = null, $attribs = null){
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
     * build the element
     */
    $strOutput = '<div class="docwrapper">
                    <div class="doctop">Dokumente hinzuf&uuml;gen: <img src="/zoolu/images/icons/icon_addmedia.png" width="16" height="16" onclick="myForm.getAddDocumentOverlay(\'divDocumentContainer_'.$this->view->escape($id).'\'); return false;"/></div>
                    <div id="divDocumentContainer_'.$this->view->escape($id).'"'.$disabled.' class="'.$attribs['class'].'">
                    </div>
                    <input type="hidden" id="'.$this->view->escape($id).'" name="'.$this->view->escape($name).'" isCoreField="'.$attribs['isCoreField'].'" fieldId="'.$attribs['fieldId'].'" value="'.$this->view->escape($value).'"/>
                  </div>';
    
    
    return $strOutput;
  }
}

?>