<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script id="modMemberTemplate" type="text/html">
	<div class="form-group">
		<label class="col-sm-4 control-label">Zip or Postal code</label>
		<div class="col-sm-8">
			<input type="text" name="postcode" value="<%="${postcode}"%>" alt="Zip or Postal code" maxlength="6" class="form-control numeric" style="width:200px;">
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-4 control-label">Address</label>
		<div class="col-sm-8">
			<input type="text" name="addr1" value="<%="${addr1}"%>" alt="Address" maxlength="100" class="form-control" style="width:350px;" data-required-label="Address">
		</div>
	</div>
	<div class="form-group">
		<label class="col-sm-4 control-label">Address line</label>
		<div class="col-sm-8">
			<input type="text" name="addr2" value="<%="${addr2}"%>" alt="Address line" maxlength="100" class="form-control" style="width:350px;" data-required-label="Address line">
		</div>
	</div>
</script>

<div id="modMemberModal" class="modal fade">
	<div class="modal-dialog">
		<form action="/shop/mypage/member/mod/callback" method="post" target="zeroframe" onsubmit="return submitProc(this)">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">개인정보수정</h4>
				</div>
				<div class="modal-body form-horizontal"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-primary">등록</button>
				</div>
			</div>
		</form>
	</div>
</div>