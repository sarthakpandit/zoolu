/*
 * Blog Widget
 * @version 1.0
 */
function widgetBlogAddComment(){
	new Ajax.Updater('blogWidgetCommentForm', '/widget/blog/comment/add', {
      parameters: $('blogWidgetCommentForm').serialize(),
      onSuccess: function(){
		$('blogWidgetCommentInfo').innerHTML = 'Vielen Dank f&uuml;r Ihren Kommentar!';
	  }
	});
}

function updateCommentList(){
	new Ajax.Updater('blogWidgetCommentForm', '/widget/blog/form/addblogcomment', {
      parameters: $('blogWidgetCommentForm').serialize(),
      onSuccess: function(){
		$('blogWidgetCommentInfo').innerHTML = 'Vielen Dank f&uuml;r Ihren Kommentar!';
	  }
	});
}