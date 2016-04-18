<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
      <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
      <link href="${const.ASSETS_PATH}/front-assets/css/category/jachigu.css" type="text/css" rel="stylesheet">
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

<div class="breadcrumb" style="background-color:#F1F1F1;">
      <div class="pull-left" style="margin:8px 10px 0 0;"><img src="/front-assets/images/detail/home.png" alt="홈"> 홈<span class="arrow-sub">&gt;</span>자치구 상품
      <span class="arrow-sub">&gt;</span>
      <c:choose>
            <c:when test="${vo.jachiguCode eq ''}">
                  <strong>전체</strong>
            </c:when>
            <c:otherwise>
                   <c:forEach var="item" items="${jachiguList}" varStatus="status">
                        <c:if test="${vo.jachiguCode eq item.value}">
                              <strong>${item.name}</strong>
                        </c:if>
                  </c:forEach>
            </c:otherwise>
      </c:choose>
      </div>
      <div style="float:right; margin-right:33px; width:160px;">
            <div style="position:relative">
                  <form action="" method="post" style="display:inline-block;width:200px;margin:0;padding:0;">
                        <div class="input-group ch-detail-search" style="margin-top: 4px;">
                              <input type="text" name="name" value="${vo.name}" class="form-control search-input" placeholder="결과내 검색" data-required-label="검색어">
                              <div class="input-group-btn">
                                    <button type="submit" class="btn btn-default" style="color:#cdcdcd;border-left:none;">
                                          <i class="fa fa-search"></i>
                                    </button>
                              </div>
                        </div>
                  </form>
            </div>
      </div>
      <div class="clearfix"></div>
      <c:if test="${sessionScope.loginJachiGuCode ne null}">
            <div class="pull-right" style="margin:30px 0 5px 0; font-size:12px;"><i class="fa fa-check"></i>표시는 고객이 속한 자치구를 뜻합니다.</div>
      </c:if>
</div>
<div class="clearfix"></div>

<div class="top-nav-wrap">
      <ul class="top-nav-list">
            <li id="topList1" <c:if test="${vo.jachiguCode eq ''}">class="current"</c:if>><a href="javascript:;" onclick="goJachiGu('00')">전체</a></li>
            <c:forEach var="item" items="${jachiguList}" varStatus="status">
                  <c:choose>
                        <c:when test="${fn:length(jachiguList) eq status.count}">
                              <li id="topList${status.count+1}"
                                    <c:choose>
                                          <c:when test="${vo.jachiguCode eq item.value}">style="background-color:#4CB7C9;"</c:when>
                                          <c:otherwise>style="background-color:#d8d8d8;"</c:otherwise>
                                    </c:choose>>
                                    <a href="javascript:;" onclick="goJachiGu('${item.value}')"
                                    <c:choose>
                                          <c:when test="${vo.jachiguCode eq item.value}">style="color:#fff;font-weight:bold;"</c:when>
                                          <c:otherwise>style="color:#343434;font-weight:normal"</c:otherwise>
                                    </c:choose>
                                    >${item.name} <c:if test="${sessionScope.loginJachiGuCode eq item.value}"><i class="fa fa-check" style="margin-left:5px;"></i></c:if></a>
                              </li>
                        </c:when>
                        <c:otherwise>
                              <li id="topList${status.count+1}" <c:if test="${vo.jachiguCode eq item.value}">class="current"</c:if>>
                                    <a href="javascript:;" onclick="goJachiGu('${item.value}')">${item.name}<c:if test="${sessionScope.loginJachiGuCode eq item.value}"><i class="fa fa-check" style="margin-left:5px;"></i></c:if></a>
                              </li>
                        </c:otherwise>
                  </c:choose>
            </c:forEach>
      </ul>
</div>

<div class="clearfix"></div>

<div class="search-bar-wrap" style="margin-top:25px;">
      <div class="inner">
            <div class="item-count">등록제품 : <span>${vo.totalRowCount}</span>개</div>
            <ul class="search-list">
                  <li <c:if test="${vo.orderType eq '' or vo.orderType eq 'regdate'}">class="active"</c:if>><a href="#" onclick="orderPage('regdate')">신상품</a></li>
                  <!-- <li><a href="#">상품명</a></li> -->
                  <li <c:if test="${vo.orderType eq 'lowprice'}">class="active"</c:if>><a href="#" onclick="orderPage('lowprice')">낮은가격</a></li>
                  <li <c:if test="${vo.orderType eq 'highprice'}">class="active"</c:if>><a href="#" onclick="orderPage('highprice')">높은가격</a></li>
                  <!-- <li><a href="#">제조사</a></li> -->
            </ul>
      </div>
</div>

<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

<div class="ch-container" style="margin-top:0;">
    <ul class="ch-3col lv1-3col" style="margin-bottom:60px;">
      <c:forEach var="item" items="${list}">
            <c:if test="${item.soldOutFlag ne 'Y'}">
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
            </c:if>
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
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/category/jachigu.js"></script>
<script type="text/javascript">
      var goPage = function (page) {
        location.href = location.pathname + "?pageNum=" + page + "&orderType=${vo.orderType}" + "&" + $("#searchForm").serialize();
      };

      var orderPage = function (value) {
        location.href = location.pathname + "?orderType="+value+ "&" + $("#searchForm").serialize();
      };

      var goJachiGu = function(value) {
            var name = "${vo.name}";
            location.href = "/shop/jachigu/"+ value + "?name="+name;
      }

      $(document).ready(function() {
            $('.top-nav-list li').each(function(idx) {
                  //끝라인의 보더를 살린다
                  if((idx+1) % 8 !== 0) {
                        $(this).css({'border-right':0});
                  }

                  //맨위쪽의 보더를 살린다.
                  if(idx > 7) {
                        $(this).css({'border-top':0});
                  }

                  //현재 선택된 자치구를 true만들어 current가 풀리지 않게한다.
                  if($(this).hasClass('current')) {
                        JachiguUtil.clickFlag[idx] = true;
                  }

                  var jachiguCode = "${vo.jachiguCode}";
                  var lastIndex = "${fn:length(jachiguList)}";
                  if(idx === parseInt(lastIndex, 10) && jachiguCode === '99') {
                        JachiguUtil.clickFlag[idx] = true;
                  }
            });
      });
</script>
</body>
</html>