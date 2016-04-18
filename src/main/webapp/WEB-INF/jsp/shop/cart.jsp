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
	장바구니
</div>

<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

<%@ include file="/WEB-INF/jsp/shop/include/order_header.jsp" %>

<script id="cartTemplate" type="text/html">
	<tr {{if stockCount==="0"}}class="danger"{{/if}}>
		<td><input type="checkbox" id="seq" name="seq" value="<%="${seq}"%>" wish-value="<%="${itemSeq}"%>" checked="checked" /></td>
		<td>
			{{if img1 !== ''}}<img src="<%="${img1}"%>" style="width:70px;border:1px solid #d7d7d7;" width="70px" alt="상품 이미지" />{{/if}}
		</td>
		<td class="text-left item-name">
			{{if stockCount==="0"}}
				<span class="text-danger" data-danger="true">품절</span>
			{{else parseInt(stockCount,10) < count}}
				<span class="text-danger" data-danger="true">재고<%="${stockCount}"%>개</span>
			{{/if}}
			<a href="/shop/detail/<%="${itemSeq}"%>"><%="${name}"%></a><br/>
			<span class="option-name"><%="${optionName}"%>{{if optionName !== ''}} : {{/if}}<%="${valueName}"%></span><br/>
			<input type="hidden" name="stockCount" value="<%="${stockCount}"%>"/>
			<input type="hidden" name="optionValueSeq" value="<%="${optionValueSeq}"%>"/>
		</td>
		<td>
			<span><%="${sellPriceText}"%>원</span>
		</td>
		<td>
			<div class="input-group" style="width:88px;">
				<input type="text" id="count<%="${seq}"%>" name="count" value="<%="${count}"%>" class="form-control text-center input-count" maxlength="3" onblur="numberCheck(this);"/>
				<div class="input-group-btn"><button type="button" class="btn btn-default" onclick="Cart.add(<%="${seq}"%>, this);" style="height: 30px;width: 44px;font-size: 11px;">변경</button></div>
			</div>
			<button type="button" onclick="Cart.amount('plus',<%="${seq}"%>);" class="btn btn-link btn-xs" style="font-size:8px"><span class="glyphicon glyphicon-plus"></span></button>
			<button type="button" onclick="Cart.amount('minus',<%="${seq}"%>);" class="btn btn-link btn-xs" style="font-size:8px"><span class="glyphicon glyphicon-minus" style="color:gray"></span></button>
		</td>
		<td class="item-price">
			<%="${totalPriceText}"%>원
		</td>
		<td>
			{{if deliCost == 0}}
				{{if packageDeliCost > 0}}
					무료<br/>(묶음배송 할인)
				{{else}}
					무료
					{{if deliFreeAmount > 0}}
						<br/>(<%="${deliFreeAmountText}"%>원 이상 구매)
					{{/if}}
				{{/if}}
			{{else}}
				<span><%="${deliCostText}"%>원</span>
				{{if deliPrepaidFlag === "Y"}}
					<br/>선결제
				{{else}}
					<br/>착불
				{{/if}}
			{{/if}}
			<input type="hidden" name="deliPrepaidFlag" value="<%="${deliPrepaidFlag}"%>"/>
		</td>
		<td>
			<%="${sellerName}"%>
		</td>
		<td>
			<button class="btn btn-default btn-xs direct-btn" id="directBtn" onclick="CHProcess.buy(this)">바로구매</button><br/>
			<c:if test="${sessionScope.loginSeq ne null}">
			<button class="btn btn-default btn-xs wish-btn"  onclick="Cart.addWish(<%="${itemSeq}"%>)">위시리스트</button><br/>
			</c:if>
		</td>
		<td>
			<div class="item-delete" remove-value="<%="${seq}"%>" onclick="Cart.oneRemoveSelected(this)"><i class="fa fa-times fa-2x"></i></div>
		</td>
	</tr>
</script>

<script id="totalTemplate" type="text/html">
	<div class="left">
		<div class="price-wrap-type2">
			<div>총 판매가 : <%="${accounting.formatNumber(itemTotalPrice)}"%>원</div>
			<div>총 할인금액: 0원</div>
		</div>
		<div class="price-wrap-type2" style="margin-top:8px">
			<div>배송비 합계: <%="${accounting.formatNumber(deliCost)}"%>원</div>
		</div>
	</div>

	<div class="right">
		<div class="total-buy-price">총구매금액: <%="${accounting.formatNumber(total)}"%>원</div>
	</div>
</script>

<div class="cart-button-wrap">
	<div class="pull-left" style="margin-top:11px">
		<button type="button" class="btn cart-small-btn btn-all-select" onclick="Cart.checkProcBtn(this)">
			<span>상품 전체선택</span>
		</button>
	</div>
	<div class="clearfix"></div>
</div>

<div class="cart-main-table">
	<table class="table">
		<colgroup>
			<col width="3%"/>
			<col width="8%"/>
			<col width="26%"/>
			<col width="10%"/>
			<col width="7%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="12%"/>
			<col width="8%"/>
			<col width="2%"/>
		</colgroup>
		<thead>
			<tr>
				<td><input type="checkbox" id="allChk" onclick="Cart.checkProc(this)" checked/></td>
				<td colspan="2">상품정보</td>
				<td>판매가</td>
				<td>수량</td>
				<td>상품 금액</td>
				<td>배송정보</td>
				<td>업체</td>
				<td>선택</td>
				<td></td>
			</tr>
		</thead>
		<tbody id="cartBody">
			<tr>
				<td colspan="10" class="text-center" style="padding:50px;">
					데이터를 불러오고 있습니다. 잠시만 기다려 주세요... <img src="${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif" alt="로딩중.." />
				</td>
			</tr>
		</tbody>
	</table>
</div>

<div id="totalBody" class="cart-total-wrap">
	<div class="left">
		<div class="total-body-loading">
			데이터를 불러오고 있습니다. 잠시만 기다려 주세요... <img src="${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif" alt="로딩중.." />
		</div>
	</div>

	<div class="right">
	</div>
</div>

<div class="button-wrap">
	<button type="button" class="btn btn-buy" onclick="Cart.buy()" style="margin-left:0"><span>선택상품 주문하기</span></button>
	<button type="button" class="btn btn-all-delete" onclick="Cart.removeSelected()"><span>장바구니 비우기</span></button>
	<button type="button" class="btn btn-main" onclick="location.href='/shop/main'"><span>쇼핑 계속하기</span></button>
	<button type="button" class="btn btn-success" onclick="doPrint('estimate')"><span>견적서</span></button>
</div>
<div class="clearfix"></div>

<div id="attentionModal" class="modal fade">
	<div class="modal-dialog" style="width:500px">
		<div class="modal-content danger">
			<div class="modal-body">
				<p>장바구니 항목중에 재고가 없는 상품이 있습니다.</p>
				<p>품절 중인 상품을 삭제해주세요.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<form id="buyForm" class="hide" action="/shop/order/direct" target="zeroframe"><div></div></form>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/plugin/account.js"></script>
<script type="text/javascript" src="/front-assets/js/order/cart.js"></script>
</body>
</html>