<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<link href="/assets/css/summernote.css" rel="stylesheet">
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>
		<c:choose><c:when test="${vo eq null}">${title} 게시판 정보 등록</c:when><c:otherwise>${vo.name} 게시판 정보 수정</c:otherwise></c:choose> <small></small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
				<li>about 사회적경제</li>
			<li>게시판 관리</li>
			<li>
				<c:choose><c:when test="${vo eq null}">${title} 게시판</c:when><c:otherwise>${vo.name} 게시판</c:otherwise></c:choose>
			</li>
			<li class="active"><c:choose><c:when test="${vo eq null}">${title} 게시판 정보 등록</c:when><c:otherwise>${vo.name} 게시판 정보 수정</c:otherwise></c:choose> <small></small></li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border"><h3 class="box-title"><i class="fa fa-edit"></i> <c:choose><c:when test="${vo eq null}">${title} 게시판 정보 등록</c:when><c:otherwise>${vo.name} 게시판 정보 수정</c:otherwise></c:choose> <small></small></h3></div>
					<!-- 내용 -->
					<form id="write" class="form-horizontal" onsubmit="return submitProc(this);" method="post" action="<c:choose><c:when test="${vo eq null}">/admin/about/board/detail/reg/proc</c:when><c:otherwise>/admin/about/board/detail/edit/proc</c:otherwise></c:choose>" target="zeroframe" enctype="multipart/form-data">
						<input type="hidden" name="commonBoardSeq" value="<c:choose><c:when test="${vo eq null}">${commonBoardSeq}</c:when><c:otherwise>${vo.commonBoardSeq}</c:otherwise></c:choose>">
						<input type="hidden" name="seq" value="${vo.seq}">
						<div class="box-body">
							<c:if test="${vo ne null}">
								<div class="form-group">
									<label class="col-md-2 control-label">등록일</label>
									<div class="col-md-10">
										<p class="form-control-static">
											<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
											<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
										</p>
									</div>
								</div>
							</c:if>

							<div class="form-group">
								<label class="col-md-2 control-label" for="id">작성자</label>
								<div class="col-md-10 form-control-static">
									<%--vo가 널이라면 등록 아니라면 수정--%>
									<c:choose>
										<c:when test="${vo eq null}">
											${sessionScope.loginName}(관리자)
										</c:when>
										<c:otherwise>
												<c:choose>
													<c:when test="${vo.userSeq eq null}">
														${vo.userName}(비회원)
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${vo.userTypeCode eq 'A'}">
																${vo.memberName}(관리자)
															</c:when>
															<c:otherwise>
																${vo.memberName}(회원)
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
										</c:otherwise>
									</c:choose>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label" for="title">제목</label>
								<div class="col-md-5">
									<p class="form-control-static">
										<%--vo가 널이라면 등록 아니라면 수정--%>
										<c:choose>
											<c:when test="${vo eq null or vo.userTypeCode eq 'A'}">
												<input type="text" id="title" name="title" value="${vo.title}" class="form-control" maxlength="150" alt="제목" style="width:630px;">
											</c:when>
											<c:otherwise>
													${vo.title}
											</c:otherwise>
										</c:choose>
									</p>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label" for="content">링크 <i class="fa fa-check"></i></label>
								<div class="col-md-8">
									<div><input name="content" class="form-control" value="${vo.content}" alt="링크"/></div>
								</div>
							</div>
						</div>

						<div class="box-footer text-center">
							<button type="submit" class="btn btn-primary">
								<c:choose>
									<c:when test="${vo eq null}">등록하기</c:when>
									<c:otherwise>수정하기</c:otherwise>
								</c:choose>
							</button>
							<button type="button" class="btn btn-default" onClick="location.href='<c:choose><c:when test="${vo eq null}">/admin/about/board/detail/list/${commonBoardSeq}</c:when><c:otherwise>/admin/about/board/detail/view/${vo.seq}?commonBoardSeq=${vo.commonBoardSeq}</c:otherwise></c:choose>'">목록보기</button>
						</div>

						<c:choose>
							<c:when test="${commonBoardSeq eq 1 or vo.commonBoardSeq eq 1}"><input type="hidden" name="code" value="itemRequest"></c:when>
							<c:when test="${commonBoardSeq eq 2 or vo.commonBoardSeq eq 2}"><input type="hidden" name="code" value="sellerRequest"></c:when>
							<c:when test="${commonBoardSeq eq 3 or vo.commonBoardSeq eq 3}"><input type="hidden" name="code" value="socialNews"></c:when>
						</c:choose>
						
						<input type="hidden" name="noticeFlag" value="N" />
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
			if(flag && $(this).val() == "" || flag && $(this).val() == 0) {

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
