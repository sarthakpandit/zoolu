    <!-- Content Section -->
  <div class="wrapper content">
    <div class="subwrapper">
      <div class="inner detail">        
        <!-- Sub Navigation -->
        <?php include dirname(__FILE__).'/../../../includes/subnavigation.inc.php'; ?>
        
        <!-- Main Content -->
        <?php foreach($this->objEntries AS $entry): ?>
	        <div class="divContentContainer">
	        	<?php if (isset($entry->title)): print '<h1><a href="'.$this->strWidgetUrl.'/view/'.date("Y/m/d", strtotime($entry->created)).'/'. ereg_replace(' ','-',$entry->title).'">'. $entry->title .'</a></h1>'; endif; ?>
	        	von <em><?php if (isset($entry->username)): print $entry->username; endif; ?></em> am <?php if (isset($entry->created)): print $entry->created; endif; ?><br/><br/><?php if (isset($entry->text)): print $entry->text; endif; ?>
	          <div class="clear"></div>
	        </div>
        <?php endforeach; ?>
        <div class="clear"></div>
      </div>  
    </div>
  </div>