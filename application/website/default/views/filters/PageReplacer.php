<?php

/**
 * Zend_View_Filter_PageReplacer implements Zend_Filter_Interface
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class Zend_View_Filter_PageReplacer implements Zend_Filter_Interface{

  /**
   * @var Zend_View_Interface
   */
  public $view; 
  
  private $response;
  
  /**
   * css
   */
  const PLACEHOLDER_TEMPLATE_CSS = '<%template_css%>';
  const PLACEHOLDER_PLUGIN_CSS = '<%plugin_css%>';
  
  /**
   * js
   */
  const PLACEHOLDER_TEMPLATE_JS = '<%template_js%>';
  const PLACEHOLDER_PLUGIN_JS = '<%plugin_js%>';
  
  public function filter($value){
    $this->response = $value;
    
    $this->replaceTemplateCssPlaceholder();
    $this->replaceTemplateJsPlaceholder();
    
    $this->replacePluginCssPlaceholder();
    $this->replacePluginJsPlaceholder();
        
    return $this->response;
  }
  
  /**
   * replaceTemplateCssPlaceholder
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  private function replaceTemplateCssPlaceholder(){
    if(Zend_Registry::isRegistered('TemplateCss')){
      $this->response = str_replace(self::PLACEHOLDER_TEMPLATE_CSS, Zend_Registry::get('TemplateCss'), $this->response);
    }
  }
  
  /**
   * replacePluginCssPlaceholder
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function replacePluginCssPlaceholder(){
    $this->response = str_replace(self::PLACEHOLDER_PLUGIN_CSS, '', $this->response);     
  }
  
  /**
   * replaceTemplateJsPlaceholder
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  private function replaceTemplateJsPlaceholder(){
  	if(Zend_Registry::isRegistered('TemplateJs')){
  	  $this->response = str_replace(self::PLACEHOLDER_TEMPLATE_JS, Zend_Registry::get('TemplateJs'), $this->response);
  	}
  }
  
  /**
   * replacePluginJsPlaceholder
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  private function replacePluginJsPlaceholder(){
    $this->response = str_replace(self::PLACEHOLDER_PLUGIN_JS, '', $this->response);
  }
  
  /**
   * Set view object
   * 
   * @param  Zend_View_Interface $view 
   * @return void
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function setView(Zend_View_Interface $view){
    $this->view = $view;
  }
}

?>