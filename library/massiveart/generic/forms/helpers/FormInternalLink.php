<?php

/**
 * Form_Helper_FormInternalLink
 * 
 * Helper to generate a "tag" element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-02-13: Thomas Schedler
 * 
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormInternalLink
 */

class Form_Helper_FormInternalLink extends Zend_View_Helper_FormElement {
  
  /**
   * formUrl
   * @author Thomas Schedler <tsh@massiveart.com>
   * @param string $name
   * @param string $value
   * @param array $attribs
   * @param mixed $options
   * @param Form_Element_InternalLink $element     
   * @version 1.0
   */
  public function formInternalLink($name, $value = null, $attribs = null, $options = null, Form_Element_InternalLink &$element){
    $info = $this->_getInfo($name, $value, $attribs);
    extract($info); // name, value, attribs, options, listsep, disable
    
    // XHTML or HTML end tag
    $endTag = ' />';
    if (($this->view instanceof Zend_View_Abstract) && !$this->view->doctype()->isXhtml()) {
      $endTag= '>';
    }
    
    $strOutput = '';
  
    // build the element
    $strOutput = '
                <div class="linkedpage" id="divLinkedPage_'.$id.'">
                  <span class="big" id="spanLinkedPageBreadcrumb_'.$id.'">'.$this->view->escape($element->strLinkedPageBreadcrumb).'</span><span class="bold big" id="spanLinkedPageTitle_'.$id.'">'.$this->view->escape($element->strLinkedPageTitle).'</span> (<a href="#" onclick="myForm.getLinkedPageOverlay(\''.$id.'\'); return false;">Seite wählen</a>)<br/>
                  <span class="small" id="spanLinkedPageUrl_'.$id.'"><a href="'.$element->strLinkedPageUrl.'" target="_blank">'.$this->view->escape($element->strLinkedPageUrl).'</a></span>
                  <input type="hidden" value="'.$this->view->escape($value).'" id="'.$this->view->escape($id).'" name="'.$this->view->escape($name).'" '.$endTag.'
                </div>';
        
    return $strOutput;
  }
}

?>