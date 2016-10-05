var submitProc = function(obj) {
	if($("#statusCode").val() !== '55') {
		var flag = true;
		if ($(obj).find('textarea[name=reason]').val() === '') {
			alert('사유를 입력해주세요.');
			return false;
		}

		if ($("#statusCode").val() == '99'){
			$("#orderModal").modal('show');
		}
		return flag
	}
};

var updateOrderStatus = function(seq, orderSeq, statusCode) {
	$("#seq").val(seq);
	$("#orderSeq").val(orderSeq);
	$("#statusCode").val(statusCode);

	if (!confirm("구매 확정 하시겠습니까?")) {
		return;
	}
	$("#updateOrderStatus").attr('action','/shop/mypage/order/status/update/proc');
	$("#updateOrderStatus").submit();
};

var hhWrite = {
	writeButton:function (statusCode, seq, orderSeq, cancelType){
		$("#seq").val(seq);
		$("#orderSeq").val(orderSeq);
		$("#statusCode").val(statusCode);
		$("#cancelType").val(cancelType);

		if(statusCode==='60'){
			$('.hh-writebox-header .title').text('교환신청');
			$('#reasonText').html('교환요청사유');
		} else if(statusCode==='70'){
			$('.hh-writebox-header .title').text('반품신청');
			$('#reasonText').html('반품요청사유');
		} else if(statusCode==='90') {
			$('.hh-writebox-header .title').text('취소신청');
			$('#reasonText').html('취소요청사유');
		} else if(statusCode==='99') {
			$('.hh-writebox-header .title').text('주문취소');
			$('#reasonText').html('주문취소사유');
			$('#submitBtn').text('취소하기');
		}



		$('#statusCode').val(statusCode)



		hhWrite.renderItem(seq);

		if(statusCode==='99') {
			$("#updateOrderStatus").attr('action','/shop/mypage/order/cancel');
		} else {
			$("#updateOrderStatus").attr('action','/shop/mypage/order/status/update/proc');
		}

		$(".hh-writebox-layer").show();
	}
	,writeClose:function () {
		$(".hh-writebox-layer").hide();
		$('#reason').val('');
	}
	,renderItem:function(seq) {
		$.ajax({
			type:"GET",
			url:"/shop/mypage/item/info/ajax",
			dataType:"text",
			data:{seq:seq},
			success:function(data) {
				var vo = $.parseJSON(data);
				$("#itemTarget").html( $("#itemTemplate").tmpl(vo));
			}
		});
	}
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
		$(".hh-review-writebox").hide();
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

var viewDelivery = function(url, no) {
	window.open(url+no);
}

//현대 택배 전용폼
var viewDeliveryForHlc = function(trackUrl, deliNo) {
	var frm = document.getElementById("hlc");

	frm.InvNo.value = deliNo;
	frm.target = "_blank";

	frm.submit();
}

//Merge table cell
var mergeOrderSeqSell = function(orderSeq,seq,partCancelCnt) {
	var obj = "#tbodyOrderList td[data-merge-flag='"+orderSeq+"']";
	//첫번째 tr이후에 결제완료인 주문이 있으면 취소버튼이 가려지기 때문에 결제완료 주문이 있다면 무조건 첫번째 tr의td에 넣어준다.
	$(obj).each(function() {
		if(parseInt($(this).attr("data-merge-flag-statuscode")) < 20) {
			if(parseInt(partCancelCnt)!==1) {
				$(obj).find(".cancelDiv").html("<button class='btn btn_default btn_xs' style='margin-top:1px;' onclick=hhWrite.writeButton('99','" + seq + "','" + orderSeq + "','ALL')>전체주문 취소</button>");
			}
		}
	});

	if( $(obj).size() >= 2 ) {
		$(obj).each(function(idx) {
			if(idx === 0) {
				$(this).attr("rowspan", $(obj).size()).css({"border-bottom":"1px #ddd solid"});
			} else {
				$(this).remove();
			}
		});
	}
};

//Merge table cell
var mergeOrderDetailSell = function(orderSeq,seq,partCancelCnt) {
	var obj = "#tbodyOrderList td[data-detail-merge-flag='"+orderSeq+"']";
	if( $(obj).size() >= 2 ) {
		$(obj).each(function(idx) {
			if(idx === 0) {
				$(this).attr("rowspan", $(obj).size()).css({"border-bottom":"1px #ddd solid"});
			} else {
				$(this).remove();
			}
		});
	}
};