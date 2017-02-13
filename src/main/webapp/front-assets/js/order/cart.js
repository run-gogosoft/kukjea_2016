var Cart = {
	list:[]
	,render:function(callback){
		$.ajax({
			url:"/shop/cart/list/json",
			type:"get",
			data:{},
			dataType:"text",
			success:function(data) {
				if(data === "NOT LOGGED IN") {
					alert("로그인 해주세요.");
					return;
				}
				Cart.list = $.parseJSON(data);
				$("#cartBody").html( $("#cartTemplate").tmpl(Cart.list) );

				if(Cart.list.length === 0) {
					$('#allChk').prop('checked',false);
					$("#cartBody").html("<tr><td class='text-center' style='padding:50px' colspan='10'>장바구니에 담긴 상품이 없습니다.</td></tr>");
				}

				callback();
			}
		});
	}
	, renderTotal:function(){
		var vo = {
			itemTotalPrice:0
			, deliCost:0
			, total:0
		};
		for(var i=0; i<Cart.list.length; i++) {
			vo.itemTotalPrice += parseInt(Cart.list[i].sellPrice, 10) * parseInt(Cart.list[i].count, 10);
			vo.deliCost += parseInt(Cart.list[i].deliCost, 10);
		}
		
		vo.total += vo.itemTotalPrice + vo.deliCost;
		$("#totalBody").html( $("#totalTemplate").tmpl(vo) );
	}
	, add:function(seq, obj) {
		$(obj).prop("disabled", true);
		$.ajax({
			url:"/shop/cart/update",
			type:"get",
			data:{seq:seq, count:$('#count'+seq).val()},
			dataType:"text",
			success:function(data) {
				Cart.render(function(){
					Cart.renderTotal();
				});
			}
		});
	}
	, amount:function(value,seq) {
		if(value === 'plus'){
			$('#count'+seq).val(parseInt($('#count'+seq).val())+1);
		}else if(value === 'minus'){
			if(parseInt($('#count'+seq).val()) <= 0){
				alert("수량은 0이상으로 입력해주세요");
				return;
			}
			$('#count'+seq).val(parseInt($('#count'+seq).val())-1);
		}
	}
	, removeSelected:function(){
		if(confirm("정말로 삭제하시겠습니까?")) {
			$("#cartBody input:checkbox").each(function(){
				if(length > 1) {
					length--;
				}
				Cart.removeProc($(this).val(),length);
			});
		}
	}
	, oneRemoveSelected:function(obj){
		if(confirm("정말로 삭제하시겠습니까?")) {
			Cart.removeProc($(obj).attr('remove-value'),1);
		}
	}
	, removeProc:function(seq,length){
		$.ajax({
			url:"/shop/cart/remove",
			type:"get",
			traditional:true,
			data:{seq:seq},
			dataType:"text",
			success:function(data) {
				length--;
				if(length === 0) {
					Cart.render(function(){
						Cart.renderTotal();
					});
				}
			}
		});
	}
	, buy: function() {
		var seq = [];
		$("#cartBody input:checkbox:checked").each(function(){
			seq.push($(this).val());
		});

		if(seq.length === 0) {
			alert('상품을 선택해주세요.');
			return;
		}

		location.href="/shop/order?seq=" + seq.join(",");
	}
	, allBuy:function() {
		var seq = [];
		$('#allChk').prop('checked',true);
		$("#cartBody input:checkbox").each(function(){
			$(this).prop('checked',true);
		});

		$("#cartBody input:checkbox:checked").each(function(){
			seq.push($(this).val());
		});

		if(seq.length === 0) {
			alert('상품을 선택해주세요.');
			return;
		}

		location.href="/shop/order?seq=" + seq.join(",");
	}
	, checkProc:function(obj) {
		$("#cartBody input:checkbox").each(function(){
			$(this).prop("checked", $(obj).prop("checked"));
		});
	}
	, checkProcBtn:function() {
		var flag;
		if($('#allChk').prop("checked") === true) {
			$('#allChk').prop("checked",false);
			flag = false;
		} else {
			$('#allChk').prop("checked",true);
			flag = true;
		}
		$("#cartBody input:checkbox").each(function(){
			$(this).prop("checked", flag);
		});
	}
	, addWish:function(seq){
		$.ajax({
			url:"/shop/wish/reg/proc/ajax",
			type:"GET",
			data: {itemSeq:seq},
			dataType:"json",
			success:function(data) {
				if(data.result === "Y" || data.result === "D") {
					if(confirm(data.message)) {
						location.href = "/shop/wish/list";
					}
				} else {
					alert(data.message);
				}
			}
		});
	}
}
var CHProcess = {
	vo:{}
	, initVo:function(obj){
		CHProcess.vo = {
			seq:parseInt($(obj).parents('tr').find('input[name=seq]').attr('wish-value'), 10)
			, count:parseInt($(obj).parents('tr').find("input[name=count]").val(), 10)
			, optionValueSeq:parseInt($(obj).parents('tr').find("input[name=optionValueSeq]").val(), 10)
			, stockCount : parseInt($(obj).parents('tr').find("input[name=stockCount]").val(), 10)
			, stockFlag : $(obj).parents('tr').find("input[name=stockFlag]").val()
			, deliPrepaidFlag:''
		};
	}
	, checkVo:function(obj){
		CHProcess.initVo(obj);
		if(CHProcess.vo.optionValueSeq<=0 || CHProcess.vo.count<=0) {
			return "허용되지 않은 접근입니다.";
		} else if(CHProcess.vo.stockFlag == "Y" && CHProcess.vo.stockCount < CHProcess.vo.count) {
			return "재고가 없거나 수량이 부족합니다.";
		}
		return "";
	}
	, buy: function(obj){
		var message = CHProcess.checkVo(obj);
		if(message !== "") {
			alert(message);
			return;
		}
		$("#directBtn").prop("disabled", true);
		setTimeout(function(){
			$("#directBtn").prop("disabled", false);
		}, 1000);

		var html = "";
		for(var prop in CHProcess.vo) {
			//즉시구매 일 때는 EBProcess.vo에 있는 모든 필드를 반복해선 안된다. 이유는 바로 아래에서 deliPrepaidFlag textarea를 만들어 보내기 때문에
			// 모두 for문을 돌게되면 deliPrepaidFlag textarea가 총 두번 생성되므로 이곳에서 deliPrepaidFlag 필드는 제외한다.
			if(prop !== 'deliPrepaidFlag'){
				html += "<textarea name='"+prop+"'>"+CHProcess.vo[prop]+"</textarea>"
			}
		}

		var deliPrepaidFlag = $(obj).parents('tr').children("input[name=deliPrepaidFlag]").val();
		if(typeof deliPrepaidFlag !== 'undefined'){
			html += '<textarea name="deliPrepaidFlag">'+deliPrepaidFlag+'</textarea>';
		}

		$("#buyForm>div").html(html);
		$("#buyForm")[0].submit();
	}
};

var doPrint = function(pageType) {
	var seq = [];
	$("#cartBody input:checkbox:checked").each(function(){
		seq.push($(this).val());
	});

	if(seq.length === 0) {
		alert('상품을 선택해주세요.');
		return;
	}
	
	window.open("/shop/cart/estimate/view?pageType="+pageType+"&cartSeqs=" + seq.join(","), "estimate_view", "scrollbars=yes,width=710px,height=800px");
};

$(document).ready(function(){
	Cart.render(function(){
		Cart.renderTotal();
		if( $("#cartBody span[data-danger=true]").length > 0 ) {
			alert('장바구니 항목중에 재고가 없는 상품이 있습니다.\n품절 중인 상품을 삭제해주세요.');
		}
	});
});

