/*
 * Blog Widget
 * @version 1.0
 */
function widgetBlogAddComment(){
	new Ajax.Updater('blogWidgetCommentForm', '/widget/blog/form/addblogcomment', {
        parameters: $('blogWidgetCommentForm').serialize()
	});
}