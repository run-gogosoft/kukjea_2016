<%--
  Created by IntelliJ IDEA.
  User: aubergine
  Date: 2016. 10. 31.
  Time: 오후 6:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<h4><em class="must">*</em> 변경할 비밀번호를 입력해주세요</h4>
<!-- board_write -->
<table id="defaultTable" class="board_write">
    <caption>비밀번호변경</caption>
    <colgroup>
        <col style="width:140px" />
        <col style="width:auto" />
    </colgroup>
    <tbody>

            <tr>
                <th scope="row"><label>비밀번호</label></th>
                <td>
                    <input type="password" id="newPassword" name="newPassword" class="intxt w180" alt="비밀번호" maxlength="16"/>
                    <p class="info_msg">비밀번호는 영문과 숫자 조합 8자 이상 16자 이하로 해주세요.</p>
                </td>
            </tr>
            <tr>
                <th scope="row"><label>비밀번호확인</label></th>
                <td>
                    <input type="password" id="newPassword_confirm" name="newPassword_confirm" class="intxt w180" alt="비밀번호확인" maxlength="16" />
                    <p class="info_msg">비밀번호를 한번 더 입력하여 주십시오.</p>
                </td>
            </tr>
    </tbody>
</table>
