/**
 * 카테고리와 관련된 모든 업무를 담당함
 * @type {{renderList: Function, update: Function}}
 */
var EBCategory = {
	/** 카테고리를 그림 */
	renderList: function(depth, parentSeq, mallSeq) {
		if(mallSeq === 0){
			mallSeq = parseInt($('#mallList option:selected').val(),10) || 0;
		}
		// 로딩 메시지
		$("#lv"+depth).html("<option value=''></option>");

		var parseParentSeq = parseInt(parentSeq, 10) || 0;
		$.ajax({
			url:"/admin/category/list/ajax",
			type:"get",
			data:{depth:depth, parentSeq:parseParentSeq, mallId:mallSeq},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				var categoryList = {list:[]};
				categoryList.list = list;
				// 단계를 표시한다
				$("#lv"+depth).html( 	$("#lvTemplate").tmpl(categoryList) );

				// 다음 단계 초기화
				$("[id^=lv]").each(function(){
					if( parseInt($(this).attr("id").replace(/lv/, ""),10) > depth ) {
						$(this).html( '<option value="">분류를 선택해주세요</option>' );
					}
				});
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	/** 카테고리를 수정 */
	, update: function() {
		var cate1 = {"seq":parseInt($("#lv1 option:selected").val(),10)||'', "name":$("#lv1 option:selected").text()};
		var cate2 = {"seq":parseInt($("#lv2 option:selected").val(),10)||'', "name":$("#lv2 option:selected").text()};
		var cate3 = {"seq":parseInt($("#lv3 option:selected").val(),10)||'', "name":$("#lv3 option:selected").text()};
		var cate4 = {"seq":parseInt($("#lv4 option:selected").val(),10)||'', "name":$("#lv4 option:selected").text()};

		if(cate1.seq == '') {
			alert("대분류 카테고리를 다시 선택해주세요. 모든 항목이 제대로 입력되지 않았습니다");
			return;
		}

		$("input[name=cateLv1Seq]").val(cate1.seq);
		$("input[name=cateLv2Seq]").val(cate2.seq);
		$("input[name=cateLv3Seq]").val(cate3.seq);
		$("input[name=cateLv4Seq]").val(cate4.seq);

		if(cate1.seq != '' && cate2.seq != '' && cate3.seq != '' && cate4.seq != '') {
			$("#categoryText").html(cate1.name + " &gt; " + cate2.name + " &gt; " + cate3.name + " &gt; " + cate4.name);
		} else {
			if(cate2.seq == '' && cate3.seq == '' && cate4.seq == '') {
				$("#categoryText").html(cate1.name);
			}
			else if(cate3.seq == '' && cate4.seq == '') {
				$("#categoryText").html(cate1.name + " &gt; " + cate2.name);
			} else {
				$("#categoryText").html(cate1.name + " &gt; " + cate2.name + " &gt; " + cate3.name);
			}
		}
		
		$("#categoryModal").modal("hide");
	}
	/** 몰 선택시 */
	, mallRenderList:function(mallSeq){
		EBCategory.renderList(1, 0, mallSeq);
	}
};
/**
 * 입점업체 리스트를 불러와서 표시함
 * @param obj
 * @param pageNum
 */
var sellerProc = function(pageNum) {
	$.ajax({
		url:"/admin/seller/list/S/json",
		type:"post",
		data:{findword:$("input[name=seller]").val(), search:$("#search option:selected").val(), pageNum:pageNum},
		dataType:"text",
		success:function(data) {
			var list = $.parseJSON(data);
			if(list.length === 0) {
				$("#eb-seller-list").html( "<tr><td colspan='20' class='muted text-center' style='padding:10px'>검색된 결과가 없습니다</td></tr>" );
			} else {
				$("#eb-seller-list").html( $("#sellerTemplate").tmpl(list) );
			}
			/** 입점업체리스트를 불러온후 페이징을 호출한다. */
			sellerProcPaging(pageNum);
		},
		error:function(error) {
			alert( error.status + ":" +error.statusText );
		}
	});
};
/**
 * 입점업체 리스트 페이징 넘버를 불러와서 표시함
 * @param obj
 */
var sellerProcPaging = function(pageNum){
	$.ajax({
		type:"post",
		url:"/admin/seller/list/S/json/paging",
		dataType:"text",
		data:{findword:$("input[name=seller]").val(), search:$("#search option:selected").val(), pageNum:pageNum},
		success:function(data) {
			$("#paging").html(data);
			$("#paging").addClass("dataTables_paginate").addClass("paging_simple_numbers").addClass("text-center");
		},
		error:function(error) {
			alert( error.status + ":" +error.statusText );
		}
	});
};

/**
 * 선택된 입점업체를 표시하고 리스트의 나머지를 지움
 * @param obj
 */
var sellerSelectProc = function(obj) {
	var seq = $(obj).attr("data-seq");
	$("input[name=sellerSeq]").val(seq);
	$("#maker").val($("#seller_name"+seq).text());
	$("#eb-seller-list tr[data-seq]").each(function(){
		if($(this).attr("data-seq") != seq) {
			$(this).remove();
		} else {
			$(this).addClass("info");
		}
	});
};

var showUploadModal = function(idx) {
	$("#uploadModal").modal().find("input[name=idx]").val(idx);
	$("#uploadModal").find(".fileinput-button").show().next().hide();
};

var showUploadDetailModal = function(idx) {
	$("#uploadDetailModal").modal().find("input[name=idx]").val(idx);
	$("#uploadDetailModal").find(".fileinput-button").show().next().hide();
};

var submitUploadProc = function(obj) {
	if(!checkFileSize(obj)) {
		return;
	}
	
	$(obj).parents('form')[0].submit();
	$(obj).parents("span").hide().next().show();
};

var showDeleteModal = function(idx, imgPath, seq) {
	var text = '';
	if(idx === 1) {
		text = '대표 이미지';
	} else if(idx === 2) {
		text = '서브 이미지1';
	} else if(idx === 3) {
		text = '서브 이미지2';
	} else if(idx === 4) {
		text = '서브 이미지3';
	}
	$('#deleteModalText').text(text);
	$("#deleteModal").modal().find("input[name=idx]").val(idx);
	$("#deleteModal").find("input[name=imgPath]").val(imgPath);
	$("#deleteModal").find("input[name=imageSeq]").val(seq);
}

var showDeleteDetailModal = function(idx, imgPath, seq) {
	var text = '';
	if(idx === 1) {
		text = '상세 이미지1';
	} else if(idx === 2) {
		text = '상세 이미지2';
	} else if(idx === 3) {
		text = '상세 이미지3';
	}
	$('#deleteDetailModalText').text(text);
	$("#deleteDetailModal").modal().find("input[name=idx]").val(idx);
	$("#deleteDetailModal").find("input[name=imgPath]").val(imgPath);
	$("#deleteDetailModal").find("input[name=imageSeq]").val(seq);
}

/**
 * 폼 submit 후에 서버로부터 메시지를 받아 처리함
 * @param msg
 */
var callbackProc = function(msg) {
	if(msg.split(":")[0] === "OK") {
		//return bool;
		var returnProp = true;
		var returnOption=true;
		//공통으로 사용할 변수
		var itemSeq = parseInt(msg.split(":")[1], 10) || 0;
		var current = 1;
		//상품 추가 정보 모달
		//$("#okPropModal").modal().find(".bar").width(0); //이벤트 모달 임시로 주석처리.
		var propLength = $("#ch-info-list tr.prop").length;

		//disable되어 있는 prop 필드를 sable시킨다.
		CHItemPropInfo.sablePropInfoField();

		var propVo = CHItemPropInfo.getVo();
		propVo.itemSeq = itemSeq;

		$.ajax({
			url:"/admin/item/prop/new",
			type:"post",
			data:propVo,
			dataType:"text",
			async:false,
			success:function(data) {
				if(data === "OK") {
//					$("#okPropModal").find(".bar").width((current++/propLength*100)+"%"); //이벤트 모달 임시로 주석처리.
					if(current >= propLength) {
						setTimeout(function(){
							$("#okPropModal p").html("추가 상품정보가 정상적으로 등록되었습니다").addClass("text-success");
						}, 800);
					}
				} else if(data === "FAIL"){
					alert("추가 상품정보 데이터를 삽입하던 도중, 오류가 발생했습니다. 추가 상품정보를 등록해주세요.");
					$("#okPropModal").modal('hide');
					returnProp = false;
				} else if(data === "FILTER"){
					alert("상품 추가정보에 금지어가 포함되어 있습니다.");
					$("#okPropModal").modal('hide');
					returnProp = false;
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
		//disable되어 있는 option 필드를 sable시킨다.
		EBOption.sableOptionField();
		CHItemPropInfo.sablePropInfoField();
		if(!returnProp) {
			return;
		} else {
			//상품 옵션 정보 모달
			$("#okModal").modal().find(".bar").width(0);
		}

		current = 1; //1로 초기화
		//var itemSeq = parseInt(msg.split(":")[1], 10) || 0;
		var length = $("#eb-option-list tr.child").length;

		// 먼저 부모를 돌면서 옵션을 추가시킨다
		$("#eb-option-list tr.parent").each(function(){
			var vo = EBOption.getVo(this);
			vo.itemSeq = itemSeq;
			$.ajax({
				url:"/admin/item/option/new",
				type:"post",
				data:vo,
				dataType:"text",
				success:function(data) {
					var validData = parseInt(data,10) || 0;
					if(validData === 0) {
						$("#okModal").modal('hide');
						alert(data);
						return;
					}

					var optionSeq = parseInt(data, 10) || 0;
					$("#eb-option-list tr.child[data-pk="+vo.pk+"]").each(function(){
						var ovo = EBOption.getVo(this);
						ovo.optionSeq = optionSeq;

						// 부모로부터 optionSeq를 얻었으니 자식(옵션항목)을 추가시킨다
						$.ajax({
							url:"/admin/item/option/child/new",
							type:"post",
							data:ovo,
							async:false,
							dataType:"text",
							success:function(data) {
								if(data === 'FAIL[1]') {
									alert('비정상적인 접근입니다');
									$("#okModal").modal('hide');
									returnOption = false;
								} else if(data === 'FAIL[2]') {
									alert('옵션항목은 반드시 입력되어야 합니다');
									$("#okModal").modal('hide');
									returnOption = false;
								} else if(data === 'FAIL[4]') {
									alert('옵션을 등록하던 도중 오류가 발생했습니다');
									$("#okModal").modal('hide');
									returnOption = false;
								} else if(data === 'FAIL[5]') {
									alert('옵션항목에 금지어가 포함되어 있습니다');
									$("#okModal").modal('hide');
									returnOption = false;
								} else if(data === 'FAIL[6]') {
									alert('재고량을 0이상으로 입력해주세요.');
									$("#okModal").modal('hide');
									returnOption = false;
								} else if(data === 'FAIL') {
									alert('옵션 로그를 등록하던 도중 오류가 발생했습니다');
									$("#okModal").modal('hide');
									returnOption = false;
								} else {
									$("#okModal").find(".bar").width((current++/length*100)+"%");
									//if(current >= length) {
										setTimeout(function(){
											$("#okModal p").html("정상적으로 등록되었습니다").addClass("text-success");
											top.location.href="/admin/item/list";
										}, 800);
									//}
								}
							},
							error:function(error) {
								alert( error.status + ":" +error.statusText );
							}
						});

						if(!returnOption) {
							return;
						}
					});
				},
				// error:function(error) {
				// 	alert( error.status + ":" +error.statusText );
				// }
			});
		});
	} else if(msg === "OPTION") {
		EBOption.renderList($("#seq").val());
		$("#optionModal").modal("hide");
		$('#OptionAddBtn').show();
		document.location.reload();
	} else if(msg.split(":")[0] === "DETAIL") {
		uploadDetailProc(msg.split(":")[1], msg.split(":")[2]);
	} else if(msg.split("^")[0] === "EDITOR") {
		CKEDITOR.tools.callFunction(msg.split("^")[1],msg.split("^")[2],'이미지를 업로드 하였습니다.')
	} 
	else {
		uploadProc(msg.split(":")[0], msg.split(":")[1]);
	}
};

var uploadProc = function(idx, filename) {
	var html = "";
	if(filename.indexOf("/origin/") > 0){
		// 수정하기
		html += "<div><img src='"+ filename +"' class='img-polaroid' onclick='imgProc(this, 0)' /><br/>원본</div>";
		html += "<div><img src='"+ filename.replace("/origin/", "/s60/") +"' class='img-polaroid' /><br/>60x60</div>";
		html += "<div><img src='"+ filename.replace("/origin/", "/s110/") +"' class='img-polaroid' onclick='imgProc(this, 110)' /><br/>110x110</div>";
		html += "<div><img src='"+ filename.replace("/origin/", "/s170/") +"' class='img-polaroid' onclick='imgProc(this, 170)' /><br/>170x170</div>";
		filename = ""; // 파일명을 초기화해야 데이터가 날라가지 않는다
	} else {
		// 새로운 상품
		html += "<div><img src='"+ filename +"' class='img-polaroid' onclick='imgProc(this, 0)' /><br/>원본</div>";
		html += "<div><img src='"+ filename.replace(".", "_60.") +"' class='img-polaroid' /><br/>60x60</div>";
		html += "<div><img src='"+ filename.replace(".", "_110.") +"' class='img-polaroid' onclick='imgProc(this, 110)' /><br/>110x110</div>";
		html += "<div><img src='"+ filename.replace(".", "_170.") +"' class='img-polaroid' onclick='imgProc(this, 170)' /><br/>170x170</div>";
	}

	$("input[name=img"+idx+"]").val(filename).parents(".form-group").find(".thumbimg").html(html);
	$("#uploadModal").modal("hide");
};

var uploadDetailProc = function(idx, filename) {
	var html = "";
	if(filename.indexOf("/detail/") > 0) {
		html += "<div><img src='"+ filename +"' class='img-polaroid' style='width:auto' onclick='imgProc(this, 0)' /></div>";
		filename = ""; // 파일명을 초기화해야 데이터가 날라가지 않는다
	}else{
		html += "<div><img src='"+ filename +"' class='img-polaroid' style='width:auto' onclick='imgProc(this, 0)' /></div>";
	}

	$("input[name=detailImg"+idx+"]").val(filename).parents(".form-group").find(".thumbimg").html(html);
	$("#uploadDetailModal").modal("hide");
};

/**
 * 해당 이미지의 원본 크기를 보여주거나 되돌림
 * @param obj
 * @param size
 */
var imgProc = function(obj, size) {
	if($(obj).width() === 120 && size !== 0) {
		$(obj).css({width:size, height:size});
	} else if(size === 0 && $(obj).width() === 120 ) {
		$(obj).css({width:"auto", height:"auto"});
	} else {
		$(obj).css({width:120, height:120});
	}
};

/**
 * 옵션과 관련된 모든 행동을 담당
 * @type {{add: Function, addChild: Function, remove: Function, getVo: Function}}
 */
var EBOption = {
	/** 상품옵션 row를 추가하는 메서드 */
	add:function(){
		// 옵션을 하나로만 제한한다
		// 설계상 무제한대로 옵션을 넣을 수 있도록 설계되어 있지만, 실장님이 사용자가 헷갈려할 것이라고 옵션을 하나로만 제한한다.
		// 현재 설계는 2depth가 가능하다. 하지만 1depth의 조합형을 추후 지원하도록 할 것이라고 한다.
		if($("#eb-option-list tr").length > 4) {
			alert("옵션은 하나만 생성할 수 있습니다");
			return;
		}

		var maxCount = (function(){
			var current = 0;
			$("#eb-option-list tr.parent").each(function(){
				var val = parseInt($(this).attr("data-pk"), 10) || 0;
				current = (current <= val) ? val : current;
			});
			return current + 1;
		})();
		$("#eb-option-list .muted").remove();
		//$("#eb-option-list").append( $("#optionTemplate").tmpl({idx:maxCount}) );
		$("#eb-option-list tr:last-child .icon-plus").parent("button").click();
	}
	/** 옵션항목 row를 추가하는 메서드 */
	, addChild:function(obj) {
		$(obj).parents("tr").after( $("#optionChildTemplate").tmpl({idx:$(obj).parents("tr").attr("data-pk")}) );
		showDatepicker("yyyymmdd");
	}
	/** 옵션항목 또는 부모 옵션을 삭제하는 메서드. 부모가 삭제될 경우 모든 자식도 삭제된다 */
	, remove:function(obj) {
		if( $(obj).parents("tr").is(".parent") ) {
			var delFlag = false;
			$(obj).parents("tr").addClass("current").parents("tbody").find("tr").each(function(){
				if( $(this).is(".current") ) {
					delFlag = true;
				}
				if( delFlag && $(this).is(".parent") && !$(this).is(".current") ) {
					delFlag = false;
				}
				if(delFlag) {
					$(this).remove();
				}
			});
		} else if($(obj).parents("tr").prev().is(".parent") && ( $(obj).parents("tr").next().is(".parent") || typeof $(obj).parents("tr").next().html() === "undefined")) {
			alert("옵션항목은 반드시 한 개는 입력되어야 합니다");
		} else {
			$(obj).parents("tr").remove();
		}
	}
	/** 해당 tr에서 각각 element의 value를 매핑하는 메서드 */
	, getVo:function(obj) {
		var validShowFlag = $(obj).find("select[name=showFlag] option:selected").val();

		return {
			pk:parseInt($(obj).attr("data-pk"), 10) || 0
			, seq:parseInt($(obj).attr("data-seq"), 10) || 0
			, itemSeq:parseInt($(obj).attr("data-item-seq"), 10) || 0
			, optionName:$(obj).find("input[name=optionName]").val()
			, showFlag:(validShowFlag === undefined) ? $(obj).find("input[name=showFlag]").val() : validShowFlag//input태그는 상품복사시 필요
			, valueName:$(obj).find("input[name=valueName]").val()
			, optionPrice: parseInt($(obj).find("input[name=optionPrice]").val(), 10) || 0
			, salePrice: parseInt($(obj).find("input[name=salePrice]").val(), 10) || 0
			, salePeriod: parseInt($(obj).find("input[name=salePeriod]").val(), 10) || 0
			, stockCount:parseInt($(obj).find("input[name=stockCount]").val(), 10) || 0
			, stockFlag:$(obj).find("input[name=stockFlag]:checked").val()
			, freeDeli:$(obj).find("input[name=freeDeli]:checked").val()
			, eventAdded:$(obj).find("input[name=eventAdded]").val()
		};
	}

	/** 해당 아이템의 모든 옵션을 다시 그린다 */
	, renderList:function(seq) {
		// alert( "renderList!! seq :" +seq);

		$("#eb-eb-option-list").html('<tr><td class="muted text-center" colspan="20">데이터를 불러오고 있습니다 <img src="/assets/img/common/ajaxloader.gif" alt="" /></td></tr>');
		$.ajax({
			url:"/admin/item/option/json/"+seq,
			type:"get",
			data:{},
			dataType:"text",
			success:function(data) {
				var list = $.parseJSON(data);
				for(var idx in list) {
					if (list[idx].list && list[idx].list.length > 0) {
						$('#OptionAddBtn').hide();
						break;
					}
				}

				$("#eb-option-list").html($("#optionEditTemplate").tmpl(list));
				showDatepicker("yyyymmdd");
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, showDeleteOptionModal:function(obj, seq) {
		$(obj).prop("disabled", true);
		$.ajax({
			url:"/admin/item/option/json/",
			type:"get",
			data:{seq:seq},
			dataType:"text",
			success:function(data) {
				var vo = $.parseJSON(data);
				vo.action = "/admin/item/option/delete";
				$("#optionModal").modal().html( $("#optionDeleteTemplate").tmpl(vo) );
				$(obj).prop("disabled", false);
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, showDeleteOptionValueModal:function(obj, seq) {
		$(obj).prop("disabled", true);
		$.ajax({
			url:"/admin/item/option/value/json/",
			type:"get",
			data:{seq:seq},
			dataType:"text",
			success:function(data) {
				var vo = $.parseJSON(data);
				vo.action = "/admin/item/option/value/delete";
				$("#optionModal").modal().html( $("#optionDeleteTemplate").tmpl(vo) );
				$(obj).prop("disabled", false);
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, showUpdateOptionModal:function(obj, seq) {
		$(obj).prop("disabled", true);
		$.ajax({
			url:"/admin/item/option/json/",
			type:"get",
			data:{seq:seq},
			dataType:"text",
			success:function(data) {
				var vo = $.parseJSON(data);
				vo.action = "/admin/item/option/update";
				$("#optionModal").modal().html( $("#optionUpdateTemplate").tmpl(vo) );
				$(obj).prop("disabled", false);
				showDatepicker("yyyymmdd");
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, showUpdateOptionValueModal:function(obj, seq) {
		$(obj).prop("disabled", true);
		$.ajax({
			url:"/admin/item/option/value/json/",
			type:"get",
			data:{seq:seq},
			dataType:"text",
			success:function(data) {
				var vo = $.parseJSON(data);
				vo.action = "/admin/item/option/value/update";
				$("#optionModal").modal().html( $("#optionValueUpdateTemplate").tmpl(vo) );
				$(obj).prop("disabled", false);
				showDatepicker("yyyymmdd");
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, showAddModal:function(seq) {
		// 옵션을 하나로만 제한한다
		// 설계상 무제한대로 옵션을 넣을 수 있도록 설계되어 있지만, 실장님이 사용자가 헷갈려할 것이라고 옵션을 하나로만 제한한다.
		// 현재 설계는 2depth가 가능하다. 하지만 1depth의 조합형을 추후 지원하도록 할 것이라고 한다.
		if($("#eb-option-list tr").length > 4) {
			alert("더이상 추가할 수 없습니다.");
			return;
		}

		$("#optionModal").modal().html( $("#optionAddTemplate").tmpl({seq:seq}) );
		showDatepicker("yyyymmdd");
	}
	, submitAddProc:function(seq, obj) {
		var vo = EBOption.getVo( $(obj).parents("div.modal") );
		vo.itemSeq = seq;

		if($.trim(vo.optionName) === "") {
			alert("쇼핑몰은 반드시 입력되어야 합니다");
			return;
		} else if($.trim(vo.valueName) === "") {
			alert("공급자명은 반드시 입력되어야 합니다");
			return;
		} else  if($.trim(vo.optionPrice) == "0") {
			alert("제품 가격을 입력해주세요")
			return;
		} else if($.trim(vo.stockCount) === "0") {
			alert("재고수량을 1이상 입력해주세요.");
			return;
		}
			for(var i=0; i<$('#filterCount').val(); i++){
				if ($.trim(vo.optionName).indexOf($('#filter'+i).val()) != -1) {
					alert('상품옵션명에 금지어 ' + $('#filter'+i).val() + '이 포함되어 있습니다!');
					return;
				} else if ($.trim(vo.valueName).indexOf($('#filter'+i).val()) != -1) {
					alert('옵션항목명에 금지어 ' + $('#filter'+i).val() + '이 포함되어 있습니다!');
					return;
				}
			}

		$(obj).prop("disabled", true);
		$.ajax({
			url:"/admin/item/option/new",
			type:"get",
			data:vo,
			dataType:"text",
			success:function(data) {
				var validData = parseInt(data,10) || 0;
				if(validData === 0) {
					alert(data);
					return;
				}

				vo.optionSeq = parseInt(data,10) || 0;
				$.ajax({
					url:"/admin/item/option/child/new",
					type:"get",
					data:vo,
					dataType:"text",
					success:function(data) {
						if(data === 'FAIL[1]') {
							alert('비정상적인 접근입니다');
							return;
						} else if(data === 'FAIL[2]') {
							alert('옵션항목은 반드시 입력되어야 합니다');
							return;
						} else if(data === 'FAIL[4]') {
							alert('옵션을 등록하던 도중 오류가 발생했습니다');
							return;
						} else if(data === 'FAIL[5]') {
							alert('옵션항목에 금지어가 포함되어 있습니다');
							return;
						} else if(data === 'FAIL') {
							alert('옵션 로그를 등록하던 도중 오류가 발생했습니다');
							return;
						} else {
							$("#optionModal").modal("hide");
							EBOption.renderList($("#seq").val());
							document.location.reload();
						}
					},
					error:function(error) {
						alert( error.status + ":" +error.statusText );
					}
				});
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, showAddValueModal:function(obj, optionSeq) {
		$("#optionModal").modal().html( $("#optionValueAddTemplate").tmpl({optionSeq:optionSeq}) );
		showDatepicker("yyyy-mm-dd");
	}
	, submitAddValueProc:function(seq, obj) {
		var vo = EBOption.getVo( $(obj).parents("div.modal") );
		vo.optionSeq = seq;
		if($.trim(vo.valueName) === "") {
			alert("옵션항목은 반드시 입력되어야 합니다");
			return;
		}

		var stockCount = $(obj).parents("div.modal").find("input[name=stockCount]").val();
		if(stockCount < 1) {
			alert("재고량을 1이상으로 입력해주세요.");
			return;
		}

		$(obj).prop("disabled", true);
		$.ajax({
			url:"/admin/item/option/child/new",
			type:"get",
			data:vo,
			dataType:"text",
			success:function(data) {
				if(data === 'FAIL[1]') {
					alert('비정상적인 접근입니다');
					return;
				} else if(data === 'FAIL[2]') {
					alert('옵션항목은 반드시 입력되어야 합니다');
					return;
				} else if(data === 'FAIL[4]') {
					alert('옵션을 등록하던 도중 오류가 발생했습니다');
					return;
				} else if(data === 'FAIL[5]') {
					alert('옵션항목에 금지어가 포함되어 있습니다');
					return;
				} else if(data === 'FAIL[6]') {
					alert('재고량을 0이상으로 입력해주세요.');
				} else if(data === 'FAIL') {
					alert('옵션 로그를 등록하던 도중 오류가 발생했습니다');
					return;
				} else {
					$("#optionModal").modal("hide");
					EBOption.renderList($("#seq").val());
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, disableOptionField:function(){
		$("#eb-option-list tr.parent").each(function(){
			var validShowFlag = $(this).find("select[name=showFlag] option:selected").val();
			$(this).find("input[name=optionName]").prop('disabled',true);
			(validShowFlag === undefined) ? $(this).find("input[name=showFlag]").prop('disabled',true) : $(this).find("select[name=showFlag]").prop('disabled',true);
		});

		$("#eb-option-list tr.child").each(function(){
			$(this).find("input[name=valueName]").prop('disabled',true);
			$(this).find("input[name=optionPrice]").prop('disabled',true);
			$(this).find("input[name=salePrice]").prop('disabled',true);
			$(this).find("input[name=salePeriod]").prop('disabled',true);
			$(this).find("input[name=stockCount]").prop('disabled',true);
			$(this).find("input[name=stockFlag]").prop('disabled',true);
			$(this).find("input[name=freeDeli]").prop('disabled',true);
			$(this).find("input[name=eventAdded]").prop('disabled',true);
		});
	}
	, sableOptionField:function(){
		$("#eb-option-list tr.parent").each(function(){
			var validShowFlag = $(this).find("select[name=showFlag] option:selected").val();
			$(this).find("input[name=optionName]").prop('disabled',false);
			(validShowFlag === undefined) ? $(this).find("input[name=showFlag]").prop('disabled',false) : $(this).find("select[name=showFlag]").prop('disabled',false);
		});

		$("#eb-option-list tr.child").each(function(){
			$(this).find("input[name=valueName]").prop('disabled',false);
			$(this).find("input[name=optionPrice]").prop('disabled',false);
			$(this).find("input[name=salePrice]").prop('disabled',true);
			$(this).find("input[name=salePeriod]").prop('disabled',true);
			$(this).find("input[name=stockCount]").prop('disabled',false);
			$(this).find("input[name=stockFlag]").prop('disabled',false);
			$(this).find("input[name=freeDeli]").prop('disabled',false);
			$(this).find("input[name=eventAdded]").prop('disabled',false);
		});
	}
};

var CHItemPropInfo = {
	selectInfo:function(obj, formCode){
		if($('input[name=sellerSeq]').val()===''){
			alert('입점업체를 먼저 선택해 주세요.');
            $('#typeCd option:first').prop('selected',true);
			return;
		}

		parseInt($(obj).val(),10) !== 0 ? CHItemPropInfo.renderList($(obj).val(),formCode) : $("#ch-info-list").html("<tr><td class='muted text-center' colspan='2'>상품군을 선택해 주세요</td></tr>");
	}
	, renderList:function(typeCd,formCode){
		$.ajax({
			type:"GET",
			url:"/admin/item/prop/json",
			dataType:"text",
			data:{typeCd:typeCd},
			success:function(data) {
				var propList = {prop:[]};
				var list = $.parseJSON(data);
				propList.prop = list;
				if(list.length != 0){
					$("#ch-info-list").html( $("#propTemplate").tmpl(propList));

					var sellerSeq = $('input[name=sellerSeq]').val();
					if(formCode === 'reg'){
						setTimeout( function(){
							// AS전화번호를 seller_seq로부터 매칭한다
							$("input.prop_cd1, input.prop_cd32").each( function(){
								var _obj = $(this);
								$.ajax({
									type:"GET",
									url:"/admin/item/seller/tel",
									dataType:"text",
									data:{sellerSeq:sellerSeq},
									success:function(data) {
										$(_obj).val( data );
									}
								});
							});
							// 제조년월은 이번달(YYYY-MM)으로 표기한다
							$("input.prop_cd11, input.prop_cd75").each( function(){
								$(this).val( function() {
									var t = new Date();
									return t.getYear() + "-" + ((t.getMonth()+1)>=10?t.getMonth()+1:"0"+(t.getMonth()+1));
								});
							});
						}, 200);
					} else if(formCode === 'mod'){
						setTimeout( function(){
							// AS전화번호를 sellerSeq로부터 매칭한다
							$("input.prop_cd1, input.prop_cd32").each( function(){
								if( $.trim($(this).val()) === "제품 상세 설명내 표기") {
									var _obj = $(this);
									$.ajax({
										type:"GET",
										url:"/admin/item/seller/tel",
										dataType:"text",
										data:{sellerSeq:sellerSeq},
										success:function(data) {
											$(_obj).val( data );
										}
									});
								}
							});
							// 제조년월은 이번달(YYYY-MM)으로 표기한다
							$("input.prop_cd11, input.prop_cd75").each( function(){
								$(this).val( function() {
									if( $.trim($(this).val()) !== "제품 상세 설명내 표기") {
										return $(this).val();
									}

									var t = new Date();
									return t.getYear() + "-" + ((t.getMonth()+1)>=10?t.getMonth()+1:"0"+(t.getMonth()+1));
								});
							});
						}, 200);
					}
				} else {
					$("#ch-info-list").html("<tr><td class='text-center' colspan='2'>이 상품은 추가 정보를 입력할 수 없는 상품입니다.</td></tr>");
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	/** 해당 tr에서 각각 element의 value를 매핑하는 메서드 */
	, getVo:function() {
	// 먼저 테이블을 돌면서 상품 추가 정보를 추가시킨다
		var i = 1;
		var propValList = [];
		$("#ch-info-list tr.propTr").each(function () {
			var tmpPropVal;

			$(this).find('input').attr('type') === 'text' ? tmpPropVal = $(this).find('input[name=prop_val'+ i +']').val() : tmpPropVal = $(this).find('input:radio[name=prop_val'+ i +']:checked').val();
			propValList.push(tmpPropVal);
			i++;
		});
		return {
			itemSeq:0
			, propValList:propValList
			, typeCd:0
		};
	}
	, disablePropInfoField:function(){
		var i=1;
		$("#ch-info-list tr.propTr").each(function(){
			$(this).find('input[name="prop_val'+(i++)+'"]').prop('disabled',true);
		});
	}
	, sablePropInfoField:function(){
		var i=1;
		$("#ch-info-list tr.propTr").each(function(){
			$(this).find('input[name="prop_val'+(i++)+'"]').prop('disabled',false);
		});
	}
	, propUpdate:function(){
		if($('#typeCd').val() == '') {
			alert("상품군을 선택해 주세요.");
			$('#typeCd').focus();
			return;
		}
		
		var propVo = CHItemPropInfo.getVo();
		propVo.itemSeq = $('#seq').val();
		propVo.typeCd = $('#typeCd option:selected').val();
		
		//상품 추가정보 필드 유효성 검사		
		// 상품 추가정보 관련 폼 검증 (단 하나라도 비워져 있거나 값이 없으면 안됩니다)
		$("#ch-info-list input:text:not(.radio)").each( function() {
			if($.trim( $(this).val() ) == "" ) {
				alert( $(this).attr("alt") + " 항목을 채워주세요." );
				$(this).focus();
				return;
			}
		});

		$("#ch-info-list input:radio").each( function() {
			if($("#ch-info-list input:radio[name="+$(this).attr("name")+"]:checked").length == 0) {
				alert( $(this).attr("alt") + " 항목을 선택해주세요." );
				return;
			}
		});

		// 만약 라디오타입 중에서 텍스트필드를 포함하는 형태가 존재한다면...
		$("#ch-info-list input.radio").each( function() {
			$(this).parent().find("input:radio").val( $(this).parent().find("input:radio").attr("alt") + "[" + $(this).val() + "]" );
		});

		$.ajax({
			url:"/admin/item/prop/mod",
			type:"post",
			data:propVo,
			dataType:"text",
			success:function(data) {
				if(data === 'OK'){
					alert('상품 추가정보가 수정되었습니다.');
				} else if(data === "FILTERLIST"){
                    alert('필터정보를 불러오지 못하였습니다.');
                } else if(data === "FAIL"){
					alert('데이터를 삽입하던 도중, 오류가 발생했습니다. 상품 추가정보를 다시 수정해주세요.');
				} else if(data === "FILTER"){
					alert("상품 추가정보에 금지어가 포함되어 있습니다.");
				}
			},
			error:function(error) {
				alert( error.status + ":" +error.statusText );
			}
		});
	}
	, renderMappingList:function(){
		var sellerSeq = $('input[name=sellerSeq]').val();
		setTimeout(function(){
			var arr = [];
			for(var i=1; i<=20; i++){
				arr.push($('.prop_val'+i).val());
			}

			$(document).ready(function(){
				$("#ch-info-list tr.propTr").each(function(idx){
					$(this).find("input:radio").each(function(){
						if( $.trim( $(this).val() )==$.trim( arr[idx] ) ) {
							$(this).attr("checked", "checked");
						} else if( $.trim(arr[idx]).indexOf( $.trim($(this).val()) )===0 ) {
							$(this).attr("checked", "checked").parent().find("input.radio").val( $.trim(arr[idx]).replace($.trim($(this).val()),"").replace(/^[\[]/,"").replace(/[\]]/, "") );
						}
					});
					if( $.trim(arr[idx]) !== "" ) {
						$($(this).find("input:not(:radio):not(.radio)").get(0)).val(arr[idx]);
					}
				}).find("input.prop_cd1, input.prop_cd32").each(function(){
					var _obj = $(this);
					if($.trim( $(this).val() ) == "") {
						$.ajax({
							type: "GET",
							url: "/admin/item/seller/tel",
							dataType: "text",
							data: {sellerSeq: sellerSeq},
							success: function (data) {
								$(_obj).val(data);
							}
						});
					}
				});
				$("input.prop_cd11, input.prop_cd75").each(function(){
					$(this).val( function() {
						var regDate = $('#regDate').val();
						return ($.trim( $(this).val() ) == "") ? regDate : $(this).val();
					});
				});
			});
		},200);
	}
};

var deliTypeCodeChange = function(){
	if($('input[name=deliTypeCode]:checked').val() === '00'){
		$('input[name=deliCost]').val(0);
		$('input[name=deliFreeAmount]').val(0);
		$('select[name=deliPrepaidFlag] option:eq(0)').prop('selected',true);

		$('input[name=deliCost]').prop('disabled',true);
		$('input[name=deliFreeAmount]').prop('disabled',true);
		$('select[name=deliPrepaidFlag]').prop('disabled',true);
	} else if($('input[name=deliTypeCode]:checked').val() === '10'){
		$('input[name=deliCost]').prop('disabled',false);
		$('input[name=deliFreeAmount]').prop('disabled',false);
		$('select[name=deliPrepaidFlag]').prop('disabled',false);
	}
};

var showCode = function() {
	if($("input[name=useCode]:checked").val() === "C") {
		$(".detail-content").show();
		$(".detail-image").hide();
	} else {
		$(".detail-content").hide();
		$(".detail-image").show();
	}
};

$(document).ready(function(){
	$(".datepicker").datepicker({
		dateFormat:"yyyymmdd"
	});

	showCode();
	deliTypeCodeChange();
});
