var CHSideNavUtil = {
	render:function(cateLv1Seq) {
		// var menuList = {menu:[]};
		// menuList.menu = validMenuJson;
		// $("#mainSubCategoryList").html($("#mainSubCategoryTemplate").tmpl(menuList));//메인 페이지 좌단메뉴 호출

		for(var i=0; i<validMenuJson.length; i++) {
			if (parseInt(validMenuJson[i].seq, 10) === parseInt(cateLv1Seq,10)) {
				$(".side-nav").html($("#sideTitleTemplate").tmpl(validMenuJson[i]));//메인 페이지 좌단메뉴 호출
				break;
			}
		}
	}
}

$(window).load(function(){
  $('#subCategoryList li').each(function() {
		$(this).mouseover(function(){
			$(this).css({'width':269+'px','background-color':'#fff','font-weight':'bold', 'marginLeft':0});
			$(this).find('i').css({'color':'#4db7c9'});

		}).mouseleave(function(){
			$(this).css({'width':260+'px','background-color':'#cef6fd','font-weight':'normal', 'marginLeft':4+'px'});
			$(this).find('i').css({'color':'black'});
		});
	});
});