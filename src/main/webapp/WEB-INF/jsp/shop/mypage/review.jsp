<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/mypage.css" type="text/css" rel="stylesheet">
	<link href="${const.ASSETS_PATH}/front-assets/css/mypage/review.css" type="text/css" rel="stylesheet">
	<title>${title}</title>

	<style type="text/css">
		.pagination {
			margin:2px 0 0 20px;
		}

		.review-search-wrap {
			margin-top:70px;
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
			홈 <span class="breadcrumb-arrow">&gt;</span> 마이페이지 <span class="breadcrumb-arrow">&gt;</span> 구매정보 <span class="breadcrumb-arrow">&gt;</span> <strong>나의 상품후기</strong>
		</div>
		<div class="line"></div>

		<%@ include file="/WEB-INF/jsp/shop/include/popup.jsp" %>

		<%--
		<div class="board-title">▣ 나의 상품평 입니다.</div>
		<div class="board-title-sub" style="margin-bottom:0;">
			<div>배송완료 상태의 상품에 대해서 상품평을 작성하실 수 있습니다.</div>
		</div>

		<div class="main-table" style="margin:30px 0 20px; 0">
			<table class="table">
				<colgroup>
					<col width="15%"/>
					<col width="8%"/>
					<col width="*"/>
					<col width="15%"/>
				</colgroup>
				<thead>
					<tr>
						<td>주문번호(주문일자)</td>
						<td colspan="2">상품정보</td>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${detailList}" varStatus="status">
						<div class="hh-writebox review-layer${status.count}" style="z-index: 100;">
							<div class="hh-writebox-wrap">
								<div class="hh-writebox-header"><span class="title">상품평</span></div>
								<div class="hh-writebox-content">
									<form class="form-horizontal" name="directForm" role="form" method="post" action="/shop/mypage/review/reg/proc" onsubmit="return submitProc(this);" target="zeroframe">
										<input type="hidden" name="itemSeq" value="${vo.itemSeq}"/>
										<input type="hidden" name="statusCode" value="50"/>
										<input type="hidden" name="detailSeq" value="${vo.seq}"/>

										<div class="ch-writebox-item-info">
											<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img1, '/origin/', '/s206/')}" style="display:inline-block;width:70px;height:70px;border:1px solid #CCC;" alt="" />
											<div style="height:120px;display:inline-block;margin-left:18px;">
												<span class="ch-item-name">${vo.itemName}</span><br/>
												<span class="ch-item-value-name">
													<c:if test="${vo.valueName ne ''}">
														옵션:&nbsp;<span class="option-name">${vo.valueName}</span>
													</c:if>
												</span>
											</div>
										</div>

										<hr/>

										<div class="ch-item-rating-wrap">
											<div class="col-md-5" style="padding:0;margin:0;width:190px;">
												<div class="start-back">
													<div class="star">
														<div class="star-left-1 star-left"></div>
														<div class="star-right-1 star-right"></div>
													</div>
													<div class="star">
														<div class="star-left-2 star-left"></div>
														<div class="star-right-2 star-right"></div>
													</div>
													<div class="star">
														<div class="star-left-3 star-left"></div>
														<div class="star-right-3 star-right"></div>
													</div>
													<div class="star">
														<div class="star-left-4 star-left"></div>
														<div class="star-right-4 star-right"></div>
													</div>
													<div class="star">
														<div class="star-left-5 star-left"></div>
														<div class="star-right-5 star-right"></div>
													</div>
												</div>
											</div>

											<div class="col-md-3 ch-item-rating">
												<span id="itemRating">0</span>
												<span style="font-size:14px;">/5점</span>
											</div>

											<div class="col-md-4 ch-item-rating-select" style="padding-left:10px;">
												<input type="radio" name="goodGrade" class="goodGrade" value="1" onclick="CHBoardUtil.selectRate(this)">1점
												<input type="radio" name="goodGrade" class="goodGrade" value="2" onclick="CHBoardUtil.selectRate(this)">2점
												<input type="radio" name="goodGrade" class="goodGrade" value="3" onclick="CHBoardUtil.selectRate(this)">3점
												<input type="radio" name="goodGrade" class="goodGrade" value="4" onclick="CHBoardUtil.selectRate(this)">4점
												<input type="radio" name="goodGrade" class="goodGrade" value="5" onclick="CHBoardUtil.selectRate(this)">5점
											</div>
										</div>

										<div class="hh-writebox-answer">
											<div class="input-group" style="height: 260px;">
												<span class="input-group-addon" style="width: 154px; height:260px; line-height:200px;"><p>상품평</p></span>
												<!-- <span id="contentLength" style="color:#00bff3;">0</span>&nbsp;/&nbsp;<span style="font-size:12px;">500자</span></span> -->
												<textarea id="reviewContent" class="form-control" name="review" style="display:inline-block; height: 260px; resize: none;" alt="상품평"></textarea>
											</div>
										</div>

										<div class="hh-writebox-footer">
											<div class="inner">
												<button type="submit" id="submitBtn" class="btn btn-qna-submit">등록하기</button>
												<button type="button" onclick="CHBoardUtil.writeClose()" class="btn btn-qna-cancel">취소하기</button>
											</div>
										</div>
									</form>

									<div class="hh-writebox-text-check" style="width:500px;">
										<br/>
										<p style="width:500px;">◇ 사이트 이용 관련 문의나 의견을 등록하시면 빠른 시일내에 답변을 드립니다.</p>
										<p style="width:500px;">◇ 문의에 대한 답변은 이메일에서 확인하시거나 마이페이지 에서 확인하실 수 있습니다.</p>
									</div>
								</div>
							</div>
						</div>
						<tr>
							<td data-merge-flag="${vo.orderSeq}">
								(${vo.orderSeq})<br/>
								${fn:substringBefore(vo.regDate,' ')}
							</td>
							<td>
								<c:if test="${vo.img1 ne ''}">
									<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img1, '/origin/', '/s206/')}" style="width:70px;height:70px;border:1px solid #CCC" alt="" />
								</c:if>
							</td>
							<td class="text-left item-name">
								${vo.itemName}<br/>
								<c:if test="${vo.valueName ne ''}">
									옵션:&nbsp;${vo.valueName}
								</c:if>
							</td>
							<td>
								<button class="btn-xs btn-review" onclick="CHBoardUtil.writeButton('${status.count}')" >상품평 쓰기</button>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(detailList) eq 0}">
						<tr><td colspan="5" class="text-center non-row" style="height:50px;">등록된 내용이 없습니다.</td></tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<div class="paging" style="float:right">${detailPaging}</div>
		<div class="pull-right total-count-title">
			고객님은 현재 미등록 상품평이 총 <span>${fn:length(detailList)}</span>건 있습니다.
		</div>
		--%>

		<div class="review-search-wrap" style="margin-top:0; border-top:0;">
			<div class="board-title">▣ 내가 작성한 상품후기 입니다.</div>

			<div class="inner" style="margin:0">
				<%@ include file="/WEB-INF/jsp/shop/include/mypage_search.jsp" %>
			</div>
		</div>

		<div class="main-table" style="margin:80px 0 20px; 0">
			<table class="table">
				<colgroup>
					<col width="15%"/>
					<col width="8%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="15%"/>
				</colgroup>
				<thead>
					<tr>
						<td>주문번호(주문일자)</td>
						<td colspan="2">상품정보</td>
						<td>평점</td>
						<td></td>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vo" items="${list}" varStatus="status">
						<tr>
							<td>
								(${vo.orderSeq})<br/>
								${fn:substringBefore(vo.regDate,' ')}
							</td>
							<td>
								<c:if test="${vo.img1 ne ''}">
									<img src="${const.IMG_DOMAIN}${const.UPLOAD_PATH}${fn:replace(vo.img1, '/origin/', '/s206/')}" style="width:70px;height:70px;border:1px solid #CCC" alt="" />
								</c:if>
							</td>
							<td class="text-left item-name">
									<a href="/shop/detail/${vo.itemSeq}" >${vo.itemName}</a><br/>
									<c:if test="${vo.valueName ne ''}">
										옵션:&nbsp;<span class="option-name">${vo.valueName}</span>
									</c:if>
							</td>
							<td class="good-grade">
								<smp:reviewStar max="5" value="${vo.goodGrade}" />
							</td>
							<td>
								<button class="btn-xs btn-review" onclick="CHToggleUtil.toggleDisplay('review_${status.count}');">상품후기 보기</button>
							</td>
						</tr>
						<tr style="height: 123px; display: none; background-color: #f7f7f7;" id="review_${status.count}">
							<td style="border-right: none;">
								<i class="fa fa-pencil-square-o fa-3x"></i>
							</td>
							<td colspan="5" style="text-align: left;">${fn:replace(vo.review, newLine, "<br/>")}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) == 0}">
							<tr><td colspan="5" class="text-center non-row" style="height:50px;">등록된 내용이 없습니다.</td></tr>
						</c:if>
				</tbody>
			</table>
		</div>

		<div class="paging" style="float:right">${paging}</div>
		<div class="pull-right total-count-title">
			고객님은 현재 작성한 상품후기가 총 <span>${fn:length(list)}</span>건 있습니다.
		</div>
		<div class="clearfix"></div>
	</div>
</div>
<div class="clearfix"></div>
<%@ include file="/WEB-INF/jsp/shop/include/footer.jsp" %>
<script type="text/javascript" src="/front-assets/js/mypage/mypage.js"></script>
<script type="text/javascript" src="/front-assets/js/mypage/review.js"></script>
<script type="text/javascript">
	var goPage = function (page) {
		location.href = location.pathname + "?pageNum=" + page+"&" + $("#search_form").serialize();
	};
</script>
</body>
</html>