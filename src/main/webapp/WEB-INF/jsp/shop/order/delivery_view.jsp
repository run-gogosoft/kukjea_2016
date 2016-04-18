<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%--배송지 관리 리스트--%>
<div id="deliverList" class="ch-delivery-list">
	<div class="delivery-list-wrap">
		<div class="delivery-list-header">
			배송지 목록
		</div>
		<div>
			<div class="delivery-list-top-text">
				<br/>
				<p id="deliveryTopTitle" style="margin:0;"></p>
			</div>

			<%--<div class="pull-right" style="width:705px;">--%>
				<%--<div class="input-group pull-right" style="width:230px;">--%>
					<%--<input type="text" class="form-control" style="width:200px;height:30px;" placeholder="search" id="findword" name="findword" value="" disabled/>--%>
					<%--<div class="input-group-btn">--%>
						<%--<button type="button" class="btn btn-default btn-sm" onclick="CHDelivery.deliveryListShow()" style="height:30px;border-left:0;"><span class="glyphicon glyphicon-search"></span></button>--%>
					<%--</div>--%>
				<%--</div>--%>
				<%--<div class="dropdown pull-right">--%>
					<%--<button class="btn btn-default btn-sm dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" style="margin-right:3px;">--%>
						<%--전체--%>
						<%--<span class="caret"></span>--%>
					<%--</button>--%>
					<%--<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">--%>
						<%--<li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="searchProc(this);return false;" data-value="all" data-submit="">전체</a></li>--%>
						<%--<li class="divider"></li>--%>
						<%--<li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="searchProc(this);return false;" data-value="title" data-submit="">배송지이름</a></li>--%>
						<%--<li role="presentation"><a role="menuitem" tabindex="-1" href="#" onclick="searchProc(this);return false;" data-value="name" data-submit="">받는사람</a></li>--%>
					<%--</ul>--%>
					<%--<input type="hidden" name="deliverySearch" id="deliverySearch" value="" />--%>
				<%--</div>--%>
			<%--</div>--%>
			<div class="clearfix"></div>
		</div>
		<div class="delivery-list-content" style="margin-top:10px;">
			<!-- 배송지리스트 template -->
			<script id="deliveryTrTemplate" type="text/html">
				<tr>
					<td class="text-center"><input type="radio" name="deliverySelected" value="<%="${seq}"%>"/></td>
					<td class="text-center">
						<%="${title}"%>
						{{if defaultFlag === 'Y'}}
							(기본)
						{{/if}}
					</td>
					<td class="text-left"><%="${addr1}"%>&nbsp;<%="${addr2}"%></td>
					<td class="text-center"><%="${name}"%></td>
					<td class="text-center"><%="${cell}"%></td>
				</tr>
			</script>
			<%--배송지 등록--%>
			<div id="deliveryForm" style="display:none">
				<table class="order-info-table delivery-table" style="width:100%">
					<colgroup>
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<tr>
						<td>배송지 이름<span class="need">*</span></td>
						<td style="font-size:12px;color:#636363;">
							<input type="text" name="title" class="form-control" data-name="title" alt="배송지 이름" style="width:200px;height: 30px;"/>
							<input type="checkbox" name="defaultFlag" data-name="defaultFlag" style="margin-left:5px;height:auto"/> 이 주소를 기본으로 설정함
						</td>
					</tr>
					<tr>
						<td>받으시는 분<span class="need">*</span></td>
						<td style="color:#d2d2d2;">
							<input type="text" name="name" data-name="name" class="form-control" alt="받으시는 분" style="width:200px;height: 30px;"/>
						</td>
					</tr>
					<tr>
						<td>휴대폰 번호<span class="need">*</span></td>
						<td style="color:#d2d2d2;">
							<input type="text" name="cell1" data-name="cell1" class="form-control tel-input" alt="휴대폰 번호" onblur="numberCheck(this);" style="margin-left:0;" maxlength="4"/>
							&nbsp;&nbsp;-
							<input type="text" name="cell2" data-name="cell2" class="form-control tel-input" alt="휴대폰 번호" onblur="numberCheck(this);" maxlength="4"/>
							&nbsp;&nbsp;-
							<input type="text" name="cell3" data-name="cell3" class="form-control tel-input" alt="휴대폰 번호" onblur="numberCheck(this);" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<td>집 전화번호<span class="need">*</span></td>
						<td style="color:#d2d2d2;">
							<input type="text" name="tel1" data-name="tel1" class="form-control tel-input" alt="집 전화번호" onblur="numberCheck(this);" style="margin-left:0;" maxlength="4"/>
							&nbsp;&nbsp;-
							<input type="text" name="tel2" data-name="tel2" class="form-control tel-input" alt="집 전화번호" onblur="numberCheck(this);" maxlength="4"/>
							&nbsp;&nbsp;-
							<input type="text" name="tel3" data-name="tel3" class="form-control tel-input" alt="집 전화번호" onblur="numberCheck(this);" maxlength="4"/>
						</td>
					</tr>
					<tr>
						<td>배송지 주소<span class="need">*</span></td>
						<td>
							<input type="text" id="deliveryPostcode" name="postcode" data-name="postcode" class="form-control tel-input" alt="주소" style="height: 30px;margin:0;" readonly/>
							<button type="button" class="btn btn-xs small-btn" onclick="CHDeliPostCodeUtil.deliveryPostWindow('open', '#deliveryForm');">우편번호 찾기</button>
							<input type="text" class="form-control" id="deliveryAddr1" name="addr1" data-name="addr1" alt="주소" style="display:block;height: 30px;margin-top:5px;"  readonly/>
							<input type="text" class="form-control" id="deliveryAddr2" name="addr2" data-name="addr2" alt="주소" style="display:block;height: 30px;margin-top:5px;"/>
						</td>
					</tr>
				</table>
				<div style="text-align:center;margin:20px 23px 10px 0;">
					<button type="button" onclick="CHDelivery.deliverySubmit()"  class="btn btn-info btn-sm">확인</button>
					<button type="button" onclick="CHDelivery.deliveryListBack()" style="margin-left:10px" class="btn btn-default btn-sm">목록보기</button>
				</div>
			</div>

			<%--배송지 리스트--%>
			<div id="deliveryList">
				<table class="table table-bordered" style="margin-top:15px;">
					<colgroup>
						<col width="7%"/>
						<col width="20%"/>
						<col/>
						<col width="20%"/>
						<col width="16%"/>
					</colgroup>
					<thead>
						<tr>
							<td>선택</td>
							<td>배송지이름</td>
							<td>주소</td>
							<td>받는사람</td>
							<td>연락처</td>
						</tr>
					</thead>
					<tbody id="deliveryListTarget">
						<tr>
							<td class="text-center" style="vertical-align:middle" colspan="5">배송지 목록을 불러오고 있습니다..&nbsp;&nbsp;<img src="/front-assets/images/common/ajaxloader.gif" alt="" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="delivery-list-footer">
			<div class="">
				<div class="pull-left" style="margin:0 23px 10px 0;">
					<button type="button" onclick="CHDelivery.deliveryForm('insert')" class="btn btn_default btn_sm">배송지 추가</button>
					<button type="button" onclick="CHDelivery.deliveryForm('update')"  class="btn btn_default btn_sm">수정</button>
					<button type="button" onclick="CHDelivery.deliveryDelete()" class="btn btn_default btn_sm">삭제</button>
				</div>

				<div class="pull-right" style="margin:0 0 10px 0;">
					<button type="button" onclick="CHDelivery.deliveryListHide()" class="btn btn_default btn_sm">취소</button>
					<button type="button" onclick="CHDelivery.deliverySelected()"  class="btn btn_blue btn_sm">배송지로 선택</button>
				</div>
			</div>
		</div>
	</div>
</div>