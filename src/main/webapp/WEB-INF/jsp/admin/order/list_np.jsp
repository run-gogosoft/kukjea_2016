<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
	<style type="text/css">
		.current-info:hover {
			color:#08C;
		}
	</style>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>후청구/방문결제 주문 리스트  <small>입금완료 현황</small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>판매 관리</li>
			<li class="active">주문 리스트</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<!--  검색 영역 -->
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<form class="form-horizontal" id="searchForm" method="get">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">주문일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${pvo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${pvo.searchDate2}">
									</div>
								</div>
								<div class="col-md-6 form-control-static">
									<button type="button" onclick="calcDate(0)" class="btn btn-success btn-xs">오늘</button>
									<button type="button" onclick="calcDate(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
									<button type="button" onclick="calcDate('clear')" class="btn btn-info btn-xs">전체</button>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">입금완료일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="npPayDate1" name="npPayDate1" value="${pvo.npPayDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="npPayDat2" name="npPayDate2" value="${pvo.npPayDate2}">
									</div>
								</div>
								<div class="col-md-6 form-control-static">
									<button type="button" onclick="calcDate2(0)" class="btn btn-success btn-xs">오늘</button>
									<button type="button" onclick="calcDate2(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="calcDate2(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="calcDate2(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="calcDate2(365)" class="btn btn-default btn-xs">1 년</button>
									<button type="button" onclick="calcDate2('clear')" class="btn btn-info btn-xs">전체</button>
								</div>
							</div>

							<div class="form-group">
								<label class="col-md-2 control-label">주문번호</label>
								<div class="col-md-2">
									<input class="form-control" type="text" name="orderSeq" value="${pvo.orderSeq}"	maxlength="20" onblur="numberCheck(this);"/>
								</div>	
								<label class="col-md-2 control-label">고객명</label>
								<div class="col-md-2">
									<select class="form-control" id="searchMember" name="searchMember" onchange="memberChange(this);">
										<option value="memberName" <c:if test="${pvo.searchMember eq 'memberName' or pvo.search eq ''}">selected</c:if>>주문자명</option>
										<option value="memberId" <c:if test="${pvo.searchMember eq 'memberId'}">selected</c:if>>주문자ID</option>
										<option value="receiverName" <c:if test="${pvo.searchMember eq 'receiverName'}">selected</c:if>>수령자</option>
									</select>
								</div>
								<div class="col-md-2">
									<input class="form-control" type="text" id="member"
										<c:choose>
											<c:when test="${pvo.searchMember eq 'memberName' or pvo.searchMember eq ''}">name="memberName" value="${pvo.memberName}"</c:when>
											<c:when test="${pvo.searchMember eq 'memberId'}">name="memberId" value="${pvo.memberId}"</c:when>
											<c:when test="${pvo.searchMember eq 'receiverName'}">name="receiverName" value="${pvo.receiverName}"</c:when>
										</c:choose>
									maxlength="20"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">결제수단</label>
								<div class="col-md-2">
									<select class="form-control" id="payMethod" name="payMethod">
										<option value="">---전체 선택---</option>
										<option value="OFFLINE" ${pvo.payMethod eq 'OFFLINE' ? 'selected':'' }>방문결제</option>
										<option value="NP_CARD" ${pvo.payMethod eq 'NP_CARD' ? 'selected':'' }>후청구(신용카드)</option>
										<option value="NP_CASH" ${pvo.payMethod eq 'NP_CASH' ? 'selected':'' }>후청구(무통장입금)</option>
									</select>
								</div>
								<label class="col-md-2 control-label">완료여부</label>
								<div class="col-md-2">
									<select class="form-control" name="npPayFlag">
										<option value="">---전체 선택---</option>
										<option value="N" ${pvo.npPayFlag eq 'N' ? 'selected':'' }>입금대기</option>
										<option value="Y" ${pvo.npPayFlag eq 'Y' ? 'selected':'' }>입금완료</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">기관명</label>
								<div class="col-md-2">
									<input class="form-control" type="text" name="groupName" value="${pvo.groupName}" maxlength="20"/>
								</div>	
								<label class="col-md-2 control-label">한페이지출력수</label>
								<div class="col-md-2">
									<select class="form-control" id="rowCount" name="rowCount">
										<option value="50" <c:if test="${pvo.rowCount eq '50'}">selected="selected"</c:if>>50개씩보기</option>
										<option value="100" <c:if test="${pvo.rowCount eq '100'}">selected="selected"</c:if>>100개씩보기</option>
										<option value="200" <c:if test="${pvo.rowCount eq '200'}">selected="selected"</c:if>>200개씩보기</option>
										<option value="500" <c:if test="${pvo.rowCount eq '500'}">selected="selected"</c:if>>500개씩보기</option>
									</select>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${pvo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<button type="button" onclick="downloadExcel()" class="btn btn-success btn-sm">엑셀다운로드</button>
								<button type="button" onclick="location.href='/admin/order/list/np'" class="btn btn-warning btn-sm">검색초기화</button>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!--소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3>
						<div class="pull-right">
						</div> -->
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered">
							<colgroup>
								<col style="width:5%"/>
								<col style="width:8%"/>
								<col style="width:8%"/>
								<col style="width:8%"/>
								<col style="width:7%"/>
								<col style="width:*"/>
								<col style="width:4%"/>
								<col style="width:5%"/>
								<col style="width:4%"/>
								<col style="width:4%"/>
								<col style="width:6%"/>
								<col style="width:7%"/>
								<col style="width:5%"/>
								<col style="width:6%"/>
								<col style="width:7%"/>
							</colgroup>
							<thead>
								<tr>
									<th>주문번호</th>
									<th>결제수단</th>
									<th>기관명</th>
									<th>주문자명</th>
									<th>
										수령자
										<div class="text-info">연락처</div>
									</th>
									<th>상품명</th>
									<th>부가세</th>
									<th>판매가</th>
									<th>수량</th>
									<th>배송비</th>
									<th>주문상태</th>
									<th>
										합계 금액
										<div class="text-info">결제(예정) 금액</div>
									</th>
									<th>처리 상태</th>
									<th>
										주문일자
										<div class="text-info">입금완료 일자</div>
									</th>
									<th>처리</th>
								</tr>
							</thead>
							<tbody id="order-list">
							<c:set var="i" value="0"/>
							<c:forEach var="item" items="${list}" varStatus="status">
								<tr data-tr-order-seq="${item.orderSeq}" style="height:50px;">
									<td class="text-center" data-order-seq="${item.orderSeq}">
										<a href="/admin/order/view/${item.orderSeq}?seq=${item.seq}" target="_blank">${item.orderSeq}</a>
									</td>
									<td class="text-center" data-pay-method-name="${item.orderSeq}">${item.payMethodName}</td>
									<td class="text-center" data-group-name="${item.orderSeq}">${item.groupName}</td>
									<td class="text-center" data-member-name="${item.orderSeq}">${item.memberName}</td>
									<td class="text-center" data-receiver-name="${item.orderSeq}">
										${item.receiverName}
										<div class="text-info">${item.receiverTel}</div>
									</td>
									<td data-item-name="${item.orderSeq}">
										${item.itemName}
										<c:if test="${item.optionValue ne ''}">
											(${item.optionValue})
										</c:if>
									</td>
									<td class="text-center" data-tax-name="${item.orderSeq}">${item.taxName}</td>
									<td class="text-right" data-sell-price="${item.orderSeq}"><fmt:formatNumber value="${item.sellPrice}"/></td>
									<td class="text-right" data-order-cnt="${item.orderSeq}"><fmt:formatNumber value="${item.orderCnt}"/></td>
									<td class="text-right" data-deli-cost="${item.orderSeq}"><fmt:formatNumber value="${item.deliCost}"/></td>
									<td class="text-center" data-status-text="${item.orderSeq}">${item.statusText}</td>
									<td class="text-right" data-total-price="${item.orderSeq}">
										<fmt:formatNumber value="${item.totalPrice}"/>
										<div class="text-info"><fmt:formatNumber value="${item.payPrice}"/></div>
									</td>
									<td class="text-center" data-np-pay-flag="${item.orderSeq}">
										<c:choose>
											<c:when test="${item.npPayFlag eq 'Y'}">
												<strong class="text-info">입금완료</strong>
											</c:when>
											<c:otherwise>
												<c:if test="${item.payPrice > 0}">
												<strong class='text-danger'>입금대기</strong>
												</c:if>
												<c:if test="${item.payPrice == 0}">
												<strong class='text-danger'>입금대기중<br/>취소</strong>
												</c:if>
											</c:otherwise>
										</c:choose>
									</td>																	
									<td class="text-center" data-np-date="${item.orderSeq}">
										${fn:substring(item.regDate,0,10)}
										<div class="text-info">${fn:substring(item.npPayDate,0,10)}</div>
									</td>
									<td class="text-center" data-proc-btn="${item.orderSeq}">
										<c:if test="${sessionScope.loginType eq 'A' and item.payPrice > 0 and !fn:contains(item.payMethod,'NP_CARD')}">
										<c:if test="${item.npPayFlag eq 'N'}">
											<button type="button" onclick="updateNpPayFlag(${item.orderSeq},'Y');" class="btn btn-xs btn-info">입금완료</button>
											</c:if>
											<c:if test="${item.npPayFlag eq 'Y'}">
											<button type="button" onclick="updateNpPayFlag(${item.orderSeq},'N');" class="btn btn-xs btn-danger">입금완료 취소</button>
											</c:if>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="15">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<form id="modForm" method="post" action="/admin/order/update/np" target="zeroframe">
	<input type="hidden" id="orderSeq" name="orderSeq" value=""/>
	<input type="hidden" id="npPayFlag" name="npPayFlag" value=""/>
	<input type="hidden" id="returnUrl" name="returnUrl" value=""/>
</form>

<input type="hidden" id="downloadFlag" value=""/>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="/assets/js/plugins/jquery.powertip.js"></script>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	/** 페이지 로딩시 초기화 */
	$(document).ready(function () {
		/* 날짜 검색 달력 기능 */
		showDatepicker("yy-mm-dd");

		if($('#search').val()=='seq' || $('#search').val()=='orderSeq' || $('#search').val()=='itemSeq') {
			$('#findword').add($('#findword').attr('onblur','numberCheck(this);'));
		}else{
			$('#findword').attr('onblur','');
		}

		//pvo.statusCode값이 null이 아니라면 상태가 검색된 상태이기 때문에 상태검색바를 보여준다.
		if("${pvo.statusCode}" !== '') {
			toggleSearchBar('statusSearchBar');
		}

		$('.current-info').each(function(){
			$(this).data('powertiptarget', 'ToolTipInfo'+$(this).attr('data-index'));
			$(this).powerTip({
				placement: 'w',
				offset:10,
				mouseOnToPopup: true
			})
		});
		
		<c:forEach var="item" items="${list}">
		mergeByOrderSeq('${item.orderSeq}');
		</c:forEach>

	});

	var goPage = function(page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	var statusSearch = function (arg) {
		$("#statusCode").val(arg);
		$("#searchForm").submit();
	};



	var toggleSearchBar = function(className) {
		if($('.'+className).css("display")==='none') {
			$('.'+className).show();
		} else {
			$('.'+className).hide();
		}
	};

	/** 입금완료 상태 일괄 변경 */
	var updateNpPayFlag = function(orderSeq, npPayFlag) {
		var confirmMsg = "입금완료 처리 하시겠습니까?";
		if(npPayFlag == 'N') {
			confirmMsg = "입금대기 상태로 되돌리시겠습니까?"
		}
		
		if(!confirm(confirmMsg)) {
			return;
		}
		
		$("#orderSeq").val(orderSeq);
		$("#npPayFlag").val(npPayFlag);
		$("#returnUrl").val( location.pathname + "?pageNum=" + ${pvo.pageNum} + "&" + $("#searchForm").serialize() );

		$("#modForm").submit();
	};

	/** 날짜 계산 */
	var calcDate = function(val) {
		if(val === "clear") {
			$("input[name=searchDate1]").val( '2014-01-01' );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		} else {
			$("input[name=searchDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		}
	};
	
	var calcDate2 = function(val) {
		if(val === "clear") {
			$("input[name=npPayDate1]").val( '2014-01-01' );
			$("input[name=npPayDate2]").val( moment().format("YYYY-MM-DD"));
		} else {
			$("input[name=npPayDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
			$("input[name=npPayDate2]").val( moment().format("YYYY-MM-DD"));
		}
	};

	var memberChange = function(obj) {
		$('#member').attr('name', obj.value);
	};

	//주문정보 cell 병합
	var mergeByOrderSeq = function(orderSeq) {
		var obj;
		var mergeAttrName = [
			"data-order-seq",
			"data-pay-method-name",
			"data-group-name",
			"data-member-name",
			"data-receiver-name",
			"data-total-price",
			"data-np-pay-flag",
			"data-np-date",
			"data-proc-btn"
		];
		
		for(var i=0; i < mergeAttrName.length; i++) {
			obj = "#order-list td["+mergeAttrName[i]+"='"+orderSeq+"']";
			if( $(obj).size() >= 2 ) {
				$(obj).each(function(idx) {
					if(idx === 0) {
						$(this).attr("rowspan", $(obj).size()).css("border-bottom","1px #ccc solid");
					} else {
						$(this).remove();
					}
				});
			} else {
				$(obj).each(function(idx) {
					if(idx == 0) {
						$(this).css("border-bottom","1px #ccc solid");
					}
				});
			}
		}
		
		var divAttrName = [
   			"data-item-name",
   			"data-tax-name",
   			"data-sell-price",
   			"data-order-cnt",
   			"data-deli-cost",
   			"data-status-text"
   		];
		
		for(var i=0; i < divAttrName.length; i++) {
			obj = "#order-list td["+divAttrName[i]+"='"+orderSeq+"']";
			$(obj).each(function(idx) {
				if($(obj).size() == idx+1) {
					$(this).css("border-bottom","1px #ccc solid");
				} 
			});
		}
		
	}
	
	var downloadExcel = function() {
		$("#searchForm").attr("action", "/admin/order/list/np/excel");
		$("#searchForm").submit();
		$("#searchForm").attr("action",location.pathname);
	}
	
</script>
</body>
</html>
