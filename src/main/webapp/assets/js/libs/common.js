/** 폼 필수값 체크 */
var checkRequiredValue = function(frmObj, attrName) {
	var submit = true;
	/* 입력폼 앞뒤 공백 일괄 제거 */
	$(frmObj).find("input[type='text'],input[type='password'],textarea").each( function() {
		var value = $.trim($(this).val());
		$(this).val(value);
	});

	/* 필수 값 공백 체크 */
	$(frmObj).find("input["+attrName+"],textarea["+attrName+"],select["+attrName+"]").each( function() {
		if(submit && $(this).val() == "") {
			alert($(this).attr(attrName) + " 항목은 필수 값입니다.");
			this.focus();
			submit = false;
		}
	});

	return submit;
};

/** datepicker 기본 설정*/
var showDatepicker = function(format) {
	$(".datepicker").datepicker({
		dateFormat: format,
		//changeMonth: false,
		//changeYear: false,
		showButtonPanel: true,
        //currentText: '오늘 날짜',
        closeText: 'Close',
		//dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
        //dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
        //monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
        //monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	});
	//$(".datepicker").datepicker();
};

/** 숫자이외에 나머지 문자 공백 처리 */
var numberCheck = function(obj){
	obj.value=obj.value.replace(/[^\d]/g, '');
};

var CHPostCodeUtil = {
	/** 주소 검색 */
	getAddr:function(page){
		$.ajax({
			url :"http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
			,type:"post"
			,data:{currentPage:page,countPerPage:100,confmKey:'U01TX0FVVEgyMDE1MDkyNDExMTkxOA==',keyword:$('#keyword').val()}
			,dataType:"jsonp"
			,crossDomain:true
			,success:function(xmlStr){
				if(navigator.appName.indexOf("Microsoft") > -1){
					var xmlData = new ActiveXObject("Microsoft.XMLDOM");
					xmlData.loadXML(xmlStr.returnXml)
				}else{
					var xmlData = xmlStr.returnXml;
				}
				$("#showAddr").html("");
				var errCode = $(xmlData).find("errorCode").text();
				var errDesc = $(xmlData).find("errorMessage").text();
				if(errCode != "0"){
					alert(errDesc);
				}else{
					if(xmlStr != null){
						$('#showAddr').fadeIn();
						CHPostCodeUtil.makeList(xmlData, page);
					}
				}
			}
			,error: function(xhr,status, error){
				alert("에러발생");
			}
		});
	}
	, makeList:function(xmlStr, page){
		var totalPage = parseInt($(xmlStr).find("totalCount").text()/$(xmlStr).find("countPerPage").text())+1;
		var htmlStr = "";
		htmlStr += "<table class='table table-condensed table-hover' style='width: 383px;'>";
		htmlStr += "<tr style='background-color: #f7f7f7;'>";
		htmlStr += "<td style='width: 300px;'>주소</td>";
		htmlStr += "<td>우편번호</td>";
		htmlStr += "</tr>";
		$(xmlStr).find("juso").each(function(){
			htmlStr += "<tr>";
			htmlStr += "<td><a href='javascript:;' style='text-decoration:none;' onclick='CHPostCodeUtil.showAddr(\""+$(this).find('roadAddr').text()+"\",\""+$(this).find('zipNo').text()+"\");'><span style='color: dodgerblue;'>도로명:</span><span style='color: #000;'>"+$(this).find('roadAddr').text()+"</span></a><br/>"
			htmlStr += "<a href='javascript:;' style='text-decoration:none;' onclick='CHPostCodeUtil.showAddr(\""+$(this).find('jibunAddr').text()+"\",\""+$(this).find('zipNo').text()+"\");'><span style='color: dodgerblue;'>지번:</span><span style='color: #000;'>"+$(this).find('jibunAddr').text()+"</span></a></td>";
			htmlStr += "<td>"+$(this).find('zipNo').text()+"</td>";
			htmlStr += "</tr>";
		});
		htmlStr += "</table>";
		htmlStr += "<div id='paging' style='text-align:center; border-top: 1px solid #dddddd;'><ul class='pagination'>";
		for(var i=0; i<totalPage; i++){
			if(page==i+1) {
				htmlStr += "<li class='active'><a href='#' onclick='return false;'>" + (i + 1) + "</a></li>";
			}else{
				htmlStr += "<li><a href='#' onclick='CHPostCodeUtil.getAddr("+(i + 1)+")'>" + (i + 1) + "</a></li>";
			}
		}
		htmlStr += "</ul></div>"

		$("#showAddr").html(htmlStr);
	}
	, enterSearch:function() {
		var evt_code = (window.netscape) ? ev.which : event.keyCode;
		if (evt_code == 13) {
			event.keyCode = 0;
			CHPostCodeUtil.getAddr(1); //jsonp사용시 enter검색
		}
	}
	, postWindow:function(sort, id){
		if(sort == 'open') {
			$("#origin").show().css({opacity:0, marginTop:100}).animate({opacity:1, marginTop:$(id).offset().top}, "slow");
			$("html, body").animate({scrollTop:$(id).offset().top - 200}, 700);
		}else if(sort == 'close'){
			$("#showAddr").fadeOut();
			$("#showAddr").html('');
			$("#keyword").val('');

			$("#origin").hide();
		}
	}
	, showAddr:function(addr, post){
		$("input[name='postcode']").val(post);
		$("input[name='addr1']").val(addr);

		CHPostCodeUtil.postWindow('close');
		$("body").animate({scrollTop:$("input[name='addr2']").offset().top-300}, 500);
		$("input[name='addr2']").focus();
	}
};

var CHReturnPostCodeUtil = {
	/** 주소 검색 */
	returnGetAddr:function(page){
		$.ajax({
			url :"http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do"  //인터넷망
			,type:"post"
			,data:{currentPage:page,countPerPage:100,confmKey:'U01TX0FVVEgyMDE1MDkyNDExMTkxOA==',keyword:$('#returnKeyword').val()}
			,dataType:"jsonp"
			,crossDomain:true
			,success:function(xmlStr){
				if(navigator.appName.indexOf("Microsoft") > -1){
					var xmlData = new ActiveXObject("Microsoft.XMLDOM");
					xmlData.loadXML(xmlStr.returnXml)
				}else{
					var xmlData = xmlStr.returnXml;
				}
				$("#returnShowAddr").html("");
				var errCode = $(xmlData).find("errorCode").text();
				var errDesc = $(xmlData).find("errorMessage").text();
				if(errCode != "0"){
					alert(errDesc);
				}else{
					if(xmlStr != null){
						$('#returnShowAddr').fadeIn();
						CHReturnPostCodeUtil.returnMakeList(xmlData, page);
					}
				}
			}
			,error: function(xhr,status, error){
				alert("에러발생");
			}
		});
	}
	, returnMakeList:function(xmlStr, page){
		var totalPage = parseInt($(xmlStr).find("totalCount").text()/$(xmlStr).find("countPerPage").text())+1;
		var htmlStr = "";
		htmlStr += "<table class='table table-condensed table-hover' style='width: 383px;'>";
		htmlStr += "<tr style='background-color: #f7f7f7;'>";
		htmlStr += "<td style='width: 300px;'>주소</td>";
		htmlStr += "<td>우편번호</td>";
		htmlStr += "</tr>";
		$(xmlStr).find("juso").each(function(){
			htmlStr += "<tr>";
			htmlStr += "<td><a href='javascript:;' style='text-decoration:none;' onclick='CHReturnPostCodeUtil.returnShowAddr(\""+$(this).find('roadAddr').text()+"\",\""+$(this).find('zipNo').text()+"\");'><span style='color: dodgerblue;'>도로명:</span><span style='color: #000;'>"+$(this).find('roadAddr').text()+"</span></a><br/>"
			htmlStr += "<a href='javascript:;' style='text-decoration:none;' onclick='CHReturnPostCodeUtil.returnShowAddr(\""+$(this).find('jibunAddr').text()+"\",\""+$(this).find('zipNo').text()+"\");'><span style='color: dodgerblue;'>지번:</span><span style='color: #000;'>"+$(this).find('jibunAddr').text()+"</span></a></td>";
			htmlStr += "<td>"+$(this).find('zipNo').text()+"</td>";
			htmlStr += "</tr>";
		});
		htmlStr += "</table>";
		htmlStr += "<div id='paging' style='text-align:center; border-top: 1px solid #dddddd;'><ul class='pagination'>";
		for(var i=0; i<totalPage; i++){
			if(page==i+1) {
				htmlStr += "<li class='active'><a href='#' onclick='return false;'>" + (i + 1) + "</a></li>";
			}else{
				htmlStr += "<li><a href='#' onclick='CHReturnPostCodeUtil.returnGetAddr("+(i + 1)+")'>" + (i + 1) + "</a></li>";
			}
		}
		htmlStr += "</ul></div>"

		$("#returnShowAddr").html(htmlStr);
	}
	, returnEnterSearch:function() {
		var evt_code = (window.netscape) ? ev.which : event.keyCode;
		if (evt_code == 13) {
			event.keyCode = 0;
			CHReturnPostCodeUtil.returnGetAddr(1); //jsonp사용시 enter검색
		}
	}
	, returnPostWindow:function(sort, id){
		if(sort == 'open') {
			$("#return").show().css({opacity:0, marginTop:100}).animate({opacity:1, marginTop:$(id).offset().top}, "slow");
			$("html, body").animate({scrollTop:$(id).offset().top - 200}, 700);
		}else if(sort == 'close'){
			$("#returnShowAddr").fadeOut();
			$("#returnShowAddr").html('');
			$("#returnKeyword").val('');

			$("#return").hide();
		}
	}
	, returnShowAddr:function(addr, post){
		$("input[name='returnPostCode']").val(post);
		$("input[name='returnAddr1']").val(addr);

		CHReturnPostCodeUtil.returnPostWindow('close');
		$("body").animate({scrollTop:$("input[name='returnAddr2']").offset().top-300}, 500);
		$("input[name='returnAddr2']").focus();
	}
};

/** 파일 최대 용량 체크 */
var checkFileSize = function(obj) {
	var size = obj.files[0].size; 
	var maxsize = 31457280;
	if(size > maxsize) {
		alert("파일 하나당 첨부 가능한 최대 용량을 초과하였습니다.\n\n최대용량: "+ parseInt(maxsize/1024/1024,10)+"MB / 실제: " + parseInt(size/1024/1024,10) + "MB");
		obj.focus();
		obj.value = "";
		return false;
	}
	
	return true;
};