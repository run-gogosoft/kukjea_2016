<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="hh-writebox" id="origin">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header">
			<span style="font-family: NanumGothic;font-weight:bold;font-size:24px;">우편번호 찾기</span><i onclick="CHPostCodeUtil.postWindow('close');" class="fa fa-times" style="position: absolute;top:10px;left: 440px;cursor: pointer;"></i>
		</div>
		<div class="hh-writebox-content">
			<div class="hh-writebox-text-check">
				<br/>
				<p style="margin-bottom:5px;">◇ 지번주소 검색시 주소의 동(읍/면)이름을 입력해서 검색해 주세요.</p>
				<p class="example">예) 서울시 강남구 역삼1동이라면, '역삼1' 혹은 '역삼1동' 검색</p>
				<p style="margin-bottom:5px;">◇ 도로명주소 검색시 도로명과 건물번호를 입력해서 검색해 주세요.</p>
				<p class="example">예) 테헤란로(도로명) + 427 (건물번호)</p>
				<p>◇ 검색결과는 최대 1000건까지만 보여집니다(자세한 주소를 입력해주세요).</p>
				<div class="input-group">
					<input type="text" class="form-control" id="keyword" style="width: 300px;height: 28px;" onkeydown="CHPostCodeUtil.enterSearch();" placeholder="주소명">
					<button type="button" class="btn btn-warning input-group-addon search-btn" onclick="CHPostCodeUtil.getAddr(1);" style="background-color:#f0ad4e;width: 62px;"><i class="fa fa-search"></i>검색</button>
				</div>
			</div>
			<div class="hh-writebox-answer">
				<hr />
				<div id="showAddr" class="inputgroup" style="display: none;">
				</div>
			</div>
		</div>
	</div>
</div>

<div class="hh-writebox" id="return">
	<div class="hh-writebox-wrap">
		<div class="hh-writebox-header">
			<span style="font-family: NanumGothic;font-weight:bold;font-size:24px;">우편번호 찾기</span><i onclick="CHReturnPostCodeUtil.returnPostWindow('close');" class="fa fa-times" style="position: absolute;top:10px;left: 440px;cursor: pointer;"></i>
		</div>
		<div class="hh-writebox-content">
			<div class="hh-writebox-text-check">
				<br/>
				<p style="margin-bottom:5px;">◇ 지번주소 검색시 주소의 동(읍/면)이름을 입력해서 검색해 주세요.</p>
				<p class="example">예) 서울시 강남구 역삼1동이라면, '역삼1' 혹은 '역삼1동' 검색</p>
				<p style="margin-bottom:5px;">◇ 도로명주소 검색시 도로명과 건물번호를 입력해서 검색해 주세요.</p>
				<p class="example">예) 테헤란로(도로명) + 427 (건물번호)</p>
				<p>◇ 검색결과는 최대 1000건까지만 보여집니다(자세한 주소를 입력해주세요).</p>
				<div class="input-group">
					<input type="text" class="form-control" id="returnKeyword" style="width: 300px;height: 28px;" onkeydown="CHReturnPostCodeUtil.returnEnterSearch();" placeholder="주소명">
					<button type="button" class="btn btn-warning input-group-addon search-btn" onclick="CHReturnPostCodeUtil.returnGetAddr(1);" style="background-color:#f0ad4e;width: 62px;"><i class="fa fa-search"></i>검색</button>
				</div>
			</div>
			<div class="hh-writebox-answer">
				<hr />
				<div id="returnShowAddr" class="inputgroup" style="display: none;">
				</div>
			</div>
		</div>
	</div>
</div>