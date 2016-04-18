<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/direct.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		.pagination {
			margin:2px 0 0 20px;
		}

		#popup-zone {
      margin-top:-5px;
    }
	</style>
</head>
<body>
<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>

<div class="body-wrap">
	<%@ include file="/WEB-INF/jsp/shop/include/mypage_left.jsp" %>

	<div class="main-content-wrap">
		<div class="breadcrumb">
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 나의정보 <span class="breadcrumb-arrow">&gt;</span> <strong>상품Q&amp;A</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 상품문의 내역 입니다.</div>

		<form class="form-horizontal" role="form" method="post" onsubmit="return submitProc(this);" action="/shop/mypage/qna/mod/proc" target="zeroframe" enctype="multipart/form-data">
			<input type="hidden" name="seq" value="${vo.seq}">
			<%--개인회원--%>
			<div class="sign-form form1" style="height:510px">
				<div class="inner">
					<div class="title-back">
						<div class="title-wrap">
							<div class="title">상품문의 수정하기</div>
							<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
						</div>
					</div>
					<table id="defaultTable" class="table sign-table">
						<tr>
							<td>제목<span>*</span></td>
							<td><input type="text" class="form-control" name="title" value="${vo.title}" style="font-size:12px;" maxlength="15" alt="제목"/></td>
						</tr>
						<tr>
							<td>문의내용<span>*</span></td>
							<td>
								<textarea class="form-control" name="content" style="height: 303px; resize: none; font-size:12px;" alt="문의내용">${vo.content}</textarea>
							</td>
						</tr>
					</table>
				</div>
			</div>

			<c:if test="${vo ne null}">
				<c:if test="${fn:length(file) > 0}">
					<div class="sign-form form6">
						<div class="inner" style="height:auto;">
							<div class="title-back">
								<div class="title-wrap">
									<div class="title">파일첨부</div>
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
					                            <input type="file" onchange="checkFileSize(this);" id="file1" name="file1" class="text-muted" style="display:inline-block; width:282px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
					                        </div>
					                    </div>
					                </c:if>
					                <c:if test="${vo ne null}">
					                    <c:forEach var="item" items="${file}">
					                        <div class="file-wrap${item.num}">
					                            <div class="form-group">
					                                <label></label>
					                                <p class="help-block" style="padding-left: 40px">
					                                        ${item.filename} 파일이 등록되어 있습니다
					                                    <a href="/shop/mypage/direct/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">[다운로드]</a>
					                                </p>
					                            </div>
					                        </div>
					                    </c:forEach>
					                </c:if>
					            </div>
						        </div>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</c:if>
			</c:if>

			<div class="button-wrap">
				<button type="submit" class="btn btn-confirm"><span>수정하기</span></button>
				<button type="button" class="btn btn-cancel" onclick="history.back()"><span>목록으로</span></button>
			</div>
		</form>
	</div>
</div>

<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/direct.js"></script>
<script type="text/javascript">
var submitProc = function(obj) {
	var flag = true;
	$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
		if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {
			alert($(this).attr("alt") + "란을 입력해주세요!");
			flag = false;
			$(this).focus();
		}
	});
	return flag;
};
</script>
</body>
</html>