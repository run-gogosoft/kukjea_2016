<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/search/search.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

      <style type="text/css">
            .ch-pagination {
                  margin:0 0 20px 0;
            }

            #popup-zone {
                  margin-top:23px;
            }
      </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>
<form role="form" id="searchForm" method="get">
	<input type="hidden" name="name" value="${itemSearchVo.name}" />
	<input type="hidden" name="cateLv1Seq" value="${itemSearchVo.cateLv1Seq}" />
	<input type="hidden" name="cateLv2Seq" value="${itemSearchVo.cateLv2Seq}" />
	<input type="hidden" name="cateLv3Seq" value="${itemSearchVo.cateLv3Seq}" />
</form>

<div class="breadcrumb">
  <div class="pull-left" style="margin-right:10px;"><i class="fa fa-home fa-2x"></i> 홈 &gt;</div>
  <form id="lvForm" method="get" class="pull-left" style="margin-top:8px;">
    <select name="cateLv1Seq" style="display:inline;width:155px;" onchange="submitCatagory(1,this);">
          <option value="">대분류</option>
          <c:forEach var="item" items="${cateLv1List}" varStatus="status" begin="0" step="1">
            <%--함께누리 측의 요청으로 공공기관에만 특별주문 카테고리를 노출한다.--%>
            <c:choose>
              <c:when test="${sessionScope.loginMemberTypeCode eq 'P'}">
                <option value="${item.seq}" <c:if test="${itemSearchVo.cateLv1Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
              </c:when>
              <c:otherwise>
                <c:if test="${item.seq ne 53}">
                  <option value="${item.seq}" <c:if test="${itemSearchVo.cateLv1Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                </c:if>
              </c:otherwise>
            </c:choose>
          </c:forEach>
    </select>
    &gt;
    <select name="cateLv2Seq" style="display:inline;width:155px;" onchange="submitCatagory(2,this);">
          <option value="">중분류(전체)</option>
          <c:forEach var="item" items="${cateLv2List}" varStatus="status" begin="0" step="1">
                <option value="${item.seq}" <c:if test="${itemSearchVo.cateLv2Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
          </c:forEach>
    </select>
    &gt;
    <select name="cateLv3Seq" style="display:inline;width:155px;" onchange="submitCatagory(3,this);">
          <option value="">소분류(전체)</option>
          <c:forEach var="item" items="${cateLv3List}" varStatus="status" begin="0" step="1">
                <option value="${item.seq}" <c:if test="${itemSearchVo.cateLv3Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
          </c:forEach>
    </select>
    <c:if test="${fn:length(cateLv4List) ne 0}">
          &gt;
          <select name="cateLv4Seq" style="display:inline;width:155px;" onchange="submitCatagory(4,this);">
                <option value="">세분류(전체)</option>
                <c:forEach var="item" items="${cateLv4List}" varStatus="status" begin="0" step="1">
                      <option value="${item.seq}" <c:if test="${itemSearchVo.cateLv4Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                </c:forEach>
          </select>
    </c:if>
    <input type="hidden" name="name" value="${itemSearchVo.name}" />
  </form>

  <select id="jachiguCode" name="jachiguCode" style="display:inline;margin-top:8px;width:155px;" class="pull-right" onchange="goJachiGu(this);">
    <option value="00" <c:if test="${itemSearchVo.jachiguCode eq ''}">selected="selected"</c:if>>전체</option>
    <c:forEach var="item" items="${jachiguList}" varStatus="status">
      <option value="${item.value}" <c:if test="${itemSearchVo.jachiguCode eq item.value}">selected="selected"</c:if>>${item.name}</option>
    </c:forEach>
	</select>
</div>

<div class="search-title-wrap">
	<c:choose>
		<c:when test="${itemSearchVo.name eq ''}">전체</c:when>
		<c:otherwise>"${itemSearchVo.name}"</c:otherwise>
	</c:choose>
	<span>검색결과</span>
</div>

<div class="total-count-wrap">
	<span>${fn:length(categoryList)}</span>개 카테고리 / <span>${itemSearchVo.totalRowCount}</span>개의 상품이 검색되었습니다.
</div>

<div class="category-list-wrap">
	<ul class="cate-list">
		<c:forEach var="item" items="${categoryList}">
				<li>
					<a href="/shop/search?name=${itemSearchVo.name}&
					<c:choose>
						<c:when test="${item.depth==1}">
							cateLv1Seq=${item.seq}
						</c:when>
						<c:when test="${item.depth==2}">
							cateLv1Seq=${item.parentSeq}&cateLv2Seq=${item.seq}
						</c:when>
						<c:when test="${item.depth==3}">
							cateLv1Seq=${itemSearchVo.cateLv1Seq}&cateLv2Seq=${item.parentSeq}&cateLv3Seq=${item.seq}
						</c:when>
						<c:when test="${item.depth==4}">
							cateLv1Seq=${itemSearchVo.cateLv1Seq}&cateLv2Seq=${itemSearchVo.cateLv2Seq}&cateLv3Seq=${item.parentSeq}&cateLv4Seq=${item.seq}
						</c:when>
					</c:choose>
					&jachiguCode=${itemSearchVo.jachiguCode}
					">
					${item.name} <span>(${item.count})</span>
					</a>
				</li>
		</c:forEach>
	</ul>
</div>

<div class="search-bar-wrap" style="margin-top:35px">
	<div class="inner">
		<ul class="search-list">
			<li <c:if test="${itemSearchVo.orderType eq '' or itemSearchVo.orderType eq 'regdate'}">class="active"</c:if>><a href="#" onclick="orderPage('regdate')">신상품</a></li>
			<!-- <li><a href="#">상품명</a></li> -->
			<li <c:if test="${itemSearchVo.orderType eq 'lowprice'}">class="active"</c:if>><a href="#" onclick="orderPage('lowprice')">낮은가격</a></li>
			<li <c:if test="${itemSearchVo.orderType eq 'highprice'}">class="active"</c:if>><a href="#" onclick="orderPage('highprice')">높은가격</a></li>
			<!-- <li><a href="#">제조사</a></li> -->
		</ul>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

<div class="ch-container" style="margin-top:0;">
  <ul class="ch-3col lv1-3col" style="margin-bottom:60px;">
    <c:forEach var="item" items="${list}">
        <li style="margin-top:23px;">
        	<div class="img"><a href="/shop/detail/${item.seq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" <c:if test="${item.img2 ne ''}">data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img2, 'origin', 's270')}"</c:if>/></a></div>
        	<div class="info">
        		<div class="name"><a href="/shop/detail/${item.seq}">${item.name}</a></div>
        			<c:choose>
                  		<c:when test="${item.typeCode eq 'N'}">
                       		<div class="price"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원<span></div>
                  		</c:when>
                  		<c:when test="${item.typeCode eq 'E'}">
                     	   <div class="price" style="font-size:20px;">견적요청</div>
                		</c:when>
           		 </c:choose>
        	</div>
        </li>
    </c:forEach>
  </ul>
</div>

<div class="clearfix"></div>

<div id="paging" style="text-align:center;margin-bottom:40px;">
  ${paging}
</div>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/category/common.lv.js"></script>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/search/search.js"></script>
<script type="text/javascript">
	var goJachiGu = function(obj) {
    	location.href = location.pathname + "?startPrice=${itemSearchVo.startPrice}&endPrice=${itemSearchVo.endPrice}&orderType=${itemSearchVo.orderType}&jachiguCode="+ $(obj).val() + "&" + $("#searchForm").serialize();
  	}

	var goPage = function (page) {
		location.href = location.pathname + "?startPrice=${itemSearchVo.startPrice}&endPrice=${itemSearchVo.endPrice}&pageNum=" + page + "&orderType=${itemSearchVo.orderType}&jachiguCode=${itemSearchVo.jachiguCode}" + "&" + $("#searchForm").serialize();
	};

	var rowPage = function () {
		location.href = location.pathname + "?startPrice=${itemSearchVo.startPrice}&endPrice=${itemSearchVo.endPrice}&orderType=${itemSearchVo.orderType}&" + $("#searchForm").serialize();
	};

	var orderPage = function (value) {
		location.href = location.pathname + "?startPrice=${itemSearchVo.startPrice}&endPrice=${itemSearchVo.endPrice}&orderType="+value+"&jachiguCode=${itemSearchVo.jachiguCode}&" + $("#searchForm").serialize();
	};
</script>
</body>
</html>