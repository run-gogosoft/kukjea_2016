<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="box">
	<!-- 소제목 -->
	<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
	<!-- 내용 -->
	<form id="searchForm" action="/admin/item/list" class="form-horizontal" method="get" onsubmit="search(this);">
		<input type="hidden" name="pageNum"  id="pageNum" value="${vo.pageNum}"/>
		<input type="hidden" name="orderByName" id="orderByName" value="${vo.orderByName}"/>
		<input type="hidden" name="orderByType" id="orderByType" value="${vo.orderByType}"/>
		<div class="box-body">
			<div class="form-group">
				<label class="col-md-2 control-label">등록일자</label>
				<div class="col-md-4">
					<div class="input-group">
						<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<input class="form-control datepicker" type="text" id="searchDate1" name="searchDate1" value="${vo.searchDate1}">
						<div class="input-group-addon" style="border:0"><strong>~</strong></div>
						<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<input class="form-control datepicker" type="text" id="searchDate2" name="searchDate2" value="${vo.searchDate2}">
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
			<div class="form-group">
				<label class="col-md-2 control-label">카테고리</label>
				<div class="col-md-2">
					<select class="form-control" name="cateLv1Seq">
						<option value="">---대분류---</option>
						<c:forEach var="item" items="${cateLv1List}">
							<option value="${item.seq}" <c:if test="${vo.cateLv1Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
						<option value="0" <c:if test="${vo.cateLv1Seq eq 0}">selected="selected"</c:if>>미지정</option>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="cateLv2Seq">
						<option value="">---중분류---</option>
						<c:forEach var="item" items="${cateLv2List}">
							<option value="${item.seq}" <c:if test="${vo.cateLv2Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
						<option value="0" <c:if test="${vo.cateLv2Seq eq 0}">selected="selected"</c:if>>미지정</option>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="cateLv3Seq">
						<option value="">---소분류---</option>
						<c:forEach var="item" items="${cateLv3List}">
							<option value="${item.seq}" <c:if test="${vo.cateLv3Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
						<option value="0" <c:if test="${vo.cateLv3Seq eq 0}">selected="selected"</c:if>>미지정</option>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="cateLv4Seq">
						<option value="">---세분류---</option>
						<c:forEach var="item" items="${cateLv4List}">
							<option value="${item.seq}" <c:if test="${vo.cateLv4Seq eq (''+item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
						<option value="0" <c:if test="${vo.cateLv4Seq eq 0}">selected="selected"</c:if>>미지정</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">판매상태</label>
				<div class="col-md-2">
					<select class="form-control" name="statusCode">
						<option value="">---선택---</option>
						<option value="E" <c:if test="${vo.statusCode eq 'E'}">selected="selected"</c:if>>대량등록</option>
						<option value="H" <c:if test="${vo.statusCode eq 'H'}">selected="selected"</c:if>>가승인</option>
						<option value="Y" <c:if test="${vo.statusCode eq 'Y'}">selected="selected"</c:if>>판매중</option>
						<option value="N" <c:if test="${vo.statusCode eq 'N'}">selected="selected"</c:if>>판매중지</option>
						<option value="S" <c:if test="${vo.statusCode eq 'S'}">selected="selected"</c:if>>품절</option>
					</select>
				</div>
				<div class="col-md-2"></div>
				<label class="col-md-1 control-label">배송비</label>
				<div class="col-md-2">
					<select class="form-control" id="deliTypeCode" name="deliTypeCode">
						<option value="">---선택--</option>
						<option value="00" <c:if test="${vo.deliTypeCode eq '00'}">selected="selected"</c:if>>무료</option>
						<option value="10" <c:if test="${vo.deliTypeCode eq '10'}">selected="selected"</c:if>>유료</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">상품명/상품코드</label>
				<div class="col-md-2">
					<select class="form-control" id="itemSearchType" name="itemSearchType">
						<%-- <option value="">---구분---</option> --%>
						<option value="seq"  <c:if test="${vo.itemSearchType eq 'seq'}">selected</c:if>>상품코드</option>
						<option value="name" <c:if test="${vo.itemSearchType eq '' or vo.itemSearchType eq 'name'}">selected</c:if>>상품명</option>
					</select>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="itemSearchValue" name="itemSearchValue" value="${vo.itemSearchValue}" maxlength="20"/>
				</div>
				<label class="col-md-1 control-label">입점업체</label>
				<div class="col-md-2">
					<select class="form-control" id="sellerSearchType" name="sellerSearchType">
						<option value="sellerName"  <c:if test="${vo.sellerSearchType eq 'sellerName'}">selected</c:if>>입점업체명</option>
						<option value="sellerId" <c:if test="${vo.sellerSearchType eq 'sellerId'}">selected</c:if>>입점업체ID</option>
					</select>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="sellerSearchValue" name="sellerSearchValue" value="${vo.sellerSearchValue}" maxlength="20"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">부가세</label>
				<div class="col-md-2">
					<select class="form-control" id="taxCode" name="taxCode">
						<option value="">---전체---</option>
						<option value="1" <c:if test="${vo.taxCode eq '1'}">selected="selected"</c:if>>과세</option>
						<option value="2" <c:if test="${vo.taxCode eq '2'}">selected="selected"</c:if>>면세</option>
					</select>
				</div>
				<div class="col-md-1"></div>
				<label class="col-md-2 control-label">한페이지출력수</label>
				<div class="col-md-2">
					<select class="form-control" id="rowCount" name="rowCount">
						<option value="50" <c:if test="${vo.rowCount eq '50'}">selected="selected"</c:if>>50개씩보기</option>
						<option value="100" <c:if test="${vo.rowCount eq '100'}">selected="selected"</c:if>>100개씩보기</option>
						<option value="200" <c:if test="${vo.rowCount eq '200'}">selected="selected"</c:if>>200개씩보기</option>
						<option value="500" <c:if test="${vo.rowCount eq '500'}">selected="selected"</c:if>>500개씩보기</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">인증구분</label>
				<div class="checkbox col-md-10">				
				<c:forEach var="item" items="${authCategoryList}">
					<label>
						<input type="checkbox" name="authCategory" value="${item.value}" ${fn:contains(vo.authCategory,item.value) ? "checked":"" }/>${item.name}
						<img src="/front-assets/images/detail/auth_mark_${item.value}.png" alt="${item.name}">
					</label>
				</c:forEach>		
				</div>
			</div>
		</div>
		<div class="box-footer">
			<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${vo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
			<div class="pull-right">
				<button type="submit" class="btn btn-sm btn-default">검색하기</button>
				<c:if test="${sessionScope.loginType eq 'A' and (sessionScope.gradeCode eq 0 or sessionScope.gradeCode eq 1 or sessionScope.gradeCode eq 2) or sessionScope.loginType eq 'S'}">
					<button type="button" onclick="CHExcelDownload.excelDownCheck()" class="btn btn-success btn-sm">엑셀다운</button>
				</c:if>
				<button type="button" onclick="location.href='/admin/item/list'" class="btn btn-sm btn-warning">검색초기화</button>
			</div>
		</div>
	</form>
</div>
