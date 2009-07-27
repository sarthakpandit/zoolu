<?php

/**
 * Form_Helper_FormDselect
 * 
 * Helper to generate dependent selects
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-01-09: Cornelius Hansjakob
 * 
 * @author Cornelius Hansjakob <cha@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormDselect
 */

class Form_Helper_FormDselect extends Zend_View_Helper_FormElement {

  /**
   * formDselect
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function formDselect($name, $value = null, $attribs = null){
    $info = $this->_getInfo($name, $value, $attribs);
    extract($info); // name, id, value, attribs, options, listsep, disable

    // force $value to array so we can compare multiple values to multiple 
    // options; also ensure it's a string for comparison purposes.
    $value = array_map('strval', (array) $value);
  
    // Build the surrounding select element first.
    $xhtml = '<select style="display:none;"'
              . ' name="' . $this->view->escape($name) . '"'
              . ' id="' . $this->view->escape($id) . '"'
              . $this->_htmlAttribs($attribs)
              . ">\n    ";

    // build the list of options
    $list = array();
    
    foreach ($attribs['MultiOptions'] as $opt_value => $opt_label) {
      if (is_array($opt_label)) {
        $opt_disable = '';
        if (is_array($disable) && in_array($opt_value, $disable)) {
          $opt_disable = ' disabled="disabled"';
        }
        $list[] = '<optgroup'
                  . $opt_disable
                  . ' label="' . $this->view->escape($opt_value) .'">';
        foreach ($opt_label as $val => $lab) {
          $list[] = $this->optBuild($val, $lab, $value, $disable);
        }
        $list[] = '</optgroup>';
      } else {
      	$list[] = $this->optBuild($opt_value, $opt_label, $value, $disable);
      }
    }

    // add the options to the xhtml and close the select
    $xhtml .= implode("\n    ", $list) . "\n</select>";
    
    // javascript observer
    $xhtml .= '<script type="text/javascript" language="javascript">
      alert(\''.$this->view->escape($id).'\');
    </script>';
    
    return $xhtml;
  }

  /**
   * Builds the actual <option> tag
   *
   * @param string $value Options Value
   * @param string $label Options Label
   * @param array  $selected The option value(s) to mark as 'selected'
   * @param array|bool $disable Whether the select is disabled, or individual options are
   * @return string Option Tag XHTML
   */
  protected function optBuild($value, $label, $selected, $disable){
    if (is_bool($disable)) {
      $disable = array();
    }

    $opt = '<option'
           . ' value="' . $this->view->escape($value) . '"'
           . ' label="' . $this->view->escape($label) . '"';

     // selected?
     if (in_array((string) $value, $selected)) {
       $opt .= ' selected="selected"';
     }

     // disabled?
     if (in_array($value, $disable)) {
       $opt .= ' disabled="disabled"';
     }

     $opt .= '>' . $this->view->escape($label) . "</option>";

     return $opt;
  }
}

?>