<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
</head>
<body>
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="main">
	<div class="container">
		<div class="row">
			<div class="span12">
				<div class="widget widget-form stacked">
					<div class="widget-header">
						<i class="icon-th-list"></i>
						<h3>${title}</h3>
					</div>
					<div class="widget-content nopadding">
						<form action="/admin/point/write/proc" method="post" target="zeroframe" class="form-horizontal"  onsubmit="return doSubmit(this)">
						<div class="row-fluid">
							<div class="control-group span6">
								<label class="control-label">지급자</label>
								<div class="controls">${sessionScope.loginName}</div>
							</div>
						</div>
							<div class="row-fluid">
								<div class="control-group">
									<label class="control-label">회원 명(아이디)<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
										<div class="controls">
											<c:choose>
												<c:when test="${formFlag eq 'Y'}">
													<input type="text" name="memberSeq" class="span1" value="${vo.seq}" readonly="readonly" alt="회원"/>
													${vo.name} (${vo.id})
												</c:when>
												<c:when test="${formFlag eq 'N'}">
													<input type="text" name="memberSeq" class="span1" value="" readonly="readonly" alt="회원" data-required-label="회원"/>

													<select id="search" name="search" class="span2">
														<option value="id">아이디</option>
														<option value="name">이름</option>
													</select>

													<input type="text" id="findword" name="findword" class="span3" value="" placeholder="회원 검색" />
													<button type="button" class="btn btn-info" onclick="memberProc(this)">검색</button><br/>
													<span class="icon icon-info-sign"></span> 회원을 검색한 후에 선택해주세요
													<br/>
													<br/>
													<script id="memberTemplate" type="text/html">
														<tr class="hand" data-seq="<%="${seq}"%>" onclick="memberSelectProc(this)">
															<td class="text-center"><%="${id}"%></td>
															<td class="text-center"><%="${name}"%></td>
															<td class="text-center"><%="${statusText}"%></td>
															<td class="text-center"><%="${mallName}"%></td>
															<td class="text-center"><%="${gradeText}"%></td>
															<td class="text-center"><%="${lastDate}"%></td>
															<td class="text-center"><%="${regDate}"%></td>
														</tr>
													</script>
													<div class="hide">
														<table class="table table-striped table-bordered table-list">
															<thead>
															<tr>

																<th>아이디</th>
																<th>이름</th>
																<th>상태</th>
																<th>쇼핑몰</th>
																<th>등급</th>
																<th>마지막접속일</th>
																<th>등록일자</th>
															</tr>
															</thead>
															<tbody id="member-list">
															<tr><td class="muted text-center" colspan="7">
																검색결과가 이 안에 표시됩니다
															</td></tr>
															</tbody>
														</table>
													</div>
												</c:when>
											</c:choose>
										</div>
								</div>
							</div>
							<div class="row-fluid">
								<div class="control-group span12">
									<label class="control-label">만료일<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
									<div class="controls">
										<div class="input-append">
											<input type="text" id="endDate" name="endDate" class="span12 datepicker numeric" maxlength="10" data-required-label="만료일"/>
											<button type="button" onclick="$(this).prev().focus()" class="btn"><i class="icon-calendar"></i></button>

										</div>
									</div>
								</div>
							</div>
							<div class="row-fluid">
								<div class="control-group span6">
									<label class="control-label">지급포인트<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
									<div class="controls">
										<input type="text" id="point" name="point" class="span7 alphanumeric" maxlength="20" onblur="numberCheck(this);" data-required-label="지급포인트"/> 포인트
									</div>
								</div>
							</div>
							<div class="row-fluid">
								<div class="control-group span6">
									<label class="control-label">사용구분<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
									<div class="controls">
										<select id="validFlag" name="validFlag" class="span7">
											<option value="">전체</option>
											<option value="Y">사용가능</option>
											<option value="N">사용불가</option>
										</select>
									</div>
								</div>
							</div>
							<div class="row-fluid">
								<div class="control-group span6">
									<label class="control-label">적립방식<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
									<div class="controls">
										<select id="reserveCode" name="reserveCode" class="span7">
											<option value="">전체</option>
											<c:forEach var="item" items="${commonlist}">
												<option value="${item.value}">${item.name}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="row-fluid">
								<div class="control-group">
									<label class="control-label">비고</label>
									<div class="controls">
										<input type="text" id="reserveComment" name="reserveComment" alt="reserveComment" class="span9" maxlength="60"/>
									</div>
								</div>
							</div>
							<div class="row-fluid">
								<div class="control-group">
									<label class="control-label">등록 구분<i class="icon-ok" style="margin-left:5px;font-size:10px;"></i></label>
									<div class="controls">
										<label class="radio inline">
											<input type="radio" name="typeCode" alt="일반" value="1">일반
										</label>
										<label class="radio inline">
											<input type="radio" name="typeCode" alt="부분취소" value="2">부분취소
										</label>
									</div>
								</div>
							</div>
							<div id="cancelDiv" style="display:none;">
									<div class="row-fluid">
									<div class="control-group span6">
										<label class="control-label">주문번호</label>
										<div class="controls">
											<input type="text" id="orderSeq" name="orderSeq" class="span7 alphanumeric" maxlength="20" onblur="numberCheck(this);" alt="주문번호"/>
											<button type="button" class="btn btn-info" onclick="detailProc(this)">검색</button><br/>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="control-group">
										<label class="control-label">상품 주문번호</label>
										<div class="controls">
											<input type="text" id="orderDetailSeq" name="orderDetailSeq" readonly/>
										</div>
									</div>
								</div>
								<div class="row-fluid">
									<div class="control-group">
										<script id="detailTemplate" type="text/html">
											<tr class="hand" data-seq="<%="${seq}"%>" onclick="detailSelectProc(this)">
												<td class="text-center"><%="${seq}"%></td>
												<td class="text-center"><%="${itemName}"%></td>
												<td class="text-right"><%="${sellPrice}"%></td>
												<td class="text-right"><%="${optionPrice}"%></td>
												<td class="text-right"><%="${orderCnt}"%></td>
												<td class="text-right"><%="${deliCost}"%></td>
												<td class="text-right"><%="${usePoint}"%></td>
												<td class="text-center"><%="${statusText}"%></td>
												<td class="text-center"><%="${sellerName}"%></td>
											</tr>
										</script>
										<div class="hide">
											<table class="table table-striped table-bordered table-list">
												<thead>
												<tr>
													<th>상품주문번호</th>
													<th>상품명</th>
													<th>판매단가</th>
													<th>옵션가</th>
													<th>수량</th>
													<th>배송비</th>
													<th>사용포인트</th>
													<th>주문상태</th>
													<th>입점업체명</th>
												</tr>
												</thead>
												<tbody id="detail-list">
												<tr><td class="muted text-center" colspan="9">
													검색결과가 이 안에 표시됩니다
												</td></tr>
												</tbody>
											</table>
											<strong style="color:red;">※ 배송비에 사용한 포인트가 있다면 첫번째 주문의 사용포인트에 더해집니다.</strong>
										</div>
									</div>
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="btn btn-info">등록하기</button>
								<button type="button" class="btn" onclick="history.go(-1);">목록보기</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/libs/jquery.alphanumeric.js"></script>
<script type="text/javascript">
	var memberProc = function(obj) {
		if($("#findword").val()==""){
			$.msgbox("검색할 키워드를 입력주세요.", {type: "info"});
			return;
		}

		$("#member-list").html( "<tr><td colspan='7' class='muted text-center' style='padding:10px'>데이터를 불러오고 있습니다</td></tr>" ).parents(".hide").show();
		$.ajax({
			url:"/admin/point/member/json",
			type:"post",
			data:{findword:$("#findword").val(), search:$("select[name=search] option:selected").val()},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				if(list.result === "false") {
					$.msgbox(list.message, {type: "info"});
				}

				if(list.length === 0) {
					$("#member-list").html( "<tr><td colspan='7' class='muted text-center' style='padding:10px'>검색된 결과가 없습니다</td></tr>");
				} else {
					$("#member-list").html( $("#memberTemplate").tmpl(list) );
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};

	var memberSelectProc = function(obj) {
		var seq = parseInt($(obj).attr("data-seq"), 10) || 0;
		$("input[name=memberSeq]").val(seq);
		$("#member-list tr[data-seq]").each(function(){
			if(parseInt($(this).attr("data-seq"), 10) !== seq) {
				$(this).remove();
			} else {
				$(this).addClass("info");
			}
		});
	};

	var detailProc = function(obj) {
		if($("#orderSeq").val()==""){
			$.msgbox("주문번호를 입력주세요.", {type: "info"});
			return;
		}

		$("#detail-list").html( "<tr><td colspan='9' class='muted text-center' style='padding:10px'>데이터를 불러오고 있습니다</td></tr>" ).parents(".hide").show();
		$.ajax({
			url:"/admin/point/detail/json",
			type:"post",
			data:{orderSeq:$("#orderSeq").val()},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				if(list.result === "false") {
					$.msgbox(list.message, {type: "info"});
				}

				if(list.length === 0) {
					$("#detail-list").html( "<tr><td colspan='9' class='muted text-center' style='padding:10px'>검색된 결과가 없습니다</td></tr>");
				} else {
					$("#detail-list").html( $("#detailTemplate").tmpl(list) );
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	};

	var detailSelectProc = function(obj) {
		var seq = parseInt($(obj).attr("data-seq"), 10) || 0;

		if($(obj).hasClass("info")){
			$(obj).removeClass("info");

			var detailSeq = $("#orderDetailSeq").val();
			var saveDetailSeq = "";
			if(detailSeq.indexOf(seq) > -1){
				$("#detail-list tr.info").each(function(){
					if(saveDetailSeq !== ""){
						saveDetailSeq += ",";
					}
					saveDetailSeq += $(this).attr("data-seq");
				});
				$("#orderDetailSeq").val(saveDetailSeq);
			}
		} else {
			if($("#orderDetailSeq").val() !== ""){
				$("#orderDetailSeq").val($("#orderDetailSeq").val()+","+seq);
			} else {
				$("#orderDetailSeq").val(seq);
			}

			$("#detail-list tr[data-seq]").each(function(){
				if(parseInt($(this).attr("data-seq"), 10) === seq) {
					$(this).addClass("info");
				}
			});
		}
	};

	/** 폼 전송 */
	var doSubmit = function(frmObj) {
		/* 필수값 체크 */
		var submit = checkRequiredValue(frmObj, "data-required-label");
		if(submit){
			if($("select[name=validFlag] option:selected").val()===""){
				alert("사용구분이 선택되지 않았습니다.");
				return submit=false;
			}

			if($("select[name=reserveCode] option:selected").val()===""){
				alert("적립방식이 선택되지 않았습니다.");
				return submit=false;
			}
		} else {
			return submit=false;
		}

		if(typeof $(':radio[name="typeCode"]:checked').val()==="undefined"){
			alert("등록구분이 선택되지 않았습니다.");
			return submit=false;
		}

		if($(':radio[name="typeCode"]:checked').val()==="2"){
			if($("input[name=orderSeq]").val()===""){
				alert("주문번호가 입력되지 않았습니다.");
				return submit=false;
			}

			if(typeof $(frmObj).find("#orderDetailSeq").val() === "undefined"){
				alert("상품 주문번호를 추가해 주세요.");
				return submit=false;
			}
		}
		return submit;
	};

	/* 페이지 로딩시 초기화 */
	$(document).ready(function () {
		//숫자 입력 칸 나머지 문자 입력 막기
		$(".numeric").css("ime-mode", "disabled").numeric();
		//아이디 입력칸 숫자,영문만 입력되도록....
		$(".alphanumeric").css("ime-mode", "disabled").alphanumeric();

		$(".datepicker").datepicker({
			dateFormat:"yy-mm-dd"
		});

		$('input:radio[name="typeCode"]').click(function(){
			if($(':radio[name="typeCode"]:checked').val()=="1"){
				$("#cancelDiv").hide();
			}
			if($(':radio[name="typeCode"]:checked').val()=="2"){
				$("#cancelDiv").show();
			}
		});
	});
</script>
</body>
</html>
