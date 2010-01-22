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
 * @package    application.widgets.blog.models
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Model_BlogTags
 *
 *
 * Version history (please keep backward compatible):
 * 1.0, 2010-01-13: Florian Mathis
 *
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.1
 */

class Model_BlogTags {	
	/**
	 * @var Core
	 */
	protected $core;
	
	/**
	 * @var Model_Table_BlogEntriesTag
	 */
	protected $objBlogEntriesTagTable;
	
	public function __construct() {
		$this->core = Zend_Registry::get('Core');
	}
	
	public function getTagCloud(){
		$this->core->logger->debug('widgets->blog->Model_BlogTags->getTagCloud()');
		
		$objSelect = $this->getBlogEntryTagTable()->select();
		$objSelect->setIntegrityCheck(false);
		$objSelect->from('tags', array('title', 'count(tagSubwidgets.idTags) AS c', 'MAX(c) AS maxC', 'MIN(c) AS minC'));
		$objSelect->join('tagSubwidgets', 'tagSubwidgets.idTags = tags.id', array());
		$objSelect->group('tags.title');

		$tags = array();
		foreach($this->objBlogEntriesTagTable->fetchAll($objSelect) AS $keywords) {
			array_push($tags,array('count' => $keywords->count, $keywords->title));
		}
		
		echo var_dump($tags);
		
		/*
		$typecount = array_count_values($tags);
		$types = $tags;
		
		$max = max($typecount);
		$min = min($typecount);
		echo $max.'-'.$min;
		
		$x = 18; // 18px
		$y = 11; // 11px
		
		$stepvalue = ($max - $min) / ($x - $y);	
		
			for($i=0;$i<count($types);$i++)
		{
		  echo '<a href="/fonts?t='.$types[$i].'" 
		  style="font-size:'. ( $y + round( ($typecount[$types[$i]]-$min) / $stepvalue ) ).'px;">'. $types[$i].'</a>';
		  if($i<count($types)-1) echo ",\n";
		}*/
	}
	
	/**
   * getBlogEntryTagTable
   * @return Zend_Db_Table_Abstract
   * @author Florian Mathis <flo@massiveart.com>
   * @version 1.0
   */
  public function getBlogEntryTagTable(){
    if($this->objBlogEntriesTagTable === null) {
      require_once GLOBAL_ROOT_PATH.'application/widgets/blog/models/tables/BlogEntriesTag.php';
      $this->objBlogEntriesTagTable = new Model_Table_BlogEntriesTag();
    }

    return $this->objBlogEntriesTagTable;
  }
}

?>