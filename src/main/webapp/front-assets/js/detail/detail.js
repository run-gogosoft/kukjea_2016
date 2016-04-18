
var PriceLB = {
	  sellPrice: parseInt($("#sell-price").attr("data-price"), 10) || 0
	, optionPrice : 0
	, stockCount : 0
	, setOptionPrice: function(obj) {
		PriceLB.optionPrice = (parseInt($(obj).attr("data-option-price"),10) || 0);
	}
	, setStockCount: function(obj) {
		PriceLB.stockCount = (parseInt($(obj).attr("data-stock-count"),10) || 0);
	}
	, renderText: function(obj) {
		$("#option-name").text( $(obj).text() ).parents("tr").css({'height':30});
		$("#option-name").css("display","block");
	}
	, changeProc: function(obj) {
		PriceLB.renderText(obj);
		PriceLB.setOptionPrice(obj);
		PriceLB.setStockCount(obj);

		$("#optionValueSeq").val( $(obj).attr("data-option-value") );
	}
	, calcOrderAmt: function() {
		$("#order-amt").text( numeral((PriceLB.sellPrice + PriceLB.optionPrice) * $("#count").val()).format("0,0") );
	}
};

var addCount = function(cnt) {
	var count = parseInt($("#count").val(), 10) + cnt;
	if(count <= 0) {
		return;
	}
	$("#count").val(count);
};

var getReviewList = function(pageNum){
	$.ajax({
		type:"GET",
		url:"/shop/detail/review/getList",
		dataType:"text",
		data:{itemSeq:$("#seq").val(),pageNum:pageNum},
		success:function(data) {
			var list = $.parseJSON(data);
			if(list.length != 0){
				$("#boardTarget").html( $("#trTemplate").tmpl(list));
			} else {
				$("#boardTarget").html("<tr><td class='text-center' colspan='5'><strong>등록된 내용이 없습니다.</strong></td></tr>");
			}

			newLineReviewText('#reviewTable td', list); //질문 내용

			//구매평 갯수
			$.ajax({
				type:"GET",
				url:"/shop/detail/review/reviewcount",
				dataType:"text",
				data:{itemSeq:$("#seq").val()},
				success:function(data) {
					$(".reputation-counter").html("<strong>전체 "+data+"개</strong>");
				}
			});
		}
	});
};

var getReviewPaging = function(pageNum){
	$.ajax({
		type:"GET",
		url:"/shop/detail/review/paging",
		dataType:"text",
		data:{itemSeq:$("#seq").val(),pageNum:pageNum},
		success:function(data) {
			$("#paging").html(data);
			$("#paging>ul").addClass("ch-pagination");
		}
	});
};

var newLineReviewText = function(tagName, list) {
	$(tagName).each(function() {
		var parseMainSeq = parseInt($(this).attr('data-seq-review'), 10) || 0;
		if(parseMainSeq > 0) {
			for(var vo in list) {
				var parseSubSeq = parseInt(list[vo].seq, 10) || 0;
				if(parseMainSeq === parseSubSeq) {
					$(this).html(list[vo].review.replace(/\n/gi, '<br/>'));
				}
			}
		}
	});
};

var getItemQnaList = function(pageNum){
	$.ajax({
		type:"GET",
		url:"/shop/detail/itemqna/getList",
		dataType:"text",
		data:{integrationSeq:$("#seq").val(),pageNum:pageNum},
		success:function(data) {
			var list = $.parseJSON(data);
			if(list.length != 0){
				$("#boardItemQnaTarget").html($("#trItemQnaTemplate").tmpl(list));
			} else {
				$("#boardItemQnaTarget").html("<tr><td class='text-center' colspan='5'><strong>등록된 내용이 없습니다.</strong></td></tr>");
			}

			// 내용에 newLine을 먹이기 위해 스크립트를 새로 짰다..하아..
			newLineQnaText('#qnaTable td', list); //질문 내용

			//Qna 갯수
			$.ajax({
				type:"GET",
				url:"/shop/detail/qna/count",
				dataType:"text",
				data:{integrationSeq:$("#seq").val()},
				success:function(data) {
					$("#qna-reputation-counter").html("<strong>전체 "+data+"개</strong>");
				}
			});
		}
	});
};

var getItemQnaPaging = function(pageNum){
	$.ajax({
		type:"GET",
		url:"/shop/detail/itemqna/paging",
		dataType:"text",
		data:{integrationSeq:$("#seq").val(),pageNum:pageNum},
		success:function(data) {
			$("#itemQnaPaging").html(data);
			$("#itemQnaPaging>ul").addClass("ch-pagination");
		}
	});
};

var newLineQnaText = function(tagName, list) {
	$(tagName).each(function() {
		var parseContentSeq = parseInt($(this).attr('data-seq-content'), 10) || 0;
		if(parseContentSeq > 0) {
			for(var vo in list) {
				var parseSubSeq = parseInt(list[vo].seq, 10) || 0;
				if(parseContentSeq === parseSubSeq) {
					$(this).html(list[vo].content.replace(/\n/gi, '<br/>'));
				}
			}
		}

		var parseAnswerSeq = parseInt($(this).attr('data-seq-answer'), 10) || 0;
		if(parseAnswerSeq > 0) {
			for(var vo in list) {
				var parseSubSeq = parseInt(list[vo].seq, 10) || 0;
				if(parseAnswerSeq === parseSubSeq) {
					$(this).html(list[vo].answer.replace(/\n/gi, '<br/>'));
				}
			}
		}
	});
};

var getSellerItemList = function(pageNum){
	$.ajax({
		type:"GET",
		url:"/shop/detail/seller/item/list/ajax",
		dataType:"text",
		data:{sellerSeq:$("#sellerSeq").val(), statusCode:"Y", pageNum:pageNum, rowCount:5},
		success:function(data) {
			var vo = $.parseJSON(data);
			if(vo.list.length != 0){
				$("#sellerTarget").html( $("#sellerTemplate").tmpl(vo.list));
			}
			
			$("#sellerPaging").html(vo.paging);
			$("#sellerPaging>ul").addClass("ch-pagination");
		}
	});
};

var goPage = function (page) {
	getReviewList(page);
	getReviewPaging(page);
};

var goPageQna = function (page) {
	getItemQnaList(page);
	getItemQnaPaging(page);
};

var goPageSellerItem = function (page) {
	getSellerItemList(page);
};

var callbackProc = function(msg) {
	if(msg === "OK") {
		$("#cartModal").modal();
	} else if(msg === "SIZE OVER") {
		alert("장바구니에 상품을 20개 이상 담을 수 없습니다.");
	} else if(msg === "ERROR[1]"){
		alert("수량은 0 이하가 될 수 없습니다.");
	} else if(msg === "ERROR[2]"){
		alert("존재하지 않는 옵션입니다.");
	} else if(msg === "ERROR[3]"){
		alert("장바구니 등록에 실패하였습니다.");
	} else if(msg === "ERROR[4]"){
		alert("장바구니 수정에 실패하였습니다.");
	} else if(msg === "ERROR[5]"){
		alert("쿠폰상품은 장바구니에 담을 수 없습니다.");
	} else if( msg == "ESTIMATE_OK") {
		if(confirm("견적 신청이 완료되었습니다.\n\n신청 내역 조회 페이지로 이동하시겠습니까?")) {
			location.href = "/shop/mypage/estimate/list";
		}
	}
}

var EBProcess = {
	vo:{}
	, initVo:function(){
		EBProcess.vo = {
			seq:parseInt($("#seq").val(), 10)
			, count:parseInt($("#count").val(), 10)
			, optionValueSeq:parseInt($("#optionValueSeq").val(), 10)
			, deliPrepaidFlag:''
		};
	}
	, checkVo:function(){
		EBProcess.initVo();
		if(EBProcess.vo.optionValueSeq<=0 || EBProcess.vo.count<=0) {
			return "허용되지 않은 접근입니다.";
		} else if($("#option-name").text() === "" && $("#optionValueSeq").parents("tr.hide").length === 0) {
			return "옵션이 선택되지 않았습니다.";
		} else if(PriceLB.stockCount < EBProcess.vo.count) {
			return "재고가 없습니다.";
		}
		return "";
	}
	, addCart:function(loginSeq,itemSeq){
		$('#guestCartModal').modal('hide');
		if(loginSeq == "null"){
			alert("로그인을 하셔야 합니다.");
			location.href="/shop/login?DirectURL=/shop/detail/"+itemSeq;
		}
		var message = EBProcess.checkVo();
		if(message !== "") {
			alert(message);
			return;
		}

		$(".btn-cart").prop("disabled", true);
		setTimeout(function(){
			$(".btn-cart").prop("disabled", false);
		}, 1000);

		var html = "";
		for(var prop in EBProcess.vo) {
			//EBProcess.vo에 있는 모든 필드를 반복해선 안된다. 이유는 바로 아래에서 deliPrepaidFlag textarea를 만들어 보내기 때문에
			//모두 for문을 돌게되면 deliPrepaidFlag textarea가 총 두번 생성되므로 이곳에서 deliPrepaidFlag 필드는 제외한다.
			if(prop !== 'deliPrepaidFlag'){
				html += "<textarea name='"+prop+"'>"+EBProcess.vo[prop]+"</textarea>"
			}
		}

		var deliPrepaidFlag = $('#deliPrepaidFlag option:selected').val();
		if(deliPrepaidFlag == null){
			var deliPrepaidFlagDiv = $('#deliPrePaidFlagDIv').attr('data-deli-prepaid-flag');
			if(deliPrepaidFlagDiv == null) {
				deliPrepaidFlagDiv = "";
			}
			html += '<textarea name="deliPrepaidFlag">'+deliPrepaidFlagDiv+'</textarea>';
		} else {
			html += '<textarea name="deliPrepaidFlag">'+deliPrepaidFlag+'</textarea>';
		}
		html += '<textarea name="itemSeq">'+$('#seq').val()+'</textarea>';
		html += '<textarea name="typeCode">'+$('#typeCode').val()+'</textarea>'; //상품타입 추가(N:일반상품, C:쿠폰상품)

		$("#cartForm>div").html(html);
		$("#cartForm").submit();
	}
	, guestAlert: function(obj){
		
		var message = EBProcess.checkVo();
		if(message !== "") {
			alert(message);
			return false;
		}
		
		if(obj=='cart'){
			$("#guestCartModal").modal();
		}else if(obj=='buy'){
			$("#guestBuyModal").modal();
		}
		
	}
	, buy: function(){
		$('#guestBuyModal').modal('hide');
		var message = EBProcess.checkVo();

		if($('#payMethod').val() === '') {
			alert('결제가 중지된 쇼핑몰입니다.');
			return false;
		}

		if(message !== "") {
			alert(message);
			return false;
		}

		$(".eb-btn .btn-buy").prop("disabled", true);
		setTimeout(function(){
			$(".eb-btn .btn-buy").prop("disabled", false);
		}, 1000);

		var html = "";
		for(var prop in EBProcess.vo) {
			//즉시구매 일 때는 EBProcess.vo에 있는 모든 필드를 반복해선 안된다. 이유는 바로 아래에서 deliPrepaidFlag textarea를 만들어 보내기 때문에
			// 모두 for문을 돌게되면 deliPrepaidFlag textarea가 총 두번 생성되므로 이곳에서 deliPrepaidFlag 필드는 제외한다.
			if(prop !== 'deliPrepaidFlag'){
				html += "<textarea name='"+prop+"'>"+EBProcess.vo[prop]+"</textarea>"
			}
		}

		var deliPrepaidFlag = $('#deliPrepaidFlag option:selected').val();
		if(deliPrepaidFlag == null){
			var deliPrepaidFlagDiv = $('#deliPrePaidFlagDIv').attr('data-deli-prepaid-flag');
			if(deliPrepaidFlagDiv == null) {
				deliPrepaidFlagDiv = "";
			}
			html += '<textarea name="deliPrepaidFlag">'+deliPrepaidFlagDiv+'</textarea>';
		} else {
			html += '<textarea name="deliPrepaidFlag">'+deliPrepaidFlag+'</textarea>';
		}

		html += '<textarea name="itemSeq">'+$('#seq').val()+'</textarea>';
		html += '<textarea name="typeCode">'+$('#typeCode').val()+'</textarea>'; //상품타입 추가(N:일반상품, E:견적상품)


		$("#buyForm>div").html(html);
		$("#buyForm").submit();
	}
	, changeTypeProc:function(type) {
		if(type === 'normal') {
			$('#buyType2').show();
			$('#buyType1').hide();
		} else {
			$('#buyType1').show();
			$('#buyType2').hide();
		}
	}
};

var addWish = function(loginSeq) {
	//회원만 이용 가능하다.
	if(loginSeq === '') {
		alert("회원 로그인 후 이용하시기 바랍니다.");
		return false;
	}

	if($("#option-name").text() === "" && $("#optionValueSeq").parents("tr.hide").length === 0) {
		alert("옵션이 선택되지 않았습니다.");
		return false;
	}
	var deliPrepaidFlag = $('#deliPrepaidFlag option:selected').val();
	if(typeof deliPrepaidFlag === 'undefined'){
		deliPrepaidFlag = $('#deliPrePaidFlagDIv').attr('data-deli-prepaid-flag');
	}
	$.ajax({
		url:"/shop/wish/reg/proc/ajax",
		type:"GET",
		data: {itemSeq:$("#seq").val(), optionValueSeq:parseInt($("#optionValueSeq").val(), 10), deliPrepaidFlag:deliPrepaidFlag},
		dataType:"json",
		success:function(data) {
			if(data.result === "Y" || data.result === "D") {
				if(confirm(data.message)) {
					location.href = "/shop/wish/list";
				}
			} else {
				alert(data.message);
			}
		},
		error:function(e){
			var message = "<p class='text-danger'><span class='glyphicon glyphicon-warning-sign'></span> 로그인해주세요.</p>";
			$(".eb-btn .btn-wish").popover({content:message, placement:"bottom", html:true, delay:{hide:1}}).popover("show");
			setTimeout(function(){
				$(".eb-btn .btn-wish").popover('destroy');
			}, 5000);
		}
	});
};

var submitProc = function(obj) {
	var flag = true;
	$(obj).find("input[alt], textarea[alt]").each( function() {
		if(flag && $(this).val() == "") {
			alert($(this).attr("alt") + "을 입력해주세요.");
			flag = false;
			$(this).focus();
		}
	});
	return flag;
};

var reviewExist = function(){
	$.ajax({
		url:"/shop/detail/review/exist/ajax",
		type:"GET",
		data: {search:'item_seq',findword:$("#seq").val()},
		dataType:"json",
		success:function(data) {
			if(data.result === "Y") {
				location.href = "/shop/mypage/review";
			} else {
				alert(data.message);
			}
		}
	});
};

var submitCatagory = function (lvValue , obj, dataLv) {
	var urlDepth1 = '';
	var urlDepthEtc = '';
	//카테고리를 아무것도 선택하지 않았을 경우 상위 카테고리로 이동한다.
	if($(obj).val() === '') {
		if (lvValue === 1) {
			urlDepth1 = "/shop/main";
		} else {
			urlDepthEtc = "/shop/lv" + (lvValue - 1) + "/" + dataLv;
		}
	} else {
		urlDepthEtc = "/shop/lv"+lvValue+"/"+$(obj).val();
	}

	$('#searchForm').attr('action', urlDepth1 !== '' ? urlDepth1 : urlDepthEtc); //urlDepth1이 null이 아니라면 urlDepth1이 실행될 것이다.
	$('#searchForm').submit();
};

var addInfoBoxHeight = function() {
	var subListheight;
	var subListLength = $('.add-info-content .inner>div').length;

	//첫번째 라인이라면 50px로 고정
	if(subListLength === 1 || subListLength === 2) {
		subListheight = 50;
	} else {
		subListheight = 32;
	}

	var calcLineLength = Math.ceil(subListLength / 2);
	$('.add-info-content').css({'height':subListheight*calcLineLength});
}

var CHBoardUtil = {
	qnaWriteButton:function (loginSeq, position){
		//회원만 이용 가능하다.
		if(loginSeq === '') {
			alert("회원 로그인 후 이용하시기 바랍니다.");
			return false;
		}

		$(".hh-writebox-detail").show().css({top:200});
		if(position == "bottom") {
			$(".hh-writebox-detail").show().css({top:$("#qna").offset().top-200,left:$('#qna').offset().left+650});
		}
	}
	, qnaWriteClose:function () {
		$(".hh-writebox-detail").hide();
		$('#qnaContent').val('');
		$('#qnaTitle').val('');
	}
};

$(document).ready(function() {
	$(".ch-gallery-thumb > ul > li").each(function(){
		$(this).mouseover(function(){
			if(!$(this).is(".current")) {
				$(".ch-gallery-thumb .current").removeClass("current");
				$(this).addClass("current");

				var src = $(this).find('[data-src]').attr("data-src");
				$(".ch-gallery > img").stop().animate({opacity:0}, "fast", function(){
					$('.ch-gallery>img').attr('src', src).animate({opacity:1}, "fast");
				});
				
				
			}
		});
	});
	$(".numeric").numeric().css({"ime-mode":"disabled"});

	if( $(".optionList .optionItem").length === 1) {
		PriceLB.changeProc($(".optionList .optionItem a"))
	}

	// is sold out?
	(function(){
		var count = 0;
		$(".optionList .optionItem a").each(function(){
			if(parseInt($(this).attr("data-stock-count"),10) === 0 ) {
				count++;
			}
		});
		if(count === $(".optionList .optionItem a").length) {
			$("#soldOutModal").modal();
		}
	})();

	// add Side cart-item
	(function(){
		var seq = $("input[name=seq]").val();
		var cartList = (typeof $.cookie('cartList') === "undefined") ? []: $.cookie('cartList').split("::");
		var cartImageList = (typeof $.cookie('cartImageList') === "undefined") ? []: $.cookie('cartImageList').split("::");
		var newCartList = [];
		var newCartImageList = [];

		for(var i=0; i<cartList.length; i++) {
			if(cartList[i] != seq) {
				newCartList.push(cartList[i]);
				newCartImageList.push(cartImageList[i]);
			}
			if(newCartList.length===10) { // MAX_COUNT
				newCartList = newCartList.slice(1);
				newCartImageList = newCartImageList.slice(1);
				break;
			}
		}

		newCartList.push(seq);
		newCartImageList.push($(".ch-gallery-thumb img").eq(0).attr("src"));

		$.cookie('cartList', newCartList.join("::"), { expires:1, path: '/' });
		$.cookie('cartImageList', newCartImageList.join("::"), { expires:1, path: '/' });
	})();

	getReviewList(0);
	getReviewPaging(0);
	getItemQnaList(0);
	getItemQnaPaging(0);
	getSellerItemList(0);

	// $('.icon-over').each(function() {
		$('.icon-over').mouseover(function(){
			$(this).find('.description').css({'color':'#fbac18'});
			$(this).find('img').attr("src", $(this).find('img').attr("src").replace("_off", "_on"));
		}).mouseleave(function(){
			$(this).find('.description').css({'color':'#fff'});
			$(this).find('img').attr("src", $(this).find('img').attr("src").replace("_on", "_off"));
		});
	// });
});
