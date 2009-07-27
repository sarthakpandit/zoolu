<?php

/**
 * Form_Helper_FormGmaps
 * 
 * Helper to generate a google maps element
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2009-07-17: Florian Mathis
 * 
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 * @package massiveart.forms.helpers
 * @subpackage Form_Helper_FormGmaps
 */

class Form_Helper_FormGmaps extends Zend_View_Helper_FormElement {
  
  /**
   * formGmaps
   * @author Florian Mathis <flo@massiveart.com>
   * @param string $name
   * @param string $value
   * @param array $attribs
   * @param mixed $options   
   * @version 1.0
   */
  public function formGmaps($name, $value = null, $attribs = null, $options = null){
    $info = $this->_getInfo($name, $value, $attribs);
    extract($info); // name, value, attribs, options, listsep, disable
    $blnStdLatLng = true;

    // XHTML or HTML end tag
    $endTag = ' />';
    if (($this->view instanceof Zend_View_Abstract) && !$this->view->doctype()->isXhtml()) {
      $endTag= '>';
    }
    
    $strOutput = ' <script type="text/javascript">
	    function initialize() {
	      if (GBrowserIsCompatible()) {
	        var map = new GMap2(document.getElementById("map_canvas"));
	        map.addControl(new GSmallMapControl());
          map.addControl(new GMapTypeControl());
          map.addControl(new GScaleControl());
          map.enableDoubleClickZoom();
          map.enableContinuousZoom();
          map.enableScrollWheelZoom();
      ';

    // Display Standard Marker to Bregenz AT if lat/lng is empty
    if(isset($value['latitude']) && isset($value['longitude'])) {
      if($value['latitude'] != '' && $value['longitude'] != '') {
      	$blnStdLatLng=false;
      }
    }
    
    if($blnStdLatLng) {
    	$value['latitude'] = '47.503042';
    	$value['longitude'] = '9.747067';
    	$strOutput .= '
    	    var center = new GLatLng(47.503042, 9.747067);
          map.setCenter(center, 8);';
    } else {
    	$strOutput .= '
          var center = new GLatLng('.$value['latitude'].', '.$value['longitude'].');
          map.setCenter(center, 8);';
    }
    
    $strOutput .= '
          var marker = new GMarker(center, {draggable: true});
	        GEvent.addListener(marker, "drag", function() {
	          var pos = marker.getLatLng();
	          document.getElementById("'.$this->view->escape($id).'Latitude").value = pos.lat();
	          document.getElementById("'.$this->view->escape($id).'Longitude").value = pos.lng();
	        });
	        map.addOverlay(marker);
	      }
	    }
	    initialize();
    </script>
    <div id="map_canvas" style="width: 500px; height: 300px"></div>';
    

    // Hidden Fields Latitude and Longitude
     $strOutput .= '<input type="hidden" value="'.$this->view->escape($value['latitude']).'" id="'.$this->view->escape($id).'Latitude" name="'.$this->view->escape($name).'Latitude"  '.$endTag.'
                    <input type="hidden" value="'.$this->view->escape($value['longitude']).'" id="'.$this->view->escape($id).'Longitude" name="'.$this->view->escape($name).'Longitude"  '.$endTag.'';
 
    return $strOutput;
  }
}

?>