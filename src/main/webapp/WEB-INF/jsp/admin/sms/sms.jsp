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
		<h1>SMS 관리 <small></small></h1>
		<ol class="breadcrumb">
			<li><a href="/admin/index"><i class="fa fa-home"></i>Home</a></li>
			<li>시스템 관리</li>
			<li class="active">SMS 관리</li>
		</ol>
	</section>
	<!-- 콘텐츠 -->
	<section class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="box">
					<div class="box-header">
						<ul class="nav nav-tabs" style="margin-bottom: 10px;">
							<li><a href="/admin/sms/list">SMS 관리 리스트</a></li>
							<li><a href="/admin/sms/log/list">SMS 발송내역 리스트</a></li>
							<li class="active"><a href="/admin/sms/send">SMS 발송하기</a></li>
						</ul>
					</div>
					<form action="/admin/sms/send/proc" onsubmit="return submitProc(this);" method="post" class="form-horizontal" target="zeroframe">
						<div class="box-body">
							<div class="row">
								<div class="col-md-6">
									<div class="box box-default box-solid">
										<div class="box-header with-border">
											<h3 class="box-title">발송대상 휴대폰 번호 입력</h3>
										</div>
										<div class="box-body">
											<div class="form-group">
												<div class="col-md-3">
													<textarea class="form-control" id="trPhone" name="trPhone" rows="16" onfocusout="calcRow()" placeholder="휴대폰 번호 입력" alt="휴대폰 번호"></textarea>
													<div id="row_count" class="text-info text-right"></div>
												</div>
												<div class="col-md-9 text-danger">
													<div style="margin-bottom:20px;font-weight:bold;">
														<i class="fa fa-exclamation-circle"></i> 2개 이상의 휴대폰 번호를 입력할 경우 각 항목 사이에 엔터키(줄바꿈)를 눌러<br/>구분지어 주시기 바랍니다. 
													</div>
													<div style="margin-bottom:20px;font-weight:bold;">
														<i class="fa fa-exclamation-circle"></i> 엑셀에서 가져올 경우 휴대폰번호 항목 열을 선택/복사하여 입력 칸에 붙여넣기 하시면 됩니다. <br/>
													</div>
													<div style="margin-bottom:20px;font-weight:bold;">
														<i class="fa fa-exclamation-circle"></i> 각각의 휴대폰 번호는 숫자('-' 기호 포함)로만 이루어져야 합니다.
													</div>
													<div style="margin-bottom:20px;font-weight:bold;">
														<i class="fa fa-exclamation-circle"></i> 메세지는 최대 129byte까지 입력 가능합니다.
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-1 text-center" style="padding-top:160px">
									<i class="fa fa-chevron-right fa-4x"></i>
								</div>
								<div class="col-md-2">
									<div class="box box-default box-solid">
										<div class="box-header with-border">
											<h5 style="margin-bottom:5px;">
												<i class="fa fa-signal fa-2x"></i>
												<div class="pull-right"><i class="fa fa-envelope fa-2x"></i></div>
											</h5>
										</div>
										<div class="box-body" style="background:transparent -moz-linear-gradient(center top , #FAFAFA 0%, #E9E9E9 100%) repeat scroll 0% 0%">
											<div class="form-group">
												<div class="col-md-12">발신번호 : 02-2222-3896</div>
											</div>
											<div class="form-group">
												<div class="col-md-12">
													<textarea class="form-control" id="trMsg" name="trMsg" alt="문자메세지" onfocus="checkText();" style="height:200px"></textarea>
												</div>
											</div>
											<span id="contentByte">0</span>Byte
											<div class="pull-right" style="margin-top:-10px;">
												<button type="submit" class="btn btn-sm btn-info">메세지 보내기</button>
											</div>
										</div>
									</div>
								</div>
								<!-- <div class="col-md-4">
									<div class="box box-default box-solid">
										<div class="box-header with-border">
											<div class="form-group" style="margin-bottom:5px;">
												<div class="col-md-5">
													<input type="hidden" id="mallSeq" value="1">
													<input type="text" class="form-control" id="memberId" placeholder="아이디">
												</div>
												<div class="col-md-2">
													<button type="button" class="btn btn-warning" style="color:#fff;" onclick="searchMember();">검색</button>
												</div>
											</div>
										</div>
										<div class="box-body text-center" style="max-height:305px;background:transparent -moz-linear-gradient(center top , #FAFAFA 0%, #E9E9E9 100%) repeat scroll 0% 0%">
											<div class="form-group">
												<div class="col-md-5">
													<select class="form-control" id="member" size="15" multiple>
														<option value="">--검색된 회원--</option>
													</select>
												</div>
												<div class="col-md-2" style="padding-top:90px;">
													<div style="margin-bottom:5px;"><button type="button" class="btn btn-default btn-xs" onclick="memberAdd('add');"><i class="fa fa-angle-double-right"></i></button></div>
													<div><button type="button" class="btn btn-default btn-xs" onclick="memberAdd('del');"><i class="fa fa-angle-double-left"></i></button></div>
												</div>
												<div class="col-md-5">
													<select class="form-control" id="send" name="memberCell" size="15" multiple>
														<option value="">--수신 회원--</option>
													</select>
												</div>
											</div>
											<div class="pull-right" style="margin-top:-10px;">
												<button type="submit" class="btn btn-info">메세지 보내기</button>
											</div>
										</div>
									</div>
								</div> -->
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>

<div class="main">
	<div class="container">
		<div class="row">
			<div class="span12" style="width: 1150px;">
				<div class="widget widget-table stacked">
					<div class="widget-header">
						<i class="icon-th-list"></i>
						<h3>${ title }</h3>
					</div>
					<div class="widget-content">



							<div class="smsform" style="float:right;width: 560px;">
								<div style="position: relative;padding: 30px;">

								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
</body>
<script type="application/javascript">
	function checkText() {
		var searchStr = "";
		if (searchStr != $('#trMsg').val()) {
			contentLength($('#trMsg'));
		}else {
			$('#contentByte').text("0");
		}
		setTimeout('checkText()', 100);
	}

	var contentLength = function(obj){
		var stringByteLength = $(obj).val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length;
		$('#contentByte').text(stringByteLength);
	}

	var submitProc = function(obj) {
		var checkflag = true;
		$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
			if($.trim($(this).val()) == "") {
				alert($(this).attr("alt") + "를 채워주세요!");
				$(this).focus();
				checkflag = false;
			}
		});
		
		if(!checkflag) {
			return false;
		}
		
		if(!confirm("해당 메세지를 입력하신 휴대폰 번호로 일괄 발송하시겠습니까?")) {
			return false;
		}
		
		return true;
	};
	
	/** 휴대폰 번호 입력 칸 빈줄 제거 */
	var calcRow = function() {
		var count = 0;
		var rows = $("#trPhone").val().split("\n");
		
		var validRows = "";
		for(var i=0; i < rows.length; i++) {
			if($.trim(rows[i]) != "") {
				count++;
				validRows = validRows + rows[i] + "\n";
			}
		}
		
		$("#trPhone").val(validRows);
		
		$("#row_count").html("<strong>"+count + "</strong>건");
	}
</script>
</html>
