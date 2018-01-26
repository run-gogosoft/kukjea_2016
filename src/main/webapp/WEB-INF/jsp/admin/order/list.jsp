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
<c:choose>
	<c:when test="${sessionScope.loginType eq 'S'}">
		<body class="skin-green sidebar-mini">
	</c:when>
	<c:otherwise>
		<body class="skin-blue sidebar-mini">
	</c:otherwise>
</c:choose>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>주문 리스트  <small>주문 내역 조회 및 상태 일괄 업데이트 페이지</small></h1>
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
				<%@ include file="/WEB-INF/jsp/admin/include/order_search_form.jsp" %>
				<div class="box">
					<!--소제목 -->
					<div class="box-header with-border">
						<!-- <h3 class="box-title"></h3> -->
						<!-- 주문 상태별 건수 -->
						<table class="table table-bordered" style="margin-bottom:20px;">
							<colgroup>
								<col style="width:16%;"/>
								<col style="width:16%;"/>
								<col style="width:16%;"/>
								<col style="width:16%;"/>
								<col style="width:16%;"/>
								<col style="width:16%;"/>
							</colgroup>
							<tr>
								<td class="text-center" style="background-color:#ff9999"><b><a href="javascript:toggleSearchBar('statusSearchBar');">결제완료</a></b></td>
								<td class="text-center" style="background-color:#ffcc99"><b><a href="javascript:toggleSearchBar('statusSearchBar');">주문확인</a></b></td>
								<td class="text-center" style="background-color:#ffffcc"><b><a href="javascript:toggleSearchBar('statusSearchBar');">배송</a></b></td>
								<td class="text-center" style="background-color:#ccff99"><b><a href="javascript:toggleSearchBar('statusSearchBar');">교환</a></b></td>
								<td class="text-center" style="background-color:#99ffff"><b><a href="javascript:toggleSearchBar('statusSearchBar');">반품</a></b></td>
								<td class="text-center" style="background-color:#99ccff"><b><a href="javascript:toggleSearchBar('statusSearchBar');">취소</a></b></td>
							</tr>
							<tr class="statusSearchBar" style="display:none;">
								<td class="text-center"><i class="fa fa-fw fa-shopping-cart"></i> <a href="#" onclick="statusSearch('10');" <c:if test="${pvo.statusCode eq 10}">style="color:#d9534f;font-weight:bold;"</c:if>>결제완료</a></td>
								<td class="text-center"><i class="fa fa-fw fa-edit"></i> <a href="#" onclick="statusSearch('20');" <c:if test="${pvo.statusCode eq 20}">style="color:#d9534f;font-weight:bold;"</c:if>>주문확인</a></td>
								<td class="text-center"><i class="fa fa-fw fa-truck"></i> <a href="#" onclick="statusSearch('30');" <c:if test="${pvo.statusCode eq 30}">style="color:#d9534f;font-weight:bold;"</c:if>>배송중</a></td>
								<td class="text-center"><i class="fa fa-fw fa-phone"></i> <a href="#" onclick="statusSearch('60');" <c:if test="${pvo.statusCode eq 60}">style="color:#d9534f;font-weight:bold;"</c:if>>교환요청</a></td>
								<td class="text-center"><i class="fa fa-fw fa-phone"></i> <a href="#" onclick="statusSearch('70');" <c:if test="${pvo.statusCode eq 70}">style="color:#d9534f;font-weight:bold;"</c:if>>반품요청</a></td>
								<td class="text-center"><i class="fa fa-fw fa-remove"></i> <a href="#" onclick="statusSearch('90');" <c:if test="${pvo.statusCode eq 90}">style="color:#d9534f;font-weight:bold;"</c:if>>취소요청</a></td>
							</tr>
							<tr class="statusSearchBar" style="display:none;">
								<td></td>
								<td></td>
								<td class="text-center"><i class="fa fa-fw fa-check"></i> <a href="#" onclick="statusSearch('50');" <c:if test="${pvo.statusCode eq 50}">style="color:#d9534f;font-weight:bold;"</c:if>>배송완료</a></td>
								<td class="text-center"><i class="fa fa-fw fa-exchange"></i> <a href="#" onclick="statusSearch('61');" <c:if test="${pvo.statusCode eq 61}">style="color:#d9534f;font-weight:bold;"</c:if>>교환 진행중</a></td>
								<td class="text-center"><i class="fa fa-fw fa-repeat"></i> <a href="#" onclick="statusSearch('71');" <c:if test="${pvo.statusCode eq 71}">style="color:#d9534f;font-weight:bold;"</c:if>>반품 진행중</a></td>
								<td class="text-center"><i class="fa fa-fw fa-check"></i> <a href="#" onclick="statusSearch('99');" <c:if test="${pvo.statusCode eq 99}">style="color:#d9534f;font-weight:bold;"</c:if>>취소완료</a></td>
							</tr>
							<tr class="statusSearchBar" style="display:none;">
								<td></td>
								<td></td>
								<td></td>
								<td class="text-center"><i class="fa fa-fw fa-check"></i> <a href="#" onclick="statusSearch('69');" <c:if test="${pvo.statusCode eq 69}">style="color:#d9534f;font-weight:bold;"</c:if>>교환완료</a></td>
								<td class="text-center"><i class="fa fa-fw fa-check"></i> <a href="#" onclick="statusSearch('79');" <c:if test="${pvo.statusCode eq 79}">style="color:#d9534f;font-weight:bold;"</c:if>>반품완료</a></td>
								<td></td>
							</tr>
						</table>
						<!--div class="pull-left" style="margin:10px 0 0 10px">
								<i class="fa fa-user"></i>개인회원&nbsp;
								<i class="fa fa-user-plus text-primary"></i>기업/시설/단체&nbsp;
								<i class="fa fa-user-secret text-warning"></i>공공기관회원
						</div-->
						<div class="pull-right">
							<%-- <c:if test="${sessionScope.loginType eq 'A'}">
								<button type="button" onclick="updateStatus('10');" class="btn btn-sm btn-warning">입금확인</button>
							</c:if> --%>
							<c:if test="${sessionScope.loginType eq 'A' or sessionScope.loginType eq 'S'}">
								<button type="button" onclick="updateStatus('20');" class="btn btn-sm btn-info">주문확인</button>
								<button type="button" onclick="updateStatus('30');" class="btn btn-sm btn-danger">발송처리</button>
								<button type="button" onclick="updateStatus('50');" class="btn btn-sm btn-success">배송완료</button>
							</c:if>
						</div>
					</div>
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<form id="modForm" method="post" action="/admin/order/status/update/batch" target="zeroframe" onsubmit="return doSubmit(this)">
							<input type="hidden" name="updateStatusCode" value=""/>
							<input type="hidden" name="returnUrl" value=""/>
						<table id="list1" class="table table-bordered table-striped">
							<colgroup>
								<col style="width:2%;"/>
								<col style="width:5%;"/>
								<col style="width:5%;"/>
								<col style="width:5%;"/>
								<col style="width:8%"/>
								<col style="width:7%;"/>
								<col style="width:7%;"/>
								<col style="width:*"/>
								<col style="width:*"/>
								<col style="width:4%"/>
								<col style="width:5%"/>
								<col style="width:5%"/>
								<col style="width:6%"/>
								<col style="width:7%"/>
								<col style="width:10%;"/>
								<col style="width:8%"/>
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="all_chk" <c:if test="${sessionScope.loginType ne 'A' and sessionScope.loginType ne 'S'}">disabled</c:if>/></th>
									<th>
										주문일자
										<div class="text-primary">비교견적</div>
									</th>
									<th>상품<br/>주문번호</th>
									<th>주문번호</th>
									<th>기관명<br/><span class="text-primary">부서명</span></th>
									<th>
										주문상태<br/>
										<span class="text-primary">결제수단</span><br/>
										<%-- <c:if test="${sessionScope.loginType eq 'A'}">결제장비</c:if> --%>
									</th>
									<th>
										주문자<br/>
										<span class="text-primary">수령자</span>
									</th>
									<th>
										상품명 / 옵션
										<div class="text-primary">부가세</div>
									</th>
									<th>옵션</th>
									<th>수량</th>
									<th>
										판매단가
										<div class="text-primary">판매원가</div>
									</th>
									<th>합계</th>
									<th>배송비</th>
									<th>이벤트</th>
									<th>송장번호</th>
									<th>
										<div class="text-primary">입점업체명</div>
										담당자 연락처
									</th>
								</tr>
							</thead>
							<tbody>
							<c:set var="i" value="0"/>
							<c:forEach var="item" items="${list}" varStatus="status">
								<%--<tr ${item.deliSeq == null ? "":"style='background-color:#f7df56'"}>--%>
								<tr style="background-color:${item.bgColor}">
								<%--<tr ${item.statusText == "결제완료" ? style='background-color:#ff9999':--%>
										<%--(item.statusText == "주문확인" ? style='background-color:#ffcc99':style='background-color:#f7df56')}>--%>
									<td class="text-center">
										<input type="checkbox" name="seq" value="${item.seq}" data-value="${i}" <c:if test="${pvo.statusCode ne 30}">onclick="toggleDeliField(this.checked,${i})"</c:if> <c:if test="${sessionScope.loginType ne 'A' and sessionScope.loginType ne 'S'}">disabled</c:if>/>
										<%-- <input type="hidden" name="orderSeq" value="${item.orderSeq}"/> --%>
									</td>
									<td class="text-center">
										${fn:substring(item.regDate,0,10)}
										<div class="text-primary">
											<c:choose>
												<c:when test="${item.estimateCompareCnt > 0}">완료</c:when>
												<c:otherwise>
													${item.estimateCompareFlag eq 'Y' ? "접수":""}
												</c:otherwise>
											</c:choose>
										</div>
									</td>
									<td class="text-center">
										<a href="/admin/order/view/${item.orderSeq}?seq=${item.seq}">${item.seq}</a>
									</td>
									<td class="text-center">${item.orderSeq}</td>
									<td class="text-center">
										${item.groupName}<br/>
										<span class="text-primary">${item.deptName}</span>
									</td>
									<td class="text-center">
										<input type="hidden" name="statusCode" value="${item.statusCode}"/>
										<strong>${item.statusText}</strong><br/>
										<span class="text-primary">
											<c:choose>
												<c:when test="${item.payMethod eq ''}">제휴사 결제</c:when>
												<c:otherwise>
													${item.payMethodName}
												</c:otherwise>
											</c:choose>
										</span>
										<%-- <c:if test="${sessionScope.loginType eq 'A'}">
										<br/>
											<c:choose>
												<c:when test="${item.deviceType eq 'M'}">모바일</c:when>
												<c:otherwise>일반</c:otherwise>
											</c:choose>
										</c:if> --%>
									</td>
									<td class="text-center">
									<c:choose>
										<c:when test="${item.memberTypeCode eq 'P'}"><i class="fa fa-user-secret text-warning"></i></c:when>
										<c:when test="${item.memberTypeCode eq 'O'}"><i class="fa fa-user-plus text-primary"></i></c:when>
										<c:otherwise><i class="fa fa-user"></i></c:otherwise>
									</c:choose>
										${item.memberName}<br/>
										<span class="text-primary">${item.receiverName}</span>
									</td>
									<td>
										${item.itemName}<br/>
										<div class="text-primary">${item.taxName}</div>
									</td>
									<td>${item.optionValue}</td>
									<td class="text-right"><fmt:formatNumber value="${item.orderCnt}"/></td>
									<td class="text-right">
										<fmt:formatNumber value="${item.sellPrice}"/><br/>
										<div class="text-primary"><fmt:formatNumber value="${item.orgPrice}"/></div>
									</td>
									<td class="text-right">
										<fmt:formatNumber value="${((item.sellPrice) * item.orderCnt)}"/><br/>
										<div class="text-primary"><fmt:formatNumber value="${((item.orgPrice) * item.orderCnt)}"/></div>
									</td>
									<td class="text-right">
										<c:choose>
											<c:when test="${((item.sellPrice) * item.orderCnt) >= 50000}">
												무료배송
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${item.freeDeli eq 'Y'}">무료배송</c:when>
													<c:otherwise>선결제</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</td>
									<td class="text-right">
										<c:choose>
											<c:when test="${item.eventAdded !='' && item.eventAdded !=' ' && item.eventAdded !='0'}">${item.eventAdded}</c:when>
											<c:otherwise>이벤트없음</c:otherwise>
										</c:choose>
									</td>
									<td>
										<select name="deliSeq" alt="택배사" style="margin-bottom:3px;width:100%" disabled>
											<option value="">-----택배사 선택-----</option>
											<c:forEach var="deliItem" items="${deliCompanyList}">
												<option value="${ deliItem.deliSeq }" ${item.deliSeq == deliItem.deliSeq ? "selected" :  ""}>${deliItem.deliCompanyName} <c:if test="${deliItem.useFlag eq 'N'}">(사용안함)</c:if></option>
											</c:forEach>
										</select><br/>
										<input type="text" name="deliNo" value="${item.deliNo}" maxlength="15" alt="송장번호" onblur="numberCheck(this);" placeholder="송장번호(숫자만입력)" style="width:100%" disabled/>
										<input type="text" name="boxCnt" value="${item.boxCnt}" maxlength="5" alt="총박스수" onblur="numberCheck(this);" placeholder="총박스(숫자만입력)" style="width:100%" disabled/>
										<input type="text" name="totalDeliCost" value="${item.totalDeliCost}" maxlength="11" alt="총배송금액" onblur="numberCheck(this);" placeholder="총배송금액(숫자만입력)" style="width:100%" disabled/>
									</td>
									<td class="text-center">
										<a href="/admin/seller/mod/${item.sellerSeq}" target="_blank">${item.sellerName}</a>
										<div>${item.salesTel}</div>
									</td>
								</tr>
								<c:set var="i" value="${i+1}"/>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="16">등록된 내용이 없습니다.</td></tr>
							</c:if>
							</tbody>
						</table>
						</form>
						<div class="dataTables_paginate paging_simple_numbers text-center">${paging}</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
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

		
		/** 리스트 전체 선택/해제 */
		$("#all_chk").click(function() {
			var checked = $("#all_chk").prop("checked");
			$("input[name='seq']").prop("checked", checked);
			<c:if test="${pvo.statusCode ne 30}">
			/* 송장입력 필드 활성/비활성화 */
			toggleDeliField(checked, null);
			</c:if>
		});
		
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

	/** 리스트 체크 여부에 따라 송장입력 필드 활성/비활성화 */
	var toggleDeliField = function(checked, idx) {
		var disabled = true;
		if(checked == true) {
			disabled = false;
		}

		if(idx == null) {
			/* 전체선택 */
			$("select[name='deliSeq']").prop("disabled", disabled);
			$("input[name='deliNo']").prop("disabled", disabled);
			$("input[name='boxCnt']").prop("disabled", disabled);
			$("input[name='totalDeliCost']").prop("disabled", disabled);
		} else {
			/* 건별 선택 */
			$("select[name='deliSeq']").eq(idx).prop("disabled", disabled);
			$("input[name='deliNo']").eq(idx).prop("disabled", disabled);
			$("input[name='boxCnt']").prop("disabled", disabled);
			$("input[name='totalDeliCost']").prop("disabled", disabled);
		}
	};


	/** 주문 상태 일괄 변경 */
	var updateStatus = function(statusCode) {
		$("#modForm input[name='returnUrl']").val(location.pathname + "?pageNum=" + ${pvo.pageNum} + "&" + $("#searchForm").serialize());
		$("#modForm input[name='updateStatusCode']").val(statusCode);
		$("#modForm").submit();
	};

	var doSubmit = function(formObj) {
		if( $(formObj).find($("input[name='seq']:checked")).length == 0 ) {
			alert("해당 주문을 선택해 주세요.");
			return false;
		}

		var flag = true;
		var updateStatusCode = formObj.updateStatusCode.value;

		$(formObj).find("input[name='seq']").each( function(idx) {
			if($(this).prop("checked")) {
				var statusCode = $(formObj).find("input[name='statusCode']").eq(idx).val();
				if(updateStatusCode == "10") {
					if(statusCode != "00") {
						alert("검색부분 '상태'항목에서 입금대기 주문 건을 먼저 조회해 주세요.");
						flag=false;
						return flag;
					}
				} else if(updateStatusCode == "20") {
					if(statusCode != "10") {
						alert("검색부분 '상태'항목에서 결제완료 주문 건을 먼저 조회해 주세요.");
						flag=false;
						return flag;
					}
				} else if(updateStatusCode == "30") {
					if(statusCode != "20" && statusCode != "30") {
						alert("검색부분 '상태'항목에서 주문확인 또는 배송중인 주문 건을 먼저 조회해 주세요.");
						flag=false;
						return flag;
					}

					var objDeliSeq = $(formObj).find("select[name='deliSeq']").eq(idx);
					var objDeliNo  = $(formObj).find("input[name='deliNo']").eq(idx);
					var objBoxCnt  = $(formObj).find("input[name='boxCnt']").eq(idx);
					var objTotalDeliCost  = $(formObj).find("input[name='totalDeliCost']").eq(idx);
					if($(objDeliSeq).val() == "") {
						alert("택배사를 선택해 주세요.");
						$(objDeliSeq).focus();
						flag = false;
						return flag;
					} else if($(objDeliSeq).val() !== "19" && $(objDeliNo).val() == "") {
						alert("송장 번호를 입력해 주세요.");
						$(objDeliNo).focus();
						flag = false;
						return flag;
					} else if($(objBoxCnt).val() == "0" || $(objBoxCnt).val() == "") {
						alert("배송 박스 수를 입력해 주세요.");
						$(objBoxCnt).focus();
						flag = false;
						return flag;
					} else if($(objTotalDeliCost).val() == "0" || $(objTotalDeliCost).val() == "") {
						alert("총 배송비를 입력해 주세요.");
						$(objTotalDeliCost).focus();
						flag = false;
						return flag;
					}
				} else if(updateStatusCode == '50') {
					var parseDeliSeq = parseInt($("#modForm select[name='deliSeq']").eq(idx).val());
					if(statusCode != "30") {
						alert("검색부분 '상태'항목에서 배송중인 주문 건을 먼저 조회해 주세요.");
						flag=false;
						return flag;
					}
					if(flag && parseDeliSeq !== 19) {
						alert("직접수령인 주문만 배송완료로 변경 할수있습니다.");
						flag=false;
						return flag;
					}
				}
			}
		});

		if(flag) {
			formObj.returnUrl.value = location.pathname + "?pageNum=" + ${pvo.pageNum} + "&" + $("#searchForm").serialize();
		}
		return flag;
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


	var orderChange = function(obj){
		$('#order').attr('name', obj.value);
	};

	var sellerChange = function(obj) {
		$('#seller').attr('name', obj.value);
	};

	var memberChange = function(obj) {
		$('#item').attr('name', obj.value);
	};

var CHExcelDownload = {
	excelDownCheck:function() {
		var searchDate1 = $("#searchDate1").val();
		var searchDate2 = $("#searchDate2").val();
		if(searchDate1 === '' || searchDate2 === '') {
			alert("주문일자를 입력해 주세요.");
			$(searchDate1).focus();
			return false;
		}

		CHExcelDownload.excelDownAjax();
	}
	, excelDownAjax:function() {
		//ajax:엑셀다운로드 유효성 체크
		$.ajax({
			type: 'POST',
			data: $("#searchForm").serialize(),
			dataType: 'json',
			url: '/admin/order/list/download/excel/check',
			success: function(data) {
				if(data.result === "true") {
					if(data.message !== '') {
						alert(data.message);
					}

					CHExcelDownload.downloadExcel('Y');
				} else {
					alert(data.message);
					CHExcelDownload.downloadExcel('N');
				}
			}
		});
	}

	, downloadExcel:function(validflag) {
		if(validflag === 'N') {
			return;
		}
		$("#searchForm").attr("action", "/admin/order/list/download/excel");
		$("#searchForm").submit();
		$("#searchForm").attr("action",location.pathname);
	}
} ;
</script>
</body>
</html>
