$(document).ready(function() {
	//페이징 클래스 추가
	$("#paging>ul").addClass("ch-pagination");
	$('.datepicker').datepicker({
		autoclose: true
	});

	var arrayStr = ['order', 'cancel', 'estimate', 'compare', 'NP_CARD2', 'taxrequest', 'confirm', 'delivery', 'direct'];
	for(var i=0; i<$(".sub-list li").length; i++) {
		if(location.pathname.match(arrayStr[i])) {
			$(".sub-list li").eq(i).find('a').addClass('current');
			return false;
		}
	}
});

//날짜 계산
var calcDate = function(val) {
	if(val === "clear") {
		$("input[name=searchDate1]").val( '2014-01-01' );
		$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
	} else {
		$("input[name=searchDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
		$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
	}
};