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
			 
				<form name="addComment" method="post" id="blogWidgetCommentForm" onsubmit="javascript:widgetBlogAddComment()">
					<strong>Eine Antwort schreiben</strong><br/>
					<label for="name">Name</label><input type="text" name="name"/><br/>
					<label for="mail">E-Mail</label><input type="text" name="mail"/><br/>
					<textarea name="text"></textarea><br/>
					<input type="submit" name="submit" value="Absenden"/>
				</form>
        <div class="clear"></div>
      </div>  
    </div>
  </div>