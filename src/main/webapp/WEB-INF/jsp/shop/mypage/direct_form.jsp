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
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 나의정보 <span class="breadcrumb-arrow">&gt;</span> <strong>나의 1:1 문의내역</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<div class="board-title">▣ 1:1문의 입니다.</div>
		<div class="board-title-sub" style="margin-bottom:0;">
			<div>궁금하신 부분을 남겨주세요. 함게누리 담당자가 최선을다해 신속하게 답변드리도록 하겠습니다.</div>
		</div>

		<form class="form-horizontal" role="form" method="post" onsubmit="return submitProc(this);" action="<c:choose><c:when test="${vo eq null}">/shop/mypage/direct/reg/proc</c:when><c:otherwise>/shop/mypage/direct/mod/proc</c:otherwise></c:choose>" target="zeroframe" enctype="multipart/form-data">
			<input type="hidden" name="seq" value="${vo.seq}">
			<%--개인회원--%>
			<div class="sign-form form1" style="height:570px">
				<div class="inner">
					<div class="title-back">
						<div class="title-wrap">
							<div class="title">1:1문의 <c:choose><c:when test="${vo eq null}">등록하기</c:when><c:otherwise>수정하기</c:otherwise></c:choose></div>
							<div class="sub-description"><span>*</span>&nbsp;표시는 필수입력 항목이오니 반드시 입력해 주세요.</div>
						</div>
					</div>
					<table id="defaultTable" class="table sign-table">
						<tr>
							<td>구분<span>*</span></td>
							<td>
								<select name="categoryCode" id="categoryCode" class="form-control" style="display:inline-block; width:152px; height:26px; border:1px solid #CCC; font-size:12px; margin-left:0; padding:3px 12px;">
									<option value="">-- 선택 --</option>
									<c:forEach var="item" items="${commonList}">
										<option value="${item.value}" <c:if test="${vo.categoryCode eq item.value}">selected</c:if>>${item.name}</option>
									</c:forEach>
							</td>
						</tr>
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
			                            <input type="file" onchange="checkFileSize(this);" id="file1" name="file1" class="text-muted" style="display:inline-block; width:282px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
			                        </div>
			                    </div>
			                </c:if>
			                <c:if test="${vo ne null}">
			                    <c:forEach var="item" items="${file}">
			                        <div class="file-wrap${item.num}">
			                            <div class="form-group">
			                                <span class="btn btn-default btn-file">
			                                    <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
			                                    <input type="file" onchange="checkFileSize(this);" id="file${item.num}" name="file${item.num}" class="text-muted" style="display:inline-block; width:282px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
			                                </span>
			                                <label></label>
			                                <p class="help-block" style="padding-left: 40px">
			                                        ${item.filename} 파일이 등록되어 있습니다
			                                    <a href="/shop/mypage/direct/file/download/proc?seq=${vo.seq}&num=${item.num}" target="zeroframe">[다운로드]</a>
			                                    <a href="/shop/mypage/direct/file/delete/proc?seq=${vo.seq}&num=${item.num}" onclick="return confirm('정말로 이 파일을 삭제하시겠습니까?');" class="text-danger" target="zeroframe">[삭제]</a>
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

			<div class="button-wrap">
				<button type="submit" class="btn btn-confirm">
					<span>
						<c:choose>
							<c:when test="${vo eq null}">
								등록하기
							</c:when>
							<c:otherwise>
								수정하기
							</c:otherwise>
						</c:choose>
					</span>
				</button>
				<button type="button" class="btn btn-cancel" onclick="history.back()"><span>목록으로</span></button>
			</div>

			<input type="hidden" name="code" value="directBoard">
		</form>
	</div>
</div>

<script id="FileTemplate" type="text/html">
    <div>
        <div class="form-group">
            <label></label>
            <i class="fa fa-2x fa-cloud-upload text-muted" style="float:left; margin-top:10px;"></i>&nbsp;
            <input type="file" onchange="checkFileSize(this);" id="file<%="${num}"%>" name="file<%="${num}"%>" class="text-muted" style="display:inline-block; width:282px; height: auto;padding: 6px 16px; border: 3px #ddd dotted;border-radius:10px;"/>
        </div>
    </div>
</script>

<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/direct.js"></script>
</body>
</html>