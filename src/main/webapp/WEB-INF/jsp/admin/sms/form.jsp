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
		<h1> <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">SMS 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header">
						<h3 class="box-title"><i class="fa fa-edit"></i> 발송 메세지 신규 등록</h3>
					</div>
					<!-- 내용 -->
					<form id="validation-form" method="post" action="<c:choose><c:when test="${vo eq null}">/admin/sms/write/proc</c:when><c:otherwise>/admin/sms/edit/proc</c:otherwise></c:choose>" target="zeroframe" class="form-horizontal" onsubmit="return submitProc(this);">
						<c:if test="${vo ne null}">
							<input type="hidden" name="seq" value="${vo.seq}"/>
						</c:if>
						<div class="box-body">
							<div class="form-group">
							<label class="col-md-2 control-label" for="title">제목 <i class="fa fa-check"></i></label>
							<div class="col-md-2">
								<input type="text" class="form-control" id="title" name="title" value="${vo.title}" maxlength="30" alt="제목"/>
							</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">발송대상 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select class="form-control" id="typeCode" name="typeCode" alt="발송대상">
										<option value="">-- 선택 --</option>
										<option value="C" ${vo ne null && vo.typeCode eq 'C' ? "selected" :  ""}>고객</option>
										<option value="S" ${vo ne null && vo.typeCode eq 'S' ? "selected" :  ""}>입점업체</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상태 <i class="fa fa-check"></i></label>
								<div class="radio">
									<label><input type="radio" name="statusType" alt="상태" value="O" <c:if test="${vo.statusType eq 'O'}">checked</c:if>>주문</label>
									<label><input type="radio" name="statusType" alt="상태" value="S" <c:if test="${vo.statusType eq 'S'}">checked</c:if>>입점업체</label>
									<label><input type="radio" name="statusType" alt="상태" value="C" <c:if test="${vo.statusType eq 'C'}">checked</c:if>>회원</label>
									<label><input type="radio" name="statusType" alt="상태" value="E" <c:if test="${vo.statusType eq 'E'}">checked</c:if>>견적</label>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-2"></div>
								<div class="col-md-2">
									<select class="form-control" id="statusCode" name="statusCode" alt="상태"></select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">내용 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<textarea class="form-control" id="content" name="content" alt="내용" rows="10">${vo.content}</textarea>
								</div>
								<div class="col-md-3">
									<div class="alert alert-info">
										특정 문구가 들어가야 할 때 아래와 같이 입력해주세요.<br/>
										쇼핑몰: [mallName]<br/>
										이 &nbsp; 름: [memberName]<br/>
										상품명: [itemName]<br/>
										주문번호: [orderSeq]
									</div>
								</div>
							</div>
						</div>
						<div class="box-footer text-center">
							<button type="submit" class="btn btn-info">
								<c:choose>
									<c:when test="${vo eq null}">등록하기</c:when>
									<c:otherwise>수정하기</c:otherwise>
								</c:choose>
							</button>
							<a class="btn btn-default" href="/admin/sms/list">목록보기</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>
<script id="commonTemplate" type="text/html">
	<option value="">--선택--</option>
	{{each list}}
	<option value="<%="${value}"%>" {{if statusCode == value}}selected{{/if}}><%="${name}"%></option>
	{{/each}}
</script>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	//새로고침시 아이디중복체크 초기화
	$(document).ready(function() {
		<c:if test="${vo ne null}">
			CHCommonUtil.list("${vo.statusType}", "${vo.statusCode}");
		</c:if>

		$('input:radio[name="statusType"]').click(function(){
			var mappingData = $(this).val();
			CHCommonUtil.list(mappingData);
		});
	});

	var CHCommonUtil = {
		list:function(mappingData, statusCode) {
			$.ajax({
				url:"/admin/sms/common/ajax",
				type:"get",
				data:{mappingData:mappingData},
				dataType:"text",
				success:function(data) {
					var list = $.parseJSON(data);
					var common = {list:[], statusCode:''};
					common.list = list;
					common.statusCode = statusCode;
					$("#statusCode").html($("#commonTemplate").tmpl(list));
					$('#statusCode').show();
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		}
	};

	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt], textarea[alt]").each( function() {
			if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {
				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});
		return flag;
	};
</script>
</body>
</html>
