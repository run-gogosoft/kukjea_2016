var submitProc = function(obj) {
	var flag = true;
	if($('#categoryCode').val() === '') {
		alert('구분을 선택해 주세요.');
		flag = false;
	}

	$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
		if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {
			alert($(this).attr("alt") + "란을 입력해주세요!");
			flag = false;
			$(this).focus();
		}
	});
	return flag;
};

CHBoardUtil = {
	writeButton:function (){
		$(".hh-writebox").show().css({top:$(".main-table").offset().top-190});
	}
	, writeClose:function () {
		$(".hh-writebox").hide();
		$('#directContent').val('');
		$('#directTitle').val('');
		$('#contentByte').text(0);
	}
	, contentLength:function(obj){
		var cutText = $(obj).val();
		var stringByteLength = $(obj).val().replace(/[\0-\x7f]|([0-\u07ff]|(.))/g,"$&$1$2").length;
		if(stringByteLength > 4000) {
			stringByteLength=4000;
			cutText = cutText.substring(0, stringByteLength);
		}
		$(obj).val(cutText);
		$('#contentByte').text(stringByteLength);
	}
	, checkText:function() {
		var searchStr = "";
		if (searchStr != $('#directContent').val()) {
			CHBoardUtil.contentLength($('#directContent'));
		}
		setTimeout('checkText()', 100);
	}
};

CHToggleUtil = {
	toggleContent:function(content) {
		if($('#'+content).css("display")=='none') {
			$('#'+content).show();
		} else {
			$('#'+content).hide();
		}
	}
	, toggleAnswer:function(content, answer) {
		if($('#'+content).css("display")=='none') {
			$('#'+content).show();
			$('#'+answer).show();
		} else {
			$('#'+content).hide();
			$('#'+answer).hide();
		}
	}
};

var callbackProc = function(num) {
		$('.file-wrap'+num).remove();
  }

var addFilePane = function() {
  var num = 1;
  $('#FileList input[type=file]').each(function(){
      var n = parseInt( $(this).attr('name').replace('file', ''), 10);
      if(num <= n) {
          num = n+1;
      }
  });
  $('#FileList').append( $('#FileTemplate').tmpl({num:num}) );

  $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
      $(this).parent().next().text(label);
  });
}
