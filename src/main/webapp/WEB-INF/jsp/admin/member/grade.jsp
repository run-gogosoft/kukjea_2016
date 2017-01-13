<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
    <!-- 헤더 -->
    <section class="content-header">
        <h1>회원 등급관리 <small></small></h1>
        <ol class="breadcrumb">
            <li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
            <li>회원 관리</li>
            <li class="active">회원 등급관리 </li>
        </ol>
    </section>
    <!-- 콘텐츠 -->
    <section class="content">
        <div class="row">
            <div class="col-md-12">

                <div class="box">
                    <!-- 소제목 -->
                    <!-- <div class="box-header with-border"><h3 class="box-title"></h3></div> -->
                    <!-- 내용 -->
                    <div class="box-body">

                        <table class="table table-bordered table-striped">

                            <thead>
                            <tr>

                                <th>등급명</th>
                                <th>회원수</th>
                                <th>할인혜택</th>
                                <th>적립혜택</th>
                                <th>정렬순서</th>
                                <th>아이콘</th>
                                <th>등급방식</th>
                                <th>등급조건</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${list}">
                                <tr>

                                    <td class="text-center">${item.name}</td>
                                    <td class="text-center">${item.count}</td>
                                    <td class="text-center">${item.salePercent} %</td>
                                    <td class="text-center">${item.pointPercent} %</td>
                                    <td class="text-center">${item.sortOrder}</td>
                                    <td class="text-center"><img src="../../images/common/icon_grade_sm.png" alt="등급" class="level" /></td>
                                    <td class="text-center">자동</td>
                                    <td class="text-center">구매금액이 <strong><fmt:formatNumber value="${item.payCondition}"/></strong> 원 이상</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${ fn:length(list)==0 }">
                                <tr>
                                    <td class="text-center" colspan="11">등록된 회원 등급이 없습니다.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
</body>
</html>

