var CHCommonBoardUtil = {
	seq:0
	, commonBoardSeq:0
	, confirm:function(secretFlag, seq, obj, loginSeq, userSeq, userTypeCode, commonBoardSeq) {
		var parseLoginSeq = parseInt(loginSeq, 10) || 0;
		var parseUserSeq = parseInt(userSeq, 10) || 0;
		CHCommonBoardUtil.seq = seq;
		CHCommonBoardUtil.commonBoardSeq = commonBoardSeq;

		if(secretFlag === 'Y') {
			//userSeq가 0보다 크고 typeCode가 A라면 관리자가 쓴글이므로 그냥 볼수있다.
			if(parseUserSeq > 0 && userTypeCode === 'A') {
				location.href='/shop/about/board/detail/view/'+ seq + '?commonBoardSeq='+commonBoardSeq;
			} else if(parseUserSeq > 0 && userTypeCode !== 'A') {
				//비밀글인데 해당 글을 작성한 userSeq와 현재로그인한 시퀀스가 같다면 비밀번호 재확인이 필요없다.
				if(parseUserSeq === parseLoginSeq) {
					location.href='/shop/about/board/detail/view/' + seq + '?commonBoardSeq='+commonBoardSeq;
				} else {
					CHCommonBoardUtil.showPassLayer(obj);
				}
			} else {
				CHCommonBoardUtil.showPassLayer(obj);
			}
		} else {
			location.href='/shop/about/board/detail/view/' + seq + '?commonBoardSeq='+commonBoardSeq;
		}
	}
	, submitProc:function(type) {
		if($('#lockPassword').val() === '') {
			alert('패스워드를 입력하세요.');
			return false;
		}

		$.ajax({
			type: "POST",
			url: "/shop/about/board/check/pass/ajax",
			dataType: "text",
			data: {userPassword:$('#lockPassword').val(), seq:CHCommonBoardUtil.seq},
			success: function (data) {
				if(data === 'ERROR[1]') {
					alert('비밀번호를 입력해주세요.');
				} else if(data === 'ERROR[2]') {
					alert('오류가 발생하였습니다.');
				} else if(data === 'false') {
					alert('비밀번호가 틀렸습니다.');
				} else if(data === 'true') {
					if(type === 'list') {
						location.href='/shop/about/board/detail/view/'+CHCommonBoardUtil.seq+'?commonBoardSeq='+CHCommonBoardUtil.commonBoardSeq;
					} else if(type === 'view') {
						location.href='/shop/about/board/detail/edit/'+CHCommonBoardUtil.seq+'?commonBoardSeq='+CHCommonBoardUtil.commonBoardSeq;
					}
				}
			},
			error: function (error) {
				alert(error.status + ":" + error.statusText);
			}
		});
	}
	, close:function() {
		$('#lockLayer').val();
		$('#lockLayer').hide();
	}
	, showPassLayer:function(obj) {
		$('#lockLayer').show().css({opacity:0, marginTop:$(obj).offset().top}).animate({opacity:1, marginTop:$(obj).offset().top-1100}, "slow");
		// $("html, body").animate({scrollTop:$(obj).offset().top}, 700);
	}
	, editConfirm:function(secretFlag, seq, loginSeq, userSeq, userTypeCode) {
		var parseLoginSeq = parseInt(loginSeq, 10) || 0;
		var parseUserSeq = parseInt(userSeq, 10) || 0;
		CHCommonBoardUtil.seq = seq;

		if(secretFlag === 'N') {
			//userSeq가 0보다 크고 typeCode가 A라면 관리자가 쓴글이므로 그냥 볼수있다.
			if(parseUserSeq > 0 && userTypeCode === 'A') {
				location.href='/shop/about/board/detail/edit/'+seq;
			} else if(parseUserSeq > 0 && userTypeCode !== 'A') {
				//비밀글인데 해당 글을 작성한 userSeq와 현재로그인한 시퀀스가 같다면 비밀번호 재확인이 필요없다.
				if(parseUserSeq === parseLoginSeq) {
					location.href='/shop/about/board/detail/edit/'+seq;
				} else {
					CHCommonBoardUtil.viewShowPassLayer();
				}
			} else {
				CHCommonBoardUtil.viewShowPassLayer();
			}
		} else {
			location.href='/shop/about/board/detail/edit/'+seq;
		}
	}
	, viewShowPassLayer:function() {
		$('#lockLayer').show().css({opacity:0, marginTop:$('.sign-form').offset().top}).animate({opacity:1, marginTop:$('.sign-form').offset().top-1100}, "slow");
		$("html, body").animate({scrollTop:$('.sign-form').offset().top-100}, 700);
	}
	, pageMove:function(loginSeq, commonBoardSeq) {
			//회원만 이용 가능하다.
			var parseLoginSeq = parseInt(loginSeq, 10) || 0;
			var parseCommonBoardSeq = parseInt(commonBoardSeq, 10) || 0;
			//비회원이고 상품등록 게시판이라면
			if(parseLoginSeq === 0 && (parseCommonBoardSeq === 1 || parseCommonBoardSeq === 2)) {
				alert("회원 로그인 후 이용하시기 바랍니다.");
				return;
			}

			location.href='/shop/about/board/detail/form/'+commonBoardSeq;
	}
	, showDeleteModal:function() {
		$("#myModal").modal("show");
	}
	, confirmDelete:function(seq, commonBoardSeq, userSeq, loginSeq, isFile) {
		var parseUserSeq = parseInt(userSeq, 10) || 0;
		var parseloginSeq = parseInt(loginSeq, 10) || 0;

		if(parseUserSeq != parseloginSeq) {
			alert('게시물을 삭제는 본인만 가능합니다.');
			return;
		}
		location.href="/shop/about/board/detail/delete/proc?seq="+seq+"&commonBoardSeq="+commonBoardSeq+"&userSeq="+userSeq+"&isFile="+isFile;
	}
};

var CHBoardUtil = {
		secretCheck:function(obj, sessionSeq) {
			var sessionSeq = parseInt(sessionSeq, 10) || 0;

			if($(obj).is(':checked')) {
				$('#postSecretFlag').val('Y');

				//비회원 구매일때만 비밀글 설정시 패스워드가 보이게 한다.
				if(sessionSeq === 0) {
					$('#passTr').removeClass('hide');
				}
			} else {
				$('#postSecretFlag').val('N');

				if(sessionSeq === 0) {
					$('#passTr').addClass('hide')
				}
			}
		}
		, submitProc:function(obj, sessionSeq) {
			var flag = true;
			var sessionSeq = parseInt(sessionSeq, 10) || 0;

			//만약 비회원인데 비밀글 설정이라면 비밀번호 유효성 체크를한다.
			if($('#secretFlag').is(':checked') && sessionSeq === 0) {
					if($('#userPassword').val() === '') {
						alert('비밀번호를 입력해주세요!');
						flag=false;
						$('#userPassword').focus();
					}
			}

			$(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
				if(flag && $(this).val() == "") {
					alert($(this).attr("alt") + "란을 입력해주세요!");
					flag = false;
					$(this).focus();
				}
			});
			return flag;
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