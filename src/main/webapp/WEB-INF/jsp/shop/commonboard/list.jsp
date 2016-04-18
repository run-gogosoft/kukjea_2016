<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/about/main.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/commonboard/list.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		.pagination {
			margin:2px 0 0 20px;
		}
	</style>
</head>
<body>
<c:choose>
	<c:when test="${vo.commonBoardSeq ge 3}">
		<%@ include file="/WEB-INF/jsp/shop/about/navigation.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="/WEB-INF/jsp/shop/include/navigation.jsp" %>
	</c:otherwise>
</c:choose>

<div class="ch-container" style="margin:0 auto">
<c:choose>
	<c:when test="${vo.commonBoardSeq eq 1}"><img src="${const.ASSETS_PATH}/front-assets/images/commonboard/item_reg.jpg" style="margin:0 auto" alt=""/></c:when>
	<c:when test="${vo.commonBoardSeq eq 2}"><img src="${const.ASSETS_PATH}/front-assets/images/commonboard/seller_reg.jpg" style="margin:0 auto" alt=""/></c:when>
</c:choose>
</div>

<div class="board-title">
	<div class="title">▣ ${title} 게시판 입니다.</div>
</div>

<div class="main-table" style="margin:0px auto 20px auto">
	<table class="table">
		<colgroup>
			<col width="5%"/>
			<col width="60%"/>
			<col width="10%"/>
			<col width="10%"/>
			<col width="10%"/>
		</colgroup>
		<thead>
			<tr>
				<td>#</td>
				<td>제목</td>
				<td>작성자</td>
				<td>등록일</td>
				<td>조회수</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${list}" varStatus="status">
				<c:if test="${item.noticeFlag eq 'Y'}">
					<tr>
						<td class="tr-notice"><strong>공지</strong></td>
						<td class="tr-notice text-left">
							<a href="/shop/about/board/detail/view/${item.seq}?commonBoardSeq=${vo.commonBoardSeq}"><strong>${item.title}</strong></a>
							<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
						</td>
						<td class="tr-notice">
							<c:choose>
								<c:when test="${item.userSeq eq null}">
									<strong>${item.userName}</strong>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${item.userTypeCode eq 'A'}">
											<strong>관리자</strong>
										</c:when>
										<c:otherwise>
											<strong>${item.memberName}</strong>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
						<td class="tr-notice"><strong>${fn:substring(item.regDate, 0, 10)}</strong></td>
						<td class="tr-notice"><strong>${item.viewCnt}</strong></td>
					</tr>
				</c:if>
			</c:forEach>
			<c:forEach var="item" items="${list}" varStatus="status">
				<c:if test="${item.noticeFlag eq 'N'}">
					<tr>
						<td>${total-item.rowNumber+1}</td>
						<td>
							<div class="text-left title-div">
								<a href="javascript:;" onclick="CHCommonBoardUtil.confirm('${item.secretFlag}', '${item.seq}', this, '${sessionScope.loginSeq}', '${item.userSeq}', '${item.userTypeCode}', '${vo.commonBoardSeq}')">
									${item.title}
									<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
									<c:if test="${cvo.commentUseFlag eq 'Y'}">[${item.commentCnt}]</c:if>
								</a>
								<c:if test="${item.secretFlag eq 'Y'}"><i class="fa fa-lock" style="margin-left:10px;color:#555"></i></c:if>
							</div>
						</td>
						<td>
							<c:choose>
								<c:when test="${item.userSeq eq null}">
									${item.userName}
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${item.userTypeCode eq 'A'}">
											관리자
										</c:when>
										<c:otherwise>
											${item.memberName}
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${fn:substring(item.regDate, 0, 10)}</td>
						<td>${item.viewCnt}</td>
					</tr>
				</c:if>
			</c:forEach>
			<c:if test="${fn:length(list) eq 0}">
				<tr><td colspan="5" style="height:70px">등록된 내용이 없습니다.</td></tr>
			</c:if>
		</tbody>
	</table>
</div>

<div class="ch-container" style="margin-bottom:120px">
	<div id="paging" class="pull-right"> ${paging} </div>
	<div class="pull-right total-count-title">
		현재 총 <span>${fn:length(list)}</span>건의 게시글이 있습니다.
	</div>
</div>

<c:if test="${vo.commonBoardSeq eq 1 or vo.commonBoardSeq eq 2}">
	<div class="button-wrap">
		<button class="btn btn-main" onclick="CHCommonBoardUtil.pageMove('${sessionScope.loginSeq}','${vo.commonBoardSeq}')">
			<span>
				<c:choose>
					<c:when test="${vo.commonBoardSeq eq 1}">
						상품등록 요청하기
					</c:when>
					<c:when test="${vo.commonBoardSeq eq 2}">
						입점문의
					</c:when>
				</c:choose>
			</span>
		</button>
	</div>
</c:if>

<div id="lockLayer" class="hh-writebox-lock">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header">
			비밀번호 확인
		</div>
		<div class="hh-writebox-content">
			<div style="font-size: 11px; list-style:none; padding:0; margin-left:10px;">
				<div style="text-indent: -11px">* 게시물의 열람을 원하시면 비밀번호를 입력하세요. </div>
			</div>

			<div style="text-align: center; margin-top:20px;">
				<table class="table">
					<tr>
						<td style="text-align:center; vertical-align:middle; width:120px;">
							<strong>비밀번호</strong><br/>
						</td>
						<td style="text-align: left;">
							<input type="password" id="lockPassword" name="password" class="form-control" maxlength="65" style="width:150px;" alt="비밀번호"/>
						</td>
					</tr>
				</table>
			</div>
			<div style="margin:10px 0 0 0;text-align: center">
				<button type="button" class="btn btn-info btn-default" onclick="CHCommonBoardUtil.submitProc('list');">확인</button>
				<button type="button" class="btn btn-default" onclick="CHCommonBoardUtil.close();">취소</button>
			</div>
		</div>
	</div>
</div>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/commonboard/commonboard.js"></script>
</body>
</html>