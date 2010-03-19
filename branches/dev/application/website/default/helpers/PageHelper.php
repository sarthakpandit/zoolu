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
 * @package    application.zoolu.modules.cms.views
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * PageHelper
 *
 * Version history (please keep backward compatible):
 * 1.0, 2010-02-04: Thomas Schedler
 *
 * @author Thomas Schedler <tsh@massiveart.com>
 * @version 1.0
 */

class PageHelper {
  
  /**
   * @var Core
   */
  protected $core;
  
  /**
   * @var Page
   */
  protected $objPage;

  /**
   * constructor
   * @author Thomas Schedler <tsh@massiveart.com>   
   */
  public function __construct(){
    $this->core = Zend_Registry::get('Core');
  }
  
  /**
   * getPagesOverview
   * @param string $strImageFolder
   * @param string $strThumbImageFolder
   * @return string $strReturn
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @version 1.0
   */
  public function getPagesOverview($strImageFolder = '80x80', $strThumbImageFolder = '40x40'){
      
    $arrPagesOverview = $this->objPage->getPagesContainer();
  
    $strReturn = '';
    if(count($arrPagesOverview) > 0){
      foreach($arrPagesOverview as $key => $this->objPageContainer){
        if(count($this->objPageContainer) > 0){
  
          $strCssClassPostfix = '';
          if($key < 2){
            $strCssClassPostfix = ' pright20';
          }
  
          if($key < 3){
  
            $strReturn .= '
                 <div class="col3'.$strCssClassPostfix.'">
                    <h3>'.htmlentities($this->objPageContainer->getContainerTitle(), ENT_COMPAT, $this->core->sysConfig->encoding->default).'</h3>';
  
            $arrPageEntries = $this->objPageContainer->getEntries();
  
            $strTopPostHtmlOutput = '';
            $strLinkItemsHtmlOutput = '';
  
            if(count($arrPageEntries) > 0){
              $counter = 0;
              foreach($arrPageEntries as $this->objPageEntry){
                if($counter == 0){
  
                  $strTopPostHtmlOutput .= '
                    <div class="divTopPost">
                      <h2><a href="'.$this->objPageEntry->url.'">'.htmlentities($this->objPageEntry->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</a></h2>';
                  if($this->objPageEntry->filename != ''){
                    $strTopPostHtmlOutput .= '
                     <div class="divImgLeft">
                       <img alt="'.$this->objPageEntry->filetitle.'" title="'.$this->objPageEntry->filetitle.'" src="'.$this->core->webConfig->domains->static->components.$this->core->sysConfig->media->paths->imgbase.$this->objPageEntry->filepath.$strImageFolder.'/'.$this->objPageEntry->filename.'?v='.$this->objPageEntry->fileversion.'"/>
                     </div>';
                  }
                  $strTopPostHtmlOutput .= '
                      '.(($this->objPageEntry->shortdescription != '') ? '<p>'.htmlentities($this->objPageEntry->shortdescription, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</p>' : $this->objPageEntry->description).'
                      <a href="'.$this->objPageEntry->url.'">Weiter lesen...</a>
                    </div>';
  
                }else{
                  $this->objPage->setCreateDate($this->objPageEntry->created);
  
                  $strLinkItemsHtmlOutput .= '
                      <div class="divListItemImg">';
                  if($this->objPageEntry->filename != ''){
                    $strLinkItemsHtmlOutput .= '
                        <div class="divListItemImgLeft">
                          <a href="'.$this->objPageEntry->url.'"><img title="'.$this->objPageEntry->filetitle.'" alt="'.$this->objPageEntry->filetitle.'" src="'.$this->core->webConfig->domains->static->components.$this->core->sysConfig->media->paths->imgbase.$this->objPageEntry->filepath.$strThumbImageFolder.'/'.$this->objPageEntry->filename.'?v='.$this->objPageEntry->fileversion.'"/></a>
                        </div>';
                  }
                  $strLinkItemsHtmlOutput .= '
                        <div class="divListItemImgRight">
                          <a href="'.$this->objPageEntry->url.'">'.htmlentities($this->objPageEntry->title, ENT_COMPAT, $this->core->sysConfig->encoding->default).'</a><br/>
                          <span>Erstellt am</span> <span class="black">'.$this->objPage->getCreateDate().'</span>
                        </div>
                        <div class="clear"></div>
                      </div>';
                }
                $counter++;
              }
            }
  
            $strReturn .= $strTopPostHtmlOutput;
            if($strLinkItemsHtmlOutput != ''){
              $strReturn .= '
                  <div class="divListContainer">
                    <h3>Weitere Themen</h3>';
              $strReturn .= $strLinkItemsHtmlOutput;
              $strReturn .= '
                    <div class="clear"></div>
                  </div>';
            }
            $strReturn .= '
                  <div class="clear"></div>
                </div>';
          }
        }
      }
    }
  
    return $strReturn;
  }
  
  /**
   * getCategoryIcons
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getCategoryIcons(){
    //TODO default category icons
  }
    
  /**
   * getProductOverview
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getProductOverview(){
    //TODO default product overview
  }
      
  /**
   * getPressOverview
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getPressOverview(){
    //TODO default product overview
  }
  
  /**
   * getLanguageChooser
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getLanguageChooser(){
    //TODO default product overview
  }
  
  /**
   * setPage    
   * @param Page $objPage   
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function setPage(Page $objPage){
    $this->objPage = $objPage;
  }
}

/**
 * function call wrapper for PageHelper
 */
require_once(dirname(__FILE__).'/page.inc.php');

?>