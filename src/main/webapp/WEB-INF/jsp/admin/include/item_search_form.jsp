<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="box">
	<!-- 소제목 -->
	<!-- <div class="box-header"><h3 class="box-title"></h3></div> -->
	<!-- 내용 -->
	<form id="searchForm" action="/admin/item/list" class="form-horizontal" method="get" onsubmit="search(this);">
		<input type="hidden" name="pageNum"  id="pageNum" value="${vo.pageNum}"/>
		<input type="hidden" name="orderByName" id="orderByName" value="${vo.orderByName}"/>
		<input type="hidden" name="orderByType" id="orderByType" value="${vo.orderByType}"/>
		<input type="hidden" name="mallSeq" id="mallSeq" value="${mallSeq}"/>
		<div class="box-body">
			<div class="form-group">
				<label class="col-md-2 control-label">카테고리</label>
				<div class="col-md-2">
					<select class="form-control" name="cateLv1Seq" onchange="$('#searchForm')[0].submit()">
						<option value="">---대분류---</option>
						<c:forEach var="item" items="${cateLv1List}" varStatus="status" begin="0" step="1">
							<option value="${item.seq}" <c:if test="${vo.cateLv1Seq eq (item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="cateLv2Seq" onchange="$('#searchForm')[0].submit()">
						<option value="">---중분류---</option>
						<c:forEach var="item" items="${cateLv2List}" varStatus="status" begin="0" step="1">
							<option value="${item.seq}" <c:if test="${vo.cateLv2Seq eq (item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="cateLv3Seq" onchange="$('#searchForm')[0].submit()">
						<option value="">---소분류---</option>
						<c:forEach var="item" items="${cateLv3List}" varStatus="status" begin="0" step="1">
							<option value="${item.seq}" <c:if test="${vo.cateLv3Seq eq (item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
					</select>
				</div>
				<div class="col-md-2">
					<select class="form-control" name="cateLv4Seq" onchange="$('#searchForm')[0].submit()">
						<option value="">---세분류---</option>
						<c:forEach var="item" items="${cateLv4List}" varStatus="status" begin="0" step="1">
							<option value="${item.seq}" <c:if test="${vo.cateLv4Seq eq (item.seq)}">selected="selected"</c:if>>${item.name}</option>
						</c:forEach>
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
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">정렬방식</label>
				<div class="col-md-2">
					<select class="form-control" id="orderType" name="orderType">
						<option value="">---구분---</option>
						<option value="lowprice" <c:if test="${vo.orderType eq 'lowprice'}">selected="selected"</c:if>>낮은가격</option>
						<option value="highprice" <c:if test="${vo.orderType eq 'highprice'}">selected="selected"</c:if>>높은가격</option>
						<option value="name" <c:if test="${vo.orderType eq 'name'}">selected="selected"</c:if>>상품명</option>
						<option value="maker" <c:if test="${vo.orderType eq 'maker'}">selected="selected"</c:if>>제조사</option>
						<option value="toporder" <c:if test="${vo.orderType eq 'toporder'}">selected="selected"</c:if>>판매순</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">상품명/상품코드/제조사/규격</label>
				<div class="col-md-2">
					<select class="form-control" id="itemSearchType" name="itemSearchType">
						<option value="">---구분---</option>
						<option value="seq"  <c:if test="${vo.itemSearchType eq 'seq'}">selected</c:if>>상품코드</option>
						<option value="name" <c:if test="${vo.itemSearchType eq 'name'}">selected</c:if>>상품명</option>
						<option value="maker" <c:if test="${vo.itemSearchType eq 'maker'}">selected</c:if>>제조사</option>
						<option value="type" <c:if test="${vo.itemSearchType eq 'type'}">selected</c:if>>규격</option>
					</select>
				</div>
				<div class="col-md-2">
					<input class="form-control" type="text" id="itemSearchValue" name="itemSearchValue" value="${vo.itemSearchValue}" maxlength="20"/>
				</div>
			</div>
			<div class="form-group">
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
		</div>
		<div class="box-footer">
			<div class="pull-left">! 총 <b style="color:#00acd6;"><fmt:formatNumber value="${vo.totalRowCount}"/></b> 건이 조회 되었습니다.</div>
			<div class="pull-right">
				<button type="submit" class="btn btn-sm btn-default">검색하기</button>
				<c:if test="${sessionScope.loginType eq 'A'  or sessionScope.loginType eq 'S'}">
					<button type="button" onclick="CHExcelDownload.excelDownCheck()" class="btn btn-success btn-sm">엑셀다운</button>
				</c:if>
				<button type="button" onclick="location.href='/admin/item/list?mallSeq=${mallSeq}'" class="btn btn-sm btn-warning">검색초기화</button>
			</div>
		</div>
	</form>
</div>
