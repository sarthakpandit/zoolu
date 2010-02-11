/*
 * Blog Widget
 * @version 1.0
 */

/*
 * widgetBlogAddComment
 * @author Florian Mathis <flo@massiveart.com>
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

/**
 * updateCommentList
 * @author Florian Mathis <flo@massiveart.com>
 * @version 1.0
 */
function updateCommentList(){
	new Ajax.Updater('blogWidgetCommentForm', '/widget/blog/form/addblogcomment', {
      parameters: $('blogWidgetCommentForm').serialize(),
      onSuccess: function(){
		$('blogWidgetCommentInfo').innerHTML = 'Vielen Dank f&uuml;r Ihren Kommentar!';
	  }
	});
}