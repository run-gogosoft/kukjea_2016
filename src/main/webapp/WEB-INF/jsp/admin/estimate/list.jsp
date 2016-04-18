<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body class="skin-blue sidebar-mini">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<!-- 헤더 -->
	<section class="content-header">
		<h1>견적 신청 리스트 <small>Estimate Request List</small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>견적 관리</li>
			<li class="active">견적 신청 리스트</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<!-- 제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!--검색 영역-->
					<form class="form-horizontal" id="searchForm" method="get">
						<div class="box-body">
							<div class="form-group">
								<label class="col-md-2 control-label">요청 일자</label>
								<div class="col-md-4">
									<div class="input-group">
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${pvo.searchDate1}">
										<div class="input-group-addon" style="border:0"><strong>~</strong></div>
										<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
										<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${pvo.searchDate2}">
									</div>
								</div>
								<div class="col-md-3 form-control-static">
									<button type="button" onclick="calcDate(0)" class="btn btn-success btn-xs">오 늘</button>
									<button type="button" onclick="calcDate(7)" class="btn btn-default btn-xs">1주일</button>
									<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
									<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
									<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
									<button type="button" onclick="calcDate('clear')" class="btn btn-info btn-xs">전 체</button>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">견적 구분</label>
								<div class="col-md-2">
									<select class="form-control" name="typeCode">
										<option value="">---전체---</option>
										<c:forEach var="item" items="${typeList}">
										<option value="${item.value}" <c:if test="${pvo.typeCode == item.value}">selected</c:if>>${item.name}</option>
										</c:forEach>
									</select>
								</div>
								<label class="col-md-2 control-label">처리 상태</label>
								<div class="col-md-2">
									<select class="form-control" name="statusCode">
										<option value="">---전체---</option>
									<c:forEach var="item" items="${statusList}">
										<option value="${item.value}" <c:if test="${pvo.statusCode == item.value}">selected</c:if>>${item.name}</option>
									</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">회원명</label>
								<div class="col-md-2">
									<input type="text" name="memberName" class="form-control" value="${pvo.memberName}"/>
								</div>
								<label class="col-md-2 control-label">상품코드</label>
								<div class="col-md-2">
									<input type="text" name="itemSeq" class="form-control" value="${pvo.itemSeq}"/>
								</div>
							</div>
						</div>
						<div class="box-footer">
							<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${pvo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-default btn-sm">검색하기</button>
								<a href="/admin/estimate/list" class="btn btn-warning btn-sm">검색초기화</a>
							</div>
						</div>
					</form>
				</div>
				<div class="box">
					<!-- 소제목 -->
					<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
					<!-- 내용 -->
					<div class="box-body">
						<!--리스트-->
						<table id="list1" class="table table-bordered table-striped">
							<colgroup>
								<col style="width:6%"/>
								<col style="width:7%"/>
								<col style="width:5%"/>
								<col style="width:*"/>
								<col style="width:6%"/>
								<col style="width:5%"/>
								<col style="width:6%"/>
								<col style="width:6%"/>
								<col style="width:6%"/>
								<col style="width:15%"/>
								<col style="width:10%"/>
								<col style="width:6%"/>
								<col style="width:6%"/>
							</colgroup>
							<thead>
								<tr>
									<th>
										견적 번호
										<div class="text-info">상품 주문번호</div>
									</th>
									<th>회원명</th>
									<th>상품 코드</th>
									<th>상품명</th>
									<th>판매 단가</th>
									<th>수량</th>
									<th>합계 금액</th>
									<th>견적 금액</th>
									<th>
										견적 구분
										<div class="text-primary">견적 상태</div>
									</th>
									<th>기타 요청사항</th>
									<th>입점업체명</th>
									<th>요청 일자</th>
									<th>
										견적 설정
										<div class="text-warning">
										견적 취소
										</div>
										<div class="text-danger">
										견적 삭제
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
							<c:forEach var="item" items="${list}">
								<tr id="row${item.seq}">
									<td class="text-center">
										${item.seq}
										<c:if test="${item.orderSeq ne null and item.orderDetailSeq ne null}">
											<div><a href="/admin/order/view/${item.orderSeq}?seq=${item.orderDetailSeq}" target="_blank">${item.orderDetailSeq}</a></div>
										</c:if>
									</td>
									<td class="text-center memberName">
										<a href="/admin/member/view/${item.memberSeq}" target="_blank">${item.memberName}</a>
									</td>
									<td class="text-center">${item.itemSeq}</td>
									<td class="itemName">
										${item.itemName}
										<c:if test="${item.optionValue ne ''}">
											- ${item.optionValue}
										</c:if>
									</td>
									<td class="text-right sellPrice"><fmt:formatNumber value="${item.sellPrice}"/></td>
									<td class="text-right qty"><fmt:formatNumber value="${item.qty}"/></td>
									<td class="text-right sum"><fmt:formatNumber value="${item.sellPrice * item.qty}"/></td>
									<td class="text-right amount">
										<strong class="text-danger"><fmt:formatNumber value="${item.amount}"/></strong>
									</td>
									<td class="text-center">
										<strong>${item.typeName}</strong>
										<div><strong class="${item.statusCode eq 9 ? "text-danger":"text-info"}">${item.statusText}</strong></div>
									</td>
									<td class="request">${item.request}</td>
									<td class="text-center">${item.sellerName}</td>
									<td class="text-center">
										${fn:substring(item.regDate,0,10)}
										<p class="text-info">${fn:substring(item.modDate,0,10)}</p>
									</td>
									<td class="text-center">
										<button type="button" onclick="showModal(${item.seq})" class="btn btn-xs btn-info" ${item.statusCode > 2 ? "disabled":""}>등록/수정</button>
										<div style="margin-top:5px;">
											<button type="button" onclick="doUpdate(${item.seq},'cancel');" class="btn btn-xs btn-warning" ${item.statusCode > 2 ? "disabled":""}>견적 취소</button>
										</div>
										<c:if test="${sessionScope.loginType eq 'A'}">
										<!-- 관리자만 삭제할 수 있다 -->
										<div style="margin-top:5px;">
											<button type="button" onclick="doUpdate(${item.seq},'delete');" class="btn btn-xs btn-danger" ${item.statusCode eq 3 ? "disabled":""}>견적 삭제</button>
										</div>
										</c:if>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${ fn:length(list)==0 }">
								<tr><td class="text-center" colspan="13">등록된 내용이 없습니다.</td></tr>
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

<form id="form1" method="get" target="zeroframe">
	<input type="hidden" name="seq" value=""/>
	<input type="hidden" name="statusCode" value=""/>
	<input type="hidden" name="returnUrl" value=""/>
</form>

<div id="modal1" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h3 class="modal-title">견적 금액 등록/수정</h3>
			</div>
			<form id="form2" class="form-horizontal" action="/admin/estimate/mod" method="post" target="zeroframe" onsubmit="return doSubmit(this);">
				<div class="modal-body">
					<input type="hidden" id="seq" name="seq"/>
					<input type="hidden" name="returnUrl" value=""/>
					<div class="form-group">
						<label class="col-md-4 control-label">견적 번호</label>
						<div class="col-md-8 form-control-static" id="seq_text"></div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label">회원명</label>
						<div class="col-md-8 form-control-static" id="memberName_text"></div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label">상품명</label>
						<div class="col-md-8 form-control-static" id="itemName_text"></div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label">판매 단가</label>
						<div class="col-md-8 form-control-static" id="sellPrice_text"></div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label">수량</label>
						<div class="col-md-4">
							<div class="input-group">
								<input type="text" id="qty" name="qty" class="form-control text-right" maxlength="5" onblur="numberCheck(this);"/>
								<div class="input-group-addon">개</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label">합계 금액</label>
						<div class="col-md-8 form-control-static" id="sum_text"></div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label">견적 금액</label>
						<div class="col-md-4">
							<div class="input-group">
								<input type="text" id="amount" name="amount" class="form-control text-right" maxlength="9" onblur="numberCheck(this);" onkeyup="numbersHangul()"/>
								<div class="input-group-addon">원</div>
							</div>
						</div>
						<div class="col-md-4" style="padding:5px;"><strong id="priceCom" style="font-size:12px;"></strong></div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label">기타 요청 사항</label>
						<div class="col-md-8 form-control-static" id="request_text"></div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-md btn-info">저장하기</button>
					<button type="button" data-dismiss="modal" class="btn btn-md btn-default">닫기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script src="/assets/js/libs/moment.js"></script>
<script type="text/javascript">
	/** 페이지 로딩시 초기화 */
	$(document).ready(function () {
		/* 날짜 검색 달력 기능 */
		showDatepicker("yy-mm-dd");
	});

	var numbersHangul = function() {
	    var message = "";
	    for(var i=0; i<$('#amount').val().length; i++) {
	        switch($('#amount').val().length-i) {
	            case 12 : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "천":"";break;
	            case 11 : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "백":"";break;
	            case 10 : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "십":"";break;
	            case 9  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "억":($('#amount').val().substr(i-3,4)!="0000") ? "억":"";break;
	            case 8  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "천":"";break;
	            case 7  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "백":"";break;
	            case 6  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "십":"";break;
	            case 5  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "만":($('#amount').val().substr(i-3,4)!="0000") ? "만":"";break;
	            case 4  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "천":"";break;
	            case 3  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "백":"";break;
	            case 2  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) + "십":"";break;
	            case 1  : message += ($('#amount').val().charAt(i)!=="0")?$('#amount').val().charAt(i) :"";break;
	            default : return "";
	        }
	    }
	    message = message
	        .split("1십").join("십")
	        .split("1백").join("백")
	        .split("1천").join("천")
	        .split("1").join("일")
	        .split("2").join("이")
	        .split("3").join("삼")
	        .split("4").join("사")
	        .split("5").join("오")
	        .split("6").join("육")
	        .split("7").join("칠")
	        .split("8").join("팔")
	        .split("9").join("구");
	    
	    
	    if(message !== ''){
			$('#priceCom').text(message+'원');
		}else{
			$('#priceCom').text('');
		}
	};
	
	var goPage = function(page) {
		location.href = location.pathname + "?pageNum=" + page + "&" + $("#searchForm").serialize();
	};

	/** 날짜 계산 */
	var calcDate = function(val) {
		if(val == "clear") {
			$("input[name=searchDate1]").val( '2014-01-01' );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		} else {
			$("input[name=searchDate1]").val( moment().subtract('days', parseInt(val,10)).format("YYYY-MM-DD") );
			$("input[name=searchDate2]").val( moment().format("YYYY-MM-DD"));
		}
	};

	/** 견적서 업로드 모달 창 띄우기 */
	var showModal = function(seq) {
		$("#seq").val(seq);
		$("#seq_text").text(seq);
		$("#memberName_text").text($("#row"+seq+ " .memberName").text());
		$("#itemName_text").text($("#row"+seq+ " .itemName").text());
		$("#sellPrice_text").text($("#row"+seq+ " .sellPrice").text() + " 원");
		$("#qty").val($.trim( $("#row"+seq+ " .qty").text().replace(/,/gi,"") ));
		$("#sum_text").text($("#row"+seq+ " .sum").text() + " 원");
		$("#amount").val($.trim( $("#row"+seq+ " .amount").text().replace(/,/gi,"") ));
		$("#request_text").text($("#row"+seq+ " .request").text());
		numbersHangul();

		$("#modal1").modal();
	};

	/** 견적서 업로드 */
	var doSubmit = function(obj) {
		if($.trim(obj.qty.value) <= 0) {
			alert("수량을 입력해 주세요.");
			obj.qty.focus();
			return false;
		}
		if($.trim(obj.amount.value) <= 0) {
			alert("견적 금액을 입력해 주세요.");
			obj.amount.focus();
			return false;
		}
		
		obj.returnUrl.value = location.pathname + "?pageNum=${pvo.pageNum}&" + $("#searchForm").serialize();
		
		return true;
	};
	
	/** 견적 취소/삭제 처리 */
	var doUpdate = function(seq, type) {
		var form = document.getElementById("form1");
		
		form.seq.value  = (type=="cancel" ? seq : "");
		form.statusCode.value = (type=="cancel" ? "9":"");
		form.action = "/admin/estimate/"+(type=="delete" ? "del/"+seq:"mod");
		
		form.returnUrl.value = location.pathname + "?pageNum=${pvo.pageNum}&" + $("#searchForm").serialize();
		
		if(!confirm(type == "delete" ? "정말로 해당 견적신청 내용을 삭제하시겠습니까?":"취소처리 하시겠습니까?")) {
			return;
		}
		
		form.submit();
	};

</script>
</body>
</html>
