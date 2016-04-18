/** 한글 삭제 */
var koreanCheck = function(obj){
	obj.value=obj.value.replace(/[가-힣ㄱ-ㅎㅏ-ㅣ]/g, '');
};

/** 아이디 중복 체크 */
var checkId = function() {
	var id = $("#id").val();
	//아이디 입력여부 검사
	if(id === "") {
		alert("아이디를 입력해주세요.");
		$("#id").focus();
		return;
	}
	//ajax:아이디중복체크
	$.ajax({
		type: 'POST',
		data: {id:id},
		dataType: 'json',
		url: '/shop/seller/check/id/ajax',
		success: function(data) {
			if(data.result === "true") {
				alert(data.message);
				$("#id_check_flag").val("Y");
			} else {
				alert(data.message);
				$("#id_check_flag").val("N");
				$("#id").focus();
			}
		}
	});
}

/** 닉네임 중복 체크 */
var checkNickname = function() {
	var nickname = $("#nickname").val();
	//닉네임 입력여부 검사
	if(nickname === "") {
		alert("상점명을 입력해주세요.");
		$("#nickname").focus();
		return;
	}
	if($('#myNickName').val() === nickname){
		alert("기존 상점명 입니다.");
		return;
	}

	//ajax:닉네임중복체크
	$.ajax({
		type: 'POST',
		data: {nickname:nickname},
		dataType: 'json',
		url: '/shop/seller/check/nickname/ajax',
		success: function(data) {
			if(data.result === "true") {
				alert(data.message);
				$("#validNickName").val($("#nickname").val());
				$("#nick_check_flag").val("Y");
			} else {
				alert(data.message);
				$("#nick_check_flag").val("N");
				$("#nickname").focus();
			}
		}
	})
};

/** 사업자 중복 체크 */
var checkBizNo = function() {
	var bizNo1 = $.trim($("#bizNo1").val());
	var bizNo2 = $.trim($("#bizNo2").val());
	var bizNo3 = $.trim($("#bizNo3").val());

	if(bizNo1 == "" || bizNo2 == "" || bizNo3 == "") {
		alert("사업자 번호를 입력해주세요.");
		return;
	}

	$.ajax({
		type: 'POST',
		data: {bizNo:bizNo1+bizNo2+bizNo3},
		dataType: 'json',
		url: '/shop/seller/check/bizno/ajax',
		success: function(data) {
			if(data.result === "true") {
				alert(data.message);
				$("#bizno_check_flag").val("Y");
			} else {
				alert(data.message);
				$("#bizno_check_flag").val("N");
			}
		}
	});
}

//소속 자치구 이벤트 컨트롤
$("#jachiguSido").change(function() {
	if($(this).val() == "01") {
		//서울시일 경우에만 자치구 선택 가능
		$("#jachiguCode").css("display","inline");
		$("#jachiguCode").val("");
	} else {
		$("#jachiguCode").css("display","none");
		$("#jachiguCode").val($(this).val());
	}
});

//자치구 시/도 항목 기본 설정
var setJachiguSido = function() {
	if($("#jachiguCode").val() == "" || $("#jachiguCode").val() == "99") {
		$("#jachiguCode").css("display","none");
		$("#jachiguSido").val($("#jachiguCode").val());
	} else {
		$("#jachiguCode").css("display","inline");
		$("#jachiguSido").val("01");
	}
}

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

$(document).ready(function(){
	//자치구 시/도 항목 기본 설정
	setJachiguSido();
});

var sellerEditUtil = {
	confirm:function(secretFlag, seq, obj, loginSeq, userSeq, userTypeCode) {
		var parseLoginSeq = parseInt(loginSeq, 10) || 0;
		var parseUserSeq = parseInt(userSeq, 10) || 0;
		CHCommonBoardUtil.seq = seq;

		if(secretFlag === 'Y') {
			//userSeq가 0보다 크고 typeCode가 A라면 관리자가 쓴글이므로 그냥 볼수있다.
			if(parseUserSeq > 0 && userTypeCode === 'A') {
				location.href='/shop/about/board/detail/view/'+seq;
			} else if(parseUserSeq > 0 && userTypeCode !== 'A') {
				//비밀글인데 해당 글을 작성한 userSeq와 현재로그인한 시퀀스가 같다면 비밀번호 재확인이 필요없다.
				if(parseUserSeq === parseLoginSeq) {
					location.href='/shop/about/board/detail/view/'+seq;
				} else {
					CHCommonBoardUtil.showPassLayer(obj);
				}
			} else {
				CHCommonBoardUtil.showPassLayer(obj);
			}
		} else {
			location.href='/shop/about/board/detail/view/'+seq;
		}
	}
	, submitProc:function(obj) {
		var flag = true;
		if($('#lockId').val() === '') {
			alert('아이디를 입력하세요.');
			flag = false;
		} else if($('#lockPassword').val() === '') {
			alert('패스워드를 입력하세요.');
			flag = false;
		}

		return flag;
	}
	, close:function() {
		$('#lockId').val();
		$('#lockPassword').val();
		$('#lockLayer').hide();
	}
	, showPassLayer:function(obj) {
		$('#lockLayer').show().css({opacity:0, marginTop:$('#form').offset().top-600}).animate({opacity:1, marginTop:$('#form').offset().top-600}, "slow");
		// $("html, body").animate({scrollTop:$(obj).offset().top}, 700);
	}
};