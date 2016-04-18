<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="/front-assets/css/member/member.css" type="text/css" rel="stylesheet">
	<link href="/front-assets/css/seller/seller.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="main-title">${title}</div>

<form id="form" class="form-horizontal" method="post" target="zeroframe" action="<c:choose><c:when test="${vo eq null}">/shop/seller/reg/proc</c:when><c:otherwise>/shop/seller/mod/${vo.seq}/proc</c:otherwise></c:choose>" onsubmit="return doSubmit(this)" enctype="multipart/form-data">
	<input type="hidden" name="allCheckFlag" value="N"/>
	<%@ include file="/WEB-INF/jsp/shop/seller/agree.jsp" %>

	<div class="sign-form form1">
		<div class="inner">
			<div class="title-back">
				<div class="title-wrap">
					<div class="title">기본정보</div>
					<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
				</div>
			</div>
			<table id="defaultTable" class="table sign-table">
				<tr>
					<td>아이디<span>*</span></td>
					<td>
						<c:choose>
							<c:when test="${vo eq null}">
								<%-- 등록일 경우 --%>
								<input type="hidden" id="id_check_flag" value="N"/>
								<input type="text" class="form-control" id="id" name="id" value="${vo.id}" maxlength="20" data-required-label="아이디">
								<button type="button" onclick="checkId()" class="btn btn-default" style="width:100px;"><span>아이디 중복확인</span></button>
								<span class="description">영소문자+숫자 4~20자 이내 입력</span>
							</c:when>
							<c:otherwise>
								<%-- 수정일 경우 --%>
								${vo.id}
								<input type="hidden" id="myNickName" value="${vo.nickname}"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>상호명(법인명)<span>*</span></td>
					<td>
						<c:choose>
							<c:when test="${vo eq null}">
								<input type="text" id="name" name="name" value="${vo.name}" class="form-control" style="width:200px;" maxlength="20" data-required-label="상호명">
							</c:when>
							<c:otherwise>
								${vo.name}
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<c:choose>
					<c:when test="${vo eq null}">
						<%-- 등록일 경우 --%>
						<tr>
							<td>비밀번호<span>*</span></td>
							<td>
								<input type="password" id="password" name="password" class="form-control" style="width:200px;" value="" maxlength="20" <c:if test="${vo eq null}">data-required-label="패스워드"</c:if>/>
								<span class="description">영문+숫자+특수문자(~, !, @, #, $, %, ^, &amp;, *) 조합 8~20자</span>
							</td>
						</tr>
						<tr>
							<td>비밀번호 재확인<span>*</span></td>
							<td>
								<input type="password" class="form-control" id="password_confirm" value="" style="width:200px;" maxlength="20" <c:if test="${vo eq null}">data-required-label="패스워드 확인"</c:if>/>
								<span class="description">비밀번호를 한번 더 입력하여 주십시요.</span>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<%-- 수정일 경우 --%>
						<input type="hidden" id="password">
						<input type="hidden" id="password_confirm">
					</c:otherwise>
				</c:choose>
				<%--상호명과 상점명이 중복느낌이 난다는 요청에 의해 상점명 항목을 제거한다.--%>
				<%--
				<tr>
					<td>상점명<span>*</span></td>
					<td>
						<input type="hidden" id="nick_check_flag" value="N"/>
						<input type="hidden" id="validNickName" name="validNickName" />
						<input type="text" class="form-control" id="nickname" name="nickname" value="${vo.nickname}" maxlength="30" data-required-label="상점명">
						<button type="button" onclick="checkNickname()" class="btn btn-default" style="width:100px;"><span>상점명 중복확인</span></button>
					</td>
				</tr>
				--%>
				<tr>
					<td>면세업체구분</td>
					<td>
						<select class="form-control" name="taxTypeFlag">
							<option value="">-- 과세/면세 --</option>
							<option value="Y" <c:if test="${vo.taxTypeFlag eq 'Y'}">selected="selected"</c:if>>과세</option>
							<option value="N" <c:if test="${vo.taxTypeFlag eq 'N'}">selected="selected"</c:if>>면세</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>사업자 번호<span>*</span></td>
					<td>
						<input type="hidden" id="bizno_check_flag" value="N"/>
						<input type="text" class="form-control" id="bizNo1" name="bizNo1" value="${vo.bizNo1}" maxlength="3" onblur="numberCheck(this);" data-required-label="사업자 번호">&nbsp;-&nbsp;
						<input type="text" class="form-control" id="bizNo2" name="bizNo2" value="${vo.bizNo2}" maxlength="2" onblur="numberCheck(this);" data-required-label="사업자 번호">&nbsp;-&nbsp;
						<input type="text" class="form-control" id="bizNo3" name="bizNo3" value="${vo.bizNo3}" maxlength="5" onblur="numberCheck(this);" data-required-label="사업자 번호">
						<button type="button" onclick="checkBizNo()" class="btn btn-default" style="width:120px;"><span>사업자번호 중복확인</span></button>
					</td>
				</tr>
				<tr>
					<td>대표자명<span>*</span></td>
					<td><input type="text" class="form-control" id="ceoName" name="ceoName" value="${vo.ceoName}" maxlength="10" data-required-label="대표자명"/></td>
				</tr>
				<tr>
					<td>업태<span>*</span></td>
					<td>
						<input type="text" class="form-control" id="bizType" name="bizType" value="${vo.bizType}" maxlength="30" style="width:350px;" data-required-label="업태"/>
					</td>
				</tr>
				<tr>
					<td>업종<span>*</span></td>
					<td>
						<input type="text" class="form-control" id="bizKind" name="bizKind" value="${vo.bizKind}" maxlength="30" style="width:350px;" data-required-label="업종"/>
					</td>
				</tr>
				<tr>
					<td>매출액<span>*</span></td>
					<td>
						<input type="text" class="form-control" id="totalSales" name="totalSales" value="${vo.totalSales}" maxlength="20" data-required-label="매출액"/>
					</td>
				</tr>
				<tr>
					<td>종업원수<span>*</span></td>
					<td>
						<input type="text" class="form-control" id="amountOfWorker" name="amountOfWorker" value="${vo.amountOfWorker}" maxlength="20" data-required-label="종업원수"/>
					</td>
				</tr>
				<tr>
					<td>대표전화<span>*</span></td>
					<td>
						<input type="text" class="form-control ime-disabled" style="width:130px;" id="tel" name="tel" value="${vo.tel}" maxlength="20" data-required-label="대표 전화" placeholder="- 포함하여 입력"/>
					</td>
				</tr>
				<tr id="normalAddr">
					<td>팩스번호</td>
					<td>
						<input type="text" class="form-control ime-disabled" style="width:130px;" id="fax" name="fax" value="${vo.fax}" value="${vo.fax}" maxlength="20" placeholder="- 포함하여 입력"/>
					</td>
				</tr>
				<tr>
					<td>소속 자치구<span>*</span></td>
					<td>
						<select class="form-control" id="jachiguSido" style="display:inline;" data-required-label="소속 자치구 시/도">
							<option value="">-- 시/도 --</option>
							<option value="01">서울시</option>
							<option value="99">기타</option>
						</select>
						&nbsp;&nbsp;
						<select class="form-control" id="jachiguCode" name="jachiguCode" style="display:none;" data-required-label="자치구">
							<option value="">-- 자치구 --</option>
							<c:forEach var="item" items="${jachiguList}">
								<option value="${item.value}" <c:if test="${vo.jachiguCode eq item.value}">selected</c:if>>${item.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>인증 구분 <span>*</span></td>
					<td>
					<c:forEach var="item" items="${authCategoryList}" begin="0" step="1" varStatus="status">
						<label style="width:150px;">
							<input type="checkbox" style="width:15px;height:15px;" name="authCategory" value="${item.value}" <c:if test="${fn:indexOf(vo.authCategory,item.value) >= 0}">checked</c:if>/> ${item.name}
							<img src="/front-assets/images/detail/auth_mark_${item.value}.png" alt="${item.name}">
						</label>
					</c:forEach>
					</td>
				</tr>
				<tr>
					<td>회사 주소<span>*</span></td>
					<td>
						<input type="text" class="form-control" id="postcode" name="postcode" value="${vo.postcode}" maxlength="5" alt="우편번호" data-required-label="우편번호" readonly />
						<button type="button" class="btn btn-default" onclick="CHPostCodeUtil.postWindow('open' , '#normalAddr');"><span>우편번호찾기</span></button>
						<span class="description">사업자등록증 상의 주소를 입력해주세요.</span>
						<br/>
						<input type="text" class="form-control addr" name="addr1" value="${vo.addr1}" maxlength="100" alt="주소" data-required-label="주소" readonly /><br/>
						<input type="text" class="form-control addr" name="addr2" value="${vo.addr2}" maxlength="100" alt="상세주소" data-required-label="상세주소" />
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="sign-form form2">
		<div class="inner">
			<div class="title-back">
				<div class="title-wrap">
					<div class="title">담당자 정보</div>
					<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
				</div>
			</div>
			<table class="table sign-table">
				<tr>
					<td>담당자명<span>*</span></td>
					<td><input type="text" class="form-control" id="salesName" name="salesName" value="${vo.salesName}" maxlength="30" data-required-label="담당자명"/></td>
				</tr>
				<tr>
					<td>담당자 이메일<span>*</span></td>
					<td>
						<input type="text"class="form-control" id="salesEmail" name="salesEmail" value="${vo.salesEmail}" style="width:200px" maxlength="100" data-required-label="담당자 이메일"/>
					</td>
				</tr>
				<tr>
					<td>담당자 전화번호<span>*</span></td>
					<td>
						<input type="text" class="form-control ime-disabled" style="width:130px;" id="salesTel1" name="salesTel" value="${vo.salesTel}" maxlength="20" data-required-label="담당자 전화번호" placeholder="- 포함하여 입력"/>
					</td>
				</tr>
				<tr>
					<td>담당자 휴대폰번호<span>*</span></td>
					<td>
						<input type="text" class="form-control ime-disabled" style="width:130px;" id="salesCell1" name="salesCell" value="${vo.salesCell}" maxlength="20" data-required-label="담당자 휴대폰번호" placeholder="- 포함하여 입력"/>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="sign-form form3">
		<div class="inner">
			<div class="title-back">
				<div class="title-wrap">
					<div class="title">정산 정보</div>
				</div>
			</div>
			<table class="table sign-table">
				<tr>
					<td>정산 담당자명</td>
					<td>
						<input type="text" class="form-control" id="adjustName" name="adjustName" value="${vo.adjustName}" maxlength="15"/>
					</td>
				</tr>
				<tr>
					<td>정산 담당자 이메일</td>
					<td>
						<input type="text" class="form-control" id="adjustEmail" name="adjustEmail" value="${vo.adjustEmail}" style="width:200px" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<td>정산 담당자 연락처</td>
					<td>
						<input type="text" class="form-control ime-disabled" style="width:130px;" id="adjustTel" name="adjustTel" value="${vo.adjustTel}" maxlength="20"/>
					</td>
				</tr>
				<tr>
					<td>입금계좌 은행명</td>
					<td>
						<input type="text" class="form-control" id="accountBank" name="accountBank" value="${vo.accountBank}" maxlength="15"/>
					</td>
				</tr>
				<tr>
					<td>입금계좌 번호</td>
					<td>
						<input type="text" class="form-control ime-disabled" style="width:200px;" id="accountNo" name="accountNo" value="${vo.accountNo}" style="ime-mode:disabled" maxlength="30" placeholder="- 포함하여 입력"/>
					</td>
				</tr>
				<tr>
					<td>입금계좌 예금주</td>
					<td>
						<input type="text" class="form-control" id="accountOwner" name="accountOwner" value="${vo.accountOwner}" value="${vo.accountOwner}" maxlength="15"/>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="sign-form form4">
		<div class="inner">
			<div class="title-back">
				<div class="title-wrap">
					<div class="title">배송/반품 정보</div>
				</div>
			</div>
			<table class="table sign-table">
				<tr id="returnAddr">
					<td>기본택배사</td>
					<td>
						<select class="form-control" name="defaultDeliCompany" style="width:150px">
							<option value="0">---택배사 선택---</option>
							<c:forEach var="item" items="${deliCompanyList}">
								<option value="${item.deliSeq}" <c:if test="${vo.defaultDeliCompany eq item.deliSeq}">selected</c:if>>${item.deliCompanyName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>반품 담당자</td>
					<td>
						<input type="text" class="form-control" id="" name="returnName" value="${vo.returnName}" maxlength="30"/>
					</td>
				</tr>
				<tr>
					<td>반품 담당자 연락처</td>
					<td>
						<input type="text" class="form-control" name="returnCell" value="${vo.returnCell}" maxlength="20" placeholder="- 포함하여 입력"/>
					</td>
				</tr>
				<tr>
					<td>반품 주소</td>
					<td>
						<input type="text" class="form-control" id="returnPostCode" name="returnPostCode" value="${vo.returnPostCode}" maxlength="5" alt="반품 우편번호" readonly/>
						<button type="button" class="btn btn-default" onclick="CHReturnPostCodeUtil.returnPostWindow('open' , '#returnAddr');"><span>우편번호찾기</span></button>
						<br/>
						<input type="text" class="form-control addr" name="returnAddr1" value="${vo.returnAddr1}" maxlength="100" placeholder="반품 주소" readonly/><br/>
						<input type="text" class="form-control addr" name="returnAddr2" value="${vo.returnAddr2}" maxlength="100" placeholder="반품 상세 주소"/>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="sign-form form5">
		<div class="inner">
			<div class="title-back">
				<div class="title-wrap">
					<div class="title">기타 정보</div>
				</div>
			</div>
			<table class="table sign-table">
				<tr>
					<td>공급사 소개</td>
					<td>
						<textarea class="form-control" name="intro" rows="8" style="resize:none;">${vo.intro}</textarea>
					</td>
				</tr>
				<tr>
					<td>주요 취급상품</td>
					<td>
						<textarea class="form-control" name="mainItem" rows="8" style="resize:none;">${vo.mainItem}</textarea>
					</td>
				</tr>
				<tr>
					<td>사회적 경제활동</td>
					<td>
						<textarea class="form-control" name="socialActivity" rows="8" style="resize:none;">${vo.socialActivity}</textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="sign-form form6">
		<div class="inner" style="height:auto;">
			<div class="title-back">
				<div class="title-wrap">
					<div class="title">파일첨부</div>
					<div class="sub-description">최대 30MB까지 업로드하실 수 있습니다</div>
				</div>
			</div>
			<div class="row" style="margin-top: 15px;">
				<div class="col-md-2 text-right" style="margin-top:3px;">필수 첨부자료</div>
				<div class="col-md-10">
					<ul style="padding:0; line-height:180%;">
						<li>사업자등록증(※공통), 통신판매/공장등록 등(※해당기업)</li>
						<li>법인명의 통장사본(*공통)</li>
						<li>각종 인증서류 : 중증시설 지정서, (예비)사회적기업 인증서, 협동조합 인증서, 각종 인증서(제품관련, 생산관련 등)</li>
						<ul type="circle" style="padding-left: 10px;">
							<li>해당기업</li>
							<li>각 제품군별 필수인증서는 반드시 첨부(예/식품군-식품판매허가 등)</li>
						</ul>
					</ul>
				</div>
				<div class="col-md-2 text-right" style="margin-top:3px;">기타 첨부자료</div>
				<div class="col-md-10">
					<ul style="padding:0; line-height:180%;">
						<li>기타 첨부 자료 (파일 용량이 큰 경우 대용량 이메일<span style="color:red">(hknuri@happyict.co.kr)</span>을 이용해 주시기 바랍니다.)</li>
						<ul type="circle" style="padding-left: 10px;">
							<li>기업카달로그 및 리플렛 등 제품 및 기업 홍보물</li>
							<li>이미지 자료 : 제품사진(있는 경우), 업체 전경사진, 생산작업현장(서비스 작업현장) 사진, 판매 및 행사관련 사진, 기타 제품 및 기업 홍보자료에 사용할 수 있는 이미지 자료.</li>
							<li>미디어 자료 : 제품 및 기업관련 홍보동영상 자료, 기타 언론보도 내용 등(※ 해당기업)</li>
						</ul>
					</ul>
				</div>
			</div>
			<table class="table sign-table">
				<tr>
					<td>
		 				<div id="fileDiv">
	            <div id="FileList" style="padding-left: 15px;">
	                <c:if test="${vo eq null}">
	                    <div>
	                        <div class="form-group">
	                            <label></label>
	                            <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
	                            <input type="file" onchange="checkFileSize(this);" id="file1" name="file1" class="text-muted" style="display:inline-block; width:262px;height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
	                        </div>
	                    </div>
	                </c:if>
	                <c:if test="${vo ne null}">
	                    <c:forEach var="item" items="${file}">
	                        <div class="file-wrap${item.num}">
	                            <div class="form-group">
	                                <span class="btn btn-default btn-file">
	                                    <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
	                                    <input type="file" onchange="checkFileSize(this);" id="file${item.num}" name="file${item.num}" class="text-muted" style="display:inline-block; width:262px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
	                                </span>
	                                <label></label>
	                                <p class="help-block" style="padding-left: 40px">
	                                        ${item.filename} 파일이 등록되어 있습니다
	                                    <a href="/shop/seller/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">[다운로드]</a>
	                                    <a href="/shop/seller/file/delete/proc?seq=${vo.seq}&num=${item.num}" onclick="return confirm('정말로 이 파일을 삭제하시겠습니까?');" target="zeroframe" class="text-danger">[삭제]</a>
	                                </p>
	                            </div>
	                        </div>
	                    </c:forEach>
	                </c:if>
	            </div>
	            <div>
	                <button type="button" onclick="addFilePane()" class="btn btn-link btn-sm"><i class="fa fa-plus"></i> 항목 더 추가하기</button>
	            </div>
		        </div>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<div class="button-wrap">
		<button type="submit" class="btn btn-confirm"><span>${vo eq null ? '등록하기':'수정하기'}</span></button>
		<c:if test="${vo eq null}">
			<button type="button" class="btn btn-warning" style="margin-left:26px;" onclick="sellerEditUtil.showPassLayer(this)"><span>수정하기</span></button>
		</c:if>
		<button type="button" class="btn btn-cancel" onclick="goMain()"><span>메인으로</span></button>
	</div>

	<input type="hidden" name="code" value="seller">
</form>

<script id="FileTemplate" type="text/html">
    <div>
        <div class="form-group">
            <label></label>
            <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
            <input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted" style="display:inline-block; width:262px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
        </div>
    </div>
</script>

<div id="lockLayer" class="hh-writebox-lock">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header">
			수정하기
		</div>
		<div class="hh-writebox-content">
			<div style="list-style:none; padding:0; margin-left:10px;">
				<div style="margin-top:15px; font-size:11px; text-indent: -11px">* 수정을 원하시면 입점신청된 아이디와 비밀번호를 입력하세요. </div>
			</div>

			<form class="form-horizontal" action="/shop/seller/mod" method="post" onsubmit="return sellerEditUtil.submitProc(this)">
				<div style="text-align: center; margin-top:20px;">
					<table class="table">
					<tr>
							<td style="padding-left:40px; text-align:left; vertical-align:middle; width:120px;">
								<strong>아이디</strong><br/>
							</td>
							<td style="text-align: left;">
								<input type="text" id="lockId" name="id" class="form-control" maxlength="20" style="width:150px;" alt="아이디"/>
							</td>
						</tr>
						<tr>
							<td class="pass-td" style="padding-left:40px; text-align:left; vertical-align:middle; width:120px; border-top:0;">
								<strong>비밀번호</strong><br/>
							</td>
							<td class="pass-td" style="text-align:left; border-top:0;">
								<input type="password" id="lockPassword" name="password" class="form-control" maxlength="65" style="width:150px;" alt="비밀번호"/>
							</td>
						</tr>
					</table>
				</div>
				<div style="margin:10px 0 0 0;text-align: center">
					<button type="submit" class="btn btn-info btn-default">확인</button>
					<button type="button" class="btn btn-default" onclick="sellerEditUtil.close();">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/postcode_view.jsp" %>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/seller/seller.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	CKEDITOR.replace('intro',{
		width:'100%',
		height:'400px',
		filebrowserImageUploadUrl: '/shop/editor/upload'
	});
	CKEDITOR.replace('mainItem',{
		width:'100%',
		height:'400px',
		filebrowserImageUploadUrl: '/shop/editor/upload'
	});
	CKEDITOR.replace('socialActivity',{
		width:'100%',
		height:'400px',
		filebrowserImageUploadUrl: '/shop/editor/upload'
	});
});
var callbackProc = function(msg) {
	if(msg.split("^")[0] === "EDITOR") {
		CKEDITOR.tools.callFunction(msg.split("^")[1], msg.split("^")[2], '이미지를 업로드 하였습니다.');
	} else {
		$('.file-wrap'+msg).remove();	
	}
}

	/** 폼 전송 */
	var doSubmit = function(frmObj) {
		if(!frmObj.agree1.checked) {
			alert('함께누리 이용약관에 동의하셔야 합니다.');
			frmObj.agree1.focus();
			return false;
		} else if(!frmObj.agree2.checked) {
			alert('함께누리 개인정보 취급방침에 동의하셔야 합니다.');
			frmObj.agree2.focus();
			return false;
		} else if(!frmObj.agree3.checked) {
			alert('함께누리 개인정보 제3자 제공에 동의하셔야 합니다.');
			frmObj.agree3.focus();
			return false;
		}

		frmObj.allCheckFlag.value = 'Y';

		/* 필수값 체크 */
		var submit = checkRequiredValue(frmObj, "data-required-label");

		if(submit) {
			/* 패스워드 일치 체크 */
			if($("#password").val() != $("#password_confirm").val()) {
				alert("패스워드가 일치하지 않습니다.");
				$("#password").focus();
				return false;
			}

			//상점명 중복체크는 함께누리에서 상호명과 중복느낌이 난다하여 제거한다.
			// //상점명 중복 체크
			// if($('#nickname').val() !== $("#validNickName").val() || $("#nick_check_flag").val() !== "Y") {
			// 	//닉네임 중복검사 여부
			// 	if(${vo ne null}) {
			// 		if ($('#myNickName').val() !== $('#nickname').val()) {
			// 			$.msgbox("상점명 중복체크를 해주세요.", {type: "error"});
			// 			$('#myNickName').focus();
			// 			return false;
			// 		}
			// 	} else {
			// 		$.msgbox("상점명 중복체크를 해주세요.", {type: "error"});
			// 		$('#nickname').focus();
			// 		return false;
			// 	}
			// }
			
			if((typeof $('input[name=authCategory]:checked').val()) === 'undefined') {
				alert('인증 구분을 선택해 주세요.');
				$('input[name=authCategory]')[0].focus();
				return false;
			}
			
			var seq = "${vo.seq}";
			if( seq == null || $.trim(seq) == "" ) {
				/* 등록 처리 */

				// 아이디 중복 체크
				if($("#id_check_flag").val() != "Y") {
					alert("아이디 중복 확인 바랍니다.");
					$('#id').focus();
					return false;
				}
				// 사업자 중복 체크
				if($("#bizno_check_flag").val() != "Y") {
					alert("사업자번호 중복 확인 바랍니다.");
					$('#bizNo1').focus();
					return false;
				}
			}
		}

		return submit;
	};

	var goMain = function() {
		if(confirm("메인으로 돌아가시겠습니까?")) {
			location.href='/shop/main'
		}
	}
</script>
</body>
</html>