<?php
/**
 * ZOOLU - Content Management System
 * Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 *
 * LICENSE
 *
 * This file is part of ZOOLU.
 *
 * ZOOLU is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * ZOOLU is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ZOOLU. If not, see http://www.gnu.org/licenses/gpl-3.0.html.
 *
 * For further information visit our website www.getzoolu.org
 * or contact us at zoolu@getzoolu.org
 *
 * @category   ZOOLU
 * @package    application.zoolu.modules.products.views
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * NavigationHelper
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-10-28: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class NavigationHelper {

	/**
   * @var Core
   */
  private $core;

  /**
   * Constructor
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }

	/**
   * getMainNavigation
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  function getMainNavigation($objRowset, $strViewType = '') {
    $this->core->logger->debug('cms->views->helpers->NavigationHelper->getMainNavigation()');

  	$strOutput = '';

    foreach ($objRowset as $objRow) {
      /**
       * get values of the row and create output
       */
      $strSelected = '';

      if($objRow->href != '' && $strViewType != '' &&strpos($objRow->href, $strViewType) !==  false) {
        $strSelected = ' selected';
        $strOutput .=  '
        <script type="text/javascript">//<![CDATA[
          var rootLevelId = '.$objRow->id.';
        //]]>
        </script>';
      }

      $strOnclick = ($objRow->href != '') ? 'location.href=\''.$objRow->href.'\'' : 'myNavigation.selectPortal('.$objRow->id.'); myNavigation.loadDashboard();';
      $strOutput .= '
      <div class="naviitemcontainer">
        <div id="naviitem'.$objRow->id.'top" class="top'.$strSelected.'"><img src="/zoolu/images/main/bg_box_230_top.png" width="230" height="4"/></div>
        <div id="naviitem'.$objRow->id.'" class="naviitem'.$strSelected.'" onclick="'.$strOnclick.'; return false;">
          <div class="producticon"></div>
          <div id="divRootLevelTitle_'.$objRow->id.'" class="itemtitle">'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
          <div class="clear"></div>
        </div>
        <div id="naviitem'.$objRow->id.'bottom" class="bottom'.$strSelected.'"><img src="/zoolu/images/main/bg_box_230_bottom.png" width="230" height="4"/></div>
        <div class="clear"></div>
      </div>';
    }

    return $strOutput;
  }

  /**
   * getNavigationElements
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  function getNavigationElements($objRowset, $currLevel) {
  	$this->core->logger->debug('cms->views->helpers->NavigationHelper->getNavigationElements()');

    $strOutput = '';
    $strOutputStartproduct = '';

    $counter = 1;

    if(count($objRowset) > 0){
    	foreach ($objRowset as $objRow){

    		if($objRow->isStartProduct == 1){
    		  /**
           * overwrite type with 'product'
           */
          $objRow->type = 'product';

    			/**
           * get values of the row and create startproduct output
           */
          $strOutputStartproduct .= '<div id="'.$objRow->type.$objRow->id.'" class="'.$objRow->type.'">
            <div class="icon img_startproduct_'.(($objRow->idStatus == $this->core->sysConfig->status->live) ? 'on' : 'off').'"></div>
            <div class="title" onclick="myNavigation.getEditForm('.$objRow->id.',\''.$objRow->type.'\',\''.$objRow->genericFormId.'\','.$objRow->version.','.$objRow->templateId.','.$objRow->linkProductId.'); return false;">'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
          </div>';
    		}else if($objRow->productType == $this->core->sysConfig->product_types->product->id){
    		  /**
           * get values of the row and create product output
           */
          $strOutput .= '<div id="'.$objRow->type.$objRow->id.'" class="'.$objRow->type.'">
            <div class="icon img_'.$objRow->type.'_'.(($objRow->idStatus == $this->core->sysConfig->status->live) ? 'on' : 'off').'"></div>
            <div class="navsortpos"><input class="iptsortpos" type="text" name="pos_'.$objRow->type.'_'.$objRow->linkProductId.'" id="pos_'.$objRow->type.'_'.$objRow->linkProductId.'" value="'.$counter.'" onfocus="myNavigation.toggleSortPosBox(\'pos_'.$objRow->type.'_'.$objRow->linkProductId.'\'); return false;" onkeyup="if(event.keyCode==13){ myNavigation.updateSortPosition(\'pos_'.$objRow->type.'_'.$objRow->linkProductId.'\',\''.$objRow->type.'\','.$currLevel.'); myNavigation.toggleSortPosBox(\'pos_'.$objRow->type.'_'.$objRow->linkProductId.'\'); return false; }" onblur="myNavigation.toggleSortPosBox(\'pos_'.$objRow->type.'_'.$objRow->linkProductId.'\'); return false;" /></div>
            <div class="title" onclick="myNavigation.getEditForm('.$objRow->id.',\''.$objRow->type.'\',\''.$objRow->genericFormId.'\','.$objRow->version.','.$objRow->templateId.','.$objRow->linkProductId.'); return false;">'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
          </div>';

          $counter++;

    		}else{
          if(Security::get()->isAllowed(Security::RESOURCE_FOLDER_PREFIX.$objRow->id, Security::PRIVILEGE_VIEW)){
      			/**
  	         * get values of the row and create default output
  	         */
  	        $strOutput .= '<div id="'.$objRow->type.$objRow->id.'" class="'.$objRow->type.'">
              <div id="divNavigationEdit_'.$objRow->id.'" class="icon img_'.$objRow->type.'_'.(($objRow->idStatus == $this->core->sysConfig->status->live) ? 'on' : 'off').'" ondblclick="myNavigation.getEditForm('.$objRow->id.',\''.$objRow->type.'\',\''.$objRow->genericFormId.'\','.$objRow->version.','.$objRow->templateId.'); return false;"></div>
              <div class="navsortpos"><input class="iptsortpos" type="text" name="pos_'.$objRow->type.'_'.$objRow->id.'" id="pos_'.$objRow->type.'_'.$objRow->id.'" value="'.$counter.'" onfocus="myNavigation.toggleSortPosBox(\'pos_'.$objRow->type.'_'.$objRow->id.'\'); return false;" onkeyup="if(event.keyCode==13){ myNavigation.updateSortPosition(\'pos_'.$objRow->type.'_'.$objRow->id.'\',\''.$objRow->type.'\','.$currLevel.'); myNavigation.toggleSortPosBox(\'pos_'.$objRow->type.'_'.$objRow->id.'\'); return false; }" onblur="myNavigation.toggleSortPosBox(\'pos_'.$objRow->type.'_'.$objRow->id.'\'); return false;"/></div>
              <div id="divNavigationTitle_'.$objRow->type.$objRow->id.'" class="title" onclick="myNavigation.selectNavigationItem('.$currLevel.', \''.$objRow->type.'\','.$objRow->id.'); return false;">'.htmlentities($objRow->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</div>
            </div>';
          }

          $counter++;
    		}
    	}

    	if($strOutputStartproduct != ''){
    	  $strOutputStartproduct .= '<div class="linegray"></div>';
      }
    }

    return $strOutputStartproduct.$strOutput;

  }

}

?>