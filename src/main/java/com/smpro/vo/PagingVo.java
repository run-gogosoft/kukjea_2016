package com.smpro.vo;

/*
 * abstract로 선언한다는 건, 이 클래스를 반드시 구현하라는 의미이다. paging 클래스를 상속 받도록 강제한 것이다. 이렇게 강제한
 * 이유는, paging 클래스가 더이상 방대해지면 안되기 때문이다. 예전에 추상이 아닌 그냥 구현으로 두고 다른 개발자들에게는 상속 받아서
 * 쓰라고 했더니, 상속을 하지 않고 그냥 클래스를 수정하는 개발자가 많았다. 결국 필드가 한 두개씩 늘어나다가 나중에는 수십개 이상 늘어나
 * 각각의 필드가 무슨 역할을 갖는지 도저히 알 수 없게 되었다. 그래서 특수한 목적을 갖는 검색 필드는 따로 구현하고, getSearch만
 * 구현하도록 하는 것이 효과적이라고 생각한다. 별도의 paging 클래스가 늘어나는 건 관리할 수 있지만 paging 클래스 하나가
 * 방대해지는 건 별로 좋지 않다고 생각한다.
 * 
 * 즉, 이 클래스를 상속받고 getSearch 메서드만 구현하라.
 */
public abstract class PagingVo {
	protected String search = "";
	protected String findword = "";

	private int pageNum = 0;
	private int rowNumber = 0;
	private int rowCount = 10;

	private int totalRowCount = 0;
	private int pageCount = 10;

	private int startRowNum = 0;
	private int endRowNum = 0;

	private String loginType = "";
	private Integer loginSeq;
	private String loginName = "";
	private String loginEmail= "";
	private String searchDate1 = "";
	private String searchDate2 = "";

	private String orderByName = "";
	private String orderByType = "";
	
	abstract public String getSearch();

	public void setSearch(String search) {
		this.search = search;
	}

	public String getFindword() {
		return findword;
	}

	public void setFindword(String findword) {
		this.findword = findword;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public void setStartRowNo(int startRowNo) {
		this.startRowNum = startRowNo;
	}

	public void setEndRowNo(int endRowNo) {
		this.endRowNum = endRowNo;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		if (pageNum < 0) {
			return;
		}
		this.pageNum = pageNum;
	}

	public int getRowNumber() {
		return rowNumber;
	}

	public void setRowNumber(int rowNumber) {
		this.rowNumber = rowNumber;
	}

	public int getRowCount() {
		return rowCount;
	}

	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}

	public int getStartRowNum() {
		calc();
		return startRowNum;
	}

	public int getEndRowNum() {
		calc();
		return endRowNum;
	}

	public int getTotalRowCount() {
		return totalRowCount;
	}

	public void setTotalRowCount(int totalRowCount) {
		this.totalRowCount = totalRowCount;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	public String getLoginType() {
		return loginType;
	}

	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}

	public Integer getLoginSeq() {
		return loginSeq;
	}

	public void setLoginSeq(Integer loginSeq) {
		this.loginSeq = loginSeq;
	}
	
	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public String getLoginEmail() {
		return loginEmail;
	}

	public void setLoginEmail(String loginEmail) {
		this.loginEmail = loginEmail;
	}

	public int getPageCount() {
		return pageCount;
	}

	public String getSearchDate1() {
		return searchDate1;
	}

	public void setSearchDate1(String searchDate1) {
		this.searchDate1 = searchDate1;
	}

	public String getSearchDate2() {
		return searchDate2;
	}

	public void setSearchDate2(String searchDate2) {
		this.searchDate2 = searchDate2;
	}
		
	public String getOrderByName() {
		return orderByName;
	}

	public void setOrderByName(String orderByName) {
		if(orderByName.matches("^[\\w|.]+$")) {
			//request parameter 값이 알파벳 또는 숫자로 구성되어 있을때만 받아들인다.
			this.orderByName = orderByName;
		}
	}

	public String getOrderByType() {
		return orderByType;
	}

	public void setOrderByType(String orderByType) {
		if(orderByType.matches("^[\\w]+$")) {
			//request parameter 값이 알파벳 또는 숫자로 구성되어 있을때만 받아들인다.
			this.orderByType = orderByType;
		}
	}

	public String drawPagingNavigation(String jsFunctionName) {
		StringBuffer _sb = new StringBuffer();
		int totalPageCnt = totalRowCount / rowCount;
		System.out.println("$$$$ totalRowCount:"+totalRowCount+", rowCount:"+rowCount+". pageNum:"+pageNum);
		if (totalRowCount % rowCount > 0) {
			totalPageCnt = totalPageCnt + 1;
		}
		int startPageNum = pageNum / pageCount * pageCount;
		int endPageNum = totalPageCnt;
		if (pageNum / pageCount != totalPageCnt / pageCount) {
			endPageNum = startPageNum + pageCount;
		}


		System.out.println("$$$$ totalPageCnt:"+totalPageCnt+", startPageNum:"+startPageNum+", endPageNum:"+endPageNum);
		_sb.append("<div class='paging'>");
		if (startPageNum >= pageCount) {
			_sb.append("<a href='#' class='prev' onclick='");
			_sb.append(jsFunctionName);
			_sb.append("(");
			_sb.append(startPageNum - 1);
			_sb.append(");return false;'>이전</a>");
		}
		_sb.append("<span class='num'>");
		for (int i = startPageNum; i < endPageNum; i++) {
			if (i == pageNum) {
				_sb.append("<em>");
				_sb.append(i + 1);
				_sb.append("</em>");
			} else {
				_sb.append("<a href='#' onclick='");
				_sb.append(jsFunctionName);
				_sb.append("(");
				_sb.append(i);
				_sb.append(");return false;'>");
				_sb.append(i + 1);
				_sb.append("</a>");
			}
		}
		_sb.append("</span>");
		if (endPageNum < totalPageCnt) {
			_sb.append("<a href='#' class='next' onclick='");
			_sb.append(jsFunctionName);
			_sb.append("(");
			_sb.append(endPageNum);
			_sb.append(");return false;'>다음</a>");
		}
		_sb.append("</div>");

		System.out.println("$$$$ _sb.tostring:"+_sb.toString());
		return _sb.toString();
	}

	private void calc() {
		startRowNum = pageNum * rowCount + 1;
		endRowNum = startRowNum + rowCount - 1;
	}
}
