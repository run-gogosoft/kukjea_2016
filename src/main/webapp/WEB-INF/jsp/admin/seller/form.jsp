<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<link href="/assets/css/postcode.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-blue sidebar-sm">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>입점업체 정보 수정 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>업체 관리</li>
			<li>입점업체 리스트</li>
			<li class="active">입점업체 정보 수정</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- <div class="box-header"><i class="icon-th-list"></i><h3 class="box-title"></h3></div> -->
					<form class="form-horizontal" method="post" target="zeroframe" onsubmit="return doSubmit(this)" enctype="multipart/form-data">
						<div class="box-body">
							<div><hr style="margin:0"/><h4>기본 정보</h4><hr style="margin:0 0 15px 0"/></div>
							<div class="form-group">
								<label class="col-md-2 control-label">아이디 <i class="fa fa-check"></i></label>
							<c:choose>
								<c:when test="${vo eq null}">
								<%-- 등록일 경우 --%>
								<div class="col-md-2">
									<input type="hidden" id="id_check_flag" value="N"/>
									<input class="form-control" type="text" id="id" name="id" placeholder="영소문자+숫자 4~20자 이내 입력" maxlength="20" data-required-label="아이디"/>
								</div>
								<div class="col-md-1 form-control-static">
									<button type="button" onclick="checkId()" class="btn btn-xs btn-warning">중복 확인</button>
								</div>
								</c:when>
								<c:otherwise>
								<%-- 수정일 경우 --%>
								<div class="col-md-2">
									<p class="form-control-static">${vo.id}</p>
									<input type="hidden" id="myNickName" value="${vo.nickname}"/>
								</div>
								</c:otherwise>
							</c:choose>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상호명(법인명) <i class="fa fa-check"></i></label>
								<div class="col-md-2">
								<c:choose>
									<c:when test="${vo eq null}">
										<input class="form-control" type="text" id="name" name="name" value="${vo.name}" maxlength="20" data-required-label="상호명"/>
									</c:when>
									<c:otherwise>
										<p class="form-control-static">${vo.name}</p>
									</c:otherwise>
								</c:choose>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">패스워드 <c:if test="${vo eq null}"><i class="fa fa-check"></i></c:if></label>
								<div class="col-md-2">
									<input class="form-control" type="password" id="password" name="password" placeholder="영문+숫자+특수문자 조합 8~20자" value="" maxlength="20" <c:if test="${vo eq null}">data-required-label="패스워드"</c:if>/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">
									패스워드 확인 <c:if test="${vo eq null}"><i class="fa fa-check"></i></c:if>
								</label>
								<div class="col-md-2">
									<input class="form-control" type="password" id="password_confirm" value="" maxlength="20" <c:if test="${vo eq null}">data-required-label="패스워드 확인"</c:if>/>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label" for="commission">수수료<i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="commission" name="commission" placeholder="%" value="${vo.commission}" maxlength="20"    <c:if test="${vo eq null}">data-required-label="수수료"</c:if> />
								</div>
							</div>

						<c:if test="${vo ne null}">
							<%--수정일 경우에만 표시한다. --%>
							<div class="form-group">
								<label class="col-md-2 control-label">상태</label>
								<div class="col-md-4 form-control-static">
									${vo.statusText} &nbsp;
									<c:if test="${sessionScope.loginType eq 'A'}">
										<%-- 관리자일 경우 상태 변경 버튼 노출 --%>
										<c:choose>
											<c:when test="${vo.statusCode eq 'H'}">
												<button type="button" onclick="updateStatus('Y')" class="btn btn-info btn-xs">승인 처리</button>
												<button type="button" onclick="updateStatus('N')" class="btn btn-warning btn-xs">보류 처리</button>
											</c:when>
											<c:when test="${vo.statusCode eq 'Y'}">
												<button type="button" onclick="updateStatus('X')" class="btn btn-danger btn-xs">폐점 처리</button>
												<button type="button" onclick="updateStatus('N')" class="btn btn-warning btn-xs">보류 처리</button>
											</c:when>
											<c:when test="${vo.statusCode eq 'N'}">
												<button type="button" onclick="updateStatus('Y')" class="btn btn-success btn-xs">정상 처리</button>
											</c:when>
											<c:when test="${vo.statusCode eq 'X'}">
												<button type="button" onclick="updateStatus('Y')" class="btn btn-success btn-xs">정상 처리</button>
											</c:when>
										</c:choose>
									</c:if>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">운영권한</label>
							</div>
							<c:forEach var="mall" items="${mallList}" begin="0" step="1">
							<div class="form-group">
								<div class="col-md-2"></div>
								<div class="col-md-4">
										<label>${mall.name}&nbsp;-&nbsp;</label>
										<c:forEach var="access" items="${vo.mallAccessVos}">
											<c:if test="${access.mallSeq eq mall.seq}">
												<c:choose>
													<c:when test="${access.accessStatus eq 'A'}">
														&nbsp;승인&nbsp;
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'H')" class="btn btn-warning btn-xs">보류</button>
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'N')" class="btn btn-danger btn-xs">미승인</button>
													</c:when>
													<c:when test="${access.accessStatus eq 'N'}">
														&nbsp;미승인&nbsp;
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'A')" class="btn btn-info btn-xs">승인</button>
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'H')" class="btn btn-warning btn-xs">보류</button>
													</c:when>
													<c:when test="${access.accessStatus eq 'R'}">
														&nbsp;승인요청&nbsp;
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'A')" class="btn btn-info btn-xs">승인</button>
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'H')" class="btn btn-warning btn-xs">보류</button>
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'N')" class="btn btn-danger btn-xs">미승인</button>
													</c:when>
													<c:when test="${access.accessStatus eq 'H'}">
														&nbsp;승인보류&nbsp;
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'A')" class="btn btn-info btn-xs">승인</button>
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'N')" class="btn btn-danger btn-xs">미승인</button>
													</c:when>
													<c:when test="${access.accessStatus eq 'X'}">
														&nbsp;미요청&nbsp;
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'A')" class="btn btn-info btn-xs">승인</button>
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'H')" class="btn btn-warning btn-xs">보류</button>
														<button type="button" onclick="updateAccessStatus(${mall.seq}, 'N')" class="btn btn-danger btn-xs">미승인</button>
													</c:when>
												</c:choose>
											</c:if>
										</c:forEach>
								</div>
							</div>
							</c:forEach>

						<%--<c:if test="${sessionScope.loginType eq 'A'}">--%>
								<div class="form-group">
									<label class="col-md-2 control-label" for="comment">코멘트</label>
									<div class="col-md-4">
										<div class="input-group">
										<textarea class="form-control" type="text" id="comment" name="comment" style="height:100px;">${vo.comment}</textarea>
											<span class="input-group-btn">
												<button type="button" onclick="updateComment()" class="btn btn-success btn-xs" style="height:100px;">코멘트 저장</button>
											</span>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-2"></label>
									<span class="text-info" style="padding-left: 20px;"><i class="fa fa-info"></i>코멘트는 코멘트 저장을 누르셔야 등록/수정이 가능합니다</span>
								</div>
							<%--</c:if>--%>
						</c:if>
							
							<div class="form-group">
								<label class="col-md-2 control-label">면세업체구분</label>
								<div class="col-md-2">
									<select class="form-control" name="taxTypeFlag">
										<option value="">-- 과세/면세 --</option>
										<option value="Y" <c:if test="${vo.taxTypeFlag eq 'Y'}">selected="selected"</c:if>>과세</option>
										<option value="N" <c:if test="${vo.taxTypeFlag eq 'N'}">selected="selected"</c:if>>면세</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label" for="bizNo1">사업자 번호</label>
							<c:choose>
								<c:when test="${vo eq null or (vo ne null and sessionScope.loginType eq 'A')}">
								<%-- 등록일 경우, 또는 관리자 수정일 경우에만 입력 폼 --%>
								<div class="col-md-4">
									<input type="hidden" id="bizno_check_flag" value="N"/>
									<div class="input-group">
										<input class="form-control" type="text" id="bizNo1" name="bizNo1" value="${vo.bizNo1}" maxlength="3" onblur="numberCheck(this);" />
										<div class="input-group-addon" style="border:0"><strong>-</strong></div>
										<input class="form-control" type="text" id="bizNo2" name="bizNo2" value="${vo.bizNo2}" maxlength="2" onblur="numberCheck(this);" />
										<div class="input-group-addon" style="border:0"><strong>-</strong></div>
										<input class="form-control" type="text" id="bizNo3" name="bizNo3" value="${vo.bizNo3}" maxlength="5" onblur="numberCheck(this);" />
									</div>
								</div>
								<div class="col-md-1 form-control-static">
									<button type="button" onclick="checkBizNo()" class="btn btn-xs btn-warning">중복 확인</button>
								</div>
								</c:when>
								<c:otherwise>
								<div class="col-md-2 form-control-static">
									${vo.bizNo1} - ${vo.bizNo2} - ${vo.bizNo3}
								</div>
								</c:otherwise>
							</c:choose>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="ceoName">대표자명</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="ceoName" name="ceoName" value="${vo.ceoName}" maxlength="10" />
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label" for="bizType">업태</label>
								<div class="col-md-3">
									<input class="form-control" type="text" id="bizType" name="bizType" value="${vo.bizType}" maxlength="30" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="bizKind">업종</label>
								<div class="col-md-3">
									<input class="form-control" type="text" id="bizKind" name="bizKind" value="${vo.bizKind}" maxlength="30" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="totalSales">매출액</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="totalSales" name="totalSales" value="${vo.totalSales}" maxlength="20" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="amountOfWorker">종업원수</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="amountOfWorker" name="amountOfWorker" value="${vo.amountOfWorker}" maxlength="20" />
								</div>
							</div>

							<div id="normalBox" class="form-group">
								<label class="col-md-2 control-label" for="tel">대표 전화</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="tel" name="tel" value="${vo.tel}" maxlength="30"  placeholder="- 포함하여 입력"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="fax">FAX 번호</label>

								<div class="col-md-2">
									<input class="form-control" type="text" id="fax" name="fax" value="${vo.fax}" maxlength="30" placeholder="- 포함하여 입력"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="addr2">회사 주소</label>
								<div class="col-md-1">
									<input type="text" class="form-control" id="postcode" name="postcode" value="${vo.postcode}" maxlength="5" alt="우편번호" readonly />
								</div>
								<div class="col-md-1 form-control-static">
									<a href="#" onclick="CHPostCodeUtil.postWindow('open' , '#normalBox');" class="btn btn-xs btn-primary">우편번호검색</a>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-2"></div>
								<div class="col-md-4">
									<input class="form-control" type="text" id="addr1" name="addr1" value="${vo.addr1}" maxlength="100" placeholder="주소"  readonly/>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-2"></div>
								<div class="col-md-4">
									<input class="form-control" type="text" id="addr2" name="addr2" value="${vo.addr2}" maxlength="100" placeholder="상세 주소" />
								</div>
							</div>
							<div><hr style="margin:0"/><h4>담당자 정보</h4><hr style="margin:0 0 15px 0"/></div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="salesName">담당자명</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="salesName" name="salesName" value="${vo.salesName}" maxlength="30" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="salesEmail">담당자 이메일</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="salesEmail" name="salesEmail" value="${vo.salesEmail}" maxlength="100" />
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label" for="salesTel1">담당자 전화번호</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="salesTel1" name="salesTel" value="${vo.salesTel}" maxlength="30"  placeholder="- 포함하여 입력"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="salesCell1">담당자 휴대폰번호</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="salesCell1" name="salesCell" value="${vo.salesCell}" maxlength="30"  placeholder="- 포함하여 입력"/>
								</div>
							</div>
							<div><hr style="margin:0"/><h4>정산 정보</h4><hr style="margin:0 0 15px 0"/></div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="adjustName">정산 담당자 성 &nbsp; 명</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="adjustName" name="adjustName" value="${vo.adjustName}" maxlength="15"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="adjustEmail">정산 담당자 이메일</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="adjustEmail" name="adjustEmail" value="${vo.adjustEmail}" maxlength="100"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="adjustTel">정산 담당자 연락처</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="adjustTel" name="adjustTel" value="${vo.adjustTel}" maxlength="30"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="accountBank">입금계좌 은행명</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="accountBank" name="accountBank" value="${vo.accountBank}" maxlength="15"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="accountNo">입금계좌 번호</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="accountNo" name="accountNo" value="${vo.accountNo}" style="ime-mode:disabled" maxlength="30" placeholder="- 포함하여 입력"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="accountOwner">입금계좌 예금주</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="accountOwner" name="accountOwner" value="${vo.accountOwner}" maxlength="15"/>
								</div>
							</div>
							<div><hr style="margin:0"/><h4>배송/반품 정보</h4><hr style="margin:0 0 15px 0"/></div>
							<div id="returnBox" class="form-group">
								<label class="col-md-2 control-label">기본택배사</label>
								<div class="col-md-2">
									<select class="form-control" name="defaultDeliCompany">
										<option value="0">---택배사 선택---</option>
										<c:forEach var="item" items="${deliCompanyList}">
											<option value="${item.deliSeq}" <c:if test="${vo.defaultDeliCompany eq item.deliSeq}">selected</c:if>>${item.deliCompanyName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">반품 담당자</label>
								<div class="col-md-2">
									<input class="form-control" type="text" id="" name="returnName" value="${vo.returnName}" maxlength="30" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">반품 담당자 연락처</label>

								<div class="col-md-2">
									<input class="form-control" type="text" name="returnCell" value="${vo.returnCell}" maxlength="30" placeholder="- 포함하여 입력"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="addr2">반품 주소</label>
								<div class="col-md-1">
									<input type="text" class="form-control" id="returnPostCode" name="returnPostCode" value="${vo.returnPostCode}" maxlength="5" alt="우편번호" readonly />
								</div>
								<div class="col-md-1 form-control-static">
									<a href="#" onclick="CHReturnPostCodeUtil.returnPostWindow('open' , '#returnBox');" class="btn btn-xs btn-primary">우편번호검색</a>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-2"></div>
								<div class="col-md-4">
									<input class="form-control" type="text" name="returnAddr1" value="${vo.returnAddr1}" maxlength="100" placeholder="반품 주소" readonly/>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-2"></div>
								<div class="col-md-4">
									<input class="form-control" type="text" name="returnAddr2" value="${vo.returnAddr2}" maxlength="100" placeholder="반품 상세 주소"/>
								</div>
							</div>
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-info">${vo eq null ? '등록하기':'수정하기'}</button>
							<button type="button" class="btn btn-default" onclick="location.href='/admin/seller/list/S'">목록보기</button>
						</div>

						<input type="hidden" name="code" value="seller">
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

<script id="itemTemplate" type="text/html">
	<tr data-seq="<%="${seq}"%>" data-depth="<%="${depth}"%>" {{if blockFlag=="Y"}}style="background-color:#CD1F48;"{{/if}}>
	{{if depth=="1"}}
		<td class="title" onclick="EBCategory.select(this)" style="cursor: pointer;">
	{{else}}
		<td class="title">
	{{/if}}
	{{if showFlag=="Y"}}
		<i class="icon icon-chevron-down"></i>
	{{else}}
		<i class="icon icon-remove-sign"></i>
	{{/if}}
		<%="${name}"%>
		</td>
		<td class="text-center">
			<%="${seq}"%>
		</td>
	</tr>
</script>

<script id="FileTemplate" type="text/html">
    <div>
        <div class="form-group">
            <label></label>
            <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
            <input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted" style="display:inline-block; width:262px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
        </div>
    </div>
</script>
<%@ include file="/WEB-INF/jsp/admin/include/postcode_view.jsp" %>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.js"></script>
<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>
<script type="text/javascript">

$(document).ready(function () {
	CKEDITOR.replace('intro',{
		width:'100%',
		height:'400px',
		filebrowserImageUploadUrl: '/admin/editor/upload'
	});
	CKEDITOR.replace('mainItem',{
		width:'100%',
		height:'400px',
		filebrowserImageUploadUrl: '/admin/editor/upload'
	});
	CKEDITOR.replace('socialActivity',{
		width:'100%',
		height:'400px',
		filebrowserImageUploadUrl: '/admin/editor/upload'
	});
});
var callbackProc = function(msg) {
	if(msg.split("^")[0] === "EDITOR") {
		CKEDITOR.tools.callFunction(msg.split("^")[1], msg.split("^")[2], '이미지를 업로드 하였습니다.');
	} else {
		$('.file-wrap'+msg).remove();	
	}
}


	$(document).ready(function(){
		//자치구 시/도 항목 기본 설정
		setJachiguSido();
	});

	var updateComment = function(){
		var seq = "${vo.seq}";

		location.href='/admin/seller/comment/reg?seq='+seq+'&comment='+$('#comment').val();
	}

	var addFilePane = function() {
	  var num = 1;
	  $('#FileList input[type=file]').each(function(){
	      var n = parseInt( $(this).attr('name').replace('file', ''), 10);
	      if(num <= n) {
	          num = n+1;
	      }
	  });
	  $('#FileList').append( $('#FileTemplate').tmpl({num:num}) );

	  $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
	      $(this).parent().next().text(label);
	  });
	}

	/** 한글 삭제 */
	var koreanCheck = function(obj){
		obj.value=obj.value.replace(/[가-힣ㄱ-ㅎㅏ-ㅣ]/g, '');
	};

	/** 폼 전송 */
	var doSubmit = function(frmObj) {
		/* 필수값 체크 */
		var submit = checkRequiredValue(frmObj, "data-required-label");

		if(submit) {
			/* 패스워드 일치 체크 */
			if($("#password").val() != $("#password_confirm").val()) {
				$.msgbox("패스워드가 일치하지 않습니다.");
				$("#password").focus();
				return false;
			}

			/* 상점명 중복 체크
			 if($('#nickname').val() !== $("#validNickName").val() || $("#nick_check_flag").val() !== "Y") {
			 	//닉네임 중복검사 여부
			 	if(${vo ne null}) {
			 		if ($('#myNickName').val() !== $('#nickname').val()) {
			 			$.msgbox("상점명 중복체크를 해주세요.", {type: "error"});
			 			$('#myNickName').focus();
			 			return false;
			 		}
			 	} else {
			 		$.msgbox("상점명 중복체크를 해주세요.", {type: "error"});
			 		return false;
			 	}
			 } */
			
		 	/*if((typeof $('input[name=authCategory]:checked').val()) === 'undefined') {
				alert('인증 구분을 선택해 주세요.');
				$('input[name=authCategory]')[0].focus();
				return false;
			}*/

			var seq = "${vo.seq}";
			if( seq == null || $.trim(seq) == "" ) {
				/* 등록 처리 */

				// 아이디 중복 체크
				if($("#id_check_flag").val() != "Y") {
					$.msgbox("아이디 중복 확인 바랍니다.");
					return false;
				}
				// 사업자 중복 체크
				var bizNo1 = $.trim($("#bizNo1").val());
				var bizNo2 = $.trim($("#bizNo2").val());
				var bizNo3 = $.trim($("#bizNo3").val());

				if(!(bizNo1 == "" || bizNo2 == "" || bizNo3 == "") && ($("#bizno_check_flag").val() != "Y") ){
					$.msgbox("사업자번호 중복 확인 바랍니다.");
					return false;
				}
				/** 등록 처리 */
				$(frmObj).attr("action","/admin/seller/reg/proc");
			} else {
				/** 수정 처리 */
				$(frmObj).attr("action","/admin/seller/mod/"+seq+"/proc");
			}
		}
		return submit;
	};

	/** 폐점/승인 처리 */
	var updateStatus = function(status) {
		if(!confirm("변경하시겠습니까?")) {
			return;
		}

		location.href="/admin/seller/status/update?seq=${vo.seq}&statusCode="+status
	}

	/** 몰이용허가 처리 */
	var updateAccessStatus = function(mallSeq, accessStatus) {
		if(!confirm("변경하시겠습니까?")) {
			return;
		}

		location.href="/admin/seller/status/accessupdate?seq=${vo.seq}&mallSeq="+mallSeq+"&accessStatus="+accessStatus
	}

	/** 아이디 중복 체크 */
	var checkId = function() {
		var id = $("#id").val();
		//아이디 입력여부 검사
		if(id === "") {
			$.msgbox("아이디를 입력해주세요.");
			$("#id").focus();
			return;
		}
		//ajax:아이디중복체크
		$.ajax({
			type: 'POST',
			data: {id:id},
			dataType: 'json',
			url: '/admin/system/check/id/ajax',
			success: function(data) {
				if(data.result === "true") {
					$.msgbox(data.message);
					$("#id_check_flag").val("Y");
				} else {
					$.msgbox(data.message);
					$("#id_check_flag").val("N");
					$("#id").focus();
				}
			}
		});
	}

	/** 닉네임 중복 체크 */
	var checkNickname = function() {
		var nickname = $("#nickname").val();
		//닉네임 입력여부 검사
		if(nickname === "") {
			alert("상점명을 입력해주세요.");
			$("#nickname").focus();
			return;
		}
		if($('#myNickName').val() === nickname){
			alert("기존 상점명 입니다.");
			return;
		}

		//ajax:닉네임중복체크
		$.ajax({
			type: 'POST',
			data: {nickname:nickname},
			dataType: 'json',
			url: '/admin/system/check/nickname/ajax',
			success: function(data) {
				if(data.result === "true") {
					$.msgbox(data.message);
					$("#validNickName").val($("#nickname").val());
					$("#nick_check_flag").val("Y");
				} else {
					$.msgbox(data.message);
					$("#nick_check_flag").val("N");
					$("#nickname").focus();
				}
			}
		})
	};

	/** 사업자 중복 체크 */
	var checkBizNo = function() {
		var bizNo1 = $.trim($("#bizNo1").val());
		var bizNo2 = $.trim($("#bizNo2").val());
		var bizNo3 = $.trim($("#bizNo3").val());

		if(bizNo1 == "" || bizNo2 == "" || bizNo3 == "") {
			$.msgbox("사업자 번호를 입력해주세요.");
			return;
		}

		$.ajax({
			type: 'POST',
			data: {bizNo:bizNo1+bizNo2+bizNo3},
			dataType: 'json',
			url: '/admin/seller/check/bizno/ajax',
			success: function(data) {
				if(data.result === "true") {
					$.msgbox(data.message);
					$("#bizno_check_flag").val("Y");
				} else {
					$.msgbox(data.message);
					$("#bizno_check_flag").val("N");
				}
			}
		});
	}

	/** 기본 주소찾기 DAUM API */
	var openDaumPostCode = function() {
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
				$("input[name='postcode1']").val(data.postcode1);
				$("input[name='postcode2']").val(data.postcode2);
				$("input[name='addr1']").val(data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, ''));

				//전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
				//아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
				//var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
				//document.getElementById('addr').value = addr;

				$("input[name='addr2']").focus();
			}
		}).open();
	}

	/** 반품 주소찾기 DAUM API */
	var openDaumReturnPostCode = function() {
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
				$("input[name='returnPostCode1']").val(data.postcode1);
				$("input[name='returnPostCode2']").val(data.postcode2);
				$("input[name='returnAddr1']").val(data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, ''));

				//전체 주소에서 연결 번지 및 ()로 묶여 있는 부가정보를 제거하고자 할 경우,
				//아래와 같은 정규식을 사용해도 된다. 정규식은 개발자의 목적에 맞게 수정해서 사용 가능하다.
				//var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
				//document.getElementById('addr').value = addr;

				$("input[name='returnAddr2']").focus();
			}
		}).open();
	}

	//소속 자치구 이벤트 컨트롤
	$("#jachiguSido").change(function() {
		if($(this).val() == "01") {
			//서울시일 경우에만 자치구 선택 가능
			$("#jachiguCode").css("display","block");
			$("#jachiguCode").val("");
		} else {
			$("#jachiguCode").css("display","none");
			$("#jachiguCode").val($(this).val());
		}
	});

	//자치구 시/도 항목 기본 설정
	var setJachiguSido = function() {
		if($("#jachiguCode").val() == "" || $("#jachiguCode").val() == "99") {
			$("#jachiguCode").css("display","none");
			$("#jachiguSido").val($("#jachiguCode").val());
		} else {
			$("#jachiguCode").css("display","block");
			$("#jachiguSido").val("01");
		}
	}
</script>
</body>
</html>
