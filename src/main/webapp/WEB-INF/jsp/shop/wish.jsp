<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/order/cart.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
    #popup-zone {
          margin-top:-5px;
    }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="main-title">
	위시리스트
</div>

<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

<div class="cart-button-wrap">
	<div class="pull-left" style="margin-top:11px">
		<button type="button" class="btn cart-small-btn btn-all-select" onclick="WishUtil.checkProcBtn()">
			<span>상품 전체선택</span>
		</button>
	</div>
	<div class="clearfix"></div>
</div>

<form id="mgrForm" method="post" target="zeroframe">
<div class="cart-main-table">
	<table class="table">
		<colgroup>
			<col width="3%"/>
			<col width="8%"/>
			<col width="*"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<thead>
			<tr>
				<td><input type="checkbox" id="allChk" onclick="WishUtil.checkProc(this)"/></td>
				<td colspan="2">상품정보</td>
				<td>판매가</td>
				<td>배송정보</td>
				<td>업체</td>
				<td>선택</td>
				<td></td>
			</tr>
		</thead>
		<tbody id="wishBody">
			<c:forEach var="item" items="${list}">
			<input type="hidden" id="seq${item.wishSeq}" value="${item.itemSeq}"/>
			<input type="hidden" id="count${item.wishSeq}" value="1"/>
			<input type="hidden" id="optionValueSeq${item.wishSeq}" value="${item.optionValueSeq}"/>
			<input type="hidden" id="stockCount${item.wishSeq}" value="${item.stockCount}"/>
			<input type="hidden" id="deliPrepaidFlag${item.wishSeq}" value="${item.deliPrepaidFlag}"/>

			<tr>
				<td class="text-center">
					<input type="checkbox" id="wishSeq" name="wishSeq" value="${item.wishSeq}" wish-value="${item.itemSeq}" style="margin:0 auto;"/>
				</td>
				<td>
					<c:if test="${item.img1 ne ''}">
						<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, '/origin/', '/s206/')}" style="width:70px;border:1px solid #d7d7d7;" width="70px" alt="상품이미지" />
					</c:if>
				</td>
				<td class="text-left item-name">
					<a href="/shop/detail/${item.itemSeq}">${item.name}</a><br/>
					<span class="option-name">${item.optionName}: ${item.valueName}</span><br/>
				</td>
				<td class="item-price">
					<fmt:formatNumber value="${ item.sellPrice }" pattern="#,###" />원
				</td>
				<td>
					<c:choose>
						<c:when test="${item.deliTypeCode eq '00'}">
							무료
						</c:when>
						<c:when test="${item.deliTypeCode eq '10'}">
							<fmt:formatNumber value="${item.deliCost}" pattern="#,###" />원
							<br/>
							<c:if test="${item.deliPrepaidFlag eq 'Y'}">
								선결제
								<%--착불 배송비 제외--%>
								<c:set var="totalDeliveryPrice" value="${totalDeliveryPrice + item.deliCost}" />
							</c:if>
							<c:if test="${item.deliPrepaidFlag eq 'N'}">
								착불
							</c:if>
						</c:when>
					</c:choose>
				</td>
				<td>
					${item.sellerName}
				</td>
				<td>
					<button type="button" class="btn btn-default btn-xs direct-btn" id="directBtn" remove-value="${item.wishSeq}" onclick="CHProcess.buy(${item.wishSeq});">바로구매</button><br/>
					<button type="button" class="btn btn-default btn-xs wish-btn" remove-value="${item.wishSeq}"  onclick="WishUtil.addCart(${item.wishSeq})" style="margin-top:5px;">장바구니</button>
				</td>
				<td class="text-center">
					<div class="item-delete" remove-value="${item.wishSeq}" onclick="WishUtil.wishOneDelProc(this)" style="margin:0 auto"><i class="fa fa-times fa-2x"></i></div>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${fn:length(list) eq 0}">
			<tr><td colspan="8">등록된 내용이 없습니다.</td></tr>
		</c:if>
		</tbody>
	</table>
</div>

<div class="button-wrap">
	<button type="button" class="btn btn-buy" onclick="WishUtil.addAllCart()"><span>전체 장바구니 등록</span></button>
	<button class="btn main-button btn-all-delete" onclick="return WishUtil.wishAllDelProc()"><span>위시리스트 비우기</span></button>
	<button class="btn main-button btn-main" onclick="location.href='/shop/main'"><span>쇼핑 계속하기</span></button>
</div>
</form>
<div class="clearfix"></div>

<form id="buyForm" class="hide" action="/shop/order/direct" target="zeroframe"><div></div></form>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/plugin/account.js"></script>
<script type="text/javascript">
var CHProcess = {
	vo:{}
	, initVo:function(obj){
		CHProcess.vo = {
			seq:$('#seq'+obj).val()
			, count:$('#count'+obj).val()
			, optionValueSeq:$('#optionValueSeq'+obj).val()
			, stockCount : $('#stockCount'+obj).val()
			, deliPrepaidFlag:''
		};
	}
	, checkVo:function(obj){
		CHProcess.initVo(obj);
		if(CHProcess.vo.optionValueSeq<=0 || CHProcess.vo.count<=0) {
			return "옵션이 선택되지 않은 상품입니다.";
		} else if(CHProcess.stockCount < CHProcess.vo.count) {
			return "재고가 없습니다.";
		}
		return "";
	}
	, buy: function(obj){
		var message = CHProcess.checkVo(obj);
		if(message !== "") {
			alert(message);
			return;
		}

		var html = "";
		for(var prop in CHProcess.vo) {
			//즉시구매 일 때는 EBProcess.vo에 있는 모든 필드를 반복해선 안된다. 이유는 바로 아래에서 deliPrepaidFlag textarea를 만들어 보내기 때문에
			// 모두 for문을 돌게되면 deliPrepaidFlag textarea가 총 두번 생성되므로 이곳에서 deliPrepaidFlag 필드는 제외한다.
			if(prop !== 'deliPrepaidFlag'){
				html += "<textarea name='"+prop+"'>"+CHProcess.vo[prop]+"</textarea>"
			}
		}

		var deliPrepaidFlag = $('#deliPrepaidFlag'+obj).val();
		if(deliPrepaidFlag !== ''){
			html += '<textarea name="deliPrepaidFlag">'+deliPrepaidFlag+'</textarea>';
		}

		$("#buyForm>div").html(html);
		$("#buyForm").submit();
	}
	, allBuy: function(){
		$("#wishBody input:checkbox").each(function(){
			$(this).prop("checked", "checked");
		});

		var seq = [];
		$("#wishBody input:checkbox:checked").each(function(){
			seq.push($(this).val());
		});

		if(seq.length === 0) {
			alert('상품을 선택해주세요.');
			return;
		}

		location.href="/shop/order?seq=" + seq.join(",");
	}
};

var WishUtil = {
	checkProcBtn:function() {
		var flag;
		if($('#allChk').prop("checked") === true) {
			$('#allChk').prop("checked",false);
			flag = false;
		} else {
			$('#allChk').prop("checked",true);
			flag = true;
		}
		$("#wishBody input:checkbox").each(function(){
			$(this).prop("checked", flag);
		});
	}
	, checkProc:function(obj) {
		$("#wishBody input:checkbox").each(function(){
			$(this).prop("checked", $(obj).prop("checked"));
		});
	}
	, wishAllDelProc:function() {
		if(confirm("정말로 삭제하시겠습니까?")) {
			$("#wishBody input:checkbox").each(function(){
				$(this).prop("checked", "checked");
			});
			if($("#wishBody input:checkbox:checked").length==0){
				alert("삭제할 상품이 없습니다.");
				return false;
			}

			$("#mgrForm").attr('action', '/shop/wish/del/proc');
			$("#mgrForm").submit();
		}
	}
	, wishOneDelProc:function(obj) {
		if(confirm("정말로 삭제하시겠습니까?")) {
			$("#wishBody input:checkbox").each(function(){
				if($(this).attr('value') === $(obj).attr('remove-value')) {
					$(this).prop("checked", "checked");
				}
				$("#mgrForm").attr('action', '/shop/wish/del/proc');
				$("#mgrForm").submit();
			});
		}
	}
	, addCart:function(obj) {
		$("#wishBody input:checkbox").each(function(){
			var parseValue1 = parseInt($(this).attr('value'), 10);
			var parseValue2 = parseInt(obj, 10);

			if(parseValue1 === parseValue2) {
				$(this).prop("checked", "checked");
			}

			$("#mgrForm").attr('action', '/shop/wish/cart/proc');
			$("#mgrForm").submit();
		});
	}
	, addAllCart:function() {
		$("#wishBody input:checkbox").each(function(){
			$(this).prop("checked", "checked");
		});

		$("#mgrForm").attr('action', '/shop/wish/cart/proc');
		$("#mgrForm").submit();
	}
	, addAllBuy:function() {
		$("#wishBody input:checkbox").each(function(){
			$(this).prop("checked", "checked");
		});

		$("#mgrForm").attr('action', '/shop/wish/all/buy/proc');
		$("#mgrForm").submit();
	}
};
</script>
</body>
</html>