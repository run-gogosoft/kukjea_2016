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