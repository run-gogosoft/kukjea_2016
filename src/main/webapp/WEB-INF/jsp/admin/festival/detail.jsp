<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.file-select {
			width:50%; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;
		}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>
			행사 참여
			<small>행사 정보 관리 및 입점업체 참여 정보 관리</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>행사 참여</li>
			<li>행사 리스트</li>
			<li class="active">행사 상세 정보</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<!-- 행사 상세 정보 -->
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">행사 상세 정보</h3>
						<div class="pull-right">
							<c:if test="${sessionScope.loginType eq 'S'}">
								<!-- 입점업체일 경우 해당 행사의 참여 신청 정보가 없을 경우 해당 버튼을 노출 시킴 -->
								<a href="/admin/festival/detail/${vo.seq}?seq=${sellerVo.seq}&detailType=sellerForm" class="btn btn-sm btn-primary">
									${sellerVo eq null ? "참여 신청 하기" : "참여 정보 수정"}
								</a>
							</c:if>
							<c:if test="${sessionScope.loginType eq 'A'}">
								<a href="/admin/festival/form/${vo.seq}" class="btn btn-sm btn-primary">수정하기</a>
								<a href="/admin/festival/del/${vo.seq}" onclick="return confirm('참여업체 리스트 정보까지 모두 삭제 처리됩니다.\n\n정말로 삭제하시겠습니까?')" class="btn btn-sm btn-danger" target="zeroframe">
									삭제하기
								</a>
							</c:if>
							<button type="button" onclick="history.go(-1);" class="btn btn-sm btn-default">뒤로가기</button>
						</div>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:10%;" />
								<col style="width:80%;" />
							</colgroup>
					        <tbody>
					        	<tr>
									<th>제목</th>
									<td>${vo.title}</td>
								</tr>
								<tr>
									<th>신청 기간</th>
									<td>${vo.startDate} ~ ${vo.endDate}</td>
								</tr>
								<tr>
									<th>첨부 파일</th>
									<td>
										<c:forEach var="item" items="${fileList}">
										<div style="margin-bottom:10px">
										    ${item.filename}
											<a href="/admin/festival/file/download/${item.seq}" target="zeroframe">[다운로드]</a>
										</div>
				                    	</c:forEach>
									</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
									</td>
								</tr>
					        </tbody>
						</table>
					</div>
				</div>
				
				<!-- 참여업체 리스트-->
				<c:if test="${detailType eq 'sellerList'}">
				<div class="box" id="seller_list">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">참여 업체 리스트</h3>
						<!-- <div class="pull-right"></div> -->
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered table-striped">
							<colgroup>
								<col style="width:5%;"/>
								<col style="width:10%;"/>
								<col style="width:*"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:12%;"/>
								<col style="width:12%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
								<col style="width:8%;"/>
							</colgroup>
							<thead>
								<tr>
									<th>No.</th>
									<th>아이디</th>
									<th>업체명</th>
									<th>사업자번호</th>
									<th>대표자명</th>
									<th>업태</th>
									<th>업종</th>
									<th>대표전화</th>
									<th>FAX번호</th>
									<th>수정일자</th>
									<th>등록일자</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${sellerList}" varStatus="status">
								<tr>
									<td class="text-center">${item.seq}</td>
									<td><a href="/admin/festival/detail/${vo.seq}?seq=${item.seq}">${item.sellerId}</a></td>
									<td>${item.sellerName}</td>
									<td class="text-center">${fn:substring(item.bizNo,0,3)}-${fn:substring(item.bizNo,3,5)}-${fn:substring(item.bizNo,5,10)}</td>
									<td class="text-center">${item.ceoName}</td>
									<td>${item.bizType}</td>
									<td>${item.bizKind}</td>
									<td>${item.tel}</td>
									<td>${item.fax}</td>
									<td class="text-center">${fn:substring(item.modDate,0,10)}</td>
									<td class="text-center">${fn:substring(item.regDate,0,10)}</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(sellerList)==0 }">
								<tr><td class="text-center" colspan="11">조회된 데이터가 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<%-- <div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div> --%>
					</div>
				</div>
				</c:if>
				
				<!-- 참여업체 정보 -->
				<c:if test="${detailType eq 'sellerDetail' and sellerVo ne null}">
				<div class="box" id="seller_detail">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">참여 업체 정보</h3>
						<div class="pull-right">
							<a href="/admin/festival/detail/${vo.seq}?seq=${sellerVo.seq}&detailType=sellerForm" class="btn btn-sm btn-primary">수정하기</a>
							<a href="/admin/festival/seller/del/${vo.seq}?seq=${sellerVo.seq}" onclick="return confirm('해당 참여업체 정보가 삭제됩니다.\n\n정말로 삭제하시겠습니까?')" class="btn btn-sm btn-danger" target="zeroframe">
								삭제하기
							</a>
						</div>
					</div>
					<!-- 내용 -->
					<table class="table table-bordered">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col style="width:40%;" />
						</colgroup>
				        <tbody>
				        	<tr>
								<th>업체명</th>
								<td>${sellerVo.sellerName}</td>
								<th>아이디</th>
								<td>${sellerVo.sellerId}</td>
							</tr>
							<tr>
								<th>사업자번호</th>
								<td>${fn:substring(sellerVo.bizNo,0,3)}-${fn:substring(sellerVo.bizNo,3,5)}-${fn:substring(sellerVo.bizNo,5,10)}</td>
								<th>대표자명</th>
								<td>${sellerVo.ceoName}</td>
							</tr>	
							<tr>
								<th>업태</th>
								<td>${sellerVo.bizType}</td>
								<th>업종</th>
								<td>${sellerVo.bizKind}</td>
							</tr>
							<tr>
								<th>매출액</th>
								<td><fmt:formatNumber value="${sellerVo.totalSales}"/></td>
								<th>종업원수</th>
								<td><fmt:formatNumber value="${sellerVo.amountOfWorker}"/></td>
							</tr>
							<tr>
								<th>대표 전화</th>
								<td>${sellerVo.tel}</td>
								<th>FAX 번호</th>
								<td>${sellerVo.fax}</td>
							</tr>
							<tr>
								<th>회사 소속</th>
								<td>${sellerVo.jachiguName}</td>
								<th>인증 구분</th>
								<td>
								<c:forEach var="item" items="${authCategoryList}" varStatus="status">
									<c:if test="${fn:contains(sellerVo.authCategory, item.value)}">
										<span style="display:inline-block;margin-right:20px;">${item.name}<img src="/front-assets/images/detail/auth_mark_${item.value}.png" alt="${item.name}"></span>
									</c:if>
								</c:forEach>
								</td>
							</tr>			
							
							<tr>
								<th>신청 내용 <i class="fa fa-check"></i></th>
								<td colspan="3">${sellerVo.content}</td>
							</tr>
							<tr>
								<th>파일 첨부 <i class="fa fa-check"></i></th>
								<td colspan="3">
				                    <c:forEach var="item" items="${sellerFileList}">
									<div style="margin-bottom:10px;">
									    ${item.filename}
										<a href="/admin/festival/file/download/${item.seq}" target="zeroframe">[다운로드]</a>
									</div>
				                    </c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				</c:if>
				
				<!-- 참여업체 정보 등록/수정 -->
				<c:if test="${detailType eq 'sellerForm'}">
				<div class="box" id="seller_form">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title">${sellerVo eq null ? "참여 신청 하기" : "참여 업체 정보 수정"}</h3>
						<!-- <div class="pull-right"></div> -->
					</div>
					<!-- 내용 -->
					<form id="validation-form" method="post" enctype="multipart/form-data" action="/admin/festival/seller/${sellerVo eq null ? "reg":"mod/"}${sellerVo eq null ? "": sellerVo.seq}" target="zeroframe" class="form-horizontal" onsubmit="return submitProc(this);">
						<input type="hidden" name="festivalSeq" value="${vo.seq}">
						<c:if test="${sessionScope.loginType eq 'A'}">
							<input type="hidden" name="sellerSeq" value="${sellerVo.sellerSeq}">
						</c:if>
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">업체명</label>
								<div class="col-md-2 form-control-static">
									${sellerVo eq null ? sessionScope.loginName : sellerVo.sellerName}
								</div>
								<label class="col-md-2 control-label">아이디</label>
								<div class="col-md-2 form-control-static">
									${sellerVo eq null ? sessionScope.loginId : sellerVo.sellerId}
								</div>
							</div>							
							<div class="form-group">
								<label class="col-md-2 control-label">신청 내용 <i class="fa fa-check"></i></label>
								<div class="col-md-8">
									<textarea name="content" class="form-control" style="height:200px" alt="신청 내용">${sellerVo.content}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">파일 첨부</label>
								<div class="col-md-8">
									<div id="fileList">
				                    <c:forEach var="item" items="${sellerFileList}">
										<div id="uploaded_file${item.seq}" class="form-control-static" style="margin-bottom:10px">
										    <input type="file" onchange="checkFileSize(this);" id="file${item.num}" name="file${item.num}" class="display-none" style="display:none"/>
										    ${item.filename}
											<a href="/admin/festival/file/download/${item.seq}" target="zeroframe">[다운로드]</a>
											<a href="/admin/festival/file/delete/${item.seq}" onclick="return confirm('정말로 이 파일을 삭제하시겠습니까?');" target="zeroframe" class="text-danger">[삭제]</a>
										</div>
				                    </c:forEach>
									</div>
									<div>
										<button type="button" onclick="addFile()" class="btn btn-link btn-sm"><i class="fa fa-plus"></i> 파일 추가하기</button>
									</div>
								</div>
							</div>
						</div>
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-primary">
								${sellerVo eq null ? "신청 하기" : "수정 하기"}
							</button>
							<button type="button" onclick="history.go(-1)" class="btn btn-default">뒤로가기</button>
						</div>
					</form>
				</div>
				</c:if>
			</div>
		</div>
	</section>
</div>

<div id="iframe_content" style="display:none">${vo.content}</div>

<script id="fileTemplate" type="text/html">
	<div style="margin-bottom:10px">
		<input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted file-select"/>
	</div>
</script>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>

<script type="text/javascript">	
	$(window).load(function() {
		$("#content_view").contents().find("body").html($("#iframe_content").html());
		$("#content_view").height($("#content_view").contents().find("body")[0].scrollHeight + 30);
		
		var detailType = "${detailType}";
		if(detailType == "sellerForm" ) {
			location.href = "#seller_form";
		}
		if(detailType == "sellerDetail" ) {
			location.href = "#seller_detail";
		}
		if(detailType == "sellerList" ) {
			location.href = "#seller_list";
		}
	});
	
	$(document).ready(function(){		
		$(".datepicker").datepicker({
			dateFormat:"yy-mm-dd"
		});
		
		<c:if test="${sellerVo eq null and detailType eq 'sellerForm'}">
			addFile();
		</c:if>
	});
	
	
	var submitProc = function(obj) {
		return checkRequiredValue(obj, "alt");
	};
			
	var addFile = function() {
		var num = 1;
		$('#fileList input[type=file]').each(function(){
			var n = parseInt( $(this).attr('name').replace('file', ''), 10);
			if(num <= n) {
				num = n+1;
			}
		});
  		
		$('#fileList').append( $('#fileTemplate').tmpl({num:num}) );
	}
	
	var callbackProc = function(msg) {
		if(msg.split("^")[0] === "FILE") {
			alert(msg.split("^")[1]);
			$("#uploaded_file"+msg.split("^")[2]).remove();
	  	}
	}
</script>
</body>
</html>