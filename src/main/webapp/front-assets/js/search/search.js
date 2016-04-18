var submitCatagory = function (lvValue , obj) {
	var urlLv = '';
	var dataLv = '';
	//카테고리를 아무것도 선택하지 않았을 경우 상위 카테고리로 이동한다.
	if($(obj).val() === '') {
		if(lvValue === 1) {
			$('select[name=cateLv2Seq]').val('');
			$('select[name=cateLv3Seq]').val('');
			$('select[name=cateLv4Seq]').val('');
		} else if(lvValue === 2) {
			urlLv = 'lv1';
			dataLv = "${itemSearchVo.cateLv1Seq}";
			$('select[name=cateLv3Seq]').val('');
			$('select[name=cateLv4Seq]').val('');
		} else if(lvValue === 3) {
			urlLv = 'lv2';
			dataLv = "${itemSearchVo.cateLv2Seq}";
			$('select[name=cateLv4Seq]').val('');
		} else if(lvValue === 4) {
			urlLv = 'lv3';
			dataLv = "${itemSearchVo.cateLv3Seq}";
		}
	} else {
		if(lvValue === 1) {
			$('select[name=cateLv2Seq]').val('');
			$('select[name=cateLv3Seq]').val('');
			$('select[name=cateLv4Seq]').val('');
		} else if(lvValue === 2) {
			$('select[name=cateLv3Seq]').val('');
			$('select[name=cateLv4Seq]').val('');
		} else if(lvValue === 3) {
			$('select[name=cateLv4Seq]').val('');
		} else if(lvValue === 4) {
			dataLv = "${itemSearchVo.cateLv3Seq}";
		}
	}
	$('#lvForm').attr('action', $(obj).val() === '' ? "/shop/"+urlLv+"/"+dataLv : "/shop/lv"+lvValue+"/"+$(obj).val());
	$('#lvForm').submit();
};


$(document).ready(function() {
	// image flip
	$(".img img[data-src]").mouseover(function(){
		if(typeof $(this).attr("data-swap") === "undefined") {
			$(this).attr("data-swap", $(this).attr("src"));
		}
		$(this).attr("src", $(this).attr("data-src"));
	}).mouseleave(function(){
		$(this).attr("src", $(this).attr("data-swap"));

	});

  $("#paging>ul").addClass("ch-pagination");
});