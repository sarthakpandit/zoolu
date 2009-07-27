<?php

/**
 * Form_Helper_FormContact
 * 
 * Helper to generate a "add document" element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-10: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormContact
 */

class Form_Helper_FormContact extends Zend_View_Helper_FormElement {

  /**
   * formContact
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function formContact($name, $value = null, $attribs = null){
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
    $strOutput = '<div class="conwrapper">
                    <div class="contop">Kontakt hinzuf&uuml;gen: <img src="/zoolu/images/icons/icon_addmedia.png" width="16" height="16" onclick="myForm.getAddContactOverlay(\'divContactContainer_'.$this->view->escape($id).'\'); return false;"/></div>
                    <div id="divContactContainer_'.$this->view->escape($id).'"'.$disabled.' class="'.$attribs['class'].'">
                    </div>
                    <input type="hidden" id="'.$this->view->escape($id).'" name="'.$this->view->escape($name).'" isCoreField="'.$attribs['isCoreField'].'" fieldId="'.$attribs['fieldId'].'" value="'.$this->view->escape($value).'"/>
                  </div>';
    
    
    return $strOutput;
  }
}

?>