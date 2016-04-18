var goPage = function (page) {
	CHPlanUtil.getCommentList(page);
	CHPlanUtil.getCommentPaging(page);
};

var CHPlanUtil = {
	vo:{}
	, calcLine:function(count) {
		var subListheight;
		var subListLength = $('.sub-item-list'+count+' li').length;

		$('.sub-item-list'+count+' li').each(function(idx) {
			var thisIdx = idx+1;

			if(thisIdx <= 5) {
				$(this).css({'margin-top':0})
			}
			//5로나눠서 나머지가 0이라면 현재라인의 맨끝 요소이다.
			if(thisIdx % 5 === 0) {
				$(this).css({'margin-right':0});
			}
		});

		//첫번째 라인이라면 285px로 고정
		if(subListLength === 1) {
			subListheight = 285;
		} else {
			subListheight = 290;
		}

		var calcLineLength = Math.ceil(subListLength / 5);
		$('.sub-item-list'+count).css({'height':subListheight*calcLineLength});
	}
	, writeButton:function (){
		$(".hh-writebox-layer").show().css({marginTop:-400});
		$("html, body").animate({scrollTop:$('#reputation').offset().top - 200}, 700);
	}
	, writeClose:function () {
		$(".hh-writebox-layer").hide();
		$('#content').val('');
	}
	, submit:function() {
		var flag = true;
		if(flag && $('#content').val() == "" || flag&& $('#content').val() == 0) {
			alert('내용을 입력해주세요');
			flag = false;
		}

		if(flag) {
			$.ajax({
				url:"/shop/event/comment/proc",
				type:"post",
				data:{integrationSeq:$('#seq').val(), content:$('#content').val()},
				dataType:"text",
				success:function(data) {
					if(data === "OK") {
						alert('등록하였습니다.');
						CHPlanUtil.getCommentList(0);
						CHPlanUtil.getCommentPaging(0);
						CHPlanUtil.writeClose();
					} else if(data === "FAIL[1]") {
						alert('오류가 발생하였습니다.')
					} else if(data === "FAIL[2]"){
						alert(data)
					}
				},
				error:function(error) {
					alert( error.status + ":" +error.statusText );
				}
			});
		}
		return flag;
	}
	, getCommentList:function(pageNum){
		$.ajax({
			type:"GET",
			url:"/shop/event/comment/list",
			dataType:"text",
			data:{integrationSeq:$("#seq").val(),pageNum:pageNum},
			success:function(data) {
				var list = $.parseJSON(data);
				if(list.length != 0){
					$('#pageNum').val(list.pageNum);
					$("#boardTarget").html( $("#trTemplate").tmpl(list));
				} else {
					$("#boardTarget").html("<div>등록된 내용이 없습니다.</div>");
				}
			}
		});
	}
	, getCommentPaging:function(pageNum){
		$.ajax({
			type:"GET",
			url:"/shop/event/comment/paging",
			dataType:"text",
			data:{integrationSeq:$("#seq").val(),pageNum:pageNum},
			success:function(data) {
				$("#paging").html(data);
				$("#paging>ul").addClass("ch-pagination");
			}
		});
	}
	, showDeleteModal:function(seq, userSeq, sessionLoginSeq) {
			//현재 로그인한 사람과 글작성한 사람이 다르면 삭제할수 없다.
			if(sessionLoginSeq != userSeq) {
				alert('본인 이외의 글은 삭제 할 수 없습니다.');
				return;
			}

			CHPlanUtil.vo.seq = seq;
			CHPlanUtil.vo.userSeq = userSeq;
			CHPlanUtil.vo.boardSeq = $('#seq').val();
			$('#DeleteModal').modal();
	}
	, deleteCommentProc:function() {
			$.ajax({
				type:"POST",
				url:"/shop/event/plan/comment/delete",
				dataType:"text",
				data:{seq:CHPlanUtil.vo.seq, userSeq:CHPlanUtil.vo.userSeq, boardSeq:CHPlanUtil.vo.boardSeq},
				success:function(data) {
					if(data === "OK") {
						alert('댓글이 삭제 되었습니다.');
						$('#DeleteModal').modal('hide');
						var pageNum = parseInt($('#pageNum').val(), 10);
						CHPlanUtil.getCommentList(pageNum);
						CHPlanUtil.getCommentPaging(pageNum);
					} else if(data === "FAIL[1]") {
						alert('본인 이외의 글은 삭제 할 수 없습니다.')
					} else if(data === "FAIL[2]"){
						alert('댓글을 삭제할 수 없었습니다');
					}
				}
			});
	}
};