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
		<h1>${title} <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>게시판 관리</li>
			<li>${title}</li>
			<li class="active">정보 수정</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 소제목 -->
					<div class="box-header with-border"><h3 class="box-title"><i class="fa fa-edit"></i> ${title}</h3></div>
					<!-- 내용 -->
					<form id="write" class="form-horizontal" onsubmit="return submitProc(this);" method="post" action="<c:choose><c:when test="${vo eq null}">/admin/board/write/proc/${ boardGroup }</c:when><c:otherwise>/admin/board/edit/proc/${ boardGroup }/${ vo.seq }</c:otherwise></c:choose>" target="zeroframe" enctype="multipart/form-data">
						<div class="box-body">
						<c:set var="loginName" value="${sessionScope.loginName} &#40;${sessionScope.loginId}&#41;"/>
						<c:if test="${vo ne null }">
							<c:set var="loginName" value="${vo.name} &#40;${vo.id}&#41;"/>
						</c:if>
						<c:choose>
						<c:when test="${boardGroup eq 'notice'}">
							<div class="form-group">
								<label class="col-md-2 control-label" for="id">작성자</label>
								<div class="col-md-2 form-control-static">${loginName}</div>
							</div>
							<c:if test="${ vo ne null }">
								<div class="form-group">
									<label class="col-md-2 control-label">등록일</label>
									<div class="col-md-10">
										<p class="form-control-static">${fn:substring(vo.regDate, 0, 10)}</p>
									</div>
								</div>
							</c:if>
							<div class="form-group">
								<label class="col-md-2 control-label" for="title">제목 <i class="fa fa-check"></i></label>
								<div class="col-md-5">
									<input class="form-control" type="text" id="title" name="title" value="${ vo.title }" alt="제목" placeholder="글 제목을 입력해주세요"  maxlength="100"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="categoryCode">공지대상 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select class="form-control" id="categoryCode" name="categoryCode" alt="공지대상">
										<option value="">-- 선택 --</option>
										<option value="1" ${vo ne null && vo.categoryCode eq 1 ? "selected" :  ""}>고객</option>
										<option value="2" ${vo ne null && vo.categoryCode eq 2 ? "selected" :  ""}>입점업체</option>
									</select>
								</div>
							</div>
							<div id="mallShow" class="form-group" ${fn:length(mallList) <= 1 ? "style='display:none;'":""}>
								<label class="col-md-2 control-label" for="title">쇼핑몰 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select class="form-control" id="mallSeq" name="mallSeq">
										<option value="">-- 선택 --</option>
										<c:forEach var="list" items="${mallList}" >
											<option value="${list.seq}" ${list.seq eq vo.mallSeq ? "selected" :  ""}>${list.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="content">내용 <i class="fa fa-check"></i></label>
								<div class="col-md-8">
									<div><textarea name="content" class="textarea">${vo.content}</textarea></div>
								</div>
							</div>
						</c:when>
						<c:when test="${boardGroup eq 'one'}">
							<div class="form-group">
								<label class="col-md-2 control-label" for="id">작성자</label>
								<div class="col-md-2 form-control-static">${loginName}</div>
							<c:if test="${ vo ne null }">
								<label class="col-md-1 control-label">등록일</label>
								<div class="col-md-2">
									<p class="form-control-static">
										<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
										<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
									</p>
								</div>

							</c:if>
							</div>
							<c:if test="${vo.integrationSeq ne null}">
								<div class="form-group">
									<label class="col-md-2 control-label">주문번호</label>
									<div class="col-md-10">
										<a href="/admin/order/view/${vo.orderSeq}?seq=${vo.integrationSeq}">${vo.integrationSeq}</a>
									</div>
								</div>
			      		  	</c:if>
							<div class="form-group">
								<label class="col-md-2 control-label" for="categoryCode">구분 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select class="form-control" id="categoryCode" name="categoryCode" alt="구분">
										<option value="">-- 선택 --</option>
										<c:forEach var="item" items="${commonList}">
											<option value="${item.value}" <c:if test="${vo.categoryCode eq item.value}">selected</c:if>>${item.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<%-- <div class="form-group">
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-10"><p class="form-control-static">${ vo.mallName }</p></div>
							</div> --%>
							<div class="form-group">
								<label class="col-md-2 control-label" for="title">제목</label>
								<div class="col-md-5"><p class="form-control-static">${vo.title}</p></div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="">내용</label>
								<div class="col-md-10 form-control-static">
								  ${fn:replace(vo.content, newLine, "<br/>")}
								  <%-- 첨부파일이 존재할 경우 --%>
						          <c:if test="${vo.isFile eq 'Y'}">
						            <div style="padding:5px 15px 5px 0;">
						                <ul class="list-unstyled">
						                    <c:forEach var="item" items="${file}">
						                        <li>
						                            <a href="/admin/board/${boardGroup}/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">
						                                <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>
						                                    ${item.filename}
						                            </a>
						                        </li>
						                    </c:forEach>
						                </ul>
						            </div>
						          </c:if>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="answerSeq">답변자</label>
								<div class="col-md-10 form-control-static">
								<c:choose>
									<c:when test="${vo.answerSeq > 0 or vo.answerSeq ne null}">
										${vo.answerName}
										<input class="form-control" type="hidden" id="answerSeq" name="answerSeq" value="${ vo.answerSeq }"/>
									</c:when>
									<c:otherwise>
										${sessionScope.loginName}
										<input class="form-control" type="hidden" id="answerSeq" name="answerSeq" value="${ sessionScope.loginSeq }"/>
									</c:otherwise>
								</c:choose>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="answer">답변 <i class="fa fa-check"></i></label>
								<div class="col-md-5">
									<textarea class="form-control" rows="10" id="answer" name="answer" alt="답변"><c:if test="${vo.answer eq ''}">[함께누리를 이용해주셔서 감사합니다.]</c:if>${ vo.answer }</textarea>
								</div>
							</div>
						</c:when>
						<c:when test="${boardGroup eq 'faq'}">
							<div class="form-group">
								<label class="col-md-2 control-label" for="id">작성자</label>
								<div class="col-md-10 form-control-static">${loginName}</div>
							</div>
							<c:if test="${ vo ne null }">
								<div class="form-group">
									<label class="col-md-2 control-label">등록일</label>
									<div class="col-md-10 form-control-static">${fn:substring(vo.regDate,0,10)}</div>
								</div>
							</c:if>
							<div class="form-group">
								<label class="col-md-2 control-label" for="categoryCode">구분 <i class="fa fa-check"></i></label>
								<div class="col-md-2">
									<select class="form-control" id="categoryCode" name="categoryCode" alt="구분">
										<option value="">-- 선택 --</option>
										<option value="10" ${vo ne null && vo.categoryCode eq 10 ? "selected" : ""}>회원</option>
										<option value="20" ${vo ne null && vo.categoryCode eq 20 ? "selected" : ""}>주문/결제/배송</option>
										<option value="30" ${vo ne null && vo.categoryCode eq 30 ? "selected" : ""}>환불/취소/재고</option>
										<option value="40" ${vo ne null && vo.categoryCode eq 40 ? "selected" : ""}>영수증</option>
										<option value="50" ${vo ne null && vo.categoryCode eq 50 ? "selected" : ""}>이벤트</option>
										<option value="60" ${vo ne null && vo.categoryCode eq 60 ? "selected" : ""}>기타</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="title">제목 <i class="fa fa-check"></i></label>
								<div class="col-md-5">
									<input class="form-control" type="text" id="title" name="title" value="${ vo.title }" alt="제목" placeholder="글 제목을 입력해주세요" maxlength="100"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="content">내용 <i class="fa fa-check"></i></label>
								<div class="col-md-8">
									<div><textarea name="content" class="textarea">${vo.content}</textarea></div>
								</div>
							</div>
						</c:when>
						<c:when test="${boardGroup eq 'qna'}">
							<div class="form-group">
								<label class="col-md-2 control-label" for="id">작성자</label>
								<div class="col-md-2 form-control-static">${loginName}</div>
							<c:if test="${ vo ne null }">
								<label class="col-md-1 control-label">등록일</label>
								<div class="col-md-2 form-control-static">
									<fmt:parseDate value="${ vo.regDate }" var="regDate" pattern="yyyy-mm-dd"/>
									<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
								</div>
							</c:if>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">상품명</label>
								<div class="col-md-10 form-control-static">
									<img src="${const.UPLOAD_PATH}${fn:replace(vo.img1, 'origin', 's206')}" style="width:70px;"/>
									<a href="/admin/item/view/${ vo.integrationSeq }" target="_blank">${vo.itemName}</a>
								</div>
							</div>
							<%-- <div class="form-group">
								<label class="col-md-2 control-label">쇼핑몰</label>
								<div class="col-md-10"><p class="form-control-static">${ vo.mallName }</p></div>
							</div> --%>
							<div class="form-group">
								<label class="col-md-2 control-label" for="title">제목</label>
								<div class="col-md-10"><p class="form-control-static">${ vo.title }</p></div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="content">내용</label>
								<div class="col-md-10"><p class="form-control-static">${fn:replace(vo.content, newLine, "<br/>")}</p></div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="answerSeq">답변자</label>
								<div class="col-md-10">
									<p class="form-control-static">
								<c:choose>
									<c:when test="${vo.answerSeq > 0 or vo.answerSeq ne null}">
										${ vo.answerName }
										<input class="form-control" type="hidden" id="answerSeq" name="answerSeq" value="${ vo.answerSeq }"/>
									</c:when>
									<c:otherwise>
										${ sessionScope.loginName }
										<input class="form-control" type="hidden" id="answerSeq" name="answerSeq" value="${ sessionScope.loginSeq }"/>
									</c:otherwise>
								</c:choose>
									</p>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label" for="answer">답변 <i class="fa fa-check"></i></label>
								<div class="col-md-5">
									<textarea class="form-control" rows="10" id="answer" name="answer" alt="답변"><c:if test="${vo.answer eq ''}">[함께누리를 이용해주셔서 감사합니다.]</c:if>${ vo.answer }</textarea>
								</div>
							</div>
						</c:when>
					</c:choose>
						</div>

					<div><hr style="margin:0"/><span class="glyphicon glyphicon-floppy-disk" style="margin-left:10px; margin-right:5px; font-size:16px" aria-hidden="true"></span><span style="font-size:18px; color:inherit">파일 첨부</span><span style="margin-left:10px; font-size:12px; color:#A94442">최대 250MB까지 업로드하실 수 있습니다</span><hr style="margin:0 0 15px 0"/></div>
						<div class="form-group">
							<label class="col-md-2 control-label">파일 첨부</label>
							<div class="col-md-5">
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
				                                  <a href="/admin/board/${boardGroup}/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">[다운로드]</a>
			                                    <a href="/admin/board/${boardGroup}/file/delete/proc?seq=${vo.seq}&num=${item.num}" class="text-danger" onclick="return confirm('정말로 이 파일을 삭제하시겠습니까?');" target="zeroframe">[삭제]</a>
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
							<c:choose>
								<c:when test="${vo eq null}">
									<button type="submit" class="btn btn-primary" >등록하기</button>
								</c:when>
								<c:otherwise>
									<button type="submit" class="btn btn-primary" >
										<c:choose>
											<c:when test="${boardGroup eq 'qna' || boardGroup eq 'one'}">답변하기</c:when>
											<c:otherwise>수정하기</c:otherwise>
										</c:choose>
									</button>
								</c:otherwise>
							</c:choose>
							<button type="button" class="btn btn-default" onClick="goCancelNotice('${boardGroup}')">목록보기</button>
						</div>

						<input type="hidden" name="code" value="${boardGroup}">
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
            <input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted" style="display:inline-block; width:262px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
        </div>
    </div>
</script>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<!-- CK Editor -->
<script type="text/javascript" src="/assets/ckeditor/ckeditor.js"></script>

<script type="text/javascript" src="/assets/js/libs/summernote.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		CKEDITOR.replace('content',{
        	width:'100%',
        	height:'500',
        	filebrowserImageUploadUrl: '/admin/editor/upload'
        });
	});

	var callbackProc = function(num) {
		$('.file-wrap'+num).remove();
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

	var mallShow = function(){
		if($('#categoryCode').val()==1){
			$('#mallShow').show();
		}else if($('#categoryCode').val()==2){
			$('#mallSeq').val('');
			$('#mallShow').hide();
		}
	}

	var submitProc = function(obj) {
		var flag = true;
		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {

				alert($(this).attr("alt") + "란을 채워주세요!");
				flag = false;
				$(this).focus();
			}
		});
		return flag;
	};

	var goCancelNotice = function(arg1){
		$("#flag").val("N");
		location.href = "/admin/board/list/"+arg1;

	};

	var goDeleteNotice = function(arg1,arg2){
		if(confirm("정말 삭제 하시겠습니까?")){
			location.href = "/admin/board/del/proc/"+arg1+"/"+arg2;
		}
	};
	
	var callbackProc = function(msg) {
		if(msg.split("^")[0] === "EDITOR") {
			CKEDITOR.tools.callFunction(msg.split("^")[1], msg.split("^")[2], '이미지를 업로드 하였습니다.')
		} 
	};
</script>
</body>
</html>
