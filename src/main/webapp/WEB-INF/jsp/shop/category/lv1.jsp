<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/category/lv1.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

      <style type="text/css">
            #popup-zone {
                  margin-top:-4px;
            }
      </style>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

      <div class="breadcrumb">
            <div class="pull-left" style="margin:8px 10px 0 0;"><img src="/front-assets/images/detail/home.png" alt="홈"> 홈<span class="arrow">&gt;</span></div>
            <form id="searchForm" method="get" class="pull-left" style="margin-top:8px;">
                  <select name="cateLv1Seq" style="display:inline;width:155px;" onchange="submitCatagory(1, this, '');">
                        <option value="">대분류</option>
                        <c:forEach var="item" items="${cateLv1List}" varStatus="status" begin="0" step="1">
                              <%--함께누리 측의 요청으로 공공기관에만 특별주문 카테고리를 노출한다.--%>
                              <c:choose>
                                    <c:when test="${sessionScope.loginMemberTypeCode eq 'P'}">
                                          <option value="${item.seq}" <c:if test="${vo.seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                          <c:if test="${item.seq ne 53}">
                                                <option value="${item.seq}" <c:if test="${vo.seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                                          </c:if>
                                    </c:otherwise>
                              </c:choose>
                        </c:forEach>
                  </select>

                  <c:if test="${fn:length(cateLv2List) ne 0}">
                  <span class="arrow-sub">&gt;</span>
                  <select name="cateLv2Seq" style="display:inline;width:155px;" onchange="submitCatagory(2, this, ${vo.seq});">
                        <option value="">중분류(전체)</option>
                        <c:forEach var="item" items="${cateLv2List}" varStatus="status" begin="0" step="1">
                              <option value="${item.seq}">${item.name}</option>
                        </c:forEach>
                  </select>
                  </c:if>
            </form>
      </div>

	<div class="hero-wrap">
		<script id="sideTitleTemplate" type="text/html">
			<div class="lv2Title"><%="${categoryName}"%></div>
			{{each lv2List}}
				<ul id="subCategoryList">
					<li onclick="location.href='/shop/lv2/<%="${seq}"%>'"><%="${categoryName}"%><i class="fa fa-angle-right fa-2x"></i></li>
				</ul>
			{{/each}}
		</script>

		<div class="side-nav">
			<img src="${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif" style="display:block;margin:230px auto 0 auto;" alt="" />
		</div>

            <%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="clearfix"></div>

            <c:if test="${fn:length(gallery1) ne 0}">
      		<%-- 히어로배너 영역 --%>
      		<ul class="widget-3th-type">
	            <c:forEach var="item" items="${gallery1}" varStatus="status" begin="0" step="1">
	                  <c:if test="${status.index < item.limitCnt}">
	      			<li>
	      				<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's500')}" width="480" height="480" alt=""/></a>
	      				<div class="item">
	      					<span class="title"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></span>
	                         <c:choose>
	                               <c:when test="${item.typeCode eq 'N'}">
	                                     <span class="korea"><fmt:formatNumber value="${item.sellPrice}" pattern="#,###" /><span>원</span></span>
	                               </c:when>
	                               <c:when test="${item.typeCode eq 'E'}">
	                                    <span class="korea">견적요청</span>
	                               </c:when>
	                         </c:choose>
	      				</div>
	      			</li>
	                  </c:if>
	            </c:forEach>
      		</ul>
            </c:if>
	</div>

      <div class="clearfix"></div>

      <c:if test="${fn:length(gallery2) ne 0}">
      	<div class="widget-gallery-type">
      		<dl>
            <c:forEach var="item" items="${gallery2}" varStatus="status" begin="0" step="1">
                <c:if test="${status.index < 2}">
      			<%--up--%>
      			<dd>
                	<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's500')}" width="270" height="270" alt=""/></a>
                </dd>
      			<dt class="number${status.count}">
      				<div class="up">
      					<div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
                         <span class="description">${item.originCountry} | ${item.brand}</span>
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
            <c:forEach var="item" items="${gallery2}" varStatus="status" begin="0" step="1">
	            <c:if test="${status.index > 1 and status.index < 4}">
	            <%--down--%>
	            <dt class="number${status.count}">
	             <div class="down">
	                 <div class="name"><a href="/shop/detail/${item.itemSeq}">${item.itemName}</a></div>
	                 <span class="description">${item.originCountry} | ${item.brand}</span>
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
               		<a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's500')}" width="270" height="270" alt=""/></a>
	            </dd>
	            </c:if>
            </c:forEach>
      		</dl>
      	</div>
      </c:if>
      <div class="clearfix"></div>

	  <div id="anchor_list" class="search-bar-wrap" style="margin-top:40px">
	      <div class="inner">
	            <div class="item-count">등록제품 : <fmt:formatNumber value="${vo.totalRowCount}"/> 개</div>
	            <ul class="search-list">
	                <li class="regdate"><a href="/shop/lv1/${vo.cateLv1Seq}?orderType=regdate&anchor=anchor_list">신상품</a></li>
	                <li class="lowprice"><a href="/shop/lv1/${vo.cateLv1Seq}?orderType=lowprice&anchor=anchor_list">낮은가격</a></li>
	                <li class="highprice"><a href="/shop/lv1/${vo.cateLv1Seq}?orderType=highprice&anchor=anchor_list">높은가격</a></li>
	            </ul>
	      </div>
	  </div>

		<div class="ch-container" style="margin-top:0;">
			<ul class="ch-3col lv1-3col">
				<c:forEach var="item" items="${list}">
				<li style="margin-top:23px;">
					<div class="img">
					      <a href="/shop/detail/${item.seq}"><img src="${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" <c:if test="${item.img2 ne ''}">data-src="${const.UPLOAD_PATH}${fn:replace(item.img2, 'origin', 's270')}"</c:if> alt="상품이미지"/></a>
					</div>
					<div class="info">
						<div class="name"><a href="/shop/detail/${item.seq}">${item.name}</a></div>
						<c:if test="${item.typeCode eq 'N'}">
						<div class="price"><fmt:formatNumber value="${item.sellPrice}"/><span>원</span></div>
						</c:if>
						<c:if test="${item.typeCode eq 'E'}">
						<div class="price" style="font-size:20px;">견적요청</div>
						</c:if>
					</div>
				</li>
				</c:forEach>
			</ul>
		</div>
      <div class="clearfix"></div>
      <div id="paging" style="text-align:center;margin-bottom:40px;">${paging}</div>

     <!--  <c:if test="${fn:length(gallery3) ne 0}">
            <div class="ch-container" style="margin-top:0;">
                  <ul class="ch-3col lv1-3col">
                        <c:forEach var="item" items="${gallery3}" varStatus="status" begin="0" step="1">
                              <c:if test="${status.index < item.limitCnt}">
                                    <li style="margin-top:23px;">
                                    	<div class="img">
                                                <a href="/shop/detail/${item.itemSeq}"><img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, 'origin', 's270')}" <c:if test="${item.img2 ne ''}">data-src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img2, 'origin', 's270')}"</c:if>/></a>
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
                        </c:forEach>
                  </ul>
            </div>
      </c:if> -->
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/category/lv1.js"></script>
<script type="text/javascript" src="/front-assets/js/category/common.lv.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".img img[data-src]").mouseover(function(){
			if(typeof $(this).attr("data-swap") === "undefined") {
				$(this).attr("data-swap", $(this).attr("src"));
			}
			$(this).attr("src", $(this).attr("data-src"));
		}).mouseleave(function(){
			$(this).attr("src", $(this).attr("data-swap"));
	
		});
	
		$(".widget-3th-type li").each(function(){
			$(this).mouseover(function(){
				$(this).find(".item").slideDown();
			}).mouseleave(function(){
				$(this).find(".item").stop().slideUp();
			});
		});
		
		CHSideNavUtil.render(${vo.cateLv1Seq});
		
		//페이징 네비게이션 이동시 상품리스트 영역 스크롤 유지
		<c:if test="${anchor ne null}">
			location.href = "#${anchor}";
		</c:if>
		
		//정렬 버튼 css스타일
		setStyleOrderBtn("${vo.orderType}");
	});
	
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page + "&anchor=anchor_list&orderType=${vo.orderType}" + "&" + $("#searchForm").serialize();
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
	
	var setStyleOrderBtn = function(orderType) {
		$('.regdate').removeClass('active');
		$('.lowprice').removeClass('active');
		$('.highprice').removeClass('active');
		
		$('.'+orderType).addClass('active');
	};
</script>
</body>
</html>