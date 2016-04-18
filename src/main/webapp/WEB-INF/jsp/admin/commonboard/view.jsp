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
		<h1>${vo.name} 게시판 상세 정보<small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>about 사회적경제</li>
			<li>게시판 관리</li>
			<li>${vo.name} 게시판</li>
			<li class="active">${vo.name} 게시판 상세 정보</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-newspaper-o"></i>${vo.name} 게시판 상세 정보</h3>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<table id="view1" class="table table-bordered">
							<colgroup>
								<col style="width:20%;"/>
								<col style="width:80%;"/>
							</colgroup>
							<tbody>
								<tr>
									<th>등록일</th>
									<td>${fn:substring(vo.regDate, 0, 10)}</td>
								</tr>
								<tr>
									<th>조회수</th>
									<td>${vo.viewCnt}</td>
								</tr>
								<tr>
									<th>작성자</th>
									<td>
										<c:choose>
											<c:when test="${vo.userSeq eq null}">
												${vo.userName}(회원)
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
									</td>
								</tr>
								<tr>
									<th>공지 여부</th>
									<td>
										<c:choose>
											<c:when test="${vo.noticeFlag eq 'Y'}">
												공지글
											</c:when>
											<c:otherwise>
												일반글
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>비밀글 여부</th>
									<td>
										<c:choose>
											<c:when test="${vo.secretFlag eq 'Y'}">
												비밀글
											</c:when>
											<c:otherwise>
												공개글
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
								<tr>
									<th>제목</th>
									<td>${vo.title}</td>
								</tr>
								<tr>
									<th>내용</th>
									<td>
										<%-- 첨부파일이 존재할 경우 --%>
					          <c:if test="${vo.isFile eq 'Y'}">
					            <div style="padding:5px 15px 5px 0;">
					                <ul class="list-unstyled">
					                    <c:forEach var="item" items="${file}">
					                        <li>
					                            <a href="/admin/about/board/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
					                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
					                                    ${item.filename}
					                            </a>
					                        </li>
					                    </c:forEach>
					                </ul>
					            </div>
					          </c:if>
										<iframe id="content_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
									</td>
								</tr>

								<c:if test="${vo ne null and vo.userTypeCode ne 'A'}">
									<tr>
										<th>답변여부</th>
										<td>
											<c:choose>
												<c:when test="${vo.answerFlag eq 'Y'}">
													답변
												</c:when>
												<c:otherwise>
													미답변
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:if>

								<c:if test="${vo.answerFlag eq 'Y'}">
									<tr>
										<th>답변자</th>
										<td>${vo.answerName}</td>
									</tr>
									<tr>
										<th>답변</th>
										<td>
											<iframe id="answer_view" src="/content_view.jsp" scrolling="no" style="border:0;width:100%;height:0;"></iframe>
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<div class="box-footer text-center">
							<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2)}">
								<a href="/admin/about/board/detail/edit/${vo.seq}?commonBoardSeq=${vo.commonBoardSeq}" class="btn btn-sm btn-info">수정하기</a>
							</c:if>
							<button type="button" class="btn btn-sm btn-danger" onclick="showDeleteModal();">삭제하기</button>
							<button type="button" class="btn btn-sm btn-default" onclick="location.href='/admin/about/board/detail/list/${vo.commonBoardSeq}'">목록보기</button>
						</div>
				</div>
			</div>
		</div>
	</section>
	
	<c:if test="${cvo.commentUseFlag eq 'Y'}">
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<div class="box-header with-border">
						<h3 class="box-title"><i class="fa fa-newspaper-o"></i>댓글</h3>
					</div>
					<form id="commentForm" role="form" action="/admin/about/board/detail/comment/insert" onsubmit="return isValidCommentForm();" target="zeroframe" method="post">
						<div class="well">
							<div class="form-group">
								<label for="content">댓글 쓰기 <i data-code="content" class="fa fa-check-square-o"></i></label>
								<button type="submit" class="pull-right btn btn-xs btn-default"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 등록</button>
								<textarea id="content" name="content" class="form-control" rows="3" style="margin-top:10px;"></textarea>
							</div>
						</div>
						<input type="hidden" name="commonBoardSeq" value="${vo.commonBoardSeq}" />
						<input type="hidden" name="boardSeq" value="${vo.seq}" />
					</form>
					<!-- 내용 -->
					<div class="box-body">
						<table class="table table-bordered">
							<colgroup>
								<col style="width:15%;"/>
								<col style="width:60%;"/>
								<col style="width:15%;"/>
								<col style="width:10%;"/>
							</colgroup>
							<tbody>
								<c:forEach var="item" items="${clist}">
								<tr>
									<th>${item.userName}</th>
									<td>
										<div style="white-space:pre">${item.content}</div>
										
									</td>
									<td class="text-center">
										${item.regDate}
									</td>
									<td class="text-center">
										<button type="button" class="btn btn-danger btn-sm" onclick="showCommentDeleteModal(${item.seq});">
											삭제
										</button>
									</td>
								</tr>
								</c:forEach>
								<c:if test="${fn:length(clist) eq 0}">
								<tr><td colspan="3" class="text-center text-muted">등록된 댓글이 없습니다</td></tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	</c:if>
</div>

<%-- 삭제 모달 --%>
<div id="myModal" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="padding:1px 15px; background-color:#D73925; color:#fff">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h3 id="myModalLabel" style="margin-top:15px;">경고</h3>
			</div>
			<div class="modal-body">
				<p>정말 삭제 하시겠습니까?</p>
			</div>
			<div class="modal-footer">
				<button class="btn btn-default" data-dismiss="modal" aria-hidden="true">닫기</button>
				<a href="#myModal2" onclick="confirmDelete('${vo.seq}','${vo.commonBoardSeq}');" role="button" class="btn btn-danger" data-dismiss="modal" data-toggle="modal">삭제하기</a>
			</div>
		</div>
	</div>
</div>

<div id="iframe_content" style="display:none">${vo.content}</div>
<div id="iframe_content_answer" style="display:none">${vo.answer}</div>

<!-- 템플릿 호출  -->
<%@ include file="/WEB-INF/jsp/admin/include/member_view_tmpl.jsp" %>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script type="text/javascript">
	$(window).load(function() {
		//글내용
		$("#content_view").contents().find("body").html($("#iframe_content").html());
		$("#content_view").height($("#content_view").contents().find("body")[0].scrollHeight + 30);
		
		<c:if test="${vo.answerFlag eq 'Y'}">
		//답변
		$("#answer_view").contents().find("body").html($("#iframe_content_answer").html());
		$("#answer_view").height($("#answer_view").contents().find("body")[0].scrollHeight + 30);
		</c:if>
	});
	var showDeleteModal = function() {
		$("#myModal").modal("show");
	}

	var confirmDelete = function(seq, commonBoardSeq) {
		location.href="/admin/about/board/detail/delete/proc?seq="+seq+"&commonBoardSeq="+commonBoardSeq;
	}
	
	function showCommentDeleteModal(seq) {
		if(confirm("정말로 삭제하시겠습니까?\n이 과정은 복구할 수 없습니다")) {
			$('#zeroframe').attr("src", "/admin/about/board/detail/comment/delete?seq="+seq);
		}
	}
</script>
</body>
</html>
