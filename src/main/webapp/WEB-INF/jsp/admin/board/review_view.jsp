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
		<h1>${title} 게시판 상세 정보<small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>게시판 관리</li>
			<li>${title} 게시판</li>
			<li class="active">${title} 게시판 상세 정보</li>
		</ol>
	</section>

	<!-- 콘텐츠 -->
	<section class="content">
			<div class="row">
				<div class="col-md-12">
					<div class="box">
						<!-- 제목 -->
						<div class="box-header with-border">
							<h3 class="box-title"><i class="fa fa-newspaper-o"></i>${title} 게시판 상세 정보</h3>
						</div>
						<!-- 내용 -->
						<div class="box-body">
							<%-- 현재 로그인한 관리자 시퀀스 , 현재는 사용하지 않는다. --%>
							<input type="hidden" id="loginSeq" value="${loginSeq}"/>
							<table class="table table-bordered table-striped">
								<colgroup>
									<col style="width:20%;" />
									<col style="width:80%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>작성자</th>
										<td>${ vo.nickName }</td>
									</tr>
									<tr>
										<th>등록일</th>
										<td>
											<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
											<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
										</td>
									</tr>
									<tr>
										<th>상품번호</th>
										<td><div style="float:left;"><img src="/upload${fn:replace(vo.img1, 'origin', 's60')}" style="width:70px;" alt=""/></div><div style="float:left;width:430px;padding:12px 0 0 10px;">${vo.itemSeq}<br/>${vo.itemName}</div></td>
									</tr>
									<tr>
										<th>쇼핑몰</th>
										<td>${ vo.mallName }</td>
									</tr>
									<tr>
										<th>구매평</th>
										<td>${fn:replace(vo.review, newLine, "<br/>")}</td>
									</tr>
									<tr>
										<th>상품평가</th>
										<td style="color:#fcb040"><smp:reviewStar max="5" value="${vo.goodGrade}" /></td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="box-footer text-center">
							<c:if test="${vo ne null and sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
								<%-- 관리자만 수정 가능 --%>
								<%--<button type="button" class="btn btn-primary"  onclick="goEditReview('${vo.seq}','${vo.memberSeq}')">수정하기</button>--%>

								<%-- 관리자만 삭제 가능 --%>
								<input type="hidden" name="seq" value="${vo.seq}" />

								<span role="button" class="btn btn-sm btn-danger" onclick="confirmDelete('${vo.memberSeq}')">삭제하기</span>
								<a href="/admin/board/review/list" class="btn btn-sm btn-default">목록보기</a>
								<div id="myModal" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header" style="padding:1px 15px; background-color:#D73925; color:#fff">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
												<h3 id="myModalLabel" style="margin-top:15px;">경고</h3>
											</div>
											<div class="modal-body">
												<p>삭제 하시겠습니까?</p>
											</div>
											<div class="modal-footer">
												<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
												<a href="#myModal2" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">삭제하기</a>
											</div>
										</div>
									</div>
								</div>

								<div id="myModal2" class="modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header" style="padding:1px 15px;background-color:#D73925;color:#fff">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
												<h3 id="myModalLabel" style="margin-top:15px;">경고</h3>
											</div>
											<div class="modal-body">
												<p>삭제하시면 다시는 복구할수 없습니다, 정말 삭제하시겠습니까?</p>
											</div>
											<div class="modal-footer">
												<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
												<button class="btn btn-danger" onClick="goDeleteReview('${vo.seq}','${vo.memberSeq}')">삭제하기</button>
											</div>
										</div>
									</div>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
	</section>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript">
	var goEditReview = function(seq,memberSeq){
//		if(memberSeq != $("#loginSeq").val()){
//			alert("본인 이외의 글은 수정 할 수 없습니다.");
//			return;
//		}
		location.href = "/admin/board/review/edit/"+seq+"?memberSeq="+memberSeq;
	};

	var confirmDelete = function(memberSeq){
//		if(memberSeq != $("#loginSeq").val()){
//			alert("본인 이외의 글은 삭제 할 수 없습니다.");
//			return;
//		}
		$("#myModal").modal("show");
	};
	var goDeleteReview = function(seq, memberSeq){
//		if(memberSeq != $("#loginSeq").val()){
//			alert("본인 이외의 글은 삭제 할 수 없습니다.");
//			return;
//		}
		location.href = "/admin/board/review/del/proc/"+seq+"?memberSeq="+memberSeq;
	};
</script>
</body>
</html>
