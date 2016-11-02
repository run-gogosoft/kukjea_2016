var CHAgreeUtil = {
	doSubmit:function(formObj, memberTypeCode) {
		if(!formObj.agree1.checked) {
			alert('이용약관에 동의하셔야 합니다.');
			formObj.agree1.focus();
			return false;
		} else if(!formObj.agree2.checked) {
			alert('개인정보 수집및 이용에 동의하셔야 합니다.');
			formObj.agree2.focus();
			return false;
		} else if(!formObj.agree3.checked) {
			alert('개인정보 제3자 제공에 동의하셔야 합니다.');
			formObj.agree3.focus();
			return false;
		}
		// if(memberTypeCode === 'C') {
		// 	if(!formObj.agree4.checked) {
		// 		alert('고유식별 정보처리에 동의하셔야 합니다.');
		// 		formObj.agree4.focus();
		// 		return false;
		// 	}
		// }


		formObj.allCheckFlag.value ='Y';

		// if(memberTypeCode == "C") {
		// 	if(formObj.memberCertFlag.value != "Y") {
		// 		alert("본인인증(아이핀/휴대폰) 완료 후 회원가입이 가능합니다.");
		// 		return false;
		// 	}
        //
		// }

		formObj.target = "_top";

		return true;
	}
}

var CHInsertUtil = {
	submitProc:function(obj, memberTypeCode) {
		var flag = true;
		var email = $("#email1").val() + '@' + $("#email2").val();
		if(email === '@') {
			email = '';
		}

		if($('#id').val() != $('#id_check_flag').val()) {
			alert('아이디 중복확인을 해주세요.');
			$('#id').focus();
			flag = false;
		} else if($('#password').val() != $('#passwordCheck').val() ){
			alert('동일한 비밀번호를 입력해주세요.');
			$('#password').focus();
			flag = false;
		} else {
			$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
				if(flag && $(this).val() == "") {
					alert($(this).attr("alt") + "란을 입력해주세요!");
					flag = false;
					$(this).focus();
				}
			});
		}
		return flag;
	}
	, validIdCheck:function() {
		var id = $("#id").val();

		//아이디 입력여부 검사
		if(typeof id === 'undefined') {
			alert('아이디를 입력해주세요');
			return;
		}
		//ajax:아이디중복체크
		$.ajax({
			type: 'POST',
			data: {id:id},
			dataType: 'json',
			url: '/shop/member/check/id/ajax',
			success: function(data) {
				if(data.result === "true") {
					// alert(data.message);
					$('.error_msg').show().addClass('able').removeClass('disable').text(data.message);
					$("#id_check_flag").val($('#id').val());
				} else {
					// alert(data.message);
					$('.error_msg').show().removeClass('able').addClass('disable').text(data.message);
					$("#id_check_flag").val('');
					$("#id").focus();
				}
			}
		});
	}
	, validEmailCheck:function() {
		var email = $("#email1").val() + '@' + $("#email2").val();

		//이메일 입력여부 검사
		if(email === '@') {
			alert('이메일을 입력해주세요');
			return;
		}

		//ajax:이메일중복체크
		$.ajax({
			type: 'POST',
			data: {email:email},
			dataType: 'json',
			url: '/shop/member/check/email/ajax',
			success: function(data) {
				if(data.result === "true") {
					alert(data.message);
					$("#emailCheckFlag").val(email);
				} else {
					alert(data.message);
					$("#emailCheckFlag").val('');
					$("#email1").focus();
				}
			}
		});
	}
	, checkBizNo:function() {
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
			url: '/shop/member/check/bizno/ajax',
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
};

$(document).ready(function() {
	var arrayStr = ['group', 'start', 'reg', 'finish'];
	for(var i=0; i<arrayStr.length; i++) {
		if(location.pathname.match(arrayStr[i])) {
			$('.'+arrayStr[i]).find('img').attr("src", $('.'+arrayStr[i]).find('img').attr("src").replace("_off", "_on"));
			return false;
		}
	}
});