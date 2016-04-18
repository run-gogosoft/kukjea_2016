<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/jsp/shop/include/header.jsp" %>
	<style type="text/css">
		body {
			font-size:9pt;
		}
		ul li {
			list-style:none;
			padding-right:5px;
		}
		input[type='text'] {
			border:1px solid #cccccc;
			vertical-align:middle;
			padding:2px 2px 2px 2px;
		}
	</style>
</head>
<body>
<div style="margin:5px 5px 5px 5px;font-size:9pt;">
	<%--탭메뉴--%>
	<table style="font-size:9pt;width:100%">
		<colgroup>
			<col style="width:5%"/>
			<col style="width:45%"/>
			<col style="width:45%"/>
			<col style="width:5%"/>
		</colgroup>
		<thead>
		<tr>
			<th style="border-bottom:1px solid #cccccc;"></th>
			<th id="tab_menu01" onclick="moveTab('01')" style="text-align:center;height:30px;cursor:pointer;border-top:1px solid #cccccc;border-left:1px solid #cccccc;border-right:1px solid #cccccc">
				지번 주소
			</th>
			<th id="tab_menu02" onclick="moveTab('02')" style="text-align:center;height:30px;cursor:pointer;border-bottom:1px solid #cccccc;background-color:#eeeeee">
				도로명 주소
			</th>
			<th style="border-bottom:1px solid #cccccc;"></th>
		</tr>
		</thead>
	</table>
	<%--지번 주소 조회 폼--%>
	<div id="search_form1" style="margin-top:20px">
		동(읍/면/리)명 입력
		<input type="text" name="emd" value=""/>
		<input type="button" value="검색" onclick="getOldList()" style="width:50px;height:20px"/>
	</div>
	<%--도로명 주소 조회 폼--%>
	<div id="search_form2" style="display:none;margin-top:20px;">
		<ul>
			<li style="float:left">
				<select name="sido" id="sido" onchange="getSigunguList()">
					<option value="">--- 시/도 ---</option>
				</select>
			</li>
			<li>
				<select name="sigungu" id="sigungu">
					<option value="">--- 시/군/구 ---</option>
				</select>
			</li>
		</ul>

		<ul>
			<li style="float:left"><input type="radio" name="searchType" value="1" checked/>도로명 + 건물번호</li>
			<li style="float:left"><input type="radio" name="searchType" value="2"/>동(읍/면/리)명 + 번지</li>
			<li><input type="radio" name="searchType" value="3"/>건물명(아파트)</li>
		</ul>
		<ul>
			<li id="input1" style="float:left">
				<input type="text" name="streetName" id="streetName" placeholder="도로명"/> +
				<input type="text" name="buildingNo" id="buildingNo" placeholder="건물번호"/>
			</li>
			<li id="input2" style="float:left;display:none">
				<input type="text" name="emd" id="emd" placeholder="동(읍/면/리)"/> +
				<input type="text" name="streetAddr" id="streetAddr" placeholder="번지"/>
			</li>
			<li id="input3" style="float:left;display:none">
				<input type="text" name="buildingName" id="buildingName" placeholder="건물명(아파트)"/>
			</li>
			<li><input type="button" value="검색" onclick="getList()" style="width:50px;height:20px"/></li>
		</ul>
	</div>
	<%--주소 조회 결과 리스트--%>
	<div id="search_list" style="display:none;margin-top:20px;">
		<script id="addr_list_tmpl" type="text/html">
			<tr>
				<td style="border-top:dashed #cccccc 1px"><span id="postcode<%="${seq}"%>"><%="${postcode}"%></span></td>
				<td style="border-top:dashed #cccccc 1px">
					<a href="#addr<%="${seq}"%>" id="addr<%="${seq}"%>" onclick="selectAddr('<%="${seq}"%>')">
					<%="${sido}"%> <%="${sigungu}"%> <%="${streetName}"%> <%="${buildingNo}"%> <%="${buildingName}"%><br/>
					(구 <%="${emd}"%><%="${li}"%> <%="${streetAddr}"%>)
					</a>
				</td>
			</tr>
		</script>
		<script id="addr_list_old_tmpl" type="text/html">
			<tr>
				<td style="border-top:dashed #cccccc 1px"><span id="postcode<%="${postcode}${serialNo}"%>"><%="${postcode}"%></span></td>
				<td style="border-top:dashed #cccccc 1px">
					<a href="#addr<%="${postcode}${serialNo}"%>" id="addr<%="${postcode}${serialNo}"%>" onclick="selectAddr('<%="${postcode}${serialNo}"%>')">
						<%="${sido}"%> <%="${sigungu}"%> <%="${emd}"%> <%="${li}"%> <%="${streetAddr}"%> <%="${buildingName}"%>
					</a>
				</td>
			</tr>
		</script>

		<table style="width:100%;">
			<colgroup>
				<col style="width:20%"/>
				<col style="width:80%"/>
			</colgroup>
			<thead>
			<tr>
				<th>우편번호</th>
				<th>주소</th>
			</tr>
			</thead>
			<tbody id="addr_list">
			<tr>
				<td colspan="2" style="border-top:dashed #cccccc 1px">데이터를 불러오고 있습니다.</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>

<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${const.ASSETS_PATH}/front-assets/js/jquery.tmpl.js"></script>
<script type="text/javascript">
	/* 메뉴 이동 */
	var moveTab = function(tabId) {
		if(tabId === "01") {
			//지번주소 탭메뉴 활성화, 도로명주소 탭메뉴 비활성화
			$("#tab_menu01").css("border-top","1px solid #cccccc");
			$("#tab_menu01").css("border-left","1px solid #cccccc");
			$("#tab_menu01").css("border-right","1px solid #cccccc");
			$("#tab_menu01").css("border-bottom-width","0");
			$("#tab_menu01").css("background-color","#ffffff");
			$("#tab_menu02").css("border-width","0");
			$("#tab_menu02").css("border-bottom","1px solid #cccccc");
			$("#tab_menu02").css("background-color","#eeeeee");

			$("#search_form1").show();
			$("#search_form2").hide();
		} else if(tabId === "02") {
			//도로명주소 탭메뉴 활성화, 지번주소 탭메뉴 비활성화
			$("#tab_menu02").css("border-top","1px solid #cccccc");
			$("#tab_menu02").css("border-left","1px solid #cccccc");
			$("#tab_menu02").css("border-right","1px solid #cccccc");
			$("#tab_menu02").css("border-bottom-width","0");
			$("#tab_menu02").css("background-color","#ffffff");
			$("#tab_menu01").css("border-width","0");
			$("#tab_menu01").css("border-bottom","1px solid #cccccc");
			$("#tab_menu01").css("background-color","#eeeeee");

			$("#search_form1").hide();
			$("#search_form2").show();
			//도로명 주소 메뉴 이동시 시/도 리스트 가져오기
			$.ajax({
				url:"/shop/addr/list/sido/ajax",
				type:"get",
				success:function(data) {
					var list = $.parseJSON(data);
					if(list.length > 0) {
						$("#sido option").not("[value='']").remove();
						for(var i=0; i<list.length; i++) {
							$("#sido").append("<option value='"+list[i].sido+"'>"+list[i].sido+"</option>");
						}
					}
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			})
		}
	};

	/* 시군구 리스트 */
	var getSigunguList = function() {
		$.ajax({
			url:"/shop/addr/list/sigungu/ajax",
			type:"get",
			data:{sido:$("#sido").val()},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				if(list.length >0) {
					$("#sigungu option").not("[value='']").remove();
					for(var i=0; i<list.length; i++) {
						$("#sigungu").append("<option value='"+list[i].sigungu+"'>"+list[i].sigungu+"</option>");
					}
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		})
	}

	//도로명 주소 리스트
	var getList = function() {
		$("#search_list").show();
		$.ajax({
			url:"/shop/addr/list/ajax",
			type:"get",
			data:{
				searchType:$("#search_form2 input:radio[name='searchType']:checked").val(),
				sido:$("#sido").val(),
				sigungu:$("#sigungu").val(),
				streetName:$("#streetName").val(),
				buildingNo:$("#buildingNo").val(),
				emd:$("#emd").val(),
				streetAddr:$("#streetAddr").val(),
				buildingName:$("#buildingName").val()
			},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				if(list.length >0) {
					$("#addr_list").html($("#addr_list_tmpl").tmpl(list));
				} else {
					$("#addr_list").html("<tr><td colspan='2'>조회된 데이터가 없습니다.</td></tr>");
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		})
	}

	//기존 지번 주소 리스트
	var getOldList = function() {
		$("#search_list").show();
		$.ajax({
			url:"/shop/addr/list/old/ajax",
			type:"get",
			data:{
				emd:$("#search_form1 input[name='emd']").val()
			},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				if(list.length >0) {
					$("#addr_list").html($("#addr_list_old_tmpl").tmpl(list));
				} else {
					$("#addr_list").html("<tr><td colspan='2'>조회된 데이터가 없습니다.</td></tr>");
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		})
	}

	var callAddr = "${callAddr}";

	//opener 창의 폼에 선택된 주소값 넘김
	var selectAddr = function(seq) {
		//주문 페이지, 배송지 등록/수정 폼
		if(callAddr === 'delivery') {
			$(opener.document).find("#deliveryPostCode").val($("#postcode"+seq).text());
			$(opener.document).find("#deliveryAddr1").val($.trim($("#addr"+seq).text()));
		} else {
			$(opener.document).find("input[name='postcode']").val($("#postcode"+seq).text());
			$(opener.document).find("input[name='addr1']").val($.trim($("#addr"+seq).text()));
		}
		self.close();
	}
</script>
</body>
</html>
