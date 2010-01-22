    <!-- Content Section -->
  <div class="wrapper content">
    <div class="subwrapper">
      <div class="inner detail">        
        <!-- Sub Navigation -->        
        <!-- Main Content -->
        <?php foreach($this->objEntries AS $entry): ?>
	        <div class="divContentContainer">
	        	<?php if (isset($entry->title)): print '<h1><a href="'.$entry->url.'">'. $entry->title .'</a></h1>'; endif; ?>
	        	von <em><?php if (isset($entry->username)): print $entry->username; endif; ?></em> am <?php if (isset($entry->created)): print $entry->created; endif; ?><br/><br/>
	        	<?php if (isset($entry->text)): if(strlen($entry->text) > 1500): print substr($entry->text,0,1500).' ...'; else: print $entry->text; endif; endif; ?>
	          <div class="clear"></div>
	        </div>
        <?php endforeach; ?>
        <div class="clear"></div>
        <?php print $this->pager($this->total, $this->perPage)->paginate() ?>
      </div>  
    </div>
  </div>