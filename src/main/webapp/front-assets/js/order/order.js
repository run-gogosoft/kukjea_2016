var EBDelivery = {
	list:[]
	, renderList:function(callback){
//		if(EBDelivery.list.length === 0) {
			$.ajax({
				url:"/shop/mypage/delivery/list/json",
				type:"get",
				data:{},
				dataType:"text",
				success:function(data) {
					/*if(data === "NOT LOGGED ON") {
						location.href = "/shop/login?status=expired";
					}*/
					var list = $.parseJSON(data);
					EBDelivery.list = list;

					if(typeof callback === "function") {
						callback();
					}
				}
			});
//		}
	}
	, renderListForced:function(){
		EBDelivery.list=[];
		EBDelivery.renderList({});
	}
	, getSeqForDefaultFlag: function() {
		for(var vo in EBDelivery.list) {
			if(EBDelivery.list[vo].defaultFlag === "Y") {
				return parseInt( EBDelivery.list[vo].seq, 10);
			}
		}
	}
	, mappingVo: function(seq) {
		for(var vo in EBDelivery.list) {
			if(parseInt(EBDelivery.list[vo].seq, 10) === seq) {
				for(var name in EBDelivery.list[vo]) {
					$("#deliveryTable").find("input[data-name="+name+"], select[data-name="+name+"]").val(EBDelivery.list[vo][name]);
				}
				break;
			}
		}
	}
	, deliveryListMappingVo: function(seq) {
		$.ajax({
			url:"/shop/mypage/delivery/list/json",
			type:"get",
			data:{},
			dataType:"text",
			success:function(data) {
				if(data === "NOT LOGGED ON") {
					location.href = "/shop/login?status=expired";
				}
				var list = $.parseJSON(data);
				EBDelivery.list = list;

				for(var vo in EBDelivery.list) {
					if(parseInt(EBDelivery.list[vo].seq, 10) === seq) {
						for(var name in EBDelivery.list[vo]) {
							$("#deliveryForm table").find("input[data-name="+name+"], select[data-name="+name+"]").val(EBDelivery.list[vo][name]);
							if(name === 'defaultFlag') {
								var flag = EBDelivery.list[vo][name] === 'Y' ? true : false;
								$("#deliveryForm table").find("input[data-name="+name+"]").prop('checked',flag);
							}
						}
						break;
					}
				}
			}
		});
	}
};

/** 포인트 적용 */
var applyPoint = function() {
	var curPoint = parseInt($("#cur_point").val(), 10);
	var totalPrice = parseInt($("#total_price").val(), 10);
	var point = 0;

	if($("#point").val().replace(/[^\d]/g, '') != "") {
		point = parseInt($("#point").val(), 10);
	}

	if( point <= 0) {
		alert("사용할 포인트 금액을 입력해 주세요.");
		return;
	}

	if(point%500 != 0){
		alert("포인트는 500 포인트 단위로 사용하실 수 있습니다.");
		return;
	}

	if( curPoint < point ) {
		alert("잔여 포인트 금액을 초과하여 사용할 수 없습니다.");
		return;
	}

	if( totalPrice < point ) {
		alert("구매 금액을 초과하여 사용할 수 없습니다.");
		return;
	}

	//총 할인금액 업데이트
	$("#totalDiscountPriceText").text(numeral(point).format("0,0"));
	//최종 구매금액 업데이트
	$("#payPriceText").text(numeral(totalPrice - point).format("0,0"));

	//적용 버튼 클릭 설정
	$("#apply_point_btn_click").val("Y");

	//전액 포인트결제일 경우 결제수단 disable 설정
	if(totalPrice - point == 0) {
		$("input[name='payMethod']").prop("disabled", true);
	}


	alert("포인트 사용이 적용되었습니다.");
};

/** 사용 포인트 자동 입력 */
var inputPointAll = function(obj) {
	if(obj.checked) {
		var curPoint = parseInt($("#cur_point").val(), 10);
		var totalPrice = parseInt($("#total_price").val(), 10);
		var point = 0;

		point = curPoint;
		if( totalPrice <= curPoint ) {
			point = totalPrice;
		}

		$("#point").val(point);

		//적용 버튼 클릭 여부 초기화
		$("#apply_point_btn_click").val("N");

	} else {
		initPoint();
	}
};

/** 포인트 사용 초기화 */
var initPoint = function() {
	//사용 포인트 금액
	$("#point").val("0");
	//총 할인금액
	$("#totalDiscountPriceText").text("0");
	//최종 구매금액
	$("#payPriceText").text( numeral($("#total_price").val()).format("0,0") );

	//적용 버튼 클릭 여부 초기화
	$("#apply_point_btn_click").val("N");

	//모두 적용하기 체크박스 클릭 초기화
	$("#apply_point_checkbox_click").prop("checked", false);

	//주결제수단 disable 초기화
	$("input[name='payMethod']").prop("disabled", false);
}

var submitProc = function(obj) {
	var flag = true;
	$(obj).find("input[alt]").each( function() {
		if(flag && $(this).val() == "") {
			alert($(this).attr("alt") + '을(를) 입력해주세요.');
			$(this).focus();
			flag = false;
		}
	});

	if(flag) {
		var totalPrice = parseInt($("#total_price").val(), 10);
		var point = 0;
		
		if($('#point').val() != null) {
			point = parseInt($('#point').val() ,10);
		}
		
		var payPrice = totalPrice - point;

		if( point > 0 && $("#apply_point_btn_click").val() == "N") {
			alert('포인트를 사용하시려면 적용하기 버튼을 클릭해 주세요');
			return false;
		}

		var payMethod = $("input[name='payMethod']:checked").val();

		if(payMethod == null && payPrice > 0 ) {
			alert("주결제 수단을 선택해 주세요.");
			return false;
		}
		
		if(obj.estimateCompareFlag != undefined && $("input[name='estimateCompareFlag']:checked").val() == null){
			alert("비교견적 요청 여부를 선택해 주세요.");
			return false;
		}

		if(payMethod == "NP_CARD2") {
			if(!confirm("신용카드 결제로 주문을 진행하시겠습니까?")) {
				return false;
			}
		}

		if(payMethod == "NP_CASH") {
			if(!confirm("무통장입금 결제로 주문을 진행하시겠습니까?")) {
				return false;
			}
		}

		$(obj.accountInfo).prop("disabled",true);
		if(payPrice > 0 && (payMethod == "CASH" || payMethod == "NP_CASH")) {
			$(obj.accountInfo).prop("disabled",false);
		}
		
		$('#receiverAddr2').val($('#addr2').val());
		$("#orderSubmitBtn").attr("disabled", true);
		$("#orderModal").modal('show');

		return true;
	}

	return false;
};


var CHDelivery = {
	submitCode:''
	, seq:0
	, deliveryListShow:function() {
		$('#deliveryTopTitle').text('◇ 배송지 목록을 확인 하실수 있습니다.');
		$("#deliverList").show().css({opacity:0, marginTop:100}).animate({opacity:1, marginTop:$("#deliveryTable").offset().top-100}, "slow");
		$("html, body").animate({scrollTop:$("#deliveryTable").offset().top - 300}, 700);

		$.ajax({
			url:"/shop/mypage/delivery/list/json",
			type:"get",
			data:{findword:$('#findword').val(),search:$('#deliverySearch').val()},
			dataType:"text",
			success:function(data) {
				if(data === "NOT LOGGED ON") {
					location.href = "/shop/login?status=expired";
				}
				var list = $.parseJSON(data);
				$("#deliveryListTarget").html( $("#deliveryTrTemplate").tmpl(list) );

			}
		});
	}
	, deliveryForm:function(flag) {
		CHDelivery.submitCode = flag;
		if(flag === 'insert') { //배송지 추가 버튼 클릭시
			$('#deliveryList').hide();
			$('#deliveryTopTitle').text('◇ 배송지를 등록 하실수 있습니다.');
			$('#deliveryForm').show();
		} else { //배송지 추가 버튼 클릭시
			var checkValidFlag;
			var seq=0;
			$('#deliveryListTarget input[type=radio]').each(function(){
				if($(this).prop('checked') === true) {
					checkValidFlag = true;
					seq = $(this).val();
					return false;
				} else {
					checkValidFlag = false;
				}
			});

			if(checkValidFlag) {
				CHDelivery.seq = parseInt(seq,10);
				$('#deliveryList').hide();
				EBDelivery.deliveryListMappingVo(parseInt(seq,10));
				$('#deliveryTopTitle').text('◇ 배송지를 수정 하실수 있습니다.');
				$('#deliveryForm').show();
			} else {
				alert('배송지 주소를 선택해 주세요');
			}
		}
	}
	, deliveryVo:function() {
		return ({
			seq:0
			, title: $('#deliveryForm table').find("input[name=title]").val()
			, defaultFlag: $('#deliveryForm table').find("input[name=defaultFlag]:checked").prop('checked') === true ? 'Y' : 'N'
			, name:$('#deliveryForm table').find("input[name=name]").val()
			, cell1: $('#deliveryForm table').find("input[name=cell1]").val()
			, cell2: $('#deliveryForm table').find("input[name=cell2]").val()
			, cell3: $('#deliveryForm table').find("input[name=cell3]").val()
			, tel1: $('#deliveryForm table').find("input[name=tel1]").val()
			, tel2: $('#deliveryForm table').find("input[name=tel2]").val()
			, tel3: $('#deliveryForm table').find("input[name=tel3]").val()
			, postcode: $('#deliveryForm table').find("input[name=postcode]").val()
			, addr1: $('#deliveryForm table').find("input[name=addr1]").val()
			, addr2: $('#deliveryForm table').find("input[name=addr2]").val()
		});
	}
	, deliveryInitForm:function() {
		$('#deliveryForm table').find("input[alt], input[name=defaultFlag]").each(function(){
			$(this).val('');
		});
	}
	, deliverySubmit:function() {
		var flag = true;
		$('#deliveryForm table').find("input[alt], textarea[alt], select[alt]").each(function() {
			if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {
				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});

		if(flag) {
			var vo = CHDelivery.deliveryVo();
			vo.seq = CHDelivery.seq;//수정일때 seq를 박는다

			var submitFlag = CHDelivery.submitCode === 'insert' ? 'reg' : 'mod';
			$.ajax({
				url:"/shop/order/delivery/"+submitFlag+"/proc",
				type:"post",
				data:vo,
				dataType:"text",
				success:function(data) {
					if(data === "OK") {
						submitFlag === 'reg' ? alert('등록하였습니다.') : alert('수정하였습니다.');
						CHDelivery.deliveryListBack();
						CHDelivery.deliveryListShow();
						CHDelivery.deliveryInitForm();

						EBDelivery.renderList(
							(function(){
								return EBDelivery.mappingVo( EBDelivery.getSeqForDefaultFlag() );
							})
						);
					} else if(data === "FAIL") {
						alert('오류가 발생하였습니다.')
					} else {
						alert(data)
					}
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		}
		return flag;
	}
	, deliveryDelete:function() {
		var checkValidFlag;
		var seq=0;
		$('#deliveryListTarget input[type=radio]').each(function(){
			if($(this).prop('checked') === true) {
				checkValidFlag = true;
				seq = $(this).val();
				return false;
			} else {
				checkValidFlag = false;
			}
		});

		if(checkValidFlag) {
			if(!confirm("정말로 삭제하시겠습니까?")) {
				return false;
			}

			$.ajax({
				url:"/shop/order/delivery/del/proc",
				type:"post",
				data:{seq:seq},
				dataType:"text",
				success:function(data) {
					if(data === "OK") {
						alert('삭제하였습니다.');
						CHDelivery.deliveryListShow();
					} else {
						alert(data);
					}
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		} else {
			alert('배송지 주소를 선택해 주세요');
		}
	}
	, deliveryListBack:function() {
		$('#deliveryForm').hide();
		CHDelivery.deliveryInitForm();
		$('#deliveryTopTitle').text('◇ 배송지 목록을 확인 하실수 있습니다.');
		$('#deliveryList').show();
	}
	, deliveryListHide:function() {
		CHDelivery.deliveryListBack();
		$("#deliverList").hide();
	}
	, deliverySelected:function() {
		//라디오버튼이 하나라도 선택이 안되어 있다면 리턴시킨다.
		var checkValidFlag;
		var seq=0;
		$('#deliveryListTarget input[type=radio]').each(function(){
			if($(this).prop('checked') === true) {
				checkValidFlag = true;
				seq = $(this).val();
				return false;
			} else {
				checkValidFlag = false;
			}
		});

		if(checkValidFlag) {
			EBDelivery.mappingVo(parseInt(seq,10));
			CHDelivery.deliveryListHide();
		} else {
			alert('배송지 주소를 선택해 주세요');
		}
	}
};
var CHProcess = {
	payMethod:function(obj) {
		var payTextArr = ['card','ra'];

		if($(obj).val() === payTextArr[0]) {
			$('#'+payTextArr[0]+'PayTable').show();
			$('#'+payTextArr[1]+'PayTable').hide();
		} else if($(obj).val() === payTextArr[1]) {
			$('#'+payTextArr[1]+'PayTable').show();
			$('#'+payTextArr[0]+'PayTable').hide();
		}
	}
	, cardPeriodMethod:function(obj) {
		$(obj).val() === 'lumpSum' ? $('#cardPeriodBox').hide() : $('#cardPeriodBox').show();
	}

	, allCheckProc:function(obj) {
		if($(obj).prop("checked") === true){
			$('.btn-terms-check').each(function(){
				$(this).prop('checked',true);
			});
		} else {
			$('.btn-terms-check').each(function(){
				$(this).prop('checked',false);
			});
		}
	}
	, checkProc:function(obj) {
		var i=0;
		//약관이 몇개나 체크 되었는지 확인한다.
		$('.btn-terms-check').each(function(){
			if($(this).prop("checked") === true) {
				i++;
			}
		});

		//약관이 모두 체크가 되었다면(4개) 모두선택 checkbox를 true시킨다. 아니라면 false를 시켜 모두선택 checkbox로 결제를 진행여부를 판단한다.
		if(i === 4) {
			$('#allTermsCheck').prop('checked',true);
		} else {
			$('#allTermsCheck').prop('checked',false);
		}
	}
	, getLatelyOrderMappingVo:function() {
		$.ajax({
			type: "GET",
			url:"/shop/order/lately/vo/json",
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				for(var vo in list) {
					$("#deliveryTable").find("input[data-name="+vo+"], select[data-name="+vo+"]").val(list[vo]);
				}
			}
		});
	}
	, getBuyerMappingVo:function() {
		$.ajax({
			type: "GET",
			url:"/shop/member/json",
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				for(var vo in list) {
					$("#deliveryTable").find("input[data-name="+vo+"], select[data-name="+vo+"]").val(list[vo]);
				}
			}
		});
	}
	,deliveryAddrMethod:function(obj) {
		var v = $(obj).val();

		if(v =="self"){
			$("#deliveryTable").hide();
			$('#deliveryTable input[name=receiverName]').val('직접수령');
			$('#deliveryTable input[name=postcode]').val('06949');
			$('#deliveryTable input[name=addr1]').val('국제메디팜');
			$('#deliveryTable input[name=addr2]').val('국제메디팜');
			return;
		}

		$("#deliveryTable").show();

		if(v === 'default') { //새로입력일때
			EBDelivery.renderList( (function(){
				return EBDelivery.mappingVo( EBDelivery.getSeqForDefaultFlag() );
			}) );
//			EBDelivery.mappingVo(EBDelivery.getSeqForDefaultFlag());
		} else if(v === 'lately') {
			CHProcess.getLatelyOrderMappingVo();
		} else if(v === 'buyer') {
			CHProcess.getBuyerMappingVo();
		} else if(v === 'new') { //새로입력일때
			$('#deliveryTable input[type=text]').each(function () {
				$(this).val('');
			});
		}else if(v === 'notlogin') {
			// 비회원 로그인일 경우
			$('input[name=receiverName]').val( $('input[name=memberName]').val() );
			$('input[name=receiverCell1]').val( $('input[name=memberCell1]').val() );
			$('input[name=receiverCell2]').val( $('input[name=memberCell2]').val() );
			$('input[name=receiverCell3]').val( $('input[name=memberCell3]').val() );
		}
	}
};

var CHDeliPostCodeUtil = {
	deliveryGetAddr:function(page){
		$.ajax({
			url :"http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
			,type:"post"
			,data:{currentPage:page,countPerPage:100,confmKey:'U01TX0FVVEgyMDE1MDkyNDExMTkxOA==',keyword:$('#deliveryKeyword').val()}
			,dataType:"jsonp"
			,crossDomain:true
			,success:function(xmlStr){
				if(navigator.appName.indexOf("Microsoft") > -1){
					var xmlData = new ActiveXObject("Microsoft.XMLDOM");
					xmlData.loadXML(xmlStr.returnXml)
				}else{
					var xmlData = xmlStr.returnXml;
				}
				$("#deliveryShowAddr").html("");
				var errCode = $(xmlData).find("errorCode").text();
				var errDesc = $(xmlData).find("errorMessage").text();
				if(errCode != "0"){
					alert(errDesc);
				}else{
					if(xmlStr != null){
						$('#deliveryShowAddr').fadeIn();
						CHDeliPostCodeUtil.deliveryMakeList(xmlData, page);
					}
				}
			}
			,error: function(xhr,status, error){
				alert("에러발생");
			}
		});
	}
	, deliveryMakeList:function(xmlStr, page){
		var totalPage = parseInt($(xmlStr).find("totalCount").text()/$(xmlStr).find("countPerPage").text())+1;
		var htmlStr = "";
		htmlStr += "<table class='table table-condensed table-hover' style='width: 383px;'>";
		htmlStr += "<tr style='background-color: #f7f7f7;'>";
		htmlStr += "<td style='width: 300px;'>주소</td>";
		htmlStr += "<td>우편번호</td>";
		htmlStr += "</tr>";
		$(xmlStr).find("juso").each(function(){
			htmlStr += "<tr>";
			htmlStr += "<td><a href='javascript:;' style='text-decoration:none;' onclick='CHDeliPostCodeUtil.deliveryShowAddr(\""+$(this).find('roadAddr').text()+"\",\""+$(this).find('zipNo').text()+"\");'><span style='color: dodgerblue;'>도로명:</span><span style='color: #000;'>"+$(this).find('roadAddr').text()+"</span></a><br/>"
			htmlStr += "<a href='javascript:;' style='text-decoration:none;' onclick='CHDeliPostCodeUtil.deliveryShowAddr(\""+$(this).find('jibunAddr').text()+"\",\""+$(this).find('zipNo').text()+"\");'><span style='color: dodgerblue;'>지번:</span><span style='color: #000;'>"+$(this).find('jibunAddr').text()+"</span></a></td>";
			htmlStr += "<td>"+$(this).find('zipNo').text()+"</td>";
			htmlStr += "</tr>";
		});
		htmlStr += "</table>";
		htmlStr += "<div id='paging' style='text-align:center; border-top: 1px solid #dddddd;'><ul class='pagination'>";
		for(var i=0; i<totalPage; i++){
			if(page==i+1) {
				htmlStr += "<li class='active'><a href='#' onclick='return false;'>" + (i + 1) + "</a></li>";
			}else{
				htmlStr += "<li><a href='#' onclick='CHDeliPostCodeUtil.deliveryGetAddr("+(i + 1)+")'>" + (i + 1) + "</a></li>";
			}
		}
		htmlStr += "</ul></div>"

		$("#deliveryShowAddr").html(htmlStr);
	}
	, deliveryEnterSearch:function() {
		var evt_code = (window.netscape) ? ev.which : event.keyCode;
		if (evt_code == 13) {
			event.keyCode = 0;
			CHDeliPostCodeUtil.deliveryGetAddr(1); //jsonp사용시 enter검색
		}
	}
	, deliveryPostWindow:function(sort, id){
		if(sort == 'open') {
			$("#delivery").show().css({opacity:0, marginTop:100}).animate({opacity:1, marginTop:$(id).offset().top-100}, "slow");
			$("html, body").animate({scrollTop:$(id).offset().top - 200}, 700);
			$('#deliveryKeyword').focus();
		}else if(sort == 'close'){
			$("#deliveryShowAddr").fadeOut();
			$("#deliveryShowAddr").html('');
			$("#deliveryKeyword").val('');

			$("#delivery").hide();
		}
	}
	, deliveryShowAddr:function(addr, post){
		$("#deliveryPostcode").val(post);
		$("#deliveryAddr1").val(addr);

		CHDeliPostCodeUtil.deliveryPostWindow('close');
		$('body').animate({scrollTop:$('#deliveryAddr2').offset().top-500}, 500);
		$("#deliveryAddr2").focus();
	}
}
