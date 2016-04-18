<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/best/best.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
    #popup-zone {
          margin-top:0;
    }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="breadcrumb">
	<div class="pull-left" style="margin:8px 10px 0 0;"><img src="/front-assets/images/detail/home.png" alt="홈"> 홈<span class="arrow-sub">&gt;</span><strong>베스트상품</strong></div>
</div>

<div class="widget-gallery-type">
	<dl>
		<%--1~2위--%>
		<c:forEach var="item" items="${list}" varStatus="status">
			<c:if test="${status.index < 2}">
				<dd>
					<a href="/shop/detail/${item.itemSeq}">
						<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" <c:if test="${item.img2 ne ''}">data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img2, 'origin', 's270')}"</c:if> width="270" height="270" alt="" />
					</a>
				</dd>
				<dt class="number${status.count}">
					<div class="up">
						<div class="rank-number">0${status.count}</div>
						<div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
						<c:choose>
					    <c:when test="${item.typeCode eq 'N'}">
					    	<div class="korea"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></div>
					    </c:when>
					    <c:when test="${item.typeCode eq 'E'}">
					    	<div class="korea">견적요청</div>
					    </c:when>
					  </c:choose>
					</div>
				</dt>
			</c:if>
		</c:forEach>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>
		<%--3~4위--%>
		<c:forEach var="item" items="${list}" varStatus="status">
			<c:if test="${status.index > 1 and status.index < 4}">
				<dt class="number${status.count}">
					<div class="down">
						<div class="rank-number">0${status.count}</div>
						<div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
						<c:choose>
					    <c:when test="${item.typeCode eq 'N'}">
					    	<div class="korea"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></div>
					    </c:when>
					    <c:when test="${item.typeCode eq 'E'}">
					    	<div class="korea">견적요청</div>
					    </c:when>
					  </c:choose>
					</div>
				</dt>
				<dd class="down-img-wrap">
		      <a href="/shop/detail/${item.itemSeq}">
		      	<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" <c:if test="${item.img2 ne ''}">data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img2, 'origin', 's270')}"</c:if> width="270" height="270" alt="" />
		      </a>
		    </dd>
	    </c:if>
		</c:forEach>
	</dl>

	<div class="line"></div>

	<dl>
		<%--5~6위--%>
		<c:forEach var="item" items="${list}" varStatus="status">
			<c:if test="${status.index > 3 and status.index < 6}">
				<dd>
					<a href="/shop/detail/${item.itemSeq}">
		      	<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" <c:if test="${item.img2 ne ''}">data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img2, 'origin', 's270')}"</c:if> width="270" height="270" alt="" />
		      </a>
				</dd>
				<dt class="number${status.count}">
					<div class="up">
						<div class="rank-number">0${status.count}</div>
						<div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
						<c:choose>
					    <c:when test="${item.typeCode eq 'N'}">
					    	<div class="korea"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></div>
					    </c:when>
					    <c:when test="${item.typeCode eq 'E'}">
					    	<div class="korea">견적요청</div>
					    </c:when>
					  </c:choose>
					</div>
				</dt>
			</c:if>
		</c:forEach>

		<%--7~8위--%>
		<c:forEach var="item" items="${list}" varStatus="status">
			<c:if test="${status.index > 5 and status.index < 8}">
				<dt class="number${status.count}">
					<div class="down">
						<div class="rank-number">0${status.count}</div>
						<div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
						<c:choose>
					    <c:when test="${item.typeCode eq 'N'}">
					    	<div class="korea"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></div>
					    </c:when>
					    <c:when test="${item.typeCode eq 'E'}">
					    	<div class="korea">견적요청</div>
					    </c:when>
					  </c:choose>
					</div>
				</dt>
				<dd class="down-img-wrap">
		      <a href="/shop/detail/${item.itemSeq}">
		      	<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" <c:if test="${item.img2 ne ''}">data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img2, 'origin', 's270')}"</c:if> width="270" height="270" alt="" />
		      </a>
		    </dd>
	    </c:if>
		</c:forEach>
	</dl>
</div>

<div class="clearfix"></div>

<%--sub-item-list뒤의 숫자는 status.count여야 한다.--%>
<div class="ch-container sub-item-list-wrap sub-item-list1">
	<ul class="ch-5col">
		<c:forEach var="item" items="${list}" varStatus="status">
			<c:if test="${status.index > 7}">
				<c:if test="${status.index < item.limitCnt}">
				  <li>
				  	<div class="img" style="border: 1px #e1e1e1 solid;">
				  		<a href="/shop/detail/${item.itemSeq}">
				      	<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" <c:if test="${item.img2 ne ''}">data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img2, 'origin', 's270')}"</c:if> width="204" height="204" alt="" />
				      </a>
				  	</div>
				  	<div class="info">
			    		<div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
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
			  </c:if>
			</c:if>
	  </c:forEach>
	</ul>
</div>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/plan/plan.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		for(var i=0; i<$('.sub-item-list-wrap').length; i++) {
			CHPlanUtil.calcLine(i+1);
		}

		$(".img img[data-src]").mouseover(function(){
			if(typeof $(this).attr("data-swap") === "undefined") {
				$(this).attr("data-swap", $(this).attr("src"));
			}
			$(this).attr("src", $(this).attr("data-src"));
		}).mouseleave(function(){
			$(this).attr("src", $(this).attr("data-swap"));

		});
	});
</script>
</body>
</html>