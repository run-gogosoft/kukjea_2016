<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="PopupModal" class="popup-modal"></div>

<script id="DescTemplate" type="text/html">
    <div>
        <div class="box_sty1">
            <p><strong><%="${vo.name}"%></strong></p>
            <p class="mt5"><%="${vo.maker}"%></p>
            <div class="price_info">
                <span class="price_label">해당 상품 최저가</span>
                <span class="price"><strong><%="${ebFormatNumber(vo.sellPrice)}"%>원</strong></span>
                <a href="/shop/about/board/detail/form/10"  class="btn btn_gray btn_xs" >가격제안</a>
            </div>
        </div>

        <table class="data_type2">
            <caption>상품 목록</caption>
            <colgroup>
                <col style="width:12%" />
                <col style="width:auto" />
                <col style="width:20%" />
                <col style="width:20%" />
                <col style="width:15%" />
                <col style="width:15%" />
            </colgroup>
            <thead>
            <tr>
                <th scope="col">선택</th>
                <th scope="col">공급사</th>
                <th scope="col"><span class="hide">프로모션 아이콘</span></th>
                <th scope="col">공급가</th>
                <th scope="col">재고</th>
                <th scope="col">수량</th>
            </tr>
            </thead>
            <tbody class="optionList">
            {{each optionList}}
            <tr class="optionItem">
                <td>
                    <input type="radio" class="radio" title="상품 선택" name="goods" value="<%="${optionSeq}"%>" onclick="PriceLB.changeProc(this);PriceLB.calcOrderAmt();" data-option-value="<%="${seq}"%>" data-option-price="<%="${optionPrice}"%>" data-stock-count="<%="${stockCount}"%>" data-stock-flag="<%="${stockFlag}"%>"/>
                </td>
                <td class="lt" ><%="${valueName}"%></td>
                <td>
                    <span class="icons">
                        {{if freeDeli =='Y'}}<span class="icon icon_txt icon_txt_gray">무료배송</span>{{/if}}
                        {{if eventAdded !=''}}<span class="icon icon_txt icon_txt_yellow"><%="${eventAdded}"%></span>{{/if}}
                        {{if salePercent <100 && salePercent >0}}<span class="icon icon_txt icon_txt_red"><%="${salePercent}"%>%</span>{{/if}}
                    </span>
                </td>
                <td>
                    <em class="txt_point">
                        <strong><%="${ebFormatNumber(sellPrice)}"%></strong>
                    </em>원
                </td>
                <td><%="${stockCount}"%></td>
                <td>
                    <input type="text" class="intxt wfull" title="수량 입력" value="1" />
                </td>
            </tr>
            {{/each}}
            </tbody>
        </table>

        <input type="hidden" id="optionValueSeq" name="optionValueSeq" value="" />


        <input type="hidden" id="seq" value="<%="${vo.seq}"%>" />
        <input type="hidden" id="typeCode" name="typeCode" value="<%="${vo.typeCode}"%>" />

        <strong id="sell-price" style="display:none" data-price="<%="${vo.sellPrice}"%>"><%="${vo.sellPrice}"%></strong>
        <div id="option-name" style="display:none"></div>

        <div class="btn_action rt mt10">
            <button type="button" onclick="return addWish('${loginSeq}','<%="${vo.seq}"%>');" class="btn btn_red">관심상품담기</button>
            <button type="button" onclick="return EBProcess.addCart('${loginSeq}','<%="${vo.seq}"%>');" class="btn btn_red">장바구니담기</button>
        </div>

        <div class="goods_desc">
            <dl>
                <dt>상품요약</dt>
                <dd>
                    <div class="thumb">

                        <img src="/upload<%="${vo.img1}"%>" alt="" onerror="noImage(this)"/>

                        <button type="button" class="btn_zoom_img" onclick="$('#PopupModal').show();">
                            <img src="/images/common/icon_zoom_img.png" alt="" /> 큰이미지 보기
                        </button>
                    </div>
                    <table class="default">
                        <caption>상품 기본 설명</caption>
                        <colgroup>
                            <col style="width:75px" />
                            <col style="width:175px" />
                        </colgroup>
                        <tbody>
                        <tr>
                            <th scope="row"><p>상 품 명</p></th>
                            <td><%="${vo.name}"%></td>
                        </tr>
                        <tr>
                            <th scope="row"><p>규 격 </p></th>
                            <td><%="${vo.type1}"%>
                                {{if vo.type2}}
                                ,<%="${vo.type2}"%>
                                {{/if}}
                                {{if vo.type3}}
                                ,<%="${vo.type3}"%>
                                {{/if}}
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <th scope="row"><p>단 위</p></th>
                            <td><%="${vo.originCountry}"%></td>
                        </tr>
                        <tr>
                            <th scope="row"><p>제 조 사</p></th>
                            <td><%="${vo.maker}"%></td>
                        </tr>
                        <tr>
                            <th scope="row"><p>보 험 코 드</p></th>
                            <td><%="${vo.insuranceCode}"%></td>
                            <td></td>
                        </tr>
                        </tbody>
                    </table>
                </dd>
                <dt class="goods_detail">상세정보
                    <button type="button" class="btn_summary_showhide">펼쳐보기</button>
                </dt>
                <dd class="goods_detail">
                    {{html vo.content}}
                </dd>

                <dt>연계상품</dt>
                <dd class="rel_goods">
                    <ul id="RelationBody"></ul>
                </dd>
            </dl>
        </div>
    </div>
</script>

<script id="RelationTemplate" type="text/html">
    <li>
        <a href="/shop/detail/<%="${seq}"%>" onclick="view(<%="${seq}"%>);return false;" title="<%="${name}"%>">
            <span class="thumb">
                <img src="<%="${img1}"%>" alt="" onerror="noImage(this)" />
            </span>
            <span class="tit"><%="${name}"%></span>
            <span class="price"><strong><%="${sellPrice}"%>원</strong></span>
        </a>
    </li>
</script>

<script id="PopupTemplate" type="text/html">
    <div class="pop_wrap pop_zoom_img">
        <div class="pop_header">
            <h1>큰이미지 보기</h1>
        </div>
        <div class="pop_cont">
            <div class="pop_inner">
                <h2><%="${vo.name}"%><em></em><span><%="${vo.maker}"%></span></h2>
                <ul class="img_list">
                    <li data-sm-img="1"><img src="/upload<%="${vo.img1}"%>" alt=""></li>
                    {{if vo.img2}}<li data-sm-img="2"><img src="/upload<%="${vo.img2}"%>" alt=""></li>{{/if}}
                    {{if vo.img3}}<li data-sm-img="3"><img src="/upload<%="${vo.img3}"%>" alt=""></li>{{/if}}
                    {{if vo.img4}}<li data-sm-img="4"><img src="/upload<%="${vo.img4}"%>" alt=""></li>{{/if}}
                </ul>
                <div class="zoom_img">
                    <ul>
                        <li data-big-img="1" class="on"><img src="/upload<%="${vo.img1}"%>" alt=""></li>
                        {{if vo.img2}}<li data-big-img="2"><img src="/upload<%="${vo.img2}"%>" alt=""></li>{{/if}}
                        {{if vo.img3}}<li data-big-img="3"><img src="/upload<%="${vo.img3}"%>" alt=""></li>{{/if}}
                        {{if vo.img4}}<li data-big-img="4"><img src="/upload<%="${vo.img4}"%>" alt=""></li>{{/if}}
                    </ul>
                </div>
            </div>
        </div>
        <button type="button" class="btn_close" onclick="$('#PopupModal').hide();"><span class="blind">팝업 닫기</span></button>
    </div>
</script>

<form id="buyForm" class="hide" action="/shop/order/direct" method="post" target="zeroframe"><div></div></form>
<form id="cartForm" class="hide" action="/shop/cart/add" method="post" target="zeroframe"><div></div></form>

<script type="text/javascript" src="/assets/js/libs/numeral.js"></script>
<script type="text/javascript" src="/front-assets/js/plugin/jquery.alphanumeric.js"></script>
<script type="text/javascript" src="/front-assets/js/detail/detail.js"></script>
<script>
    function changeRowCount(v) {
        $('form[name=searchForm] input[name=rowCount]').val(v);
        location.href=location.pathname + '?' + $('form[name=searchForm]').serialize();
    }
    function changeOrderType(v) {
        $('form[name=searchForm] input[name=orderType]').val(v);
        location.href=location.pathname + '?' + $('form[name=searchForm]').serialize();
    }
    function changeListStyle(v) {
        $('form[name=searchForm] input[name=listStyle]').val(v);
        location.href=location.pathname + '?' + $('form[name=searchForm]').serialize();
    }
    function view(seq) {
        $('[data-seq]').removeClass('on');
        $('[data-seq='+seq+']').addClass('on');

        $.get('/shop/detail/'+seq, function(data){
            $('#DescBody').html( $('#DescTemplate').tmpl(data) );

            $('.btn_summary_showhide').click(function() {
                if ($(this).parent('dt').next('dd').is(':visible')) {
                    $(this).text('펼쳐보기');
                    $(this).removeClass('on').parent('dt').next('dd').slideUp(100);
                }else {
                    $(this).text('접기');
                    $(this).addClass('on').parent('dt').next('dd').slideDown(100);
                }
            });

            // 연계상품
            relationItem( data.vo.sellerSeq );

            // 큰 이미지 보기
            $('#PopupModal').html( $('#PopupTemplate').tmpl(data));
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

            // 퀵
            addQuick(seq, '/upload'+data.vo.img1 );
        });
    }

    var goPage = function (page) {
        $("#pageNum").val(page);

        location.href = location.pathname + "?pageNum=" + page + "&" + $('form[name=searchForm]').serialize();
    };

    function relationItem(sellerSeq) {
        $.ajax({
            type:"GET",
            url:"/shop/detail/seller/item/list/ajax",
            dataType:"text",
            data:{sellerSeq:sellerSeq, statusCode:"Y", pageNum:1, rowCount:5},
            success:function(data) {
                var vo = $.parseJSON(data);
                if(vo.list.length !== 0){
                    $("#RelationBody").html( $("#RelationTemplate").tmpl(vo.list));
                }
            }
        });
    }
    $(document).ready(function(){
        $('.goods_list [data-seq] a').eq(0).click();
    });
</script>
