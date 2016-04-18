<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div class="mypage-search-bar">
	<form id="search_form" onsubmit="return searchTerm(this);" method="get">
		<div>
			<div style="display:inline-block;font-size:14px;color:#636363;font-family:NanumGothic;font-weight:bold;">조회기간</div>

			<div style="display:inline; margin-left:10px;">
				<button type="button" onclick="calcDate(7)" class="btn btn-info btn-xs" style="margin:0;">1주일</button>
				<button type="button" onclick="calcDate(30)" class="btn btn-default btn-xs">1개월</button>
				<button type="button" onclick="calcDate(90)" class="btn btn-default btn-xs">3개월</button>
				<button type="button" onclick="calcDate(365)" class="btn btn-default btn-xs">1 년</button>
				<button type="button" onclick="calcDate('clear')" class="btn btn-primary btn-xs">전 체</button>
			</div>
			<div style="display:inline;margin-left:10px;">
				<span>
					<input type="text" name="searchDate1" class="datepicker" style="height:30px;font-size:13px;width:120px;" value="${pvo.searchDate1}"/>
				</span>
				<strong> ~ </strong>
				<span>
					<input type="text" name="searchDate2" class="datepicker" style="height:30px;font-size:13px;width:120px;" value="${pvo.searchDate2}"/>
				</span> 
			</div>
			
			<span style="margin-left:10px;">
				<button type="submit" class="btn btn-warning btn-xs"><span>조회하기</span></button>
			</span>
		</div>
		<div class="clearfix"></div>
	</form>
</div>