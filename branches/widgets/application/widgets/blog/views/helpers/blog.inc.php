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
 * @package    application.widgets.blog.views.helpers
 * @copyright  Copyright (c) 2008-2009 HID GmbH (http://www.hid.ag)
 * @license    http://www.gnu.org/licenses/gpl-3.0.html GNU General Public License, Version 3
 * @version    $Id: version.php
 */

/**
 * Blog Methods
 * 
 * Version history (please keep backward compatible):
 * 1.0, 2010-01-22: Florian Mathis
 * 
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */

/**
 * get_tags
 * @return void
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */
function get_tags($objWidgetTag){
	$tags = $objWidgetTag->getTags();
	
	// in css file, blogWidgetTag1-5
	$min_size = 1;
	$max_size = 5;
	
	$minimum_count = min(array_values($tags));
	$maximum_count = max(array_values($tags));
	$spread = $maximum_count - $minimum_count;

	if($spread == 0) {
		$spread = 1;
	}
	
	$cloud_html = '';
	$cloud_tags = array();
	
	foreach ($tags as $tag => $count) {
		$size = $min_size + ($count - $minimum_count)
		* ($max_size - $min_size) / $spread;
		
		$cloud_tags[] = '<span class="blogWidgetTag'.floor($size).'">'
		. htmlspecialchars(stripslashes($tag)) . '</span>';
	}
	$cloud_html = join("\n", $cloud_tags) . "\n";
	
	echo $cloud_html;
}

/**
 * has_tags
 * @return boolean
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */
function has_tags($objWidgetTag){	
	if(count($objWidgetTag) > 0){
    return true;  
  }else{
    return false;
  }
}

?>