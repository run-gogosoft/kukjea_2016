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
                    <form id="mgrForm" method="post" target="zeroframe">
                    <table class="board_list">
                        <%--<colgroup>--%>
                            <%--<col width="3%"/>--%>
                            <%--<col width="10%"/>--%>
                            <%--<col width="*"/>--%>
                            <%--<col width="10%"/>--%>
                            <%--<col width="20%"/>--%>
                            <%--<col width="8%"/>--%>
                        <%--</colgroup>--%>
                        <thead>
                        <tr>
                            <th><input type="checkbox" id="allChk" onclick="WishUtil.checkProc(this)"/></th>
                            <th colspan="2">상품정보</th>
                            <th></th>
                            <th>판매가</th>
                            <th>업체</th>
                            <th>선택</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody id="wishBody">
                        <c:forEach var="item" items="${list}">
                            <input type="hidden" id="seq${item.wishSeq}" value="${item.itemSeq}"/>
                            <input type="hidden" id="count${item.wishSeq}" value="1"/>
                            <input type="hidden" id="optionValueSeq${item.wishSeq}" value="${item.optionValueSeq}"/>
                            <input type="hidden" id="stockCount${item.wishSeq}" value="${item.stockCount}"/>
                            <input type="hidden" id="stockFlag${item.wishSeq}" value="${item.stockFlag}"/>
                            <input type="hidden" id="deliPrepaidFlag${item.wishSeq}" value="${item.deliPrepaidFlag}"/>

                            <tr>
                                <td class="text-center">
                                    <input type="checkbox" id="wishSeq" name="wishSeq" value="${item.wishSeq}"
                                           wish-value="${item.itemSeq}" style="margin:0 auto;"/>
                                </td>
                                    <td>
                                        <a href="/shop/search?seq=${item.itemSeq}">
                                        <c:if test="${item.img1 ne ''}">
                                            <img src="/upload${fn:replace(item.img1, '/origin/', '/s170/')}"
                                                 style="width:70px;border:1px solid #d7d7d7;" width="70px" onerror="noImage(this)" alt="상품이미지"/>
                                        </c:if>
                                        </a>
                                    </td>

                                    <td class="text-left item-name">
                                        <a href="/shop/search?seq=${item.itemSeq}">
                                        ${item.name}<br/>
                                        <span class="option-name">${item.optionName}: ${item.valueName}</span><br/>
                                        </a>
                                    </td>
                                <td>
                                    <span class="icon icon_txt icon_txt_gray">무료배송</span><br/>
                                    <span class="icon icon_txt icon_txt_yellow">${item.eventAdded}</span>
                                </td>

                                <td class="item-price">
                                    <fmt:formatNumber value="${ item.sellPrice }" pattern="#,###"/>원
                                </td>
                                <td>
                                        ${item.sellerName}
                                </td>
                                <td>
                                    <button type="button" class="btn btn_default btn_xs" id="directBtn"
                                            remove-value="${item.wishSeq}" onclick="CHProcess.buy(${item.wishSeq});">
                                        바로구매
                                    </button>
                                    <br/>
                                    <button type="button" class="btn btn_default btn_xs"
                                            remove-value="${item.wishSeq}" onclick="WishUtil.addCart(${item.wishSeq})">
                                        장바구니
                                    </button>
                                </td>
                                <td class="text-center">
                                    <div class="item-delete" style="cursor:pointer" remove-value="${item.wishSeq}"
                                         onclick="WishUtil.wishOneDelProc(this)" style="margin:0 auto">
                                        <button type="button" class="btn btn_default btn_xs">
                                            삭제
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                    <div class="pull-right" style="margin-top:15px">
                        <button type="button" onclick="WishUtil.addAllCart()" class="btn btn_red">전체 장바구니 등록</button>
                        <button type="button" onclick="return WishUtil.wishAllDelProc()" class="btn btn_lightgray">관심상품 비우기</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>
<form id="buyForm" class="hide" action="/shop/order/direct" target="zeroframe"><div></div></form>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="/front-assets/js/plugin/account.js"></script>
<script type="text/javascript">
    var goPage = function (page) {
        location.href = location.pathname + "?pageNum=" + page + "&" + $("#search_form").serialize();
    };

    var CHProcess = {
        vo:{}
        , initVo:function(obj){
            CHProcess.vo = {
                seq:$('#seq'+obj).val()
                , count:$('#count'+obj).val()
                , optionValueSeq:$('#optionValueSeq'+obj).val()
                , stockCount : $('#stockCount'+obj).val()
                , stockFlag : $('#stockFlag'+obj).val()
                , deliPrepaidFlag:''
            };
        }
        , checkVo:function(obj){
            CHProcess.initVo(obj);
            if(CHProcess.vo.optionValueSeq<=0 || CHProcess.vo.count<=0) {
                return "옵션이 선택되지 않은 상품입니다.";
            } else if(CHProcess.vo.stockFlag == "Y" && CHProcess.vo.stockCount < CHProcess.vo.count) {
                return "재고가 모두 소진 되었습니다.";
            }
            return "";
        }
        , buy: function(obj){
            var message = CHProcess.checkVo(obj);
            if(message !== "") {
                alert(message);
                return;
            }

            var html = "";
            for(var prop in CHProcess.vo) {
                //즉시구매 일 때는 EBProcess.vo에 있는 모든 필드를 반복해선 안된다. 이유는 바로 아래에서 deliPrepaidFlag textarea를 만들어 보내기 때문에
                // 모두 for문을 돌게되면 deliPrepaidFlag textarea가 총 두번 생성되므로 이곳에서 deliPrepaidFlag 필드는 제외한다.
                if(prop !== 'deliPrepaidFlag'){
                    html += "<textarea name='"+prop+"'>"+CHProcess.vo[prop]+"</textarea>"
                }
            }

            var deliPrepaidFlag = $('#deliPrepaidFlag'+obj).val();
            if(deliPrepaidFlag !== ''){
                html += '<textarea name="deliPrepaidFlag">'+deliPrepaidFlag+'</textarea>';
            }

            $("#buyForm>div").html(html);
            $("#buyForm").submit();
        }
        , allBuy: function(){
            $("#wishBody input:checkbox").each(function(){
                $(this).prop("checked", "checked");
            });

            var seq = [];
            $("#wishBody input:checkbox:checked").each(function(){
                seq.push($(this).val());
            });

            if(seq.length === 0) {
                alert('상품을 선택해주세요.');
                return;
            }

            location.href="/shop/order?seq=" + seq.join(",");
        }
    };

    var WishUtil = {
        checkProcBtn:function() {
            var flag;
            if($('#allChk').prop("checked") === true) {
                $('#allChk').prop("checked",false);
                flag = false;
            } else {
                $('#allChk').prop("checked",true);
                flag = true;
            }
            $("#wishBody input:checkbox").each(function(){
                $(this).prop("checked", flag);
            });
        }
        , checkProc:function(obj) {
            $("#wishBody input:checkbox").each(function(){
                $(this).prop("checked", $(obj).prop("checked"));
            });
        }
        , wishAllDelProc:function() {
            if(confirm("정말로 삭제하시겠습니까?")) {
                $("#wishBody input:checkbox").each(function(){
                    $(this).prop("checked", "checked");
                });
                if($("#wishBody input:checkbox:checked").length==0){
                    alert("삭제할 상품이 없습니다.");
                    return false;
                }

                $("#mgrForm").attr('action', '/shop/wish/del/proc');
                $("#mgrForm").submit();
            }
        }
        , wishOneDelProc:function(obj) {
            if(confirm("정말로 삭제하시겠습니까?")) {
                $("#wishBody input:checkbox").each(function(){
                    if($(this).attr('value') === $(obj).attr('remove-value')) {
                        $(this).prop("checked", "checked");
                    }
                    $("#mgrForm").attr('action', '/shop/wish/del/proc');
                    $("#mgrForm").submit();
                });
            }
        }
        , addCart:function(obj) {
            $("#wishBody input:checkbox").each(function(){
                var parseValue1 = parseInt($(this).attr('value'), 10);
                var parseValue2 = parseInt(obj, 10);

                if(parseValue1 === parseValue2) {
                    $(this).prop("checked", "checked");
                }

                $("#mgrForm").attr('action', '/shop/wish/cart/proc');
                $("#mgrForm").submit();
            });
        }
        , addAllCart:function() {
            $("#wishBody input:checkbox").each(function(){
                $(this).prop("checked", "checked");
            });

            $("#mgrForm").attr('action', '/shop/wish/cart/proc');
            $("#mgrForm").submit();
        }
        , addAllBuy:function() {
            $("#wishBody input:checkbox").each(function(){
                $(this).prop("checked", "checked");
            });

            $("#mgrForm").attr('action', '/shop/wish/all/buy/proc');
            $("#mgrForm").submit();
        }
    };
</script>
</body>
</html>
