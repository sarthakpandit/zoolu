    <!-- Content Section -->
  <div class="wrapper content">
    <div class="subwrapper">
      <div class="inner detail">        
        <!-- Sub Navigation -->

        <!-- Main Content -->
				<?php if (isset($this->objEntry->title)): print '<h1>'.$this->objEntry->title.'</h1>'; endif; ?>
				von <em><?php if (isset($this->objEntry->username)): print $this->objEntry->username; endif; ?></em> am
				<?php if (isset($this->objEntry->created)): print date("d.m.Y\, H:i \\U\\h\\r",strtotime($this->objEntry->created)); endif; ?>
				<br/><br/>
				<?php print $this->objEntry->text; ?>
			 
			 <?php 
			 	if(count($this->arrTags) > 0):
			 		print 'Tags: ';
			 		$strTags="";
			 		foreach($this->arrTags AS $tag):
			 			$strTags .= $tag['title']. ', ';
			 		endforeach;	
			 		print trim($strTags, ', ').'<br/><br/>';	
			 	endif;
			 ?>
			 
			 <div id="blogWidgetCommentInfo"></div>
				<form name="addComment" method="post" id="blogWidgetCommentForm" onsubmit="javascript:widgetBlogAddComment(); return false;">
					<strong>Eine Antwort schreiben</strong><br/>
					<input type="hidden" name="idBlogentry" value="<?php print $this->objEntry->blogEntryId; ?>"/>
					<label for="name">Name</label><input type="text" name="name"/><br/>
					<label for="mail">Mail</label><input type="text" name="mail"/><br/>
					<textarea name="text"></textarea><br/>
					<input type="submit" name="submit" value="Absenden"/>
				</form>
				
				<?php 
					if(count($this->comments) > 0):
						foreach($this->comments AS $comment):
							print '<div style="margin-bottom: 20px; background-color: #CCCCCC; padding: 5px;"><strong><a href="mailto:'.$comment['mail'].'">'. $comment['title'].'</a></strong>:<br/><i>'.$comment['created'].'</i><br/>'.$comment['text'].'</div>';
						endforeach;
					endif;
				?>
        <div class="clear"></div>
      </div>  
    </div>
  </div>