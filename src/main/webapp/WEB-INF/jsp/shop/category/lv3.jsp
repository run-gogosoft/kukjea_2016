<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
      <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
      <link href="${const.ASSETS_PATH}/front-assets/css/category/lv1.css" type="text/css" rel="stylesheet">
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

      <div class="breadcrumb">
            <div class="pull-left" style="margin:8px 10px 0 0;"><img src="/front-assets/images/detail/home.png" alt="홈"> 홈<span class="arrow">&gt;</span></div>
            <form id="searchForm" method="get" class="pull-left" style="margin-top:8px;">
                  <select name="cateLv1Seq" style="display:inline;width:155px;" onchange="submitCatagory(1, this, '');">
                        <option value="">대분류</option>
                        <c:forEach var="item" items="${cateLv1List}" varStatus="status" begin="0" step="1">
                              <%--함께누리 측의 요청으로 공공기관에만 특별주문 카테고리를 노출한다.--%>
                              <c:choose>
                                    <c:when test="${sessionScope.loginMemberTypeCode eq 'P'}">
                                          <option value="${item.seq}" <c:if test="${vo.cateLv1Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                                    </c:when>
                                     <c:otherwise>
                                          <c:if test="${item.seq ne 53}">
                                                <option value="${item.seq}" <c:if test="${vo.cateLv1Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                                          </c:if>
                                    </c:otherwise>
                              </c:choose>
                        </c:forEach>
                  </select>

                  <c:if test="${fn:length(cateLv2List) ne 0}">
                        <span class="arrow-sub">&gt;</span>
                        <select name="cateLv2Seq" style="display:inline;width:155px;" onchange="submitCatagory(2, this, ${vo.cateLv1Seq});">
                              <option value="">중분류(전체)</option>
                              <c:forEach var="item" items="${cateLv2List}" varStatus="status" begin="0" step="1">
                                    <option value="${item.seq}" <c:if test="${vo.cateLv2Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                              </c:forEach>
                        </select>
                  </c:if>

                  <c:if test="${fn:length(cateLv3List) ne 0}">
                        <span class="arrow-sub">&gt;</span>
                        <select name="cateLv3Seq" style="display:inline;width:155px;" onchange="submitCatagory(3, this, ${vo.cateLv2Seq});">
                              <option value="">소분류(전체)</option>
                              <c:forEach var="item" items="${cateLv3List}" varStatus="status" begin="0" step="1">
                                    <option value="${item.seq}" <c:if test="${vo.cateLv3Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                              </c:forEach>
                        </select>
                  </c:if>

                  <c:if test="${fn:length(cateLv4List) ne 0}">
                        <span class="arrow">&gt;</span>
                        <select name="cateLv4Seq" style="display:inline;width:155px;" onchange="submitCatagory(4, this, ${vo.cateLv3Seq});">
                              <option value="">세분류(전체)</option>
                              <c:forEach var="item" items="${cateLv4List}" varStatus="status" begin="0" step="1">
                                    <option value="${item.seq}" <c:if test="${vo.cateLv4Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
                              </c:forEach>
                        </select>
                  </c:if>
                  <input type="hidden" name="name" value="${vo.name}" />
            </form>
      </div>

      <div class="search-bar-wrap" style="margin-top:0">
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
<script type="text/javascript">
      var goPage = function (page) {
        location.href = location.pathname + "?pageNum=" + page + "&orderType=${vo.orderType}" + "&" + $("#searchForm").serialize();
      };

      var orderPage = function (value) {
        location.href = location.pathname + "?orderType="+value+ "&" + $("#searchForm").serialize();
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
                  var lv = parseInt(lvValue,10);
                  if(lv === 2) {
                        $('select[name=lv3]').prop('disabled',true);
                        $('select[name=lv4]').prop('disabled',true);
                  } else if(lv === 3) {
                        $('select[name=lv4]').prop('disabled',true);
                  }
                  urlDepthEtc = "/shop/lv"+lvValue+"/"+$(obj).val();
            }

            $('#searchForm').attr('action', urlDepth1 !== '' ? urlDepth1 : urlDepthEtc); //urlDepth1이 null이 아니라면 urlDepth1이 실행될 것이다.
            $('#searchForm').submit();
      };
</script>
</body>
</html>