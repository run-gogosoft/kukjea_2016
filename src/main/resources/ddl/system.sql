/* 공통 코드 */
CREATE TABLE sm_common (
  seq        INT UNSIGNED  NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  group_code INT NOT NULL                 COMMENT '그룹코드',
  group_name VARCHAR(100) NOT NULL        COMMENT '그룹명',
  name       VARCHAR(100) NOT NULL        COMMENT '코드명',
  value      VARCHAR(20) NOT NULL         COMMENT '코드값',
  note       VARCHAR(300)                 COMMENT '비고/설명',
  mod_date   DATETIME                     COMMENT '수정일',
  reg_date   DATETIME NOT NULL            COMMENT '등록일',
  PRIMARY KEY (seq),
  INDEX idx1_sm_common (group_code, value)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통 코드';

  
/* 택배사 정보 */
CREATE TABLE sm_deli_company(
  seq          INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  company_name VARCHAR(60) NOT NULL         COMMENT '택배사 회사명',
  company_tel  VARCHAR(20)                  COMMENT '택배사 연락처',
  track_url    VARCHAR(200)                 COMMENT '배송추적 URL',
  complete_msg VARCHAR(150)                 COMMENT '배송완료 메시지',
  use_flag     CHAR(1) DEFAULT 'Y' NOT NULL COMMENT '배송업체 사용여부(사용:Y, 사용안함:N)',
  PRIMARY KEY (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='국내 배송 택배사 테이블';

/* 메뉴 */
CREATE TABLE sm_menu (
  seq       INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  sort      INT(2) UNSIGNED NOT NULL DEFAULT 1    COMMENT '정렬순서',
  name      VARCHAR(50) NOT NULL                  COMMENT '메뉴명',
  link_url  VARCHAR(100)                          COMMENT '링크 주소',
  PRIMARY KEY (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴 테이블';

CREATE TABLE sm_menu_sub (
  seq       INT(11) UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  main_seq  INT(11) UNSIGNED NOT NULL                 COMMENT '메인 메뉴 시퀀스',
  sort      INT(2) UNSIGNED NOT NULL DEFAULT '1'      COMMENT '정렬 순서',
  name      VARCHAR(50) NOT NULL                      COMMENT '메뉴명',
  link_url  VARCHAR(500)                              COMMENT '연결 링크 주소',
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_menu_sub FOREIGN KEY (main_seq) REFERENCES sm_menu (seq) ON UPDATE CASCADE ON DELETE CASCADE,
  INDEX idx1_sm_menu_sub (main_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴 서브 테이블';

/* 결제 수단 정보*/
CREATE TABLE sm_pay_method (
  seq       INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  name      VARCHAR(50) NOT NULL COMMENT '결제 수단명',
  value     VARCHAR(50) NOT NULL COMMENT '결제 수단 코드',
  fee_rate1      FLOAT           COMMENT '수수료(수도권)'
  fee_rate2      FLOAT           COMMENT '수수료(지방)'
  PRIMARY KEY (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제 수단 정보';

/* SMS 메세지 관리 */
CREATE TABLE sm_sms (
  seq          INT UNSIGNED NOT NULL AUTO_INCREMENT     COMMENT '시퀀스',
  title        VARCHAR(100) NOT NULL                COMMENT '제목',
  type_code    CHAR(1) NOT NULL                     COMMENT '발송대상(C:고객, S:판매자)',
  status_type  CHAR(1) NOT NULL                     COMMENT '발송상태타입(O:주문, S:판매자, C:회원)',
  status_code  CHAR(2) NOT NULL                     COMMENT '발송상태코드',
  content      VARCHAR(160) NOT NULL                COMMENT '발송내용',
  reg_date     DATETIME NOT NULL                        COMMENT '등록일',
  mall_seq     INT UNSIGNED                 COMMENT '몰시퀀스',
  PRIMARY KEY (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SMS 메세지 관리';