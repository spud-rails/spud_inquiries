$(function() {
	var initWysiwym = function() {
		$('textarea.wysiwym').wymeditor({
			basePath:'/assets/wymeditor/'
		});
	}
	initWysiwym();
});