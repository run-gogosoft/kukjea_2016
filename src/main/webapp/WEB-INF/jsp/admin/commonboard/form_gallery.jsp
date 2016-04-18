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

							<%-- 작성된 글이 회원&비회원 글이라면 공지여부 항목을 보여주지 않는다. --%>
							<%-- <c:if test="${vo eq null or vo.userTypeCode eq 'A'}">
								<div class="form-group">
									<label class="col-md-2 control-label">공지여부</label>
									<div class="col-md-10">
										<p class="form-control-static">
											<input type="radio" name="noticeFlag" value="Y" style="vertical-align:none;margin:0;" <c:if test="${vo.noticeFlag eq 'Y'}">checked</c:if>/> 공지글
											<input type="radio" name="noticeFlag" value="N" style="vertical-align:none;margin:0 0 0 10px;" <c:if test="${vo.noticeFlag eq 'N'}">checked</c:if>/> 일반글
										</p>
									</div>
								</div>
							</c:if> --%>
							<input type="hidden" name="noticeFlag" value="N" />

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

							<input type="hidden" name="content" value=".${vo.content}" />
							<%-- <div class="form-group">
								<label class="col-md-2 control-label" for="content">내용 <i class="fa fa-check"></i></label>
								<div class="col-md-8">
									<div><textarea name="content" class="textarea">${vo.content}</textarea></div>
								</div>
							</div> --%>

							<%--관리자가 쓴 글이 아닐경우에만 답변 항목을 보여준다.--%>
							<c:if test="${vo ne null and vo.userTypeCode ne 'A'}">
								<div class="form-group">
									<label class="col-md-2 control-label" for="answer">답변 <i class="fa fa-check"></i></label>
									<div class="col-md-8">
										<textarea class="form-control" rows="10" id="answer" name="answer" style="resize:none;">${vo.answer}</textarea>
									</div>
								</div>
							</c:if>
						</div>

						<div class="box">
							<div class="box-header with-border"><h3 class="box-title"><i class="fa fa-cloud-upload text-muted" style="margin-right:5px;"></i>파일첨부</h3></div>
							<div class="box-body">
								<div id="fileDiv">
			            <div id="FileList" style="padding-left: 15px;">
			                <c:if test="${vo eq null}">
			                    <div>
			                        <div class="form-group">
			                            <label></label>
			                            <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
			                            <input type="file" onchange="checkFileSize(this);" id="file1" name="file1" class="text-muted" style="display:inline-block; width:450px;height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
			                        </div>
			                    </div>
			                </c:if>
			                <c:if test="${vo ne null}">
			                    <c:forEach var="item" items="${file}">
			                        <div class="file-wrap${item.num}">
			                            <div class="form-group">
			                                <span class="btn btn-default btn-file">
			                                    <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
			                                    <input type="file" onchange="checkFileSize(this);" id="file${item.num}" name="file${item.num}" class="text-muted" style="display:inline-block; width:450px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
			                                </span>
			                                <label></label>
			                                <p class="help-block" style="padding-left: 40px">
			                                        ${item.filename} 파일이 등록되어 있습니다
			                                    <a href="/admin/about/board/file/delete/proc?seq=${vo.seq}&num=${item.num}" onclick="return confirm('정말로 이 파일을 삭제하시겠습니까?');" class="text-danger" target="zeroframe">[삭제]</a>
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
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

<script id="FileTemplate" type="text/html">
    <div>
        <div class="form-group">
            <label></label>
            <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
            <input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted" style="display:inline-block; width:450px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
        </div>
    </div>
</script>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>

<!-- CK Editor -->
<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>

<script type="text/javascript" src="/assets/js/libs/summernote.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		/* CKEDITOR.replace('content',{
        	width:'100%',
        	height:'500',
        	filebrowserImageUploadUrl: '/admin/editor/upload'
        });
		
		CKEDITOR.replace('answer',{width:'100%', height:'400'}); */
	});
	
	var submitProc = function(obj) {
		var flag = true;


		<c:if test="${vo eq null and vo.userTypeCode eq 'A'}">
			if($(':radio[name="noticeFlag"]:checked').val() === undefined){
				alert("공지여부를 선택해주세요");
				flag = false;
			}
		</c:if>

		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if(flag && $(this).val() == "" || flag && $(this).val() == 0) {

				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});
		return flag;
	};

	var callbackProc = function(msg) {
		if(msg.split("^")[0] === "EDITOR") {
			CKEDITOR.tools.callFunction(msg.split("^")[1], msg.split("^")[2], '이미지를 업로드 하였습니다.');
		} else {
			$('.file-wrap'+msg).remove();	
		}
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
</script>
</body>
</html>
