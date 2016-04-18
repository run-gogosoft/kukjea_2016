<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/about/main.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/member/member.css" type="text/css" rel="stylesheet">
	<title>about 입점업체 정보</title>
</head>
<body>
<%--about 사회적경제 헤더 네비게이션--%>
<%@ include file="/WEB-INF/jsp/shop/about/navigation.jsp" %>

<div style="margin:0 auto; width:1080px; background-color:#fff">
	<img src="/front-assets/images/about/header_seller.png" alt="입점업체 정보" />
</div>
	

<div style="margin:0 auto; width:1080px; background-color:#fff; padding-top: 50px;">
	<div style="padding: 0 50px 50px 50px;">
		<table style="width: 100%;">
		<tr>
			<td class="seller-table-top" style="color:#4DB6C9; width:240px;">
				<h4>${vo.name}</h4>
			</td>
			<td class="seller-table-top">
				<c:forEach var="item" items="${authCategoryList}">
					<c:if test="${fn:contains(vo.authCategory,item.value)}">
						<label style="width:170px;">
							${item.name}
							<img src="/front-assets/images/detail/auth_mark_${item.value}.png" alt="${item.name}">
						</label>
					</c:if>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="seller-table-bottom" style="background:#eee3cf">
				<div class="seller-info-box">
					<strong>대표자명</strong><br/>
					${vo.ceoName}
				</div>
				<div class="seller-info-box">
					<strong>종업원수</strong><br/>
					${vo.amountOfWorker}
				</div>
				<div class="seller-info-box">
					<strong>대표전화</strong><br/>
					${vo.tel}
				</div>
				<div class="seller-info-box">
					<strong>팩스번호</strong><br/>
					${vo.fax}
				</div>
				<div class="seller-info-box">
					<strong>팩스번호</strong><br/>
					${vo.fax}
				</div>
				<div class="seller-info-box">
					<strong>주소</strong><br/>
					(${vo.postcode})&nbsp;${vo.addr1}&nbsp;${vo.addr2}
				</div>
				<div class="seller-info-box">
					<strong>소속자치구</strong><br/>
					<c:if test="${vo.jachiguCode ne '99'}">서울시</c:if>
					<c:if test="${vo.jachiguCode eq '99'}">기타</c:if>
					
					<c:forEach var="item" items="${jachiguList}">
						<c:if test="${vo.jachiguCode eq item.value}">${item.name}</c:if>
					</c:forEach>
				</div>
			</td>
			<td class="seller-table-bottom">
				<div class="seller-info-box">
					<strong>업체소개</strong>
					<div style="border-bottom: 1px #acacac dotted">
						<div id="iframe_content1" style="display:none">${vo.intro}</div>
						<iframe id="content_view1" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
					</div>
				</div>
				<div class="seller-info-box">
					<strong>주요 취급상품</strong>
					<div style="border-bottom: 1px #acacac dotted">
						<div id="iframe_content2" style="display:none">${vo.mainItem}</div>
						<iframe id="content_view2" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
					</div>
				</div>
				<div class="seller-info-box">
					<strong>사회적 경제활동</strong>
					<div>
						<div id="iframe_content3" style="display:none">${vo.socialActivity}</div>
						<iframe id="content_view3" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
					</div>
				</div>
			</td>
		</tr>
		</table><br/>
	</div>
</div>

<div class="ch-container">
	<div class="banner-title" style="margin-top:50px;">
	   <span class="left">입점업체 관련상품</span>
	</div>
	<input type="hidden" id="sellerSeq" value="${vo.seq}">
	<!-- template -->
	<script id="sellerTemplate" type="text/html">
			<li style="width:207px;">
		       	<div class="img">
		       		<a href="/shop/detail/<%="${seq}"%>">
		       			<img src="<%="${img1}"%>" alt="상품이미지" {{if img2 !== ""}}data-src="<%="${img2}"%>"{{/if}}/>
		       		</a>
		       	</div>
		       	<div class="info">
		       		<div class="name"><a href="/shop/detail/<%="${seq}"%>"><%="${name}"%></a></div>
		       		{{if typeCode==="N"}}
		       			<div class="price"><%="${sellPrice}"%><span>원<span></div>
		       		{{else typeCode==="E"}}
		       			<div class="price">견적요청</div>
		       		{{/if}}
		       	</div>
			</li>
		</script>

	<div class="banner-content" style="height:272px;margin-top:15px;">
    <ul id="sellerTarget" class="ch-3col middle-banner"></ul>
  </div>
	<div class="clearfix"></div>
  <div id="sellerPaging" style="text-align:center;margin-bottom:30px;"></div>
</div>


<div class="button-wrap">
	<button type="button" class="btn btn-cancel" onclick="history.back(-1);"><span>목록보기</span></button>
</div>

<style type="text/css">
.seller-table-top {
	border-top: 2px #acacac solid;
	border-bottom: 1px #acacac dotted;
	padding: 10px 20px;
}
.seller-table-bottom {
	vertical-align: top;
	padding:50px 0;
	border-bottom:2px #acacac solid;
}
.seller-info-box {
	padding: 10px 30px;
}
</style>

<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript">
$(window).load(function() {
	$("#content_view1").contents().find("body").html($("#iframe_content1").html());
	$("#content_view1").height($("#content_view1").contents().find("body")[0].scrollHeight + 30);
	$("#content_view2").contents().find("body").html($("#iframe_content2").html());
	$("#content_view2").height($("#content_view2").contents().find("body")[0].scrollHeight + 30);
	$("#content_view3").contents().find("body").html($("#iframe_content3").html());
	$("#content_view3").height($("#content_view3").contents().find("body")[0].scrollHeight + 30);
	
	getSellerItemList(0);
});

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

var goPageSellerItem = function (page) {
	getSellerItemList(page);
};


</script>
</body>
</html>