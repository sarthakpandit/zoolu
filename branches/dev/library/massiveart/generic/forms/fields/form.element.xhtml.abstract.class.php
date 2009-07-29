<?php
/**
 * FormElementXhtmlAbstract
 *
 * @author Daniel Rotter <daniel.rotter@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.elements
 * @subpackage FormElementXhtmlAbstract
 */
class FormElementXhtmlAbstract extends Zend_Form_Element_Xhtml
{
  public function __construct($spec, $options = null)
  {
  	$objLoader = new PluginLoader();
    $objLoader->setPluginLoader($this->getPluginLoader(PluginLoader::TYPE_FORM_DECORATOR));
    $objLoader->setPluginType(PluginLoader::TYPE_FORM_DECORATOR);
    $this->setPluginLoader($objLoader, PluginLoader::TYPE_FORM_DECORATOR);
  	parent::__construct($spec, $options);
  }
}
?>