var JachiguUtil = {
	clickFlag:[]
	, init:function() {
		for(var i=0; i<33; i++) {
			JachiguUtil.clickFlag[i] = false;
		}
	}
	, toggle:function(obj) {
		var id = $(obj).attr('id');
		var arrayId = [];
		for(var i=0; i<$('.top-nav-list li').length; i++) {
			arrayId.push('topList'+(i+1));
		}

		for(var i=0; i<arrayId.length; i++) {
			if(id === arrayId[i]) {
				$('#'+id).addClass('current');
				JachiguUtil.init();
				JachiguUtil.clickFlag[i] = true;
			} else {
				$('#'+arrayId[i]).removeClass('current');
			}
		}
	}
};

$(document).ready(function() {
	JachiguUtil.init();
	var topListLength = $('.top-nav-list li').length;

	//기타는 배경색을 진하게 표시한다.
	// $('.top-nav-list li').eq(topListLength-1).css({'background-color':'#d8d8d8'});

	$('.top-nav-list li').each(function(idx) {
		$(this).mouseover(function(){
			if(JachiguUtil.clickFlag[idx] === false) {
				$(this).addClass('current');

				if(idx === (topListLength-1)) {
					$('.top-nav-list li').eq(idx).css({'background-color':'#4CB7C9'});
					$('.top-nav-list li a').eq(idx).css({'color':'#fff','font-weight':'bold'});
				}
			}
		}).mouseleave(function(){
			if(JachiguUtil.clickFlag[idx] === false) {
				$(this).removeClass('current');

				if(idx === (topListLength-1)) {
					$('.top-nav-list li').eq(idx).css({'background-color':'#d8d8d8','color':'#343434'});
				}
			}
		});
	});

	//자치구 네비게이션의 나머지 부분을 채운다.
	if(topListLength < 33) {
		for(var i=topListLength+1; i<33; i++) {
			$('.top-nav-list').append('<li></li>');
		}
	}

	$('.top-nav-list li').each(function(idx) {
		//끝라인의 보더를 살린다
		if((idx+1) % 8 !== 0) {
			$(this).css({'border-right':0});
		}

		//맨위쪽의 보더를 살린다.
		if(idx > 7) {
			$(this).css({'border-top':0});
		}

		//현재 선택된 자치구를 true만들어 current가 풀리지 않게한다.
		if($(this).hasClass('current')) {
			JachiguUtil.clickFlag[idx] = true;
		}
	});
});