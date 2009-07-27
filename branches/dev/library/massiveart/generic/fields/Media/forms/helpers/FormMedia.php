<?php

/**
 * Form_Helper_FormMedia
 * 
 * Helper to generate a "add media" element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2008-11-12: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormMedia
 */

class Form_Helper_FormMedia extends Zend_View_Helper_FormElement {

  /**
   * formMedia
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function formMedia($name, $value = null, $attribs = null){
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
    //$strOutput = '<textarea name="'.$this->view->escape($name).'" id="'.$this->view->escape($id).'"'.$disabled.' '. $this->_htmlAttribs($attribs).'>'.$this->view->escape($value).'</textarea>';
    $strOutput = '<div class="mediawrapper">
                    <div class="mediatop">Medien hinzuf&uuml;gen: <img src="/zoolu/images/icons/icon_addmedia.png" width="16" height="16" onclick="myForm.getAddMediaOverlay(\'divMediaContainer_'.$this->view->escape($id).'\'); return false;"/></div>
                    <div id="divMediaContainer_'.$this->view->escape($id).'"'.$disabled.' class="'.$attribs['class'].'">
                    </div>
                    <input type="hidden" id="'.$this->view->escape($id).'" name="'.$this->view->escape($name).'" isCoreField="'.$attribs['isCoreField'].'" fieldId="'.$attribs['fieldId'].'" value="'.$this->view->escape($value).'"/>
                  </div>';
    
    
    return $strOutput;
  }
}

?>