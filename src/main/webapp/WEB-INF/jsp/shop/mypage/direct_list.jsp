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

		<div class="board-title">▣ 1:1문의 내역 입니다.</div>
		<div class="board-title-sub" style="margin-bottom:0;">
			<div>궁금하신 부분을 남겨주세요. 함게누리 담당자가 최선을다해 신속하게 답변드리도록 하겠습니다.</div>
		</div>
		<%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>

		<div style="float:right; margin-bottom:10px; font-size:12px; color:#707070">* 답변을 확인하고 싶으시면 <div class="answer-box" style="display:inline-block; cursor:default;">미답변</div> <div class="answer-box" style="display:inline-block; margin-left:3px; cursor:default;">답변완료</div> 버튼을 클릭하세요.</div>
		<div class="main-table" style="margin-bottom:20px;">
			<table class="table">
				<colgroup>
					<col width="10%"/>
					<col width="20%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<td>번호</td>
						<td>구분</td>
						<td>제목</td>
						<td>등록일</td>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}" varStatus="status">
						<tr>
							<td>${total-item.rowNumber+1}</td>
							<td>
								<c:forEach var="commonItem" items="${commonList}">
									<c:if test="${item.categoryCode eq commonItem.value}">${commonItem.name}</c:if>
								</c:forEach>
							</td>
							<td class="text-left">
								<a href="/shop/mypage/direct/edit/form/${item.seq}" style="color: #636363;">${item.title}</a>
								<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
							</td>
							<td>
								<fmt:parseDate value="${item.regDate}" var="regDate" pattern="yyyy-mm-dd"/>
								<fmt:formatDate value="${regDate}" pattern="yyyy-mm-dd"/>
							</td>
							<td>
								<div class="answer-box">
									<c:choose>
									<c:when test="${item.answerFlag eq 2}">
										<div class="answer-box" onclick="CHToggleUtil.toggleContent('qna_c${status.count}');">미답변</div>
									</c:when>
									<c:when test="${item.answerFlag eq 1}">
										<div class="answer-box" onclick="CHToggleUtil.toggleAnswer('qna_c${status.count}','qna_a${status.count}');">답변완료</div>
									</c:when>
								</c:choose>
								</div>
							</td>
						</tr>
						<tr style="height: 100px; display: none;" id="qna_c${status.count}">
							<td style="text-align: center;border-right: none; background-color:#F8F8F8;"><i class="fa fa-comment-o fa-3x" style="color: #C2C2C2;"></i></td>
							<td colspan="5" style="text-align: left;color: #636363;background-color:#F8F8F8;">${fn:replace(item.content, newLine, "<br/>")}</td>
						</tr>
						<tr style="height: 100px; display: none;" id="qna_a${status.count}">
							<td style="text-align: center;border-right: none; background-color:#F8F8F8;"><img src="${const.ASSETS_PATH}/front-assets/images/common/answer.png" alt="" /></td>
							<td colspan="5" style="text-align: left;color: #636363;background-color:#F8F8F8;">${fn:replace(item.answer, newLine, "<br/>")}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) == 0}">
						<tr><td colspan="5" class="text-center non-row">등록된 내용이 없습니다.</td></tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<div id="paging" class="pull-right">${paging}</div>
		<div class="pull-right total-count-title">
			고객님은 현재 총 <span>${fn:length(list)}</span>건의 내역이 있습니다.
		</div>

		<div class="button-wrap">
			<div class="inner"><button class="btn btn-buy" onclick="location.href='/shop/mypage/direct/form'"><span>1:1 질문하기</span></button></div>
		</div>
	</div>
</div>
<div class="clearfix"></div>
<div class="hh-writebox">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header"><span class="title">1:1문의</span></div>
		<div class="hh-writebox-content">
			<form class="form-horizontal" name="directForm" role="form" method="post" onsubmit="return submitProc(this);" action="/shop/mypage/direct/proc" target="zeroframe">
				<input type="hidden" name="userSeq" value="${sessionScope.loginSeq}"/>

				<div class="hh-writebox-text-check">
					<br/>
					<p>◇ 사이트 이용 관련 문의나 의견을 등록하시면 빠른 시일내에 답변을 드립니다.</p>
					<p>◇ 문의에 대한 답변은 이메일에서 확인하시거나 마이페이지 에서 확인하실 수 있습니다.</p>
				</div>

				<div class="hh-writebox-answer">
					<div class="input-group">
						<span class="input-group-addon" style="width: 152px; height:26px; font-size:12px;">구분</span>
						<select name="categoryCode" id="" class="form-control" style="display:inline-block; width:152px; height:26px; border:1px solid #CCC; font-size:12px; margin-left:0; padding:3px 12px;">
							<option value="">-- 선택 --</option>
							<option value="200">주문배송</option>
							<option value="201">주문취소</option>
							<option value="202">주문반품</option>
							<option value="203">주문교환</option>
							<option value="204">기타</option>
						</select>
					</div>

					<div class="input-group">
						<span class="input-group-addon" style="width:152px; font-size:12px;">제목</span>
						<input type="text" id="directTitle" class="form-control" name="title" maxlength="15" style="width:343px; height:26px; font-size:12px;" alt="제목"/>
					</div>
					<div class="input-group" style="height: 303px;">
						<span class="input-group-addon" style="width:152px; height:303px; line-height:275px;"><p>문의내용</p></span>
						<textarea id="directContent" class="form-control" name="content" style="width:343px; height: 303px; resize: none; font-size:12px;" alt="문의내용"></textarea>
					</div>
				</div>

				<div class="hh-writebox-customer">
					<span class="customer-title">고객정보</span>
					<hr style="margin-bottom: 0;" />
					<table class="table">
						<tr>
							<td>고객명</td>
							<td>${sessionScope.loginName}</td>
						</tr>
					</table>
				</div>

				<div class="hh-writebox-footer">
					<div class="inner">
						<button type="submit" id="submitBtn" class="btn btn-qna-submit">등록하기</button>
						<button type="button" onclick="CHBoardUtil.writeClose()" class="btn btn-qna-cancel">취소하기</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/mypage/direct.js"></script>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page +"&" + $("#search_form").serialize();
	};

	$(document).ready(function() {
		$('.datepicker').datepicker();
		$("#paging>ul").addClass("ch-pagination");
	});
</script>
</body>
</html>