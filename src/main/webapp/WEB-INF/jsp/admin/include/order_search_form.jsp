<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
				<div class="col-md-3 form-control-static">
					<button type="button" onclick="calcDate(0)" class="btn btn-success btn-xs">오늘</button>
					<button type="button" onclick="calcDate(7)" class="btn btn-default btn-xs">1주일</button>
					<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
					<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
					<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
					<button type="button" onclick="calcDate('clear')" class="btn btn-info btn-xs">전체</button>
				</div>
			</div>
			
			<c:if test="${sessionScope.loginType ne 'M' && cs eq ''}">
			<div class="form-group">
				<label class="col-md-2 control-label">카테고리</label>
				<div class="col-md-2">
					<select class="form-control" name="lv1Seq" onchange="$('#searchForm')[0].submit()">
						<option value="">---대분류---</option>
						<c:forEach var="item" items="${cateLv1List}" varStatus="status" begin="0" step="1">
							<option value="${item.seq}" <c:if test="${pvo.lv1Seq == item.seq}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="lv2Seq" onchange="$('#searchForm')[0].submit()">
						<option value="">---중분류---</option>
						<c:forEach var="item" items="${cateLv2List}" varStatus="status" begin="0" step="1">
							<option value="${item.seq}" <c:if test="${pvo.lv2Seq == item.seq}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="lv3Seq" onchange="$('#searchForm')[0].submit()">
						<option value="">---소분류---</option>
						<c:forEach var="item" items="${cateLv3List}" varStatus="status" begin="0" step="1">
							<option value="${item.seq}" <c:if test="${pvo.lv3Seq == item.seq}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="lv4Seq" onchange="$('#searchForm')[0].submit()">
						<option value="">---세분류---</option>
						<c:forEach var="item" items="${cateLv4List}" varStatus="status" begin="0" step="1">
							<option value="${item.seq}" <c:if test="${pvo.lv4Seq == item.seq}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			</c:if>
			<div class="form-group">
				<label class="col-md-2 control-label">상태</label>
				<div class="col-md-4">
					<select class="form-control" id="statusCode" name="statusCode">
						<option value="">---전체 검색---</option>
						<c:forEach var="item" items="${statusList}">
							<c:choose>
								<c:when test="${cs eq 'exchange'}">
									<c:if test="${item.value >= '60' and item.value <='69'}">
										<option value="${item.value}" <c:if test="${pvo.statusCode eq item.value}">selected</c:if>>${item.name}</option>
									</c:if>
								</c:when>
								<c:when test="${cs eq 'return'}">
									<c:if test="${item.value >= '70' and item.value <='79'}">
										<option value="${item.value}" <c:if test="${pvo.statusCode eq item.value}">selected</c:if>>${item.name}</option>
									</c:if>
								</c:when>
								<c:when test="${cs eq 'cancel'}">
									<c:if test="${item.value >= '90' and item.value <='99'}">
										<option value="${item.value}" <c:if test="${pvo.statusCode eq item.value}">selected</c:if>>${item.name}</option>
									</c:if>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${sessionScope.loginType eq 'A'}">
											<option value="${item.value}" <c:if test="${pvo.statusCode eq item.value}">selected</c:if>>${item.name}</option>
										</c:when>
										<c:otherwise>
											<c:if test="${item.value ne '00'}">
												<option value="${item.value}" <c:if test="${pvo.statusCode eq item.value}">selected</c:if>>${item.name}</option>
											</c:if>
										</c:otherwise>
									</c:choose>								
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
				</div>
				<label class="col-md-1 control-label">고객명</label>
				<div class="col-md-2">
					<select class="form-control" id="searchMember" name="searchMember" onchange="memberChange(this);">
						<option value="memberName" <c:if test="${pvo.searchMember eq 'memberName' or pvo.search eq ''}">selected</c:if>>주문자명</option>
						<option value="memberId" <c:if test="${pvo.searchMember eq 'memberId'}">selected</c:if>>주문자ID</option>
						<option value="receiverName" <c:if test="${pvo.searchMember eq 'receiverName'}">selected</c:if>>수령자</option>
						<option value="receiverTel" <c:if test="${pvo.searchMember eq 'receiverTel'}">selected</c:if>>수취인전화번호</option>
					</select>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="member"
						<c:choose>
							<c:when test="${pvo.searchMember eq 'memberName' or pvo.searchMember eq ''}">name="memberName" value="${pvo.memberName}"</c:when>
							<c:when test="${pvo.searchMember eq 'memberId'}">name="memberId" value="${pvo.memberId}"</c:when>
							<c:when test="${pvo.searchMember eq 'receiverName'}">name="receiverName" value="${pvo.receiverName}"</c:when>
							<c:when test="${pvo.searchMember eq 'receiverTel'}">name="receiverTel" value="${pvo.receiverTel}"</c:when>
						</c:choose>
					maxlength="20"/>
				</div>
			</div>
	
			<div class="form-group">
				<label class="col-md-2 control-label">주문번호</label>
				<div class="col-md-2">
					<select class="form-control" id="searchOrder" name="searchOrder" onchange="orderChange(this);">
						<option value="seq" <c:if test="${pvo.searchOrder eq 'seq' or pvo.searchOrder eq ''}">selected</c:if>>상품주문번호</option>
						<option value="orderSeq" <c:if test="${pvo.searchOrder eq 'orderSeq'}">selected</c:if>>주문번호</option>
					</select>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="order"
						<c:choose>
							<c:when test="${pvo.searchOrder eq 'seq' or pvo.searchOrder eq ''}">name="seq" value="${pvo.seq}"</c:when>
							<c:when test="${pvo.searchOrder eq 'orderSeq'}">name="orderSeq" value="${pvo.orderSeq}"</c:when>
						</c:choose>
					maxlength="20" onblur="numberCheck(this);"/>
				</div>
				<label class="col-md-1 control-label">상세검색</label>
				<div class="col-md-2">
					<select class="form-control" id="search" name="search">
						<option value="itemName" 		<c:if test="${pvo.search eq 'itemName'}">selected</c:if>>상품명</option>
						<option value="itemSeq" 		<c:if test="${pvo.search eq 'itemSeq'}">selected</c:if>>상품번호</option>
					</select>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="findword" name="findword" value="${pvo.findword}" maxlength="20" onblur="numberCheck(this);"/>
				</div>
			</div>
	
			<c:if test="${sessionScope.loginType eq 'A'}">
			<div class="form-group">
				<label class="col-md-2 control-label">입점업체</label>
				<div class="col-md-2">
					<select class="form-control" id="searchSeller" name="searchSeller" onchange="sellerChange(this);">
						<option value="sellerName" <c:if test="${pvo.searchSeller eq 'sellerName' or pvo.searchSeller eq ''}">selected</c:if>>입점업체명</option>
						<option value="sellerId" <c:if test="${pvo.searchSeller eq 'sellerId'}">selected</c:if>>입점업체ID</option>
					</select>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="seller"
							<c:choose>
								<c:when test="${pvo.searchSeller eq 'sellerName' or pvo.searchSeller eq ''}">name="sellerName" value="${pvo.sellerName}"</c:when>
								<c:when test="${pvo.searchSeller eq 'sellerId'}">name="sellerId" value="${pvo.sellerId}"</c:when>
							</c:choose>
					maxlength="20"/>
				</div>
				<label class="col-md-1 control-label">결제 수단</label>
				<div class="col-md-2">
					<select class="form-control" id="payMethod" name="payMethod">
						<option value="">---전체 선택---</option>
						<c:forEach var="item" items="${payMethodList}">
							<option value="${item.value}" <c:if test="${pvo.payMethod eq item.value}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			</c:if>
			<div class="form-group">
				<label class="col-md-2 control-label">기관명 / 부서</label>
				<div class="col-md-4">
					<div class="input-group">
						<input class="form-control" type="text" name="groupName" value="${pvo.groupName}"/>
						<div class="input-group-addon" style="border:0"><string>/</string></div>
						<input class="form-control" type="text" name="deptName" value="${pvo.deptName}"/>
					</div>
				</div>
				<label class="col-md-1 control-label">한페이지출력수</label>
				<div class="col-md-2">
					<select class="form-control" id="rowCount" name="rowCount">
						<option value="50" <c:if test="${pvo.rowCount eq '50'}">selected="selected"</c:if>>50개씩보기</option>
						<option value="100" <c:if test="${pvo.rowCount eq '100'}">selected="selected"</c:if>>100개씩보기</option>
						<option value="200" <c:if test="${pvo.rowCount eq '200'}">selected="selected"</c:if>>200개씩보기</option>
						<option value="500" <c:if test="${pvo.rowCount eq '500'}">selected="selected"</c:if>>500개씩보기</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">세금계산서 요청</label>
				<div class="col-md-4">
					<select class="form-control" id="taxRequest" name="taxRequest">
						<option value="">---전체 선택---</option>
						<option value="N" <c:if test="${pvo.taxRequest eq 'N'}">selected="selected"</c:if>>요청중인 주문</option>
						<option value="Y" <c:if test="${pvo.taxRequest eq 'Y'}">selected="selected"</c:if>>완료된 주문</option>
					</select>
				</div>
				<label class="col-md-1 control-label"></label>
				<div class="col-md-2"></div>
			</div>
		</div>
		<div class="box-footer">
			<div class="pull-left">
				총 <strong class="text-warning"><fmt:formatNumber value="${pvo.totalRowCount}"/></strong> 건 / 합계금액 <strong class="text-danger"><fmt:formatNumber value="${sumPrice}"/></strong> 원
			</div>
			<div class="pull-right">
				<button type="submit" class="btn btn-default btn-sm">검색하기</button>
				<c:if test="${sessionScope.loginType eq 'A' or sessionScope.loginType eq 'S' or sessionScope.loginType eq 'M'}">
					<c:if test="${cs eq ''}">
						<button type="button" id="excelDownBtn" onclick="CHExcelDownload.excelDownCheck();" class="btn btn-success btn-sm">엑셀다운</button>
					</c:if>
				</c:if>
				<button type="button" onclick="
				<c:choose>
					<c:when test="${cs eq ''}">location.href='/admin/order/list'</c:when>
					<c:otherwise>
						location.href='/admin/order/${cs}/list'
					</c:otherwise>
				</c:choose>" class="btn btn-warning btn-sm">검색초기화</button>
			</div>
		</div>
	</form>
</div>
