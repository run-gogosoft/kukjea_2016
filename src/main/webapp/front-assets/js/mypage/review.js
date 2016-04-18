var submitProc = function(obj) {
	var flag = true;
	$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
		if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {
			alert($(this).attr("alt") + "란을 입력해주세요!");
			flag = false;
			$(this).focus();
		}
	});
	return flag;
};

var CHBoardUtil = {
	checkText:function() {
		var searchStr = "";
		if (searchStr != $('#reviewContent').val()) {
			CHBoardUtil.contentLength($('#reviewContent'));
		}
		setTimeout('CHBoardUtil.checkText()', 100);
	}
	, contentLength:function(obj){
		var cutText = $(obj).val();
		var stringLength = $(obj).val().length;
		if(stringLength > 500) {
			stringLength=500;
			cutText = cutText.substring(0, stringLength);
		}
		$(obj).val(cutText);
		$('#contentLength').text(stringLength);
	}
	, writeButton:function (count){
		$(".review-layer"+count).show();
	}
	, writeClose:function () {
		$(".hh-writebox").hide();
		$('#reviewContent').val('');
		$('#goodGrade').val(0);
		$('#itemRating').text(0)
		$('#contentLength').text(0);
		for(var i=1; i<=5; i++){
			$('.star-right-'+i).hide();
			$('.star-left-'+i).hide();
		}
	}
	, selectRate:function(obj) {
		//점수에 따른 별표를 표시하기전 모두 초기화시킨다.
		for(var i=1; i<=5; i++){
			$('.star-right-'+i).hide();
			$('.star-left-'+i).hide();
		}

		var rateValue = parseInt($(obj).val(),10) || 0;
		rateValue === 0 ? $('#itemRating').text(0) : $('#itemRating').text(rateValue);

		for(var i=1; i<=rateValue; i++){
			$('.star-right-'+i).show();
			$('.star-left-'+i).show();
		}
	}
};

var CHToggleUtil = {
	toggleDisplay:function(arg) {
		if($('#'+arg).css("display")=='none') {
			$('#'+arg).show();
		} else {
			$('#'+arg).hide();
		}
	}
};