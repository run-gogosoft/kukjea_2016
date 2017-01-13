<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<h4><em class="must">*</em> 기본정보</h4>
<!-- board_write -->
<table id="defaultTable" class="board_write">
    <caption>회원 기본정보 작성</caption>
    <colgroup>
        <col style="width:140px" />
        <col style="width:auto" />
    </colgroup>
    <tbody>
    <c:choose>
        <c:when test="${sessionScope.loginSeq > 0}">
            <tr>
                <th scope="row">아이디</th>
                <td>${sessionScope.loginId}</td>
            </tr>
            <%--<tr>--%>
                <%--<th scope="row"><label>비밀번호</label></th>--%>
                <%--<td>--%>
                    <%--<button type="button" id="changePassword" class="btn btn_default">비밀번호 변경</button>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <tr>
                <th scope="row"><label>이름</label></th>
                <td>${sessionScope.loginName}</td>
            </tr>
        </c:when>
        <c:otherwise>
            <tr>
                <th scope="row"><label for="id">아이디</label></th>
                <td>
                    <input type="text" id="id" name="id" class="intxt w180" style="ime-mode:disabled" alt="회원 아이디" maxlength="50"/>
                    <button type="button" class="btn btn_gray btn_sm" onclick="CHInsertUtil.validIdCheck()">중복확인</button>
                    <span class="error_msg">아이디를 입력해주세요</span>
                    <input type="hidden" id="id_check_flag" value="" />
                </td>
            </tr>
            <tr>
                <th scope="row"><label>비밀번호</label></th>
                <td>
                    <input type="password" id="password" name="password" class="intxt w180" alt="비밀번호" maxlength="16"/>
                    <p class="info_msg">비밀번호는 영문과 숫자 조합 8자 이상 16자 이하로 해주세요.</p>
                </td>
            </tr>
            <tr>
                <th scope="row"><label>비밀번호확인</label></th>
                <td>
                    <input type="password" id="passwordCheck" name="passwordCheck" class="intxt w180" alt="비밀번호확인" maxlength="16" />
                    <p class="info_msg">비밀번호를 한번 더 입력하여 주십시오.</p>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="userName">이름</label></th>
                <td>
                    <input type="text" id="userName" name="name" class="intxt w180" maxlength="15" alt="이름" />
                </td>
            </tr>
        </c:otherwise>
    </c:choose>
    <tr>
        <th scope="row"><label>부서명/직책</label></th>
        <td>
            <input type="text" name="deptName" value="${vo.deptName}" class="intxt w180" maxlength="15" />
            &nbsp;&nbsp;/&nbsp;&nbsp;
            <input type="text" name="posName" value="${vo.posName}" class="intxt w180" maxlength="15" />
        </td>
    </tr>
    <tr>
        <th scope="row"><label>이메일</label></th>
        <td>
            <input type="text" name="email" class="intxt w180" maxlength="60" alt="이메일" value="<c:if test="${vo ne null}">${vo.email1}@${vo.email2}</c:if>" />
        </td>
    </tr>
    <tr>
        <th scope="row"><label>휴대전화</label></th>
        <td>
            <input type="text" name="cell1" class="intxt w50" onblur="numberCheck(this);" maxlength="3" alt="휴대전화" value="${vo.cell1}" />&nbsp;-&nbsp;
            <input type="text" name="cell2" class="intxt w70" onblur="numberCheck(this);" maxlength="4" alt="휴대전화" value="${vo.cell2}" />&nbsp;-&nbsp;
            <input type="text" name="cell3" class="intxt w70" onblur="numberCheck(this);" maxlength="4" alt="휴대전화" value="${vo.cell3}"/>
        </td>
    </tr>
    <tr>
        <th scope="row"><label>유선전화</label></th>
        <td>
            <input type="text" name="tel1" class="intxt w70" onblur="numberCheck(this);" maxlength="4" alt="유선전화" value="${vo.tel1}" />&nbsp;-&nbsp;
            <input type="text" name="tel2" class="intxt w70" onblur="numberCheck(this);" maxlength="4" alt="유선전화" value="${vo.tel2}" />&nbsp;-&nbsp;
            <input type="text" name="tel3" class="intxt w70" onblur="numberCheck(this);" maxlength="4" alt="유선전화" value="${vo.tel3}"/>
        </td>
    </tr>
    <tr>
        <th scope="row"><label>팩스번호</label></th>
        <td>
            <c:set var="splitFax" value="${fn:split(gvo.fax, '-')}"/>
            <input type="text" name="fax1" class="intxt w70" onblur="numberCheck(this);" maxlength="4" value="${splitFax[0]}" />&nbsp;-&nbsp;
            <input type="text" name="fax2" class="intxt w70" onblur="numberCheck(this);" maxlength="4" value="${splitFax[1]}" />&nbsp;-&nbsp;
            <input type="text" name="fax3" class="intxt w70" onblur="numberCheck(this);" maxlength="4" value="${splitFax[2]}"/>
        </td>
    </tr>
    <tr>
        <th scope="row">주소</th>
        <td>
            <input type="text" class="intxt w180" id="postcode" name="postcode" maxlength="5" value="${vo.postcode}" alt="우편번호" readonly />
            <button type="button" class="btn btn_gray btn_sm" onclick="CHPostCodeUtil.postWindow('open' , '#defaultTable');">우편번호찾기</button>
            <p class="mt10"><input type="text" class="intxt w560" name="addr1" maxlength="100" alt="주소" value="${vo.addr1}" readonly /></p>
            <p class="mt10"><input type="text" class="intxt w560" name="addr2" maxlength="100" alt="상세주소" value="${vo.addr2}" /></p>
        </td>
    </tr>
    </tbody>
</table>
<!-- //board_write -->

<h4><em class="must">*</em> 세금계산서 발행을 위한 정보</h4>
<!-- board_write -->
<table class="board_write">
    <caption>세금계산서 발행을 위한 정보 작성</caption>
    <colgroup>
        <col style="width:140px" />
        <col style="width:auto" />
        <col style="width:140px" />
        <col style="width:auto" />
    </colgroup>
    <tbody>
    <c:choose>
    <c:when test="${sessionScope.loginSeq > 0}">
        <tr>
            <th scope="row"><label>병원명</label></th>
            <td colspan="3">
                ${gvo.name}
                <input type="hidden" name="groupSeq" value="${vo.groupSeq}"> <%--공공기관, 기업 회원일경우 그룹 시퀀스가 존재하기때문에 넘겨줘야한다.--%>
            </td>
        </tr>
    </c:when>
    <c:otherwise>
        <tr>
            <th scope="row"><label>병원명</label></th>
            <td colspan="3">
                <input type="text" class="intxt w180" name="groupName" maxlength="30" alt="병원명" value="" />
            </td>
        </tr>
    </c:otherwise>
    </c:choose>
    <tr>
        <th scope="row"><label for="ceoName">대표자명</label></th>
        <td colspan="3">
            <input type="text" id="ceoName" name="ceoName" class="intxt w180" maxlength="10" alt="대표자명" value="${gvo.ceoName}"/>
        </td>
    </tr>
    <tr>
        <th scope="row"><label>세금계산서<br/>담당자명</label></th>
        <td colspan="3">
            <input type="text" name="taxName" class="intxt w180" maxlength="10" alt="세금계산서 담당자명" value="${gvo.taxName}"/>
        </td>
    </tr>
    <tr>
        <th scope="row"><label>세금계산서<br/>담당자 이메일</label></th>
        <td colspan="3">
            <input type="text" name="taxEmail" class="intxt w180" maxlength="30" alt="세금계산서 담당자명" value="<c:if test="${gvo ne null}">${gvo.taxEmail1}@${gvo.taxEmail2}</c:if>"/>
        </td>
    </tr>
    <tr>
        <th scope="row"><label>세금계산서<br/>담당자 전화번호</label></th>
        <td colspan="3">
            <input type="text" name="taxTel1" class="intxt w70" onblur="numberCheck(this);" maxlength="4" alt="담당자 전화" value="${gvo.taxTel1}" />&nbsp;-&nbsp;
            <input type="text" name="taxTel2" class="intxt w70" onblur="numberCheck(this);" maxlength="4" alt="담당자 전화" value="${gvo.taxTel2}" />&nbsp;-&nbsp;
            <input type="text" name="taxTel3" class="intxt w70" onblur="numberCheck(this);" maxlength="4" alt="담당자 전화" value="${gvo.taxTel3}"/>
        </td>
    </tr>
    <!-- tr>
        <th scope="row">병원주소</th>
        <td colspan="3">
            <input type="text" class="intxt w180" title="우편번호" />
            <button type="button" class="btn btn_gray btn_sm">우편번호찾기</button>
            <p class="mt10"><input type="text" class="intxt w560" title="병원 기본주소" /></p>
            <p class="mt10"><input type="text" class="intxt w560" title="병원 상세주소" /></p>
        </td>
    </tr -->
    <!-- tr>
        <th scope="row"><label for="hospitalTel">병원전화번호</label></th>
        <td colspan="3">
            <input type="text" id="hospitalTel" class="intxt w180" />
        </td>
    </tr -->
    <c:choose>
    <c:when test="${sessionScope.loginSeq > 0}">
        <tr>
            <th scope="row"><label>사업자번호</label></th>
            <td colspan="3">
                ${fn:substring(gvo.bizNo,0,3)}-${fn:substring(gvo.bizNo,3,5)}-${fn:substring(gvo.bizNo,5,10)}
                <br/><br/><em class="must">*</em> 사업자등록증사본을 팩스로 보내주세요.(FAX 02-3280-8007)
            </td>
        </tr>
    </c:when>
    <c:otherwise>
        <tr>
            <th scope="row"><label>사업자번호</label></th>
            <td colspan="3">
                <input type="hidden" id="bizno_check_flag" value="N"/>
                <input type="text" id="bizNo1" name="bizNo1" class="intxt w70" onblur="numberCheck(this);" maxlength="3" >&nbsp;-&nbsp;
                <input type="text" id="bizNo2" name="bizNo2" class="intxt w50" onblur="numberCheck(this);" maxlength="2" >&nbsp;-&nbsp;
                <input type="text" id="bizNo3" name="bizNo3" class="intxt w90" onblur="numberCheck(this);" maxlength="5" >
                <br/><br/><em class="must">*</em> 사업자등록증사본을 팩스로 보내주세요.(FAX 02-3280-8007)
            </td>
        </tr>
    </c:otherwise>
    </c:choose>

    <%-- tr>
        <th scope="row">사업자첨부</th>
        <td colspan="3">
            <div class="attach_file inline_type">
                <div class="inser_file"><input type="text" class="intxt" readonly="readonly" title="사업자 첨부파일" /></div>
                <div class="btn_file">첨부파일 찾기<input type="file" class="file-search" title="File"></div>
            </div>
        </td>
    </tr --%>
    <tr>
        <th scope="row"><label for="businessType">업종</label></th>
        <td>
            <input type="text" id="businessType" name="bizType" class="intxt w180" maxlength="15" value="${gvo.bizType}"/>
        </td>
        <th scope="row"><label for="businessStatus">업태</label></th>
        <td>
            <input type="text" id="businessStatus" name="bizKind" class="intxt w180" maxlength="15" value="${gvo.bizKind}" />
        </td>
    </tr>
    </tbody>
</table>
<!-- //board_write -->

<%@ include file="/WEB-INF/jsp/shop/include/postcode_view.jsp" %>