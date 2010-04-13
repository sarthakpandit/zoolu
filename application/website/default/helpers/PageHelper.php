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
   * @var Zend_Translate
   */
  protected $objTranslate;
  
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
   * getProductCarousel
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getProductCarousel(){
    //TODO default product overview
  }
  
  /**
   * getSubPagesOverview
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getSubPagesOverview(){
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
   * getVideos
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @return string
   */
  public function getVideos(){
    //TODO default videos
  }
  
  /**
   * getIframe
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @return string
   */
  public function getIframe(){
    //TODO iframe output
  }
  
  /**
   * getForm
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @return string
   */
  public function getForm(){
    // TODO form output
  }
  
  /**
   * getFormSuccess
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @return string
   */
  public function getFormSuccess(){
    // TODO form success message output
  }
  
  /**
   * getPressContact
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getPressContact(){
    //TODO default product overview
  }
  
  /**
   * getContact
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @return string
   */
  public function getContact($strTitle = ''){
    //TODO default product overview
  }
  
  /**
   * getLocationContacts
   * @author Cornelius Hansjakob <cha@massiveart.com>
   * @return string
   */
  public function getLocationContacts($strContinent = '', $strCountry = ''){
    //TODO default product overview
  }
  
  /**
   * getPressPics
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getPressPics(){
    //TODO default product overview
  }
  
  /**
   * getExternalLinks
   * @author Thomas Schedler <tsh@massiveart.com>
   * @return string
   */
  public function getExternalLinks(){
    $strReturn = '';
    
    $objMyMultiRegion = $this->objPage->getRegion(50); //50 is the default external linkk region
  
    if($objMyMultiRegion instanceof GenericElementRegion){
      $strReturn .= '<div class="links">';
      
      if($this->objPage->getField('title_externe_links') && $this->objPage->getFieldValue('title_externe_links') != ''){
        $strReturn .= '<h2>'.htmlentities($this->objPage->getFieldValue('title_externe_links'), ENT_COMPAT, $this->core->sysConfig->encoding->default).'</h2>';
      }
      
      foreach($objMyMultiRegion->RegionInstanceIds() as $intRegionInstanceId){
        $strTitle = htmlentities($objMyMultiRegion->getField('link_title')->getInstanceValue($intRegionInstanceId), ENT_COMPAT, $this->core->sysConfig->encoding->default);
        $strUrl = $objMyMultiRegion->getField('link_url')->getInstanceValue($intRegionInstanceId);
        if(filter_var($strUrl, FILTER_VALIDATE_URL)){
          $strReturn .= '<div class="item"><a href="'.$strUrl.'">'.$strTitle.'</a></div>';
        }else if(filter_var('http://'.$strUrl, FILTER_VALIDATE_URL)){
          $strReturn .= '<div class="item"><a href="http://'.$strUrl.'">'.$strTitle.'</a></div>';
        }
      }
      $strReturn .= '</div>';
    }
    
    return $strReturn;
  }
    
  /**
   * setPage    
   * @param Page $objPage   
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function setPage(Page $objPage){
    $this->objPage = $objPage;
  }
  
  /**
   * setTranslate    
   * @param Zend_Translate $objTranslate   
   * @author Thomas Schedler <tsh@massiveart.com>
   */
  public function setTranslate(Zend_Translate $objTranslate){
    $this->objTranslate = $objTranslate;
  }
}

/**
 * function call wrapper for PageHelper
 */
require_once(dirname(__FILE__).'/page.inc.php');

?>