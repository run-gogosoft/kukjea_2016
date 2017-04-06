package com.smpro.service;

import com.smpro.dao.MemberDao;
import com.smpro.dao.MemberDeliveryDao;
import com.smpro.dao.UserDao;
import com.smpro.util.Const;
import com.smpro.util.ExcelUtil;
import com.smpro.util.StringUtil;
import com.smpro.util.crypt.CrypteUtil;
import com.smpro.vo.MemberDeliveryVo;
import com.smpro.vo.MemberStatsVo;
import com.smpro.vo.MemberVo;
import com.smpro.vo.UserVo;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private MemberDeliveryDao memberDeliveryDao;

	/** 회원 리스트 */
	public List<MemberVo> getList(MemberVo vo) throws Exception {
		List<MemberVo> list = null;
		if("email".equals(vo.getSearch())) {
			if(!"".equals(vo.getFindword())) {
				vo.setFindword(CrypteUtil.encrypt(vo.getFindword(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			}
		}
		
		list = memberDao.getList(vo);
		
		//정상적으로 이메일을 쿼리한뒤 값이 존대한다면 복호화한다.
		if("email".equals(vo.getSearch())) {
			vo.setFindword(CrypteUtil.decrypt(vo.getFindword(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		for(int i=0; i<list.size(); i++){
			list.get(i).setEmail(CrypteUtil.decrypt(list.get(i).getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		
		return list;
	}

	/** 요청 회원 리스트 */
	public List<MemberVo> getRequestList(MemberVo vo) throws Exception {
		List<MemberVo> list = null;
		if("email".equals(vo.getSearch())) {
			if(!"".equals(vo.getFindword())) {
				vo.setFindword(CrypteUtil.encrypt(vo.getFindword(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			}
		}

		list = memberDao.getRequestList(vo);

		//정상적으로 이메일을 쿼리한뒤 값이 존대한다면 복호화한다.
		if("email".equals(vo.getSearch())) {
			vo.setFindword(CrypteUtil.decrypt(vo.getFindword(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		for(int i=0; i<list.size(); i++){
			list.get(i).setEmail(CrypteUtil.decrypt(list.get(i).getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}

		return list;
	}

	public int getRequestListCount(MemberVo vo) { return memberDao.getRequestListCount(vo);}

	/** 회원 리스트 검색 건수 */
	public int getListCount(MemberVo vo) {
		return memberDao.getListCount(vo);
	}

	/** 회원 상세 정보 조회 */
	public MemberVo getData(Integer seq) throws Exception {
		MemberVo vo = memberDao.getData(seq);
		if (vo != null) {
			//전화번호 분리
			if (vo.getTel() != null) {
				String[] arrTel = null;
				String decStr = CrypteUtil.decrypt(vo.getTel(), Const.ARIA_KEY,Const.ARIA_KEY.length * 8, null);
				if(decStr != null) {
					vo.setTel(decStr);
					arrTel = decStr.split("-");
				}
				
				if (arrTel != null && arrTel.length == 3) {
					vo.setTel1(arrTel[0]);
					vo.setTel2(arrTel[1]);
					vo.setTel3(arrTel[2]);
				}
			}
			//휴대폰번호 분리
			if (vo.getCell() != null) {
				String[] arrCell = null;
				String decStr = CrypteUtil.decrypt(vo.getCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null);
				if(decStr != null) {
					vo.setCell(decStr);
					arrCell = vo.getCell().split("-");
				}
				
				if (arrCell != null && arrCell.length == 3) {
					vo.setCell1(arrCell[0]);
					vo.setCell2(arrCell[1]);
					vo.setCell3(arrCell[2]);
				}
			}
			//이메일 분리
			if (vo.getEmail() != null) {
				String[] arrEmail = null;
				String decStr = CrypteUtil.decrypt(vo.getEmail(), Const.ARIA_KEY,Const.ARIA_KEY.length * 8, null);
				if(decStr != null) {
					//vo.setEmail(decStr.replaceAll("[\\W]+$", ""));
					vo.setEmail(decStr);
					arrEmail = vo.getEmail().split("@");
				}
				
				if (arrEmail != null && arrEmail.length == 2) {
					vo.setEmail1(arrEmail[0]);
					vo.setEmail2(arrEmail[1]);
				}
			}
			
			//상세주소 복호화
			vo.setAddr2(CrypteUtil.decrypt(vo.getAddr2(), Const.ARIA_KEY,Const.ARIA_KEY.length * 8, null));
		}
		return vo;
	}

	/** 회원 상세 정보 조회(외부 연동용) */
	public MemberVo getData(String id) {
		return memberDao.getData(id);
	}

	/** 회원 상세 정보 검색 */
	public MemberVo getSearchMemberVo(MemberVo vo) {
		return memberDao.getSearchMemberVo(vo);
	}

	/** 회원 상세 정보 검색 */
	public List<MemberVo> getSearchMemberList(MemberVo vo)
			throws UnsupportedEncodingException, InvalidKeyException {
		List<MemberVo> list = memberDao.getSearchMemberList(vo);

		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getCell() != null && list.get(i).getCell() != "") {
				list.get(i).setCell(CrypteUtil.decrypt(list.get(i).getCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
			}
		}
		return list;
	}

	/** 회원가입 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean regData(MemberVo vo) throws Exception {
		int result;

		/* 입력받은 패스워드 암호화 */
		vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
		// 우편번호, 전화번호, 휴대폰 번호, 이메일 각 항목별 세부필드 합치기
		formatValue(vo);
		// 개인정보 암호화
		encrypt(vo);

		// null parameter 기본값 설정
		if ("".equals(vo.getEmailFlag())) {
			vo.setEmailFlag("N");
		}
		if ("".equals(vo.getSmsFlag())) {
			vo.setSmsFlag("N");
		}

		result = userDao.insertData(vo);
		if (result > 0) {
			result += memberDao.regData(vo);
			//이제너두 제휴사 연동몰이 아닐 경우에만 적용
			MemberDeliveryVo deliVo = new MemberDeliveryVo();
			deliVo.setMemberSeq(vo.getSeq());
			deliVo.setTitle("기본");
			deliVo.setName(vo.getName());
			deliVo.setTel(vo.getTel());
			deliVo.setCell(vo.getCell());
			deliVo.setPostcode(vo.getPostcode());
			deliVo.setAddr1(vo.getAddr1());
			deliVo.setAddr2(vo.getAddr2());
			deliVo.setDefaultFlag("Y");
			result +=  memberDeliveryDao.regData(deliVo);
		}
		
		if (result != 3) {
			throw new Exception();
		}

		return result > 0;
	}

	/** 회원 정보 수정 */
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = { Exception.class })
	public boolean modData(MemberVo vo) throws Exception {
		int result;

		// 우편번호, 전화번호, 휴대폰 번호, 이메일 각 항목별 세부필드 합치기
		formatValue(vo);
		// 개인정보 암호화
		encrypt(vo);

		// update sm_user
		result = memberDao.modDataUser(vo);
		// update sm_member
		if (result > 0) {
			result = result + memberDao.modDataMember(vo);
		}
		// update 결과가 2가 아닐경우 롤백
		if (result != 2) {
			throw new Exception();
		}

		return result > 0;
	}

	/** 회원 현황 */
	public MemberStatsVo getStats() {
		return memberDao.getStats();
	}

	/** 임시비밀번호 업데이트 */
	public int updateTempPassword(UserVo vo) throws Exception {
		// 임시 비밀번호 생성
		try {
			/* 입력받은 패스워드 암호화 */
			vo.setTempPassword(this.createTempPassword());
			vo.setPassword(StringUtil.encryptSha2(vo.getTempPassword()));
			/* 메일 encrypt */
			vo.setEmail(CrypteUtil.encrypt(vo.getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		} catch (NoSuchAlgorithmException nsae) {
			nsae.printStackTrace();
			return 0;
		}
		return userDao.updateTempPassword(vo);
	}
	
	/** 임시비밀번호 업데이트 */
	public int updateTempPasswordForSeller(UserVo vo) {
		// 임시 비밀번호 생성
		try {
			/* 입력받은 패스워드 암호화 */
			vo.setTempPassword(this.createTempPassword());
			vo.setPassword(StringUtil.encryptSha2(vo.getTempPassword()));
		} catch (NoSuchAlgorithmException nsae) {
			nsae.printStackTrace();
			return 0;
		}
		return userDao.updateTempPasswordForSeller(vo);
	}
	
	/** 임시비밀번호 업데이트 */
	public int updateTempPasswordForAdmin(UserVo vo) {
		// 임시 비밀번호 생성
		try {
			/* 입력받은 패스워드 암호화 */
			vo.setTempPassword(this.createTempPassword());
			vo.setPassword(StringUtil.encryptSha2(vo.getTempPassword()));
		} catch (NoSuchAlgorithmException nsae) {
			nsae.printStackTrace();
			return 0;
		}
		return userDao.updateTempPasswordForAdmin(vo);
	}
	
	/** 임시비밀번호 생성 */
	private String createTempPassword() {
		String password = "";
		for (int i = 0; i < 8; i++) {
			// char upperStr = (char)(Math.random() * 26 + 65);
			char lowerStr = (char) (Math.random() * 26 + 97);
			if (i % 2 == 0) {
				password += (int) (Math.random() * 10);
			} else {
				password += lowerStr;
			}
		}

		return password;
	}

	/** 회원 아이디 기등록 체크 */
	public int getIdCnt(MemberVo vo) {
		return userDao.getIdCnt(vo);
	}
	
	public int getEmailCnt(MemberVo vo) throws Exception {
		vo.setEmail(CrypteUtil.encrypt(vo.getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		return userDao.getEmailCnt(vo);
	}

	/** 회원 닉네임 기등록 체크 */
	public int getNickNameCnt(String nickname) {
		return userDao.getNickNameCnt(nickname);
	}

	public List<UserVo> getCompanyAndMemberRegCntForWeek() {
		return memberDao.getCompanyAndMemberRegCntForWeek();
	}

	/** 한달간 전체 회원 수 */
	public List<MemberStatsVo> getMonthMemberStats() {
		List<MemberStatsVo> getList = new ArrayList<>();
		for (int i = 30; i >= 0; i--) {
			getList.add(memberDao.getMonthMemberStats(new Integer(i)));
		}
		return getList;
	}

	/** 일주일간 신규 회원 수 */
	public List<MemberStatsVo> getWeekMemberStats() {
		List<MemberStatsVo> getList = new ArrayList<>();
		for (int i = 6; i >= 0; i--) {
			getList.add(memberDao.getWeekMemberStats(new Integer(i)));
		}
		return getList;
	}

	/** 회원 엑셀 다운로드 
	 * @throws UnsupportedEncodingException 
	 * @throws InvalidKeyException */
	public Workbook writeExcelMemberist(MemberVo vo, String type) throws Exception{
		Workbook wb;

		/* 타이틀 항목 생성 */
		String[] strTitle = new String[13];
		int idx = 0;
		strTitle[idx++] = "No."; // 0
		strTitle[idx++] = "회원구분"; // 1
		strTitle[idx++] = "기관(기업/시설/단체)명"; // 2 
		strTitle[idx++] = "아이디"; // 3
		strTitle[idx++] = "이름(담당자)"; // 4
		strTitle[idx++] = "부서/직책"; // 5
		strTitle[idx++] = "상태"; // 6
		strTitle[idx++] = "포인트"; // 7
		strTitle[idx++] = "유선전화"; // 8
		strTitle[idx++] = "휴대전화"; // 9
		strTitle[idx++] = "이메일"; // 10
		strTitle[idx++] = "마지막 접속일"; // 11
		strTitle[idx++] = "등록일자"; // 12

		/* 주문리스트 */
		List<MemberVo> list = memberDao.getList(vo);

		/* 데이터 생성 */
		Vector<ArrayList<Object>> row = new Vector<>();
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				MemberVo mvo = list.get(i);

				ArrayList<Object> cell = new ArrayList<>(13);
				cell.add(mvo.getSeq());
				cell.add(mvo.getMemberTypeName());
				cell.add(mvo.getGroupName());
				cell.add(mvo.getId());
				cell.add(mvo.getName());
				cell.add(mvo.getDeptName() + "/" + mvo.getPosName());
				cell.add(mvo.getStatusText());
				cell.add(StringUtil.formatAmount(vo.getPoint()) + "P");
				cell.add(CrypteUtil.decrypt(list.get(i).getTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
				cell.add(CrypteUtil.decrypt(list.get(i).getCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
				cell.add(CrypteUtil.decrypt(list.get(i).getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
				cell.add(mvo.getLastDate());
				cell.add(mvo.getRegDate());

				row.add(cell);
			}
		}

		/* 엑셀 파일 생성 */
		wb = ExcelUtil.writeExcel(strTitle, row, type, 0);

		return wb;
	}

	/** 우편번호, 이메일, 전화번호, 휴대폰번호 합치기 */
	private void formatValue(MemberVo vo) {
		/* 우편번호 붙이기 */
		if (!"".equals(vo.getPostcode1()) && !"".equals(vo.getPostcode2())) {
			vo.setPostcode(vo.getPostcode1() + vo.getPostcode2());
		}

		if (!"".equals(vo.getEmail1().trim()) && !"".equals(vo.getEmail2().trim())) {
			/* 이메일 붙이기 */
			vo.setEmail(vo.getEmail1() + "@" + vo.getEmail2());
		}

		System.out.println(">>>formatValue setEmail:"+vo.getEmail());
		/* 전화번호 붙이기 */
		if (!"".equals(vo.getTel1()) && !"".equals(vo.getTel2()) && !"".equals(vo.getTel3())) {
			vo.setTel(StringUtil.formatPhone(vo.getTel1(), vo.getTel2(), vo.getTel3()));
		}

		/* 휴대폰 번호 붙이기 */
		if (!"".equals(vo.getCell1()) && !"".equals(vo.getCell2()) && !"".equals(vo.getCell3())) {
			vo.setCell(StringUtil.formatPhone(vo.getCell1(), vo.getCell2(),	vo.getCell3()));
		}
		
		/* 생년월일 붙이기 */
		if (!"".equals(vo.getBirthyyyy()) && !"".equals(vo.getBirthmm()) && !"".equals(vo.getBirthdd())) {
			//월과 일이 한자리라면 앞에 0을 붙인다.
			String birthMM =  vo.getBirthmm().length() == 1 ? "0"+vo.getBirthmm() : vo.getBirthmm();
			String birthDD =  vo.getBirthdd().length() == 1 ? "0"+vo.getBirthdd() : vo.getBirthdd();
			
			vo.setBirthdate(vo.getBirthyyyy() + birthMM + birthDD);
		}
	}

	/** 개인정보 암호화 */
	private void encrypt(MemberVo vo) throws UnsupportedEncodingException, InvalidKeyException {
		vo.setTel(CrypteUtil.encrypt(vo.getTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		vo.setCell(CrypteUtil.encrypt(vo.getCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		vo.setEmail(CrypteUtil.encrypt(vo.getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		vo.setAddr2(CrypteUtil.encrypt(vo.getAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
	}

	/** 엑셀 데이터 유효성 체크 */
	public String chkXlsData(String[] row, Integer mallSeq) {
		MemberVo vo = new MemberVo();
		String errPosMsg = "";

		/* 아이디 */
		String id = row[0];
		/* 이름 */
		String name = row[1];
		/* 비밀 번호 */
		String pass = row[2];
		String cell = "";
		String email = "";
		if (row.length > 3) {
			/* 휴대폰 번호 */
			cell = row[3];
			if (row.length > 4) {
				/* 이메일 주소 */
				email = row[4];
			}
		}

		vo.setId(row[0]);
		vo.setMallSeq(mallSeq);

		if (row.length > 5) {
			errPosMsg += " 잘못된 회원등록 양식 입니다.";
			return errPosMsg;
		}
		/* 필수값 체크 */
		if (StringUtil.isBlank(id)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 아이디는 반드시 입력되어야 합니다";
		}

		if (StringUtil.getByteLength(id) > 50) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 아이디가 50Bytes를 초과하였습니다";
		}

		if (StringUtil.getByteLength(id) < 6) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 아이디를 6자 이상 입력해주세요";
		}

		if (!id.matches("^[a-z0-9._-]*$")) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 아이디는 영소문자/숫자/._-만 가능 합니다";
		}

		vo.setTypeCode("C");
		if (userDao.getIdCnt(vo) > 0) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 중복된 아이디 입니다";
		}
		if (StringUtil.isBlank(name)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 이름은 반드시 입력되어야 합니다";
		}
		if (StringUtil.isBlank(pass)) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += " 비밀번호는 반드시 입력되어야 합니다";
		} else if (pass.length() < 4 || pass.length() > 16) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += "비밀번호는 4-16자가 되어야 합니다.";
		} else if (!pass.matches("^[a-zA-Z0-9~!@#$%^&*()]*$")) {
			if (errPosMsg != "") {
				errPosMsg += " , ";
			}
			errPosMsg += "비밀번호는 영문/숫자/특수문자만 가능 합니다.";
		}
		if (row.length > 3) {
			if (cell != "" && !cell.matches("^([0-9]{3})+-([0-9]{3,4})+-([0-9]{4})*$")) {
				if (errPosMsg != "") {
					errPosMsg += " , ";
				}
				errPosMsg += " 잘못된 휴대폰 번호입니다( '-' 를 포함한 숫자만 입력하세요)";
			}
			if (row.length > 4) {
				if (email != ""	&& !email.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$")) {
					if (errPosMsg != "") {
						errPosMsg += " , ";
					}
					errPosMsg += " 잘못된 이메일 형식입니다";
				}
			}
		}

		return errPosMsg;
	}

	public Integer getMemberSeq(MemberVo mvo) {
		return memberDao.getMemberSeq(mvo);
	}

	public int updateMemberPassword(MemberVo vo) {
		return memberDao.updateMemberPassword(vo);
	}

	public boolean leaveMember(Integer seq) {
		return memberDao.leaveMember(seq) > 0;
	}
	
	public boolean initPassword(MemberVo vo) {
		return memberDao.initPassword(vo) > 0;
	}
		
	@Override
	public int updatePassword(UserVo vo) {
		return userDao.updatePassword(vo);
	}

	@Override
	public int updatePasswordDelay(Integer seq) {
		return userDao.updatePasswordDelay(seq);
	}

	@Override
	public boolean updateReceiverAgree(MemberVo vo) {
		return memberDao.updateReceiverAgree(vo) > 0;
	}

	@Override
	public String getFindId(UserVo vo) throws Exception {
		vo.setEmail(CrypteUtil.encrypt(vo.getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		return userDao.getFindId(vo);
	}
	
	@Override
	public String getFindIdForSeller(UserVo vo) {
		return userDao.getFindIdForSeller(vo);
	}
	
	@Override
	public String getFindIdForAdmin(UserVo vo) {
		return userDao.getFindIdForAdmin(vo);
	}

	public int checkCnt(String certKey) {
		return memberDao.checkCnt(certKey);
	}
	
	
	/** DB마이그레이션 작업용 (삭제 예정) */
	@Override
	public List<MemberVo> getListForEncrypt() {
		return memberDao.getListForEncrypt();
	}
	
	@Override
	public int updateForEncrypt(MemberVo vo) throws Exception {
		// 개인정보 암호화
		oldEncrypt(vo);
		return memberDao.updateForEncrypt(vo);
	}

	@Override
	public List<UserVo> getUserListForEncrypt(String typeCode) {
		return userDao.getListForEncrypt(typeCode);
	}
	
	@Override
	public int updateUserForEncrypt(UserVo vo) throws Exception {
		// 패스워드 암호화
		vo.setPassword(StringUtil.encryptSha2(vo.getPassword()));
		return userDao.updateForEncrypt(vo);
	}
	
	private void oldEncrypt(MemberVo vo) throws UnsupportedEncodingException, InvalidKeyException {
		if(!"".equals(vo.getTel())) {
			vo.setTel(CrypteUtil.encrypt(vo.getTel(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getCell())) {
			vo.setCell(CrypteUtil.encrypt(vo.getCell(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getEmail())) {
			vo.setEmail(CrypteUtil.encrypt(vo.getEmail(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
		if(!"".equals(vo.getAddr2())) {
			vo.setAddr2(CrypteUtil.encrypt(vo.getAddr2(), Const.ARIA_KEY, Const.ARIA_KEY.length * 8, null));
		}
	}
}
