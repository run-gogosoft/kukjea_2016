;(function( $ ) {
/* IMPORT : 
 *
 * 1. jsSelect
 * 2. slide
 *
 */
var _zIndexCnt = 1;
$.fn.extend({	
	jsSelect : function (mode) {	
		if(mode == "remove") { // 삭제 모드
			this.next().remove();
			this.remove();
			return false;
		}		
		var _this = this;
		var className = (function(t) { // 클래스이름
			var classArray = t.split(' ');
			for(i = 0; i < classArray.length; i++) {
				if(classArray[i].indexOf('jsSelect:') != -1) t = classArray[i].replace(/jsSelect:/,'');
			}
			return t;
		})(this.attr("class"));
		
		this.addClass("hide"); // 셀렉트박스 숨기기
		
		if(this.next().hasClass(className)) { // 기존에 존재한다면 제거하고 다시 생성
			this.next().remove();
		}
		
		// 셀렉트박스 뒤에 에뮬레이트 엘리먼트 추가
		this.after(
			'<div class="' + className + '">' + 
			'<div class="bg_left"></div><div class="bg_right"></div>' + 
			'<div class="value"></div><div class="itemList">' + 
			//'<div class="bg_lt"></div><div class="bg_rt"></div><div class="bg_lb"></div><div class="bg_rb"></div>' + 
			'<ul></ul></div></div>'
		);
		
		var obj = this.next(); // 생성된 객체
		var checked = this.get(0).selectedIndex; // 셀렉트박스 인덱스
		var inputVal = obj.find("div.value"); // value division

		if(this.hasClass('dis')) { //비활성화 처리
			obj.addClass('dis');
		}
		
		obj.css("width", this.get(0).style.width); // 가로길이 지정
		
		// 셀렉트박스 옵션 내용대로 항목 추가
		this.find("option").each(function () {
			obj.find(".itemList ul").append('<li><a href="#">' + $(this).html() + '</a></li>');
		});
		
		if(Boolean(checked)) { // 값이 이미 선택되어 있으면
			inputVal.html(this.find("option").eq(checked).html()); // 해당값을 value division 에 추가
		} else { // 선택값이 없다면
			inputVal.html(this.find("option").eq(0).html()); // 첫번째 값을 value division 에 추가하고
			_this.get(0).selectedIndex = 0; // 셀렉트박스 인덱스도 첫번째 값으로 변경
		}
		
		// 셀렉트박스 토글	
		
		obj.click(function(e) {
			e.stopImmediatePropagation();
			if ($(this).find(".itemList").css("display") == "block"){
				$(this).find(".itemList").css("display","none");
				$(this).removeClass("jsSelect_on");
			}else{
				$(".itemList").hide();
				if ($(this).parents().hasClass("laypop") == false)
				{
					$(".laypop").hide();
				}
				$(this).find(".itemList").css("display","block");
				$(this).addClass("jsSelect_on");
			}			
			
			_zIndexCnt++;
			var zidx = $(this).css("z-index");
			$(this).css("z-index",_zIndexCnt);
		});
				
		// 아이템 항목 클릭
		obj.find(".itemList ul li a").bind("click", function() {
			change_value($(this).parent().index());
			
			_this.change(); // 셀렉트박스 이벤트 실행
			//obj.toggleClass("jsSelect_on"); // 셀렉트박스 토글
			$(".itemList").hide();
			return false;
		});
		
		// 아이템 항목 롤오버
		obj.find(" .itemList ul li").bind("mouseenter mouseleave", function(e) {
			if(e.type == "mouseenter") {
				$(this).addClass("on");
			} else {
				$(this).removeClass("on");
			}
		});
		
		// 셀렉트박스 값 변경되면
		_this.bind("change", function(e) {
			change_value(this.selectedIndex);
		});
		
		// 셀렉트박스 클릭
		obj.bind("click", function() {
			_this.click(); // 셀렉트박스 이벤트 실행
		});
		
		// 항목 변경
		function change_value(i) {
			_this.get(0).selectedIndex = i; // 셀렉트박스 인덱스 변경
			obj.find("div.value").html(_this.find("option").eq(i).html()); // value division 값 변경
		}		
		return false;
	},
	slide : function( TIME ) {
		var $target = {},
			$ROOT = {},
			$li = {},
			viewNum = 0,
			liLength = 0,
			liWidth = 0,
			slideStatus = null,
			TIME = TIME,
			control = {
				auto : function() {
					if( typeof TIME == 'undefined' ) TIME = 1000;
					slideStatus = setInterval(function() {
						viewNum++;
						if( viewNum == liLength ) viewNum = 0;
						$ROOT.find('.slider_control > li a').removeClass('on');
						$ROOT.find('.slider_control > li').eq( viewNum ).find('a').addClass('on');
						
						if( viewNum == 0 ) {
							$target.find('> li').each(function() {
								var idx = $(this).index();
								if( idx > 0 ) {
									$(this).css({ left : liWidth });
								}
							});
							$target.find('> li').eq( viewNum ).css({ left : liWidth }).animate({ left : 0 });
							$target.find('> li').eq( viewNum - 1 ).css({ left : 0 }).animate({ left: -liWidth }, function() {
								$(this).css({ left : liWidth });
							});
						} else if( viewNum == ( liLength - 1 ) ) {
							$target.find('> li').eq( viewNum ).animate({ left : 0 });
							$target.find('> li').eq( viewNum - 1 ).animate({ left : -liWidth });
						} else {
							$target.find('> li').eq( viewNum - 1 ).animate({ left : -liWidth });
							$target.find('> li').eq( viewNum ).animate({ left : 0 });
						}
					}, TIME);
				},
				stop : function() {
					clearInterval( slideStatus );
				},
				btnAction : function() {
					var liIndex = $(this).parent().index();
					control.stop();
					
					$ROOT.find('.slider_control > li a').removeClass('on');
					$(this).addClass('on');
					
					
					if( liIndex < viewNum ) {
						if( ( viewNum == ( liLength - 1) ) && ( liIndex == 0 ) ) {
							$target.find('> li').eq( liIndex ).css({ left : liWidth }).animate({ left : 0 }, function() {
								$(this).next().css({ left: liWidth });
							});
							$target.find('> li').eq( viewNum ).animate({ left : -liWidth });
						} else {
							$target.find('> li').eq( liIndex ).css({ left : -liWidth }).animate({ left : 0 }, function() {
								$(this).next().css({ left: liWidth });
							});
							$target.find('> li').eq( viewNum ).animate({ left : liWidth });
						}
						viewNum = liIndex;
					} else if( liIndex > viewNum ) {
						if( ( viewNum == 0 ) && ( liIndex == ( liLength - 1) ) ) {
							$target.find('> li').eq( liIndex ).css({ left : -liWidth }).animate({ left : 0 }, function() {
								$(this).next().css({ left: liWidth });
							});
							$target.find('> li').eq( viewNum ).animate({ left : liWidth });
						} else {
							$target.find('> li').each(function() {
								var idx = $(this).index();
								if( idx > liIndex ) {
									$(this).css({ left : liWidth });
								}
							});
							$target.find('> li').eq( viewNum ).animate({ left : -liWidth });
							$target.find('> li').eq( liIndex ).animate({ left : 0 }, function() {
								$(this).prev().css({ left: liWidth });
							});
						}
						viewNum = liIndex;
					}
					return false;
			}
		};

		return this.each(function() {
			$target = $(this);
			$ROOT = $( '.' + $target.closest('div').parent().attr('class') );
			$li = $target.find('> li');
			liLength = $li.length;
			liWidth = $li.width();
			
			$target.find('>li').each(function() {
				if( $(this).index() == 0 ) {
					$(this).css({ position : 'absolute', left : 0 });
				} else {
					$(this).css({ position : 'absolute', left : liWidth });
				}
			});
			
			control.auto();
			$ROOT.find('.slider_control > li a').on({ click : control.btnAction });
			$ROOT.on({ mouseleave : function() {
					control.stop();
					control.auto();
				}
			});
		});
	}
});

var KUKJEUI = {
	preFuncInit : function() {
		// global
		$("ul, ol").addClass(function(){
			$(this).find(">li:last-child").addClass("last-child");
			$(this).find(">li:only-child").addClass("only-child");
		});	
		$(".btn_grp").addClass(function(){
			$(this).find(">.btn:first-child").addClass("first-child");
			$(this).find(">.btn:last-child").addClass("last-child");
			$(this).find(">.btn:only-child").addClass("only-child");
		});	

		// 탭
		$('ul.tab').each(function(){		
			if(!$(this).find('>li').hasClass('on')) {
				$(this).find('>li:nth-child(1)').addClass("on");
			}
			var $selected = $(this).find('>li.on');
			var href = $selected.find('a').attr('href');
			var $swap = $selected.find('img[src$="-or.png"], img[src$="-or.gif"], img[src$="-or.jpg"]');
			$swap.each(function(){
				$(this).attr('src', $(this).attr('src').replace("-or.", "-on."));
			});
			try
			{
				var $target = $(href).parent().children();
				$target.not(href).hide();
			}
			catch (e){}
			$(this).find('>li a').click(function(){
				$(this).closest('ul.tab').find('>li').removeClass("on")
					.find('img').filter('[src$="-on.png"], [src$="-on.gif"], [src$="-on.jpg"]').each(function(){
						$(this).attr('src', $(this).attr('src').replace("-on.", "-or."));
				});
				$(this).closest('li').addClass("on")
					.find('img').filter('[src$="-or.png"], [src$="-or.gif"], [src$="-or.jpg"]').each(function(){
						$(this).attr('src', $(this).attr('src').replace("-or.", "-on."));
				});
				try
				{
					$target.hide();
					$($(this).attr("href")).show();
					if($.browser.msie && $.browser.version == 8) $('body').css('border', "none");
					if ($(this).attr("href") && $(this).attr("href").substring (0, 1) == "#") {
						return false;
					}
				}
				catch (e){}
				
				if ($(this).attr("href") && $(this).attr("href").substring (0, 1) == "#") {
					return false;
				}
			});
		});

		// quick scroll
		$(window).scroll(function(e){ 
			var scrollTop = $(this).scrollTop();
			var headerH = $('#header').height();
			var quickTop;	

			if ($('#wrap').hasClass('main')) {
				if ($('body').hasClass('agency')) {
					headerH += 40;
				}else {
					headerH += 14;
				}
			}else {
				headerH += 70;
			}
			
			$('#quick').css('top',function() {
				if (scrollTop > headerH) {
					quickTop = 14;
				}else {
					quickTop = headerH - scrollTop;
				}
				return quickTop;
			})
		});

		// 전체메뉴보기
		$('#btnTotal').click(function() {
			if (!$(this).next().is(':visible')) {
				$(this).text('전체메뉴닫기').next().slideDown('fast');	
			}else {
				$(this).text('전체메뉴보기').next().slideUp('fast');		
			}
		});
		$('#btnCloseTotal').click(function() {
			$(this).parent().slideUp('fast');
			$('#btnTotal').text('전체메뉴보기');	
		});	

		// 상품화면(상품비교 팝업)
		$('.btn_good_detail').click(function() {
			var btnDetail = $(this);
			var goodsDetail = btnDetail.parent('.goods_desc').find('.goods_detail');
			if (goodsDetail.css('display') == 'none') {
				goodsDetail.show();
				btnDetail.text('상세보기 닫기 -');
			}else {
				goodsDetail.hide();
				btnDetail.text('상세보기 +');
			}
		});	

		// 상품화면(큰이미지 보기 팝업)
		var smImg = $('.pop_zoom_img .img_list li');
		var bigImg = $('.pop_zoom_img .zoom_img li');
		smImg.hover(function(){
			var smImgNum = $(this).data('smImg');
			bigImg.each(function(i, d) {
				var bigImgNum = $(d).data('bigImg');
				if (smImgNum == bigImgNum) {
					$(d).addClass('on').siblings().removeClass('on');
				}
			});
		});

		// 게시판 아코디언 (자주하는 질문 / 쪽지함)
		$('table.board_folding a.fold_control').click(function() {
			var q = $(this);
			if (q.closest('tr').hasClass('on')) {
				q.closest('tr').removeClass('on').next('tr.folding_view').hide();	
			}else {
				$('table.board_folding tr').removeClass('on');
				$('table.board_folding tr.folding_view').hide();
				q.closest('tr').addClass('on').next('tr.folding_view').show();
			}
			return false;
		});

		// 상품 검색결과 더보기
		$('.search_result .btn_more').click(function() {
			var btnMore = $(this);
			if (btnMore.prev().hasClass('result_more')) {
				if (!btnMore.prev('.result_more').is(':visible')) {
					btnMore.text('접기').addClass('on').prev('.result_more').show();	
				}else {
					btnMore.text('더보기').removeClass('on').prev('.result_more').hide();	
				}	
			}
			return false;
		});

		// 마이페이지 구매리스트 상세 열기,닫기
		$('.btn_listview').click(function() {
			if ($(this).closest('tr').next('tr').is(':visible')) {
				$(this).closest('tr').removeClass('on').next('tr').hide();	
			}else {
				$(this).closest('tr').addClass('on').next('tr').show();	
			}
		});

		// 상품 요약정보 열기,닫기
		$('.btn_summary_showhide').click(function() {
			if ($(this).parent('dt').next('dd').is(':visible')) {
				$(this).text('펼쳐보기');
				$(this).removeClass('on').parent('dt').next('dd').slideUp(100);	
			}else {
				$(this).text('접기');
				$(this).addClass('on').parent('dt').next('dd').slideDown(100);	
			}
		});
	},
	slideInit : function() {
		// rolling slide
		if( ($('.promotion_list').length > 0) && ($('.promotion_list li').length > 1) ) $('.promotion_list ul').slide(4000);

		// slide_list
		function Slide(htmlObjName, option) {
			var htmlObj = $("#"+htmlObjName); // 슬라이드 ID
			var viewCal = 0; // 현재 보여지고 있는 영역
			var liLength = htmlObj.find('.slide_list ul > li').length; // 리스트의 개수
			var liWidth = 0; // 리스트의 너비
			var leftNum = 0; // 움직여야하는 LEFT 위치
			var viewNum = option.viewNum; // 화면에 노출되는 개수
			if (viewCal == 0) htmlObj.find('.slide_control > a.prev').addClass('off');
			if (liLength <= viewNum) htmlObj.find('.slide_control > a.next').addClass('off');
			

			function slide_list(my){
				var aName = $(my).attr('class').split(' ')[0];
				liLength = $(my).parents('.slide_wrap').find('.slide_list ul > li').length;
				liWidth = $(my).parents('.slide_wrap').find('.slide_list ul > li').outerWidth(true);
				
				division = parseInt( liLength / viewNum, 10);
				remainder = liLength % viewNum;
				if( remainder == 0 ) division -= 1;

				switch( aName ) {
					case 'prev' :
						viewCal--;
						htmlObj.find('.slide_control > a.next').removeClass('off');
						
						if (viewCal == 0) $(my).addClass('off');
						if( viewCal == division - 1 && remainder > 0 ) {
							leftNum += remainder * liWidth;
						} else {
							if( viewCal < 0 ) {
								viewCal = 0;
							} else {
								leftNum += viewNum * liWidth;
							}
						}
					break;
					case 'next' :
						viewCal++;
						htmlObj.find('.slide_control > a.prev').removeClass('off');
						if( viewCal >= division && remainder > 0 ) {
							if( viewCal > division ) {
								viewCal = division;
							} else {
								leftNum -= remainder * liWidth;
							}
							$(my).addClass('off');
						} else {
							if( viewCal <= division ) {
								leftNum -= viewNum * liWidth;
							} else {
								viewCal = division;
							}
							$(my).removeClass('off');
						}
					break;
				}
				$(my).parents('.slide_wrap').find('.slide_list ul').stop(true).animate({ left : leftNum });
			}
			htmlObj.find('.slide_control > a').on('click',function(){
				slide_list(this);
				return false;
			});
		}
		var slider1 = new Slide('banner_slide', {viewNum : 6});
	}
};

$(function() {
	// KUKJEUI.preFuncInit
	KUKJEUI.preFuncInit();
	// KUKJEUI.slideInit
	KUKJEUI.slideInit();

	//jsSelect
	$('select[class*="jsSelect:"]').each(function() { $(this).jsSelect(); });
});
}( jQuery ));


$(document).ready(function(){
	$('#favorite').on('click', function(e) {
		var bookmarkURL = window.location.href;
		var bookmarkTitle = document.title;
		var triggerDefault = false;

		if (window.sidebar && window.sidebar.addPanel) {
			// Firefox version < 23
			window.sidebar.addPanel(bookmarkTitle, bookmarkURL, '');
		} else if ((window.sidebar && (navigator.userAgent.toLowerCase().indexOf('firefox') > -1)) || (window.opera && window.print)) {
			// Firefox version >= 23 and Opera Hotlist
			var $this = $(this);
			$this.attr('href', bookmarkURL);
			$this.attr('title', bookmarkTitle);
			$this.attr('rel', 'sidebar');
			$this.off(e);
			triggerDefault = true;
		} else if (window.external && ('AddFavorite' in window.external)) {
			// IE Favorite
			window.external.AddFavorite(bookmarkURL, bookmarkTitle);
		} else {
			// WebKit - Safari/Chrome
			alert((navigator.userAgent.toLowerCase().indexOf('mac') != -1 ? 'Cmd' : 'Ctrl') + '+D 키를 눌러 즐겨찾기에 등록하실 수 있습니다.');
		}

		return triggerDefault;
	});
});

function ebFormatNumber(num) {
	return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
}

$(document).ready(function(){
	// 상단 헤더에 메뉴명을 매핑한다
	var m1=[], m2=[];
	_.map(menuJson,function(v,i){
		7 > i ? m1.push({href: "/shop/lv1/"+v.seq, className: "mn"+(i+1), categoryName: v.categoryName}) :
				m2.push({href: "/shop/lv1/"+v.seq, className: "s_mn1", categoryName: v.categoryName})}),
				m2.push({href: "/shop/event/plan", className: "s_mn2", categoryName: "HOT"});

	$('#gnb ul[data-name=mn1]').html( $('#MenuTemplate').tmpl(m1) );
	$('#gnb ul[data-name=mn2]').html( $('#MenuTemplate').tmpl(m2) );

	// 네비게이션에 메뉴명을 매핑한다
	$('#gnb div[data-name=totalmenu]').html( $('#TotalMenuTemplate').tmpl(menuJson) );

	// 포인트를 매핑한다
	if($('[data-access=point]').length > 0) {
		$.get('/shop/mypage/point/ajax', function(data){
			$('[data-access=grade]').text( ebFormatNumber( data.grade || 0 ) );
			$('[data-access=point]').text( ebFormatNumber( data.point || 0 ) );
		});
	}
});