<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<!--[if IE 7]><html class="ie ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie ie8" lang="ko"><![endif]-->
<!--[if !(IE 7) | !(IE 8) ]><!--><html lang="ko"><!--<![endif]-->
<head>
    <%@ include file="/WEB-INF/jsp/shop/include/head.jsp" %>
</head>
<body>

<div id="skip_navi">
    <p><a href="#contents">본문바로가기</a></p>
</div>

<div id="wrap" class="sub">
    <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
    <div id="container">
        <div class="layout_inner sub_container">
            <%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>
            <div id="contents">
                <%@ include file="/WEB-INF/jsp/shop/include/mypage_anchor.jsp" %>
                <div class="sub_cont myinfo">
                    <h4><em class="must">*</em> 배송지 정보</h4>
                    <div class="delivery_list_sort">
                        <label>&nbsp;</label>
                        <%-- label><input type="radio" class="radio" name="sort" value="alphabet" checked="checked" />가나다 순으로 정렬</label>
                        <label><input type="radio" class="radio" name="sort" value="registration" />등록일 순으로 정렬</label --%>
                        <a href="/shop/mypage/delivery/reg" class="btn btn_gray btn_sm">배송지등록</a>
                    </div>

                    <div class="delivery_list">
                        <ul>
                            <c:forEach var="item" items="${list}" varStatus="status">
                            <li>
                                <div>
                                    <span class="num">${status.index + 1}</span>
                                    <p class="txt">
                                        <c:if test="${item.defaultFlag eq 'Y'}"><i class="fa fa-check"></i></c:if>
                                        <a href="/shop/mypage/delivery/mod/${item.seq}">${item.title}</a>
                                    </p>
                                    <p class="txt">
                                        <span style="letter-spacing:0;">${item.postcode}</span>
                                        ${item.addr1}, ${item.addr2}
                                    </p>
                                    <p class="date" onclick="doDel('${item.seq}')" style="cursor:pointer">삭제</p>
                                </div>
                            </li>
                            </c:forEach>
                        </ul>
                    </div>

                    <div class="board_action">${paging}</div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>
<script type="text/javascript">
    var goPage = function (page) {
        location.href = location.pathname + "?pageNum=" + page + "&" + $("#search_form").serialize();
    };

    var doDel = function(seq) {
        if(!confirm("정말로 삭제하시겠습니까?")) {
            return;
        }
        location.href="/shop/${mallId}/mypage/delivery/del/"+seq+"/proc";
    };
</script>
</body>
</html>
