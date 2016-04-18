$(document).ready(function() {
	// image flip
	$(".img img[data-src]").mouseover(function(){
		if(typeof $(this).attr("data-swap") === "undefined") {
			$(this).attr("data-swap", $(this).attr("src"));
		}
		$(this).attr("src", $(this).attr("data-src"));
	}).mouseleave(function(){
		$(this).attr("src", $(this).attr("data-swap"));

	});

  $("#paging>ul").addClass("ch-pagination");

  $('.ch-3col li').each(function(idx) {
  	if((idx+1) % 5 === 0) {
  		$(this).css({marginRight:0});
  	}
  });
});