<?php

/**
 * StaticBackendCacheAdapter
 * 
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-04-05: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 * @package massiveart.website.cache.backend
 * @subpackage StaticAdapter
 */

class StaticBackendCacheAdapter {
  
	protected $_cache = null;

  public function __construct(Zend_Cache_Core $cache){
    $this->_cache = $cache;
  }
  
  public function load($id){
    $id = $this->_encodeId($id);
    $this->__call('load', array($id));
  }

  public function test($id){
    $id = $this->_encodeId($id);
    $this->__call('test', array($id));
  }
  
  public function save($data, $id, $tags = array(), $specificLifetime = false){
    $id = $this->_encodeId($id);
    $this->__call('save', array($data, $id, $tags, $specificLifetime));
  }
  
  public function remove($id){
    $id = $this->_encodeId($id);
    $this->__call('remove', array($id));
  }
  
  public function __call($method, array $args){
    return call_user_func_array(array($this->_cache, $method), $args);
  }
  
  public function removeRecursive($id) {
    $this->_cache->getBackend()->removeRecursive($id);
  }
  
  protected function _encodeId($id) {
    return bin2hex($id); // encode path to alphanumeric hexadecimal
  }
}
?>