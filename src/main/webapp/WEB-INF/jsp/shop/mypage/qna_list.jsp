<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/qna.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		.pagination {
			margin:2px 0 0 20px;
		}

		.mypage-search-bar {
			margin-top:50px;
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

		<div class="board-title">▣  상품문의 내역 입니다.</div>
		<div class="board-title-sub" style="border-bottom:0;">
			<div>고객님이 상품상세에서 상품에 대해 질문하신 내용과 답변을 확인할 수 있습니다.</div>
			<div>상품과 관련없는 내용, 비방, 광고, 불건전한 내용의 글은 사전 동의 없이 삭제될 수 있습니다.</div>
		</div>

		<%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>

		<div style="float:right; margin-bottom:10px; font-size:12px; color:#707070">* 답변을 확인하고 싶으시면 <div class="answer-box" style="display:inline-block; cursor:default;">미답변</div> <div class="answer-box" style="display:inline-block; margin-left:3px; cursor:default;">답변완료</div> 버튼을 클릭하세요.</div>
		<div class="main-table" style="margin-bottom:20px;">
			<table class="table">
				<colgroup>
					<col width="10%"/>
					<col width="8%"/>
					<col width="15%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="5%"/>
				</colgroup>
				<thead>
					<tr>
						<td>번호</td>
						<td colspan="2">상품명</td>
						<td>제목</td>
						<td>등록일</td>
						<td>답변여부</td>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${list}" varStatus="status">
						<tr>
							<td>${total-item.rowNumber+1}</td>
							<td class="text-center">
								<c:if test="${item.img1 ne ''}">
									<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(item.img1, '/origin/', '/s206/')}" style="width:70px;height:70px;border:1px solid #d7d7d7;" alt="" />
								</c:if>
							</td>
							<td class="text-left">${item.itemName}</td>
							<td class="text-center">
								<a href="/shop/mypage/qna/edit/form/${item.seq}" style="color: #636363;">${item.title}</a>
								<c:if test="${item.isFile eq 'Y'}"><span class="glyphicon glyphicon-floppy-disk" style="margin-left:5px" aria-hidden="true"></span></c:if>
							</td>
							<td>${fn:substring(item.regDate, 0, 10)}</td>
							<td>
								<c:choose>
									<c:when test="${item.answerFlag eq 2}">
										<div class="answer-box" onclick="CHToggleUtil.toggleContent('qna_c${status.count}');">미답변</div>
									</c:when>
									<c:when test="${item.answerFlag eq 1}">
										<div class="answer-box" onclick="CHToggleUtil.toggleAnswer('qna_c${status.count}','qna_a${status.count}');">답변완료</div>
									</c:when>
								</c:choose>
							</td>
							<td>
								<div class="item-delete" onclick="delProc('${item.seq}')"><i class="fa fa-times fa-2x" style="color:#fff"></i></div>
							</td>
						</tr>
						<tr style="height: 100px; display: none;" id="qna_c${status.count}">
							<td style="text-align: center;border-right: none;background-color:#D5D5D5;"><i class="fa fa-comment-o fa-3x" style="color: #C2C2C2;"></i>
							</td>
							<td colspan="6" style="text-align: left;color: #636363;background-color:#D5D5D5;">${fn:replace(item.content, newLine, "<br/>")}</td>
						</tr>
						<tr style="height: 100px; display: none;" id="qna_a${status.count}">
							<td style="text-align: center;border-right: none;background-color:#D5D5D5;"><img src="${const.ASSETS_PATH}/front-assets/images/common/answer.png" alt="" /></td>
							<td colspan="6" style="text-align: left;color: #636363;background-color:#D5D5D5;">
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
								${fn:replace(item.answer, newLine, "<br/>")}
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) == 0}">
						<tr><td colspan="7" class="text-center non-row">등록된 내용이 없습니다.</td></tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<div id="paging" class="pull-right">${paging}</div>
		<div class="pull-right total-count-title">
			고객님은 현재 총 <span>${fn:length(list)}</span>건의 내역이 있습니다.
		</div>

	</div>
</div>
<div class="clearfix"></div>

<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page +"&" + $("#search_form").serialize();
	};

	var delProc = function(seq) {
		if(confirm('정말 삭제하시겠습니까?')) {
			location.href='/shop/mypage/qna/del/proc?seq='+seq
		}
	}

	CHToggleUtil = {
		toggleContent:function(content) {
			if($('#'+content).css("display")=='none') {
				$('#'+content).show();
			} else {
				$('#'+content).hide();
			}
		}
		, toggleAnswer:function(content, answer) {
			if($('#'+content).css("display")=='none') {
				$('#'+content).show();
				$('#'+answer).show();
			} else {
				$('#'+content).hide();
				$('#'+answer).hide();
			}
		}
	};
</script>
</body>
</html>