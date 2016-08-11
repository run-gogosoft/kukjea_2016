<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html class="no-js">
<head>
    <%@ include file="/WEB-INF/jsp/admin/include/header.jsp" %>
    <style type="text/css">
        #TableBody .drag {
            background: #eff;
        }
    </style>
</head>
<body class="skin-blue fixed">
<%@ include file="/WEB-INF/jsp/admin/include/navigation.jsp" %>
<div class="content-wrapper">
	<section class="content-header">
	    <h1>메뉴 관리 <small>Main Menu</small></h1>
	    <ol class="breadcrumb">
	        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        <li>시스템 관리</li>
	        <li class="active">메뉴 관리</li>
	    </ol>
	</section>

	<section class="content">
	    <div class="row">
	        <div class="col-md-12">
	            <div class="box">
	                <div class="box-header">
	                    <div class="box-tools pull-right">
	                        &nbsp;
	                    </div>
	                </div>
	                <div class="box-body table-responsive">
	                    <div class="alert alert-info">
	                        <i class="fa fa-info-circle"></i>
	                        칸을 드래그해서 순서를 변경할 수 있습니다. 변경하셨으면 저장 버튼을 눌러 저장해주세요.
	                    </div>

	                    <table class="table">
	                        <thead>
	                        <tr>
	                            <td><strong>이름</strong></td>
	                            <td></td>
	                            <td></td>
	                        </tr>
	                        </thead>
	                        <tbody id="TableBody">
	                        <c:forEach var="item" items="${list}">
	                            <tr data-seq="${item.seq}">
	                                <td data-col="name">${item.name}</td>
	                                <td><a href="/admin/about/menu/sub/list?mainSeq=${item.seq}" class="btn btn-sm btn-success">서브메뉴 관리</a></td>
	                                <td>
	                                    <button type="button" onclick="showUpdateModal(this);" class="btn btn-sm btn-default">수정</button>
	                                    <button type="button" onclick="showDeleteModal(${item.seq});" class="btn btn-sm btn-danger">삭제</button>
	                                </td>
	                            </tr>
	                        </c:forEach>
	                        <c:if test="${fn:length(list) eq 0}">
	                            <tr>
	                                <td colspan="10" class="text-center muted" style="padding:30px">
	                                    등록된 내용이 없습니다
	                                </td>
	                            </tr>
	                        </c:if>
	                        </tbody>
	                        <c:if test="${fn:length(list) ne 0}">
	                        <tfoot>
	                        <tr>
	                            <td class="text-muted">입점업체 정보</td>
                                <td class="text-muted">수정불가</td>
                                <td class="text-muted">수정불가</td>
	                        </tr>
	                        </tfoot>
	                        </c:if>
	                    </table>
	                </div>
	                <div class="box-footer clearfix">
	                    <button type="button" onclick="showInsertModal()" class="btn btn-sm btn-primary">등록</button>
	                    <button type="button" onclick="saveOrderProc()" class="btn btn-sm btn-success">순서 저장</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>
</div>

<div class="modal fade" id="FormModal">
    <div class="modal-dialog"></div>
</div>

<script id="FormTemplate" type="text/html">
    <form action="<%="${action}"%>" method="post" onsubmit="return submitProc(this);" target="zeroframe">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">메뉴 {{if seq}}수정{{else}}추가{{/if}}</h4>
            </div>
            <div class="modal-body">
                <p><label class="label label-info">메뉴명</label></p>
                <p><input type="text" name="name" class="form-control" maxlength="20" value="<%="${name}"%>" alt="메뉴명"/></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                <button type="submit" class="btn btn-primary">저장</button>
            </div>
            {{if seq}}<input type="hidden" name="seq" value="<%="${seq}"%>" />{{/if}}
        </div>
    </form>
</script>

<div class="modal fade" id="DeleteModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">정말로 삭제하시겠습니까?</h4>
            </div>
            <div class="modal-body">
                <ul>
                    <li>이 작업은 복원하실 수 없습니다!!</li>
                </ul>
            </div>
            <form action="/admin/about/menu/delete" target="zeroframe">
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    <button type="submit" target="zeroframe" class="btn btn-danger">삭제</button>
                </div>
                <input type="hidden" name="seq" value="" />
            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jsp/admin/include/footer.jsp" %>
<script type="text/javascript" src="/assets/js/plugins/jquery.tablednd.min.js"></script>
<script type="text/javascript">
    function goPage(pageNum) {
        location.href = "/admin/about/menu?pageNum=" + pageNum + "&" + $("#SearchForm").serialize();;
    }

    function showInsertModal() {
        var data = {
            'action' : '/admin/about/menu/insert'
        };
        $('#FormModal>div').html( $('#FormTemplate').tmpl(data) );
        $('#FormModal').modal();
    }

    function showUpdateModal(obj) {
        var data = {
            'action' : '/admin/about/menu/update',
            'name': $(obj).parents('tr').find('[data-col=name]').text() || '',
            'seq': $(obj).parents('tr').attr('data-seq')
        };
        $('#FormModal>div').html( $('#FormTemplate').tmpl(data) );
        $('#FormModal').modal();
    }

    function showDeleteModal(seq) {
        $('#DeleteModal input[name=seq]').val(seq);
        $('#DeleteModal').modal();
    }

    function saveOrderProc() {
        var arr = [];
        $('#TableBody tr').each(function(){
            arr.push( $(this).attr('data-seq') );
        });

        $('#zeroframe').attr('src', '/admin/about/menu/order?seqs=' + arr.join(','));
    }

    var submitProc = function(obj) {
        var flag = true;
        $(obj).find("input[alt], textarea[alt], select[alt]").each( function() {
            if(flag && $(this).val() == "" || flag&& $(this).val() == 0) {

                alert($(this).attr("alt") + "란을 채워주세요!");
                flag = false;
                $(this).focus();
            }
        });
        return flag;
    };

    $(document).ready(function(){
        $("#TableBody").tableDnD({
            onDragClass: "drag"
        });
    });
</script>


</body>
</html>
