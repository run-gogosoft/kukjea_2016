package com.smpro.vo;

public class CommonBoardVo extends PagingVo {
	/** 시퀀스 */
	private Integer seq;
	/** 게시판 이름 */
	private String name = "";
	/** 회원 이름 */
	private String memberName = "";
	/** 답변자 이름 */
	private String answerName = "";
	/** 작성자 타입*/
	private String userTypeCode = "";
	/** 게시판 관리 테이블 시퀀스(FK) */
	private Integer commonBoardSeq;
	/** 작성자 시퀀스(비회원:null) */
	private Integer userSeq;
	/** 작성자 이름(비회원) */
	private String userName = "";
	/** 작성자 비밀번호(비회원) */
	private String userPassword = "";
	/** 게시글 제목 */
	private String title = "";
	/** 게시글 내용 */
	private String content = "";
	/** 게시글 답변 */
	private String answer = "";
	/** 답변자 시퀀스 */
	private Integer answerSeq;
	/** 답변여부(Y=답변, N=미답변) */
	private String answerFlag = "";
	/** 게시판 최상단 공지사항 글 여부(Y=공지글, N=일반글) */
	private String noticeFlag = "";
	/** 비밀글(Y=비밀글, N=일반글) */
	private String secretFlag = "";
	/** 조회수 */
	private Integer viewCnt;
	/** 댓글수 */
	private Integer commentCnt;
	/** 추천수 */
	private Integer recommentCnt;
	/** 답변 등록 날짜 */
	private String answerDate = "";
	/** 게시글 수정 날짜 */
	private String modDate = "";
	/** 게시글 등록 날짜 */
	private String regDate = "";
	/** 첨부파일 존재 여부 */
	private String isFile = "";
	/** 첨부파일 코드 */
	private String fileCodeName = "";
	/** 첨부파일 저장이름 */
	private String realFilename = "";
	
	/** 게시판 종류 코드 (N=일반게시판, B=보도자료게시판, G=갤거리게시판,Y=유투브게시판) */
	private String typeCode = "";
	/** 코멘트 기능 사용 여부 */
	private String commentUseFlag = "";
	private Integer boardSeq;
	
	
	public Integer getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(Integer commentCnt) {
		this.commentCnt = commentCnt;
	}
	public Integer getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(Integer boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getCommentUseFlag() {
		return commentUseFlag;
	}
	public void setCommentUseFlag(String commentUseFlag) {
		this.commentUseFlag = commentUseFlag;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	
	public String getAnswerName() {
		return answerName;
	}
	public void setAnswerName(String answerName) {
		this.answerName = answerName;
	}
	
	public String getUserTypeCode() {
		return userTypeCode;
	}
	public void setUserTypeCode(String userTypeCode) {
		this.userTypeCode = userTypeCode;
	}
	
	public Integer getCommonBoardSeq() {
		return commonBoardSeq;
	}
	public void setCommonBoardSeq(Integer commonBoardSeq) {
		this.commonBoardSeq = commonBoardSeq;
	}

	public Integer getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(Integer userSeq) {
		this.userSeq = userSeq;
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Integer getAnswerSeq() {
		return answerSeq;
	}
	public void setAnswerSeq(Integer answerSeq) {
		this.answerSeq = answerSeq;
	}

	public String getAnswerFlag() {
		return answerFlag;
	}
	public void setAnswerFlag(String answerFlag) {
		this.answerFlag = answerFlag;
	}

	public String getNoticeFlag() {
		return noticeFlag;
	}
	public void setNoticeFlag(String noticeFlag) {
		this.noticeFlag = noticeFlag;
	}

	public String getSecretFlag() {
		return secretFlag;
	}
	public void setSecretFlag(String secretFlag) {
		this.secretFlag = secretFlag;
	}

	public Integer getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(Integer viewCnt) {
		this.viewCnt = viewCnt;
	}

	public Integer getRecommentCnt() {
		return recommentCnt;
	}
	public void setRecommentCnt(Integer recommentCnt) {
		this.recommentCnt = recommentCnt;
	}

	public String getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(String answerDate) {
		this.answerDate = answerDate;
	}

	public String getModDate() {
		return modDate;
	}
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getIsFile() {
		return isFile;
	}
	public void setIsFile(String isFile) {
		this.isFile = isFile;
	}
	
	public String getFileCodeName() {
		return fileCodeName;
	}
	public void setFileCodeName(String fileCodeName) {
		this.fileCodeName = fileCodeName;
	}
	
	public String getRealFilename() {
		return realFilename;
	}
	public void setRealFilename(String realFilename) {
		this.realFilename = realFilename;
	}

	@Override
	public String getSearch() {
		return search;
	}
}
