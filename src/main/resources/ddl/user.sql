/*사용자 정보(공통)*/
CREATE TABLE sm_user (
  seq                INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스(고유번호)',
  id                 VARCHAR(50) NOT NULL         COMMENT '이메일/아이디',
  password           VARCHAR(65) NOT NULL         COMMENT '패스워드',
  name               VARCHAR(50) NOT NULL         COMMENT '이름/판매자명(법인명)/쇼핑몰명',
  nickname           VARCHAR(100)                 COMMENT '닉네임',
  type_code          CHAR(1) NOT NULL             COMMENT '유형 (A:관리자,S:판매자,D:총판,C:회원,M:쇼핑몰)',
  status_code        CHAR(1) NOT NULL             COMMENT '상태(H:승인대기, Y:정상, N:중지, X:폐점/탈퇴)',
  grade_code         INT NOT NULL DEFAULT 9       COMMENT '등급',
  login_token        VARCHAR(50)                  COMMENT '로그인 토큰(세션 유지)',
  last_ip            VARCHAR(15)                  COMMENT '마지막 접속 아이피',
  last_date          DATETIME                     COMMENT '마지막 접속일',
  temp_password      VARCHAR(32)                  COMMENT '임시비밀번호',
  temp_password_date DATETIME                     COMMENT '임시 비밀번호 발급일',
  mod_password_date  DATETIME                     COMMENT '비밀번호 변경일',
  mod_date           DATETIME                     COMMENT '변경일',
  reg_date           DATETIME NOT NULL COMMENT '등록일',
  PRIMARY KEY (seq),
  INDEX idx1_sm_user (type_code),
  INDEX idx2_sm_user (status_code),
  INDEX idx3_sm_user (login_token),
  INDEX idx4_sm_user (reg_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='유저 공통';

/*관리자 장보*/
CREATE TABLE sm_admin (
  seq   INT UNSIGNED NOT NULL COMMENT '시퀀스(PK/FK)',
  email VARCHAR(50)  COMMENT '이메일',
  tel   VARCHAR(20)  COMMENT '전화번호',
  cell  VARCHAR(20)  COMMENT '핸드폰번호',
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_admin FOREIGN KEY (seq) REFERENCES sm_user (seq) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자 정보';

/*관리자 등급 관리*/
CREATE TABLE sm_admin_permission (
  seq                    INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스(PK)',
  controller_name        VARCHAR(30) NOT NULL         COMMENT '컨트롤러 이름',
  controller_method      VARCHAR(30) NOT NULL         COMMENT '메소드 이름',
  controller_division    VARCHAR(30)                  COMMENT '구분 이름',
  controller_description VARCHAR(150)                 COMMENT '컨트롤러 설명',
  admin0_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (연구소)',
  admin1_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (최고관리자)',
  admin2_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (운영관리자)',
  admin3_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (디자이너)',
  admin4_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (정산관리자)',
  admin5_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (CS관리자)',
  admin6_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (임시)',
  admin7_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (임시)',
  admin8_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (임시)',
  admin9_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (일반관리자)',
  seller_flag            CHAR(1) NOT NULL             COMMENT '관리자 등급 (판매자)',
  distributor_flag       CHAR(1) NOT NULL             COMMENT '관리자 등급 (총판)',
  PRIMARY KEY (seq),
  INDEX idx1_sm_admin_permission (controller_name, controller_method)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자 등급';

/*관리자 어드민 접속 내역*/
CREATE TABLE sm_admin_access_log (
  seq       INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  admin_seq INT UNSIGNED NOT NULL                COMMENT '어드민 시퀀스',
  ip_addr   VARCHAR(15)                 COMMENT '접속지 IP주소',
  reg_date  DATETIME NOT NULL           COMMENT '등록일',
  PRIMARY KEY (seq),
  INDEX idx1_sm_admin_access_log (admin_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='어드민 접속 로그';

/*판매자 정보*/
CREATE TABLE sm_seller (
  seq                  INT UNSIGNED NOT NULL        COMMENT '시퀀스(PK/FK)',
  adjust_grade_code    CHAR(1) DEFAULT 'C' NOT NULL COMMENT '정산등급(A:월3회,B:월2회,C:월1회)',
  tax_type_flag        CHAR(1)                      COMMENT '면세기업 여부 (Y:과세, N:면세)',
  ceo_name             VARCHAR(50) NOT NULL         COMMENT '대표자명',
  biz_no               CHAR(10) NOT NULL            COMMENT '사업자번호 10자리',
  biz_type             VARCHAR(100) NOT NULL        COMMENT '업태',
  biz_kind             VARCHAR(100) NOT NULL        COMMENT '업종',
  total_sales          VARCHAR(100)                 COMMENT '매출액',
  amount_of_worker     VARCHAR(100)                 COMMENT '종업원수',
  tel                  VARCHAR(30) NOT NULL         COMMENT '대표 전화번호',
  fax                  VARCHAR(30)                  COMMENT '팩스 번호',
  postcode             VARCHAR(10) NOT NULL         COMMENT '우편번호',
  addr1                VARCHAR(200) NOT NULL        COMMENT '주소',
  addr2                VARCHAR(200) NOT NULL        COMMENT '주소 상세',
  sales_name           VARCHAR(100) NOT NULL        COMMENT '담당자명',
  sales_tel            VARCHAR(30) NOT NULL         COMMENT '담당자 전화번호',
  sales_cell           VARCHAR(30) NOT NULL         COMMENT '담당자 휴대폰번호',
  sales_email          VARCHAR(100) NOT NULL        COMMENT '담당자 이메일',
  adjust_name          VARCHAR(50)                  COMMENT '정산 담당자명',
  adjust_email         VARCHAR(100)                 COMMENT '정산 담당자 이메일',
  adjust_tel           VARCHAR(30)                  COMMENT '정산 담당자 연락처',
  account_bank         VARCHAR(50)                  COMMENT '입금 계좌 은행명',
  account_no           VARCHAR(50)                  COMMENT '입금 계좌 번호',
  account_owner        VARCHAR(50)                  COMMENT '입금 계좌 예금주',
  master_seq           INT UNSIGNED                 COMMENT '총판 시퀀스',
  approval_date        DATETIME                     COMMENT '승인 일자',
  stop_date            DATETIME                     COMMENT '중지 일자',
  close_date           DATETIME                     COMMENT '폐점 일자',
  default_deli_company INT UNSIGNED                 COMMENT '기본택배사',
  return_name          VARCHAR(100)                 COMMENT '반품담당자',
  return_cell          VARCHAR(30)                  COMMENT '반품담당자 연락처',
  return_postcode      VARCHAR(10)                  COMMENT '반품주소지 우편번호',
  return_addr1         VARCHAR(200)                 COMMENT '반품 주소',
  return_addr2         VARCHAR(200)                 COMMENT '반품 상세주소',
  jachigu_code         VARCHAR(3)                   COMMENT '자치구 코드',
  intro                TEXT                         COMMENT '공급사소개',
  main_item            TEXT                         COMMENT '주요취급상품',
  auth_category		   VATCHAR(50)                  COMMENT '인증구분',
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_seller FOREIGN KEY (seq) REFERENCES sm_user (seq) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='판매자/총판';

/* 기관(기업/시설/단체) 회원 부가 정보 */
CREATE TABLE sm_member_group (
  seq           INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스(PK)',
  group_name    VARCHAR(100) COMMENT '기관명',
  biz_no        CHAR(10)     COMMENT '사업자등록번호',
  biz_type      VARCHAR(100)           COMMENT '업태',
  biz_kind      VARCHAR(100)           COMMENT '업종',
  ceo_name      VARCHAR(30)           COMMENT '대표자',
  jachigu_code  VARCHAR(3)            COMMENT '자치구 코드',
  invest_flag   CHAR(1) NOT NULL DEFAULT 'N' COMMENT '투자출연기관 여부',
  fax           VARCHAR(15)           COMMENT '팩스번호',
  tax_name      VARCHAR(50)           COMMENT '세금계산서 담당자',
  tax_email     VARCHAR(100)          COMMENT '세금계산서 수신 이메일',
  tax_tel       VARCHAR(15)           COMMENT '세금계산서 담당자 전화번호',
  PRIMARY KEY (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기관(기업/시설/단체) 회원 부가 정보';

/*회원 정보*/
CREATE TABLE sm_member (
  seq                     INT UNSIGNED NOT NULL COMMENT '시퀀스(PK/FK)',
  mall_seq                INT UNSIGNED NOT NULL COMMENT '쇼핑몰 시퀀스(FK)',
  member_type_code        CHAR(1) NOT NULL      COMMENT '회원 구분(C:개인, P:공공기관, O:기업/시설/단체)',
  birthdate               CHAR(8)               COMMENT '생년월일 8자리(yyyymmdd)',
  sex_code                CHAR(1)               COMMENT '성별(M:남, F:여)',
  email                   VARCHAR(100)          COMMENT '이메일',
  tel                     VARCHAR(50)           COMMENT '전화 번호',
  cell                    VARCHAR(50)           COMMENT '휴대폰 번호',
  postcode                VARCHAR(10)           COMMENT '우편번호',
  addr1                   VARCHAR(300)          COMMENT '주소',
  addr2                   VARCHAR(300)          COMMENT '주소 상세',
  email_flag              CHAR(1) NOT NULL      COMMENT '이메일 수신동의 여부(Y/N)',
  email_flag_date         DATETIME              COMMNET '이메일 수신동의 여부 변경일자',
  sms_flag                CHAR(1) NOT NULL      COMMENT 'SMS 수신동의 여부(Y/N)',
  sms_flag_date           DATETIME              COMMENT 'SMS 수신동의 여부 변경일자',
  join_path_code          CHAR(1)               COMMENT '가입 경로',
  interest_category_code  VARCHAR(10)           COMMENT '관심 카테고리',
  close_code              CHAR(1)               COMMENT '탈퇴사유 코드',
  close_text              VARCHAR(300)          COMMENT '탈퇴사유 내용',
  cert_key                VARCHAR(100)          COMMENT '본인확인 인증키(아이핀, 휴대폰등)'
  dept_name               VARCHAR(50)           COMMENT '부서명',
  pos_name                VARCHAR(50)           COMMENT '직책',
  group_seq               INT UNSIGNED          COMMENT '기관/기업 회원 부가 정보 시퀀스(FK)',
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_member FOREIGN KEY (seq) REFERENCES sm_user (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_member FOREIGN KEY (group_seq) REFERENCES sm_member_group (seq),
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원';

/*회원별 배송지*/
CREATE TABLE sm_member_delivery (
  seq          INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스(고유번호)',
  member_seq   INT UNSIGNED NOT NULL                COMMENT '회원 시퀀스(FK)',
  title        VARCHAR(50)                          COMMENT '배송지 명',
  name         VARCHAR(50)                          COMMENT '수취인 명',
  tel          VARCHAR(50)                          COMMENT '전화번호',
  cell         VARCHAR(50)                          COMMENT '휴대폰번호',
  postcode     VARCHAR(10)                          COMMENT '우편번호',
  addr1        VARCHAR(300)                         COMMENT '주소',
  addr2        VARCHAR(300)                         COMMENT '주소 상세',
  default_flag CHAR(1) DEFAULT 'N' NOT NULL         COMMENT '기본 배송지 여부',
  mod_date     DATETIME                             COMMENT '변경일',
  reg_date     DATETIME NOT NULL                    COMMENT '등록일',
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_member_delivery FOREIGN KEY (member_seq) REFERENCES sm_member (seq) ON DELETE CASCADE,
  INDEX idx1_sm_member_delivery (member_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원 배송지';


/* 어드민 변경 로그*/
CREATE TABLE sm_admin_log (
  seq        INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  admin_seq  INT UNSIGNED NOT NULL    COMMENT '어드민 시퀀스',
  login_seq  INT UNSIGNED NOT NULL    COMMENT '로그인 시퀀스',
  grade_code INT NOT NULL    COMMENT '변경된 권한',
  reg_date   DATE NOT NULL   COMMENT '등록일',
  PRIMARY KEY (seq)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='어드민 변경 로그';




