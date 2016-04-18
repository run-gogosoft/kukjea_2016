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
		<h1>관리자 등급 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">관리자 등급 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-edit"></i> ${title}</h3>
					</div>
					<!-- 내용 -->
					<form id="validation-form" method="post" action="<c:choose><c:when test="${vo eq null}">/admin/system/grade/manage/write/proc</c:when><c:otherwise>/admin/system/grade/manage/edit/proc/${vo.seq}</c:otherwise></c:choose>" target="zeroframe" class="form-horizontal" onsubmit="return submitProc(this);">
						<div class="box-body">
							<c:if test="${vo ne null}">
							<div class="form-group">
								<label class="col-md-2 control-label" for="controllerName">번호 <i class="fa fa-check"></i></label>
								<div class="col-md-2 form-control-static">${vo.seq}</div>
							</div>
							</c:if>
							<div class="form-group">
								<label class="col-md-2 control-label" for="controllerName">컨트롤러 이름 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="controllerName" name="controllerName" value="${vo.controllerName}" maxlength="30" alt="컨트롤러 이름"/>
								</div>
								<div class="col-md-6 form-control-static">
									<span class="text-danger">※ 컨트롤러 이름의 시작 문자는 소문자로 시작합니다.</span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="controllerMethod">컨트롤러 메소드 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="controllerMethod" name="controllerMethod" value="${vo.controllerMethod}" maxlength="30" alt="컨트롤러 메소드"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="controllerDivision">컨트롤러 구분</label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="controllerDivision" name="controllerDivision" value="${vo.controllerDivision}" maxlength="30"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="controllerDescription">컨트롤러 설명</label>
								<div class="col-md-2">
									<input type="text" class="form-control" id="controllerDescription" name="controllerDescription" value="${vo.controllerDescription}" maxlength="50"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">등급 <i class="fa fa-check"></i></label>
								<div class="checkbox" id="grade-checkbox">
									<label><input type="checkbox" id="admin0Flag" name="admin0Flag" value="Y" onclick="thisChecked(this)" <c:if test="${vo.admin0Flag eq 'Y'}">checked</c:if> alt="연구소"/>연구소</label>
									<label><input type="checkbox" id="admin1Flag" name="admin1Flag" value="Y" onclick="thisChecked(this)" <c:if test="${vo.admin1Flag eq 'Y'}">checked</c:if> alt="최고 관리자"/>최고 관리자</label>
									<label><input type="checkbox" id="admin2Flag" name="admin2Flag" value="Y" onclick="thisChecked(this)" <c:if test="${vo.admin2Flag eq 'Y'}">checked</c:if>/>운영 관리자</label>
									<label><input type="checkbox" id="admin3Flag" name="admin3Flag" value="Y" onclick="thisChecked(this)" <c:if test="${vo.admin3Flag eq 'Y'}">checked</c:if>/>디자이너</label>
									<label><input type="checkbox" id="admin4Flag" name="admin4Flag" value="Y" onclick="thisChecked(this)" <c:if test="${vo.admin4Flag eq 'Y'}">checked</c:if>/>정산 관리자</label>
									<label><input type="checkbox" id="admin5Flag" name="admin5Flag" value="Y" onclick="thisChecked(this)" <c:if test="${vo.admin5Flag eq 'Y'}">checked</c:if>/>CS 관리자</label>
									<label><input type="checkbox" id="admin9Flag" name="admin9Flag" value="Y" onclick="thisChecked(this)" <c:if test="${vo.admin9Flag eq 'Y'}">checked</c:if>/>일반 관리자</label>
									<label><input type="checkbox" id="sellerFlag" name="sellerFlag" value="Y" onclick="thisChecked(this)" <c:if test="${vo.sellerFlag eq 'Y'}">checked</c:if>/>입점업체</label>
								</div>
							</div>
						</div>
						<div class="box-footer text-center">
							<c:choose>
								<c:when test="${vo eq null}">
									<button type="submit" class="btn btn-info">등록하기</button>
								</c:when>
								<c:otherwise>
									<button type="submit" class="btn btn-info">수정하기</button>
								</c:otherwise>
							</c:choose>
							<a class="btn btn-default" href="/admin/system/grade/manage/list">목록보기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {
				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});

		if(flag){
			var checkCount=0;
			$("#grade-checkbox").find("input:checkbox:checked").each(function(){
				checkCount++;
			});

			if(checkCount==0){
				alert("등급을 하나이상 선택해 주세요!")
				flag = false;
				$(this).focus();
			}
		}
		return flag;
	};
</script>
</body>
</html>
