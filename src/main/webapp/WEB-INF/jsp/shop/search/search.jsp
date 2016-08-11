<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<!--[if IE 7]><html class="ie ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie ie8" lang="ko"><![endif]-->
<!--[if !(IE 7) | !(IE 8) ]><!--><html lang="ko"><!--<![endif]-->
<head>
    <%@ include file="/WEB-INF/jsp/shop/include/head.jsp" %>
</head>
<body>
<input type="hidden" id="loginSeq" value="${loginSeq}"/>
<div id="skip_navi">
    <p><a href="#contents">본문바로가기</a></p>
</div>

<div id="wrap" class="sub">
    <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
    <div id="container">
        <div id="contents" class="sub_contents">
            <div class="location_select">
                <a href="/shop/main">홈</a>
                    <span>
                        <select title="상품 대분류" onchange="(this.value)&&(location.href='/shop/lv1/'+this.value);">
                            <option value="">대분류</option>
                            <c:forEach items="${cateLv1List}" var="item">
                                <option value="${item.seq}" <c:if test="${itemSearchVo.cateLv1Seq eq item.seq}">selected="selected"</c:if>>${item.name}</option>
                            </c:forEach>
                        </select>
                    </span>
                    <span>
                    <select title="상품 중분류" onchange="location.href='/shop/lv'+(this.value==''?'1/${lv1.seq}':'2/'+this.value);">
                        <option value="">중분류</option>
                        <c:forEach items="${cateLv2List}" var="item">
                            <option value="${item.seq}" <c:if test="${itemSearchVo.cateLv2Seq eq item.seq}">selected="selected"</c:if>>${item.name}</option>
                        </c:forEach>
                    </select>
                </span>
            </div>

            <div class="search_result">
                <div class="tit">
                    <p>'<em class="txt_point">${itemSearchVo.name}</em>'로 검색된 검색결과</p>
                    <span class="result_num">검색된 상품수 : <span class="txt_accent">${itemSearchVo.totalRowCount}</span>개</span>
                </div>
                <dl>
                    <dt>카테고리(${fn:length(categoryList)})</dt>
                    <dd>
                        <ul class="defalut">
                            <c:forEach var="item" items="${categoryList}" begin="0" end="4">
                                <li><label>
                                    <a href="/shop/search?name=${itemSearchVo.name}&<c:choose><%--
                                    --%><c:when test="${item.depth==1}">cateLv1Seq=${item.seq}</c:when><%--
                                    --%><c:when test="${item.depth==2}">cateLv1Seq=${item.parentSeq}&cateLv2Seq=${item.seq}</c:when><%--
                                    --%><c:when test="${item.depth==3}">cateLv1Seq=${itemSearchVo.cateLv1Seq}&cateLv2Seq=${item.parentSeq}&cateLv3Seq=${item.seq}</c:when><%--
                                    --%><c:when test="${item.depth==4}">cateLv1Seq=${itemSearchVo.cateLv1Seq}&cateLv2Seq=${itemSearchVo.cateLv2Seq}&cateLv3Seq=${item.parentSeq}&cateLv4Seq=${item.seq}</c:when><%--
                                    --%></c:choose>">${item.name}(${item.count})</a>
                                </label></li>
                            </c:forEach>
                        </ul>
                        <div class="result_more">
                            <ul class="defalut">
                                <c:forEach var="item" items="${categoryList}" begin="4">
                                    <li><label>
                                        <a href="/shop/search?name=${itemSearchVo.name}&<c:choose><%--
                                    --%><c:when test="${item.depth==1}">cateLv1Seq=${item.seq}</c:when><%--
                                    --%><c:when test="${item.depth==2}">cateLv1Seq=${item.parentSeq}&cateLv2Seq=${item.seq}</c:when><%--
                                    --%><c:when test="${item.depth==3}">cateLv1Seq=${itemSearchVo.cateLv1Seq}&cateLv2Seq=${item.parentSeq}&cateLv3Seq=${item.seq}</c:when><%--
                                    --%><c:when test="${item.depth==4}">cateLv1Seq=${itemSearchVo.cateLv1Seq}&cateLv2Seq=${itemSearchVo.cateLv2Seq}&cateLv3Seq=${item.parentSeq}&cateLv4Seq=${item.seq}</c:when><%--
                                    --%></c:choose>">${item.name}(${item.count})</a>
                                    </label></li>
                                </c:forEach>
                            </ul>
                        </div>
                        <a href="#" class="btn_more">더보기</a>
                    </dd>
                </dl>
            </div>

            <div class="goods_container">
                <!-- 상품목록 -->
                <div class="goods_list_wrap">
                    <form name="searchForm">
                        <input type="hidden" name="name" value="${itemSearchVo.name}"/>
                        <input type="hidden" name="cateLv1Seq" value="${itemSearchVo.cateLv1Seq}" />
                        <input type="hidden" name="cateLv2Seq" value="${itemSearchVo.cateLv2Seq}" />

                        <div class="board_option">
                            <dl class="list_ctn">
                                <dt>선택 상품 정렬</dt>
                                <dd>
                                    <a href="#" <c:if test="${itemSearchVo.rowCount eq 10}">class="on"</c:if> onclick="changeRowCount(10);return false;">10개</a>
                                    <a href="#" <c:if test="${itemSearchVo.rowCount eq 12}">class="on"</c:if> onclick="changeRowCount(20);return false;">20개</a>
                                    <a href="#" <c:if test="${itemSearchVo.rowCount eq 15}">class="on"</c:if> onclick="changeRowCount(30);return false;">30개</a>
                                </dd>
                                <input type="hidden" name="rowCount" value="${itemSearchVo.rowCount}" />
                            </dl>

                            <div class="list_type">
                                <a href="#" class="type_img<c:if test="${itemSearchVo.listStyle eq 'img'}"> on</c:if>" onclick="changeListStyle('img');return false;" title="이미지 타입으로 목록보기"><span class="hide">이미지 타입으로 목록보기</span></a>
                                <a href="#" class="type_img_list<c:if test="${itemSearchVo.listStyle eq 'all'}"> on</c:if>" onclick="changeListStyle('all');return false;" title="이미지+리스트 타입으로 목록보기"><span class="hide">이미지+리스트 타입으로 목록보기</span></a>
                                <a href="#" class="type_list<c:if test="${itemSearchVo.listStyle eq 'list'}"> on</c:if>" onclick="changeListStyle('list');return false;" title="리스트 타입으로 목록보기"><span class="hide">리스트 타입으로 목록보기</span></a>
                            </div>
                            <input type="hidden" name="listStyle" value="${itemSearchVo.listStyle}" />
                        </div>
                    </form>

                    <c:choose>
                        <c:when test="${itemSearchVo.listStyle eq 'img'}">
                            <div class="goods_list img_list_type02">
                                <ul>
                                    <c:forEach var="item" items="${list}">
                                        <li data-seq="${item.seq}"><!-- class="on" -->
                                            <input type="checkbox" class="check" title="상품 선택" />
                                            <a href="/shop/detail/${item.seq}" onclick="view(${item.seq});return false;">
                                            <span class="thumb">
                                                <img src="/upload${fn:replace(item.img1, 'origin', 's110')}" alt="" onerror="noImage(this)" />
                                                <span class="icons">
                                                    <c:if test="${item.deliCost eq 0}">
                                                        <span class="icon icon_txt icon_txt_gray">무료배송</span>
                                                    </c:if>
                                                    <!--span class="icon icon_txt icon_txt_yellow">10+1</span>
                                                    <span class="icon icon_txt icon_txt_red">50%</span-->
                                                </span>
                                            </span>
                                                <span class="tit">${item.name}</span>

                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="goods_list">
                                <table class="data_type2">
                                    <caption>상품 목록</caption>
                                    <colgroup>
                                        <col style="width:25px" />
                                        <c:if test="${itemSearchVo.listStyle eq 'all'}"><col style="width:70px" /></c:if>
                                        <col style="width:auto" />
                                        <col style="width:100px" />
                                        <col style="width:100px" />
                                    </colgroup>

                                    <thead>
                                    <tr>
                                        <th scope="col"><span class="hide">상품 선택</span></th>
                                        <c:if test="${itemSearchVo.listStyle eq 'all'}">
                                            <th scope="col"><span class="hide">상품 이미지</span></th>
                                        </c:if>
                                        <th scope="col">상품명</th>
                                        <th scope="col">프로모션 아이콘</th>
                                        <th scope="col">제조사</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${list}">
                                        <tr data-seq="${item.seq}">
                                            <td><input type="checkbox" class="check" title="상품 선택" /></td>
                                            <c:if test="${itemSearchVo.listStyle eq 'all'}"><td>
                                                <a href="/shop/detail/${item.seq}" onclick="view(${item.seq});return false;">
                                    <span class="thumb">
                                        <img src="/upload${fn:replace(item.img1, 'origin', 's60')}" alt="" onerror="noImage(this)" />
                                    </span>
                                                </a>
                                            </td></c:if>
                                            <td class="lt">
                                                <a href="/shop/detail/${item.seq}" onclick="view(${item.seq});return false;">
                                                        ${item.name}
                                                </a>
                                            </td>
                                            <td>
                                                <c:if test="${item.deliCost eq 0}"><span class="icon icon_txt icon_txt_gray">무료배송</span></c:if>
                                                <%--span class="icon icon_txt icon_txt_yellow">10+1</span>
                                                <span class="icon icon_txt icon_txt_red">50%</span --%>
                                            </td>
                                            <td>${item.maker}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="btn_action mt10">
                        <button type="button" class="btn btn_default" onclick="alert('준비중입니다')">선택상품 비교</button>
                    </div>
                    <div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
                </div>

                <div id="DescBody" class="goods_view"></div>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>

<%@ include file="/WEB-INF/jsp/shop/include/view_detail.jsp" %>

</body>
</html>
