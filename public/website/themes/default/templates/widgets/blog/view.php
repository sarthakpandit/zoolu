    <!-- Content Section -->
  <div class="wrapper content">
    <div class="subwrapper">
      <div class="inner detail">        
        <!-- Sub Navigation -->
        <?php include dirname(__FILE__).'/../../../includes/subnavigation.inc.php'; ?>
        
        <!-- Main Content -->
				<?php if (isset($this->objEntry->title)): print '<h1>'.$this->objEntry->title.'</h1>'; endif; ?>
				von <em><?php if (isset($this->objEntry->username)): print $this->objEntry->username; endif; ?></em> am <?php if (isset($this->objEntry->created)): print date("d.m.Y\, H:i \\U\\h\\r",strtotime($this->objEntry->created)); endif; ?><br/><br/>
				<?php print $this->objEntry->text; ?>
				
				<form name="addComment" method="post">
					<strong>Eine Antwort schreiben</strong><br/>
					<input type="text" name="name"/> Name<br/>
					<input type="text" name="email"/> Email<br/>
					<textarea name="text"></textarea><br/>
					<input type="submit" value="Absenden"/>
				</form>
        <div class="clear"></div>
      </div>  
    </div>
  </div>