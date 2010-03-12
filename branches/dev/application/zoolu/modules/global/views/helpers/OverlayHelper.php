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
 * @package    application.zoolu.modules.global.views.helpers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * OverlayHelper
 *
 * Version history (please keep backward compatible):
 * 1.0, 2009-12-17: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class OverlayHelper {

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
   * getProductTree
   * @author Thomas Schedler <tsh@massiveart.com>
   * @version 1.0
   */
  public function getProductTree($objRowset, $strItemAction, $arrProductIds = array()) {
    $this->core->logger->debug('cms->views->helpers->OverlayHelper->getProductTree()');

    $strOutput = '';

    if(count($objRowset) > 0){
      $intLastFolderId = 0;
      foreach ($objRowset as $objRow){
        $strHidden = '';
        if(array_search($objRow->productId, $arrProductIds) !== false){
         $strHidden = ' style="display:none;"';
        }

        if($intLastFolderId != $objRow->folderId){

          $intFolderDepth = $objRow->depth;

          $strOutput .= '<div id="folder'.$objRow->folderId.'" class="olnavrootitem">
                           <div style="position:relative; padding-left:'.(20*$intFolderDepth).'px">
                             <div class="icon img_folder_'.(($objRow->folderStatus == $this->core->sysConfig->status->live) ? 'on' : 'off').'"></div>'.htmlentities($objRow->folderTitle, ENT_COMPAT, $this->core->sysConfig->encoding->default).'
                           </div>
                         </div>';

          $intLastFolderId = $objRow->folderId;
        }

        if($objRow->idProduct > 0){
          $strOutput .= '
                        <div id="olItem'.$objRow->productId.'" class="olnavrootitem"'.$strHidden.'>
                          <div style="display:none;" id="Remove'.$objRow->idProduct.'" class="itemremovelist2"></div>
                          <div id="Item'.$objRow->idProduct.'" style="position:relative; margin-left:'.(20*$intFolderDepth+20).'px; cursor:pointer;" onclick="'.$strItemAction.'('.$objRow->idProduct.', \''.$objRow->productId.'\'); return false;">
                            <div class="icon img_'.(($objRow->isStartProduct == 1) ? 'startproduct' : 'product').'_'.(($objRow->productStatus == $this->core->sysConfig->status->live) ? 'on' : 'off').'"></div>'.htmlentities($objRow->productTitle, ENT_COMPAT, $this->core->sysConfig->encoding->default).'
                          </div>
                        </div>';
        }
      }
    }

    /**
     * return html output
     */
    return $strOutput;
  }
}

?>