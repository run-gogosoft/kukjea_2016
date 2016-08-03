<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!doctype html>
<!--[if IE 7]><html class="ie ie7" lang="ko"><![endif]-->
<!--[if IE 8]><html class="ie ie8" lang="ko"><![endif]-->
<!--[if !(IE 7) | !(IE 8) ]><!--><html lang="ko"><!--<![endif]-->
<head>
    <%@ include file="/WEB-INF/jsp/shop/include/head.jsp" %>
    <link rel="stylesheet" href="/front-assets/css/common/common.css" />
    <link href="/front-assets/css/order/order.css" type="text/css" rel="stylesheet">
</head>
<body>

<div id="skip_navi">
    <p><a href="#contents">본문바로가기</a></p>
</div>

<div id="wrap" class="sub">
    <%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
    <div id="container" class="wide_container">
        <div class="layout_inner sub_container">
            <h2 class="blind">결제시스템</h2>
            <!-- contents -->
            <div id="contents">
                <div class="sub_tit">
                    <h3>결제</h3>
                </div>
                <div class="sub_cont payment">
                    <h4 class="mt20"><span>1.</span> 결제 상품 확인</h4>
                    <table class="board_list">
                        <caption>결제 상품 목록</caption>
                        <colgroup>
                            <col width="8%"/>
                            <col width="*"/>
                            <col width="10%"/>
                            <col width="7%"/>
                            <col width="12%"/>
                            <col width="12%"/>
                            <col width="12%"/>
                        </colgroup>
                        <thead>
                        <tr>
                            <th colspan="2">상품정보</th>
                            <th>판매가</th>
                            <th>수량</th>
                            <th>상품 금액</th>
                            <th>배송정보</th>
                            <th>업체</th>
                        </tr>
                        </thead>
                        <c:set var="totalSellPrice" value="0" />
                        <c:set var="totalDeliveryPrice" value="0" />
                        <tbody>
                        <c:forEach var="item" items="${list}">
                            <c:set var="rowSum" value="${(item.sellPrice +item.optionPrice) * item.count}"/>
                            <tr>
                                <td>
                                    <c:if test="${item.img1 ne ''}">
                                        <img src="/upload${fn:replace(item.img1, '/origin/', '/s60/')}" style="width:70px;border:1px solid #d7d7d7;" width="70px" onerror="noImage(this)" alt="" />
                                    </c:if>
                                </td>
                                <td class="text-left item-name">
                                        ${item.name}
                                    <c:if test="${item.estimateCount > 0}"> ( x ${item.estimateCount} 개 )</c:if>
                                    <br/>
                                    <span class="option-name">${item.optionName}: ${item.valueName}</span><br/>
                                </td>
                                <td>
                                    <span><fmt:formatNumber value="${item.sellPrice+item.optionPrice}" pattern="#,###" />원</span>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${item.count}" pattern="#,###" />개
                                </td>
                                <td class="item-price">
                                    <fmt:formatNumber value="${rowSum}" pattern="#,###" />원
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.deliCost == 0}">
                                            <c:choose>
                                                <c:when test="${item.packageDeliCost > 0}">무료<br/>(묶음배송 할인)</c:when>
                                                <c:otherwise>
                                                    무료
                                                    <c:if test="${item.deliFreeAmount >0}">
                                                        <br/><fmt:formatNumber value="${item.deliFreeAmount}" pattern="#,###" />원 이상 구매
                                                    </c:if>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${item.deliCost}" pattern="#,###" />원
                                            <c:choose>
                                                <c:when test="${item.deliPrepaidFlag eq 'Y'}">
                                                    <c:set var="totalDeliveryPrice" value="${totalDeliveryPrice + item.deliCost}" />
                                                    <br/>선결제
                                                </c:when>
                                                <c:otherwise>
                                                    <br/>착불
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    ${item.sellerName}
                                </td>
                            </tr>
                            <c:set var="totalSellPrice" value="${totalSellPrice + rowSum}" />
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr class="total_price">
                            <td colspan="7">
                                <div class="total">
                                    <dl>
                                        <dt>총 판매가</dt>
                                        <dd>
                                            <strong><fmt:formatNumber value="${totalSellPrice}" pattern="#,###" /></strong>원
                                        </dd>
                                        <dt>배송비 합계</dt>
                                        <dd>
                                            <strong><fmt:formatNumber value="${totalDeliveryPrice}" pattern="#,###" /></strong>원
                                        </dd>
                                        <dt>할인금액</dt>
                                        <dd><span><strong id="discountPriceText">0</strong>원</span></dd>
                                    </dl>
                                    <div class="price">
                                        <span>총 구매금액: <em id="totalPriceText"><fmt:formatNumber value="${totalSellPrice + totalDeliveryPrice}" pattern="#,###" /></em> 원</span>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                    <input type="hidden" id="totalDeliveryPrice" value="${totalDeliveryPrice}"/>
                    <input type="hidden" id="total_price" value="${totalSellPrice + totalDeliveryPrice}" />

                    <form action="/shop/order/start" method="post" onsubmit="return submitProc(this)" target="_self">
                        <input type="hidden" name="estimate_flag" value="${estimateFlag}"/>

                        <h4 class="mt30"><span>2.</span> 주문자 정보</h4>

                        <table class="board_write">
                            <caption>주문자 정보 작성</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
                            <tr>
                                <th scope="row"><label>주문자명</label></th>
                                <td>
                                    <c:choose>
                                        <c:when test="${sessionScope.loginSeq eq null and sessionScope.loginName ne null}">
                                            <%-- 비회원 로그인일 경우 --%>
                                            <input type="text" name="memberName" value="${sessionScope.loginName}" maxlength="15" alt="주문자명" class="intxt w180" readonly>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" name="memberName" value="${memberVo.name}" maxlength="15" alt="주문자명" class="intxt w180">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>휴대폰번호</label></th>
                                <td>
                                    <input type="text" name="memberCell1" value="${memberVo.cell1}" class="intxt w50" onblur="numberCheck(this);" alt="주문자 휴대폰 번호" maxlength="4">&nbsp;-&nbsp;
                                    <input type="text" name="memberCell2" value="${memberVo.cell2}" class="intxt w50" onblur="numberCheck(this);" alt="주문자 휴대폰 번호" maxlength="4">&nbsp;-&nbsp;
                                    <input type="text" name="memberCell3" value="${memberVo.cell3}" class="intxt w50" onblur="numberCheck(this);" alt="주문자 휴대폰 번호" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>이메일</label></th>
                                <td>
                                    <c:choose>
                                        <c:when test="${sessionScope.loginSeq eq null and sessionScope.loginEmail ne null}">
                                            <%-- 비회원 로그인일 경우 --%>
                                            <input type="text" class="intxt w180" name="memberEmail" value="<smp:decrypt value="${sessionScope.loginEmail}"/>" maxlength="100" placeholder="example@example.com" alt="이메일" readonly/>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="text" class="intxt w180" name="memberEmail" value="${memberVo.email}" maxlength="100" placeholder="example@example.com" alt="이메일"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="check_delivery">
                            <h4><span>3.</span> 배송지 정보</h4>
                            <div class="check_opt">
                                <c:if test="${sessionScope.loginSeq ne null}">
                                    <!-- 회원일 경우 -->
                                    <label><input type="radio" name="deliveryMethod" onclick="CHProcess.deliveryAddrMethod(this)" value="default" checked>&nbsp;기본 배송지</label>
                                    <label><input type="radio" name="deliveryMethod" onclick="CHProcess.deliveryAddrMethod(this)" value="lately">&nbsp;최근 배송지</label>
                                    <label><input type="radio" name="deliveryMethod" onclick="CHProcess.deliveryAddrMethod(this)" value="buyer">&nbsp;주문자 정보와 동일</label>
                                    <label><input type="radio" name="deliveryMethod" onclick="CHProcess.deliveryAddrMethod(this)" value="new">&nbsp;새로입력</label>
                                    <label><button type="button" class="btn btn_gray btn_xs" onclick="CHDelivery.deliveryListShow()">배송주소록</button>에서 불러오기</label>
                                </c:if>
                                <c:if test="${sessionScope.loginSeq eq null and sessionScope.loginEmail ne null}">
                                    <!-- 비회원 로그인일 경우 -->
                                    <label><input type="radio" name="deliveryMethod" onclick="CHProcess.deliveryAddrMethod(this)" value="notlogin">&nbsp;주문자 정보와 동일</label>
                                </c:if>
                            </div>
                        </div>
                        <table id="deliveryTable" class="board_write sign-table">
                            <caption>주문자 정보 작성</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
                            <tr>
                                <th scope="row"><label>수신자명</label></th>
                                <td>
                                    <input type="text" name="receiverName" maxlength="15" data-name="name" class="intxt w180" alt="받으시는 분" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>전화번호</label></th>
                                <td>
                                    <input type="text" name="receiverTel1" data-name="tel1" alt="전화번호" onblur="numberCheck(this);" maxlength="4" class="intxt w50">&nbsp;-&nbsp;
                                    <input type="text" name="receiverTel2" data-name="tel2" alt="전화번호" onblur="numberCheck(this);" maxlength="4" class="intxt w50">&nbsp;-&nbsp;
                                    <input type="text" name="receiverTel3" data-name="tel3" alt="전화번호" onblur="numberCheck(this);" maxlength="4" class="intxt w50">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>휴대폰번호</label></th>
                                <td>
                                    <input type="text" name="receiverCell1" data-name="cell1" alt="휴대폰 번호" onblur="numberCheck(this);" maxlength="3" class="intxt w50">&nbsp;-&nbsp;
                                    <input type="text" name="receiverCell2" data-name="cell2" alt="휴대폰 번호" onblur="numberCheck(this);" maxlength="4" class="intxt w50">&nbsp;-&nbsp;
                                    <input type="text" name="receiverCell3" data-name="cell3" alt="휴대폰 번호" onblur="numberCheck(this);" maxlength="4" class="intxt w50">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>이메일</label></th>
                                <td>
                                    <input type="text" class="intxt w180" name="receiverEmail" value="" maxlength="100" placeholder="example@example.com" data-name="email" />
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>주소</label></th>
                                <td>
                                    <input type="text" class="intxt w180" id="postcode" name="postcode" data-name="postcode" maxlength="5" value="${vo.postcode}" alt="우편번호" readonly />
                                    <button type="button" class="btn btn_gray btn_sm" onclick="CHPostCodeUtil.postWindow('open', '#deliveryTable');">우편번호찾기</button>
                                    <p class="mt10"><input type="text" class="intxt w560" name="addr1" data-name="addr1" maxlength="100" alt="주소" readonly /></p>
                                    <p class="mt10"><input type="text" class="intxt w560" name="addr2" data-name="addr2" maxlength="100" alt="상세주소" /></p>
                                    <input type="hidden" id="receiverAddr2" name="receiverAddr2"/>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row"><label>배송 메세지</label></th>
                                <td>
                                    <input type="text" name="request" maxlength="500" class="intxt w560" placeholder="ex) 배송 전 연락 바랍니다. 부재 시 경비실에 맡겨 주세요."/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <input type="hidden" id="mallId" value="${mallId}">
                        <input type="hidden" id="pointFlag" value="${fn:contains(mallVo.payMethod, 'POINT')}">

                        <h4 class="mt30"><span>4.</span> 결제 정보</h4>
                        <table class="board_write">
                            <caption>결제 정보</caption>
                            <colgroup>
                                <col style="width:140px" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
                            <c:if test="${sessionScope.loginSeq ne null}">
                                <c:if test="${fn:contains(mallVo.payMethod, 'POINT')}">
                                    <tr>
                                        <th>포인트</th>
                                        <td>
                                            나의 적립 포인트
                                            <span class="total-save-point-wrap">
                                                <input type="hidden" id="cur_point" value="${availablePoint}"/>
                                                <input type="hidden" id="apply_point_btn_click" value="N"/>
                                                <span style="width:auto"><fmt:formatNumber value="${availablePoint}" pattern="#,###" /></span>
                                                <span class="won">원</span>
                                            </span>
                                            <input type="text" id="point" name="point" class="form-control numeric point-input-box" value="0" onfocus="initPoint()"/>&nbsp;&nbsp;
                                            <span class="won">원</span>
                                            <input type="checkbox" id="apply_point_checkbox_click" class="all-point-use-button" onclick="inputPointAll(this)" style="margin-left:15px;width:20px;height:auto;"/> 사용금액 자동입력
                                            <button type="button" onclick="applyPoint()" class="btn btn-xs small-btn btn-default point-use-button">적용하기</button>
                                            <div class="point-description">
                                                - 사용하시고자 하는 포인트 확인 후 <strong style="color:red;">
                                                포인트란에 해당 금액을 입력해 주시고,'적용하기'를 눌러</strong> 주시기 바랍니다.
                                            </div>
                                            <div class="point-description">
                                                - 포인트는 <strong style="color:red;">500 포인트</strong> 단위로 사용하실 수 있습니다.
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:if>
                            <c:if test="${mallVo.payMethod ne 'POINT'}">
                                <tr>
                                    <th>결제수단</th>
                                    <td>
                                        <div class="order-radio-list" style="margin-left:0;">
                                            <c:forEach var="item" items="${payMethodList}" varStatus="status">
                                                <c:if test="${item.value ne 'POINT' and fn:contains(mallVo.payMethod, item.value)}">
                                                    <c:if test="${(sessionScope.loginMemberTypeCode eq null or sessionScope.loginMemberTypeCode eq 'C' or sessionScope.loginMemberTypeCode eq 'P') and item.value eq 'CARD1'}">
                                                        <!-- 일반,공공기관 회원 및 비회원일 경우에만 노출 (신용카드 안심클릭/ISP 인증 필요) -->
                                                        <div style="display:block; float:none; margin:10px 0; width:800px">
                                                            <input type="radio" name="payMethod" value="${item.value}" onclick="checkPayMethod(this)" />&nbsp;${item.name}
                                                            - <span class="text-info">안심클릭/ISP 인증 (30만원 이상 결제시 공인인증서 필요)</span>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${(sessionScope.loginMemberTypeCode eq 'O' or sessionScope.loginMemberTypeCode eq 'P') and item.value eq 'CARD2'}">
                                                        <!-- 기업,기관 회원일 경우에만 노출 (신용카드 안심클릭/ISP 인증 거치지 않음) -->
                                                        <div style="display:block; float:none; margin:10px 0; width:800px">
                                                            <input type="radio" name="payMethod" value="${item.value}" onclick="checkPayMethod(this)" />&nbsp;${item.name} - <span class="text-info">카드번호/비밀번호 인증</span>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${sessionScope.loginMemberTypeCode ne 'P' and item.value eq 'CASH'}">
                                                        <!-- 공공기관은 후청구(무통장 입금)을 사용하기 때문에 일반 무통장입금은 노출시키지 않는다.    -->
                                                        <div style="display:block; float:none; margin:10px 0; width:740px;">
                                                            <input type="radio" name="payMethod" value="${item.value}" onclick="checkPayMethod(this)" />&nbsp;${item.name}
                                                            (
                                                            입금은행: <strong class="text-info">ㅇㅇ은행</strong> /
                                                            계좌번호: <strong class="text-info">100-123-123456</strong> /
                                                            예금주: <strong class="text-info">(주)주식회사 홍길동</strong>
                                                            )
                                                        </div>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                            <input type="hidden" name="accountInfo" value="ㅇㅇ은행 100-123-123456 (주)주식회사 홍길동"/>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${sessionScope.loginSeq ne null and sessionScope.loginMemberTypeCode ne 'C'}">
                                <%--기관, 기업 회원만 비교 견적을 요청할 수 있다. --%>
                                <%--<tr>--%>
                                    <%--<td>비교견적 요청<span>*</span></td>--%>
                                    <%--<td>--%>
                                        <%--<div class="order-radio-list" style="width:200px;margin-left:0;">--%>
                                            <%--<div><input type="radio" name="estimateCompareFlag" value="Y">&nbsp;요청</div>--%>
                                            <%--<div><input type="radio" name="estimateCompareFlag" value="N">&nbsp;요청 안함</div>--%>
                                        <%--</div>--%>
                                    <%--</td>--%>
                                <%--</tr>--%>
                                <tr id="tax_request_tr" style="display:none">
                                    <td>세금계산서 요청</td>
                                    <td>
                                        <div class="order-radio-list" style="width:200px;margin-left:0;">
                                            <div><input type="radio" name="taxRequest" value="Y" onclick="$('#tax_request').show();" />&nbsp;요청</div>
                                            <div><input type="radio" name="taxRequest" value="N" onclick="$('#tax_request').hide();" checked="checked" />&nbsp;요청 안함</div>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>

                        <c:if test="${sessionScope.loginSeq ne null and sessionScope.loginMemberTypeCode ne 'C'}">
                        <div id="tax_request" style="display:none;">
                            <h4 class="mt30"><span>5.</span> 세금계산서 요청서</h4>
                            <table class="board_write">
                                <caption>결제 정보</caption>
                                <colgroup>
                                    <col style="width:140px" />
                                    <col style="width:auto" />
                                </colgroup>
                                <tr>
                                    <th>사업자 번호</th>
                                    <td>
                                        <input type="text" name="businessNum1" value="${fn:substring(mgVo.bizNo,0,3)}" onblur="numberCheck(this);" maxlength="3" class="form-control" style="width:60px" /> -
                                        <input type="text" name="businessNum2" value="${fn:substring(mgVo.bizNo,3,5)}" onblur="numberCheck(this);" maxlength="2" class="form-control" style="width:40px" /> -
                                        <input type="text" name="businessNum3" value="${fn:substring(mgVo.bizNo,5,10)}" onblur="numberCheck(this);" maxlength="5" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>상호(법인명)</th>
                                    <td>
                                        <input type="text" name="businessCompany" value="${mgVo.name}" maxlength="30" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>대표자</th>
                                    <td>
                                        <input type="text" name="businessName" value="${mgVo.ceoName}" maxlength="30" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>소재지</th>
                                    <td>
                                        <input type="text" name="businessAddr" value="${fn:substring(memberVo.postcode,0,3)}-${fn:substring(memberVo.postcode,3,6)} ${memberVo.addr1} ${memberVo.addr2}" maxlength="200" class="form-control" style="width:560px" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>업태</th>
                                    <td>
                                        <input type="text" name="businessCate" value="${mgVo.bizType}" maxlength="30" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>종목</th>
                                    <td>
                                        <input type="text" name="businessItem" value="${mgVo.bizKind}" maxlength="30" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>계산서 수신 이메일</th>
                                    <td>
                                        <input type="text" name="requestEmail" value="${mgVo.taxEmail}" maxlength="65" class="form-control" style="width:300px" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>담당자 성함</th>
                                    <td>
                                        <input type="text" name="requestName" value="${mgVo.taxName}" maxlength="25" class="form-control" />
                                    </td>
                                </tr>
                                <tr>
                                    <th>담당자 연락처</th>
                                    <td>
                                        <input type="text" name="requestCell1" value="" onblur="numberCheck(this);" maxlength="3" class="form-control">&nbsp;-&nbsp;
                                        <input type="text" name="requestCell2" value="" onblur="numberCheck(this);" maxlength="4" class="form-control">&nbsp;-&nbsp;
                                        <input type="text" name="requestCell3" value="" onblur="numberCheck(this);" maxlength="4" class="form-control">
                                    </td>
                                </tr>
                            </table>
                        </div>
                        </c:if>

                        <dl class="attention mt30">
                            <dt>안내</dt>
                            <dd>
                                <p>구매하신 상품은 상품가치가 훼손되면 반품이 불가합니다.</p>
                            </dd>
                        </dl>

                        <div class="btn_action rt">
                            <button id="orderSubmitBtn" class="btn btn_red" >결제하기</button>
                        </div>

                        <input type="hidden" id="seqs" name="seqs" value="${seq}" />
                        <%-- 사용 쿠폰 값 --%>
                        <input type="hidden" id="coupons" name="coupons" value="" />
                        <%-- 총 할인 금액 --%>
                        <input type="hidden" id="totalDiscountPrice" name="totalDiscountPrice" value="0"/>
                    </form>
                </form>
            </div>
        </div>
        <%@ include file="/WEB-INF/jsp/shop/include/quick.jsp" %>
    </div>

    <div id="footer">
        <%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
    </div>
</div>

        <div id="black-wall" style="top:0;left:0;position:fixed;width:100%;height:100%;background:#000;z-index:99;display:none;">
            <div style="position:absolute;top:50%;width:100%;height:50px;margin-top:-25px">
                <div class="progress progress-striped active">
                    <div class="progress-bar"  role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:100%"></div>
                </div>
            </div>
        </div>
        <div id="orderModal" class="modal fade" data-backdrop="static">
            <div class="modal-dialog" style="width: 400px;">
                <div class="modal-content" style="top: 130px;">
                    <div class="modal-body">
                        <h4>결제 처리 중입니다.. <img src="/assets/img/common/ajaxloader.gif" alt="" /></h4>
                        <h7>(결제 처리가 끝나기 전까지는 이 창을 닫지 마세요)</h7>
                    </div>
                </div>
            </div>
        </div>

<%@ include file="/WEB-INF/jsp/shop/order/delivery_view.jsp" %>
<%@ include file="/WEB-INF/jsp/shop/order/delivery_postcode_view.jsp" %>
<%@ include file="/WEB-INF/jsp/shop/include/postcode_view.jsp" %>
<script type="text/javascript" src="/assets/js/libs/numeral.js"></script>
<script type="text/javascript" src="/front-assets/js/plugin/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="/front-assets/js/order/order.js"></script>
<script type="text/javascript">
    var searchProc = function(obj) {
        $(obj).parent().parent().next().val($(obj).attr("data-value"));
        $(obj).parent().parent().prev().text($(obj).text());

        //검색조건이 전체라면 inputbox를 입력하지 못하게 막는다.
        if($(obj).attr("data-value") === 'all') {
            $('#findword').val('');
            $('#findword').prop('disabled',true);
        } else {
            $('#findword').prop('disabled',false);
        }
    };

    var loadProc = function(){
        $("#black-wall").css({opacity:0.8}).show();
    };

    var numberCheck = function(obj){
        obj.value=obj.value.replace(/[^\d]/g, '');
    };

    var callbackProc = function(msg) {
       if(msg === 'fail') {
            $("#orderModal").modal('hide');
            $("#orderSubmitBtn").attr("disabled", false);
       }
    };

    $(document).ready(function() {
        //숫자 입력 칸 나머지 문자 입력 막기
        $(".numeric").css("ime-mode", "disabled").numeric();

        var cartSeq="";
        <c:if test="${sessionScope.loginSeq ne null}">
        EBDelivery.renderList(
                (function() {
                    return EBDelivery.mappingVo( EBDelivery.getSeqForDefaultFlag() );
                })
        );
        </c:if>

        <c:if test="${sessionScope.loginSeq ne null and sessionScope.loginMemberTypeCode ne 'C'}">
        // 공공기관일 경우
        var tel = '${mgVo.taxTel}'.split('-');
        if(tel.length===3) {
            $('input[name=requestCell1]').val( tel[0] );
            $('input[name=requestCell2]').val( tel[1] );
            $('input[name=requestCell3]').val( tel[2] );
        }
        </c:if>
    });

    var checkPayMethod = function(obj) {
        // 무통장으로 입금해야만 세금계산요청서를 작성할 수 있다
        var v = $(obj).val();
        if(v === 'NP_CASH') {
            $('#tax_request_tr').show();
        } else {
            $('#tax_request_tr').hide().find('input[value=N]').click();
        }
    };
</script>
</body>
</html>
