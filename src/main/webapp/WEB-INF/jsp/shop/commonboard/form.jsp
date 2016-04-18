<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/about/main.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/member/member.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/commonboard/form.css" type="text/css" rel="stylesheet">
	<title>${title}</title>
</head>
<body>
<c:choose>
	<c:when test="${commonBoardSeq eq 3 or vo.commonBoardSeq eq 3}">
		<%@ include file="/WEB-INF/jsp/shop/about/navigation.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>
	</c:otherwise>
</c:choose>

<div class="main-title">
	<c:choose><c:when test="${vo eq null}">${title}</c:when><c:otherwise>${vo.name}</c:otherwise></c:choose>
</div>

<form class="form-horizontal" action="<c:choose><c:when test="${vo eq null}">/shop/about/board/detail/reg/proc</c:when><c:otherwise>/shop/about/board/detail/edit/proc</c:otherwise></c:choose>" method="post" target="zeroframe" onsubmit="return CHBoardUtil.submitProc(this, '${sessionScope.loginSeq}')" enctype="multipart/form-data">
	<input type="hidden" name="commonBoardSeq" value="<c:choose><c:when test="${vo eq null}">${commonBoardSeq}</c:when><c:otherwise>${vo.commonBoardSeq}</c:otherwise></c:choose>">
	<c:if test="${vo ne null}">
		<input type="hidden" name="seq" value="${vo.seq}">
	</c:if>
	<div class="sign-form form1">
		<div class="inner">
			<div class="title-back">
				<div class="title-wrap">
					<div class="title"><c:choose><c:when test="${vo eq null}">${title}</c:when><c:otherwise>${vo.name}</c:otherwise></c:choose></div>
					<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
				</div>
			</div>
			<table class="table sign-table">
				<tr>
					<td>이름<span>*</span></td>
					<td>
						<c:choose>
							<c:when test="${vo eq null}">
								<%--commonBoardSeq가 2이라면 입점문의이다.--%>
								<c:choose>
									<c:when test="${commonBoardSeq eq 1}">
										${sessionScope.loginName}
									</c:when>
									<c:when test="${commonBoardSeq eq 2}">
										<c:choose>
											<c:when test="${sessionScope.loginSeq > 0}">
												${sessionScope.loginName}
											</c:when>
											<c:otherwise>
												<input type="text" id="userName" name="userName" value="${vo.userName}" class="form-control" maxlength="6" alt="이름" style="width:150px;">
											</c:otherwise>
										</c:choose>
									</c:when>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${vo.userSeq eq null}">
										${vo.userName}
									</c:when>
									<c:otherwise>
										${vo.memberName}
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>

						<input type="checkbox" class="checkbox" id="secretFlag" style="vertical-align:none" onclick="CHBoardUtil.secretCheck(this, '${sessionScope.loginSeq}')" <c:if test="${vo.secretFlag eq 'Y'}">checked</c:if>/> 비밀글 설정
						<input type="hidden" id="postSecretFlag" name="secretFlag" value="<c:choose><c:when test="${vo eq null}">N</c:when><c:otherwise>${vo.secretFlag}</c:otherwise></c:choose>">
					</td>
				</tr>
				<tr id="passTr" <c:if test="${vo.secretFlag ne 'Y'}">class="hide"</c:if>>
					<td>비밀번호<span>*</span></td>
					<td><input type="password" id="userPassword" name="userPassword" class="form-control" maxlength="150"></td>
				</tr>
				<tr>
					<td>제목<span>*</span></td>
					<td><input type="text" id="title" name="title" value="${vo.title}" class="form-control" maxlength="150" alt="제목" style="width:630px;"></td>
				</tr>
				<tr>
					<td>내용<span>*</span></td>
					<td>
						<textarea class="form-control" name="content" value="${vo.content}" rows="8" style="resize:none; font-size:12px;" alt="내용">${vo.content}</textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>

	<c:if test="${commonBoardSeq eq 1 or vo.commonBoardSeq eq 1}">
		<div class="sign-form form6">
			<div class="inner" style="height:auto;">
				<div class="title-back">
					<div class="title-wrap">
						<div class="title">파일첨부</div>
						<div class="sub-description">최대 250MB까지 업로드하실 수 있습니다</div>
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
		                                    <a href="/shop/about/board/file/delete/proc?seq=${vo.seq}&num=${item.num}" onclick="return confirm('정말로 이 파일을 삭제하시겠습니까?');" target="zeroframe" class="text-danger">[삭제]</a>
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
	</c:if>

	<div class="button-wrap">
		<%-- <c:if test="${sessionScope.loginSeq > 0}"> --%>
			<button type="submit" class="btn btn-confirm">
				<span>
					<c:choose>
						<c:when test="${vo eq null}">등록하기</c:when>
						<c:otherwise>수정하기</c:otherwise>
					</c:choose>
				</span>
			</button>
		<%--</c:if>--%>
		<button type="button" class="btn btn-cancel" onclick="history.back()"><span>돌아가기</span></button>
	</div>

	<input type="hidden" name="code" value="itemRequest">
</form>

<script id="FileTemplate" type="text/html">
    <div>
        <div class="form-group">
            <label></label>
            <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
            <input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted" style="display:inline-block; width:450px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
        </div>
    </div>
</script>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/commonboard/commonboard.js"></script>
</body>
</html>