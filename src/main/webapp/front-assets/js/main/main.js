var CHVideoUtil = {
	renderList:function() {
		$.ajax({
			type: "GET",
			url: "/shop/video/item/list/ajax",
			dataType: "text",
			success:function(data) {
				var list = $.parseJSON(data);
				$("#VideoBoardTarget").html( $("#trTemplate").tmpl(list) );
			}
		});
	}
};

var HknuriUtil = {
	clickFlag:[true, false, false, false, false]
	, init:function() {
		for(var i=0; i<5; i++) {
			HknuriUtil.clickFlag[i] = false;
		}
	}
	, toggle:function(obj) {
		var id = $(obj).attr('id');
		var arrayId = ['nuriList1', 'nuriList2', 'nuriList3', 'nuriList4', 'nuriList5'];
		for(var i=0; i<arrayId.length; i++) {
			if(id === arrayId[i]) {
				$('.'+id).show();
				$('#'+id).addClass('current');
				$('#'+id).find('img').attr("src", $('#'+id).find('img').attr("src").replace("_off", "_on"));
				HknuriUtil.init();
				HknuriUtil.clickFlag[i] = true;
			} else {
				$('.'+arrayId[i]).hide();
				$('#'+arrayId[i]).removeClass('current');
				$('#'+arrayId[i]).find('img').attr("src", $('#'+arrayId[i]).find('img').attr("src").replace("_on", "_off"));
			}
		}
	}
};

var EBCarousel = {
	start: function (id, json) {
		// init
		$("#"+ id +" .overview").html("");

		// generate DOM
		$("#"+ id +" .data>a, #"+ id +" .data>img").each(function () {
			$("#"+ id +" .overview").append($("<li></li>").append($(this)));
		});

		// generate Rolling page
		if ($("#"+ id +" .overview li").length > 1 && json.pager === true) {
			$("#"+ id +" .overview li").each(function (idx) {
				$("#"+ id +" .pager").append($("<li><a rel='" + idx + "' class='pagenum' href='#'>" + (idx + 1) + "</a></li>"));
			});
		} else if ($("#"+ id +" .overview li").length <= 1) {
			// if not then hide body
			$("#"+ id +" .btn-group").hide();
		}
		$('#'+id).tinycarousel(json);
	}
};
// 히어로배너
var CHHero = {
	  timeVal:0
	, current:0
	, render:function(obj){
		$(".ch-hero-list li").removeClass("li-hover");
		$(".ch-hero-list li").removeClass("carrot-bottom-back");
		$(".ch-hero-list li").removeClass("carrot");

		var img = $("<img />")
			.attr("src", $(obj).addClass("carrot").addClass("carrot-bottom-back").addClass("li-hover").find("span").attr("data-src"))
			.attr('usemap',$(obj).find("span").attr('usemap'));

		if(($(obj).find("span").attr("data-href") || "") !== "") {
			$(img).css("cursor", "pointer").click(function(){
				location.href = $(obj).find("span").attr("data-href");
			});
		}
		img.appendTo( $(".ch-hero-banner").html("") );
		$(".ch-hero").css({background:$(obj).find("span").attr("data-color")});

	}
	, renderCurrent:function() {
		//모든 carrot클래스를 지운다.
		$(".ch-hero-list li").removeClass("li-hover");
		$(".ch-hero-list li").removeClass("carrot-bottom-back");
		$(".ch-hero-list li").removeClass("carrot");

		var img = $("<img />")
			.attr("src", $(".ch-hero-list li").eq(CHHero.current).addClass("carrot").addClass("carrot-bottom-back").addClass("li-hover").find("span").attr("data-src"))
			.attr('usemap', $(".ch-hero-list li").eq(CHHero.current).find("span").attr('usemap'))

		if(($(".ch-hero-list li").eq(CHHero.current).find("span").attr("data-href") || "") !== "") {
			$(img).css("cursor", "pointer").click(function(){
				location.href = $(".ch-hero-list li").eq(CHHero.current).find("span").attr("data-href");
			});
		}

		img.appendTo( $(".ch-hero-banner").html("") );
		$(".ch-hero").css({background:$(".ch-hero-list li").eq(CHHero.current).find("span").attr("data-color")});
	}
	, next:function(){
		CHHero.current = ( $(".ch-hero-list li").length > CHHero.current+1) ? CHHero.current+1: 0;
	}
};

CHHero.timeVal = setInterval(function(){
	CHHero.next();
	CHHero.renderCurrent();
}, 4000);

// 롱배너
var CHLong = {
	  timeVal:0
	, current:0
	, render:function(obj){
		$(".ch-long-list li").removeClass("li-hover");
		$(".ch-long-list li").removeClass("carrot-bottom-back");
		$(".ch-long-list li").removeClass("carrot");

		var img = $("<img />")
			.attr("src", $(obj).addClass("carrot").addClass("carrot-bottom-back").addClass("li-hover").find("span").attr("data-src"))
			.attr('usemap',$(obj).find("span").attr('usemap'));

		if(($(obj).find("span").attr("data-href") || "") !== "") {
			$(img).css("cursor", "pointer").click(function(){
				location.href = $(obj).find("span").attr("data-href");
			});
		}
		img.appendTo( $(".ch-long-banner").html("") );
		$(".ch-long").css({background:$(obj).find("span").attr("data-color")});

	}
	, renderCurrent:function() {
		//모든 carrot클래스를 지운다.
		$(".ch-long-list li").removeClass("li-hover");
		$(".ch-long-list li").removeClass("carrot-bottom-back");
		$(".ch-long-list li").removeClass("carrot");

		var img = $("<img />")
			.css('cursor', 'pointer')
			.attr("src", $(".ch-long-list li").eq(CHLong.current).addClass("carrot").addClass("carrot-bottom-back").addClass("li-hover").find("span").attr("data-src"))
			.attr('usemap', $(".ch-long-list li").eq(CHLong.current).find("span").attr('usemap'))
			.appendTo( $(".ch-long-banner").html("") );

		if(($(".ch-long-list li").eq(CHLong.current).find("span").attr("data-href") || "") !== "") {
			$(img).css("cursor", "pointer").click(function(){
				location.href = $(".ch-long-list li").eq(CHLong.current).find("span").attr("data-href");
			});
		}

		$(".ch-long")
			.css({background:$(".ch-long-list li").eq(CHLong.current).find("span").attr("data-color")});
	}
	, next:function(){
		CHLong.current = ( $(".ch-long-list li").length > CHLong.current+1) ? CHLong.current+1: 0;
	}
};

CHLong.timeVal = setInterval(function(){
	CHLong.next();
	CHLong.renderCurrent();
}, 2000);

$(document).ready(function() {
	$('.nuri-side-nav li').each(function(idx) {
		$(this).mouseover(function(){
			if(HknuriUtil.clickFlag[idx] === false) {
				$(this).addClass('current');
				$(this).find('img').attr("src", $(this).find('img').attr("src").replace("_off", "_on"));
			}
		}).mouseleave(function(){
			if(HknuriUtil.clickFlag[idx] === false) {
				$(this).removeClass('current');
				$(this).find('img').attr("src", $(this).find('img').attr("src").replace("_on", "_off"));
			}
		});
	});

	// image flip
	$(".flip img[data-src]").mouseover(function(){
		if(typeof $(this).attr("data-swap") === "undefined") {
			$(this).attr("data-swap", $(this).attr("src"))
		}

		$(this)
		.stop()
		.animate({opacity:0}, "fast", function(){
			$(this)
			.attr("src", $(this).attr("data-src"))
			.animate({opacity:1});
		});

	}).mouseleave(function(){
		$(this)
		.stop()
		.animate({opacity:0}, "fast", function(){
			$(this)
			.attr("src", $(this).attr("data-swap"))
			.animate({opacity:1});
		});
	});

	// lv1 side navigation
// 	$(".side-nav #mainSubCategoryList li").each(function(){
// 		$(this).mouseover(function(){
// 			var seq = parseInt($(this).attr("data-seq"), 10) || 0;
// 			for(var i=0; i<menuJson.length; i++) {
// 				if(parseInt(menuJson[i].seq,10) === seq) {
// 					$(".side-nav-category-lv2-div").show();
// 					var menuList = {menu:[],mallId:$('footer').attr('data-mall-id')};
// 					menuList.menu = menuJson[i].lv2List;
// //					$("#side-nav-category-lv2").html($("#mainLv2Template").tmpl(menuJson[i].lv2List));
// 					$("#side-nav-category-lv2").html($("#mainLv2Template").tmpl(menuList));
// 					break;
// 				}
// 			}

// //			따라다니는 하위카테고리 임시보류처리(컨셉결정에 따른다)
// //			$("#side-nav-category-lv2")
// //			.css({
// //				top:$(this).offset().top-210
// //			});
// 		});
// 	});

	$(".nav-wrap").mouseleave(function(){
		$(".side-nav-category-lv2-div").hide();
		$("#side-nav-cursor").hide();
	});

	$(".side-nav-category-lv2-div").mouseleave(function(){
		$(".side-nav-category-lv2-div").hide();
		$("#side-nav-cursor").hide();
	});

	//ch-hero-list over, leave시..
	$(".ch-hero").css({background:$(".ch-hero-banner img").attr("data-color")});
	$(".ch-hero").css({background:$(".ch-hero-list>li:first-child img").attr("data-color")});

	$(".ch-hero-list li").each(function(){
		$(this).mouseover(function(){
			CHHero.render(this);
			$(".ch-hero-list li").each(function(idx){
				if($(this).is(".carrot")) {
					CHHero.current = idx;
				}
			});
			clearInterval(CHHero.timeVal);
		}).mouseleave(function(){
			CHHero.timeVal = setInterval(function(){
				CHHero.next();
				CHHero.renderCurrent();
			}, 4000);
		});
	});

	//ch-long-list over, leave시..
	$(".ch-long").css({background:$(".ch-long-banner img").attr("data-color")});
	$(".ch-long").css({background:$(".ch-long-list>li:first-child img").attr("data-color")});

	$(".ch-long-list li").each(function(){
		$(this).mouseover(function(){
			CHLong.render(this);
			$(".ch-long-list li").each(function(idx){
				if($(this).is(".carrot")) {
					CHLong.current = idx;
				}
			});
			clearInterval(CHLong.timeVal);
		}).mouseleave(function(){
			CHLong.timeVal = setInterval(function(){
				CHLong.next();
				CHLong.renderCurrent();
			}, 4000);
		});
	});

	CHVideoUtil.renderList();
});