-- Create table
CREATE TABLE sm_order_seq (
  seq  INT UNSIGNED NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문 시퀀스 테이블';
--init
INSERT INTO sm_order_seq VALUES(1);

-- Create table
CREATE TABLE sm_order (
  seq               INT UNSIGNED NOT NULL       COMMENT '시퀀스',
  mall_seq          INT UNSIGNED NOT NULL       COMMENT '몰 시퀀스',
  device_type       CHAR(1)                     COMMENT '결제장비 구분(N:PC, M:모바일)',
  pay_method        VARCHAR(20)                 COMMENT '결제수단 구분(CARD:카드, POINT:포인트, TAX:후청구(세금계산서), null:제휴사결제, CARD+POINT:카드+포인트)',
  total_price       INT NOT NULL                COMMENT '총 주문 금액',
  pay_price         INT NOT NULL                COMMENT '실 결제 금액',
  member_seq        INT UNSIGNED                COMMENT '회원 시퀀스',
  member_name       VARCHAR(50) NOT NULL        COMMENT '회원 명',
  member_email      VARCHAR(100) NOT NULL       COMMENT '이메일',
  member_cell       VARCHAR(50) NOT NULL        COMMENT '회원 명',
  receiver_name     VARCHAR(50) NOT NULL        COMMENT '수취인명',
  receiver_tel      VARCHAR(50)                 COMMENT '수취인 전화번호',
  receiver_cell     VARCHAR(50)                 COMMENT '수취인 휴대폰번호',
  receiver_postcode VARCHAR(20)                 COMMENT '수취인 우편번호',
  receiver_addr1    VARCHAR(300)                COMMENT '수취인 주소',
  receiver_addr2    VARCHAR(300)                COMMENT '수취인 주소 상세',
  receiver_email    VARCHAR(100)                COMMENT '수취인 이메일',
  request           VARCHAR(2000)               COMMENT '요청사항',
  point             INT DEFAULT 0               COMMENT '포인트 사용금액',
  estimate_compare_flag CHAR(1) NOT NULL        COMMENT '비교견적 신청 여부(Y/N)',
  account_info      VARCHAR(100)                COMMENT '무통장 입금 계좌 정보',
  np_pay_flag       CHAR(1)                     COMMENT '후청구 건 결제 여부 Y/N',
  np_pay_date       DATETIME                    COMMENT '후청구 건 결제 일자',
  mod_date          DATETIME                    COMMENT '변경일',
  reg_date          DATETIME NOT NULL           COMMENT '등록일',
  PRIMARY KEY (seq),
  INDEX idx1_sm_order (member_seq),
  INDEX idx2_sm_order (pay_method),
  INDEX idx3_sm_order (reg_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문';

-- Create table
CREATE TABLE sm_order_detail (
  seq                 INT UNSIGNED NOT NULL AUTO_INCREMENT   COMMENT '시퀀스(PK)',  
  order_seq           INT UNSIGNED NOT NULL                  COMMENT '주문 시퀀스(FK)',  
  item_seq            INT UNSIGNED                           COMMENT '상품 시퀀스',  
  option_value_seq    INT UNSIGNED                           COMMENT '옵션값 시퀀스(FK)',  
  item_name           VARCHAR(300) NOT NULL         COMMENT '상품명',  
  option_value        VARCHAR(300)                  COMMENT '옵션값',  
  status_code         CHAR(2) NOT NULL              COMMENT '주문상태(00:입금대기, 10:결제왼료, 20:주문확인, 30:배송중, 50:배송완료, 55:구매확정, 90:취소요청, 99:취소완료)',  
  sell_price          INT NOT NULL                  COMMENT '판매가',  
  option_price        INT DEFAULT 0                 COMMENT '옵션 추가 금액',  
  supply_price        INT NOT NULL                  COMMENT '공급가',  
  supply_master_price INT DEFAULT 0                 COMMENT '총판 공급가',  
  coupon_price        INT DEFAULT 0                 COMMENT '쿠폰 할인 금액',  
  order_cnt           INT NOT NULL                  COMMENT '주문 수량',  
  deli_cost           INT DEFAULT 0                 COMMENT '배송비',  
  deli_prepaid_flag   CHAR(1)                       COMMENT '배송비 선결제 여부(선결제필수:Y,착불:N)',  
  deli_seq            INT UNSIGNED                           COMMENT '택배사 시퀀스',  
  deli_no             VARCHAR(20)                   COMMENT '택배 송장 번호',  
  tax_code            CHAR(1) DEFAULT '1' NOT NULL  COMMENT '과세여부 (1=과세, 2=면세, 3=영세)',  
  seller_seq          INT UNSIGNED                  COMMENT '판매자 시퀀스',  
  seller_master_seq   INT UNSIGNED                  COMMENT '총판 시퀀스',  
  seller_name         VARCHAR(100) NOT NULL         COMMENT '판매자명',  
  seller_master_name  VARCHAR(100)                  COMMENT '총판명',
  reason              VARCHAR(500)                  COMMENT '교환/반품/취소 사유',  
  package_deli_cost   INT DEFAULT 0                 COMMENT '묶음 배송비',  
  adjust_flag         CHAR(1) DEFAULT 'N' NOT NULL  COMMENT '기정산 여부',  
  offline_pay_flag    CHAR(1)                       COMMENT '방문결제 처리 여부 Y/N',
  c10_date            DATETIME                      COMMENT '결제일',  
  c20_date            DATETIME                      COMMENT '주문확인일',  
  c30_date            DATETIME                      COMMENT '발송완료일',  
  c50_date            DATETIME                      COMMENT '배송완료일',  
  c55_date            DATETIME                      COMMENT '구매확정일',
  c60_date            DATETIME                      COMMENT '교환요청일',  
  c61_date            DATETIME                      COMMENT '교환요청 접수일',  
  c69_date            DATETIME                      COMMENT '교환완료일',  
  c70_date            DATETIME                      COMMENT '반품요청일',  
  c71_date            DATETIME                      COMMENT '반품요청 접수일',  
  c79_date            DATETIME                      COMMENT '반품완료',    
  c90_date            DATETIME                      COMMENT '취소요청일',  
  c99_date            DATETIME                      COMMENT '취소완료일',  
  mod_date            DATETIME                      COMMENT '변경일',  
  reg_date            DATETIME NOT NULL             COMMENT '등록일',  
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_order_detail FOREIGN KEY (order_seq) REFERENCES sm_order (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_order_detail FOREIGN KEY (item_seq) REFERENCES sm_item (seq) ON DELETE SET NULL,
  CONSTRAINT fk3_sm_order_detail FOREIGN KEY (option_value_seq) REFERENCES sm_item_option_value (seq) ON DELETE SET NULL,
  INDEX idx1_sm_order_detail (item_seq),
  INDEX idx2_sm_order_detail (status_code),
  INDEX idx3_sm_order_detail (seller_seq),
  INDEX idx4_sm_order_detail (seller_master_seq),
  INDEX idx5_sm_order_detail (order_seq),
  INDEX idx6_sm_order_detail (reg_date),
  INDEX idx7_sm_order_detail (c10_date),
  INDEX idx8_sm_order_detail (c55_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문 상세';

 -- Create table
CREATE TABLE sm_order_cs (
  seq              INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT 'seq(PK)',
  order_detail_seq INT UNSIGNED NOT NULL        COMMENT '상품주문번호(FK)',
  contents         VARCHAR(500) NOT NULL        COMMENT 'CS내용',
  login_seq        INT UNSIGNED NOT NULL                 COMMENT '처리자',
  reg_date         DATETIME NOT NULL            COMMENT '등록일',
  CONSTRAINT pk_sm_order_cs PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_order_cs FOREIGN KEY (order_detail_seq) REFERENCES sm_order_detail (seq) ON DELETE CASCADE,
  INDEX idx1_sm_order_cs (order_detail_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문CS로그';

-- Create table
CREATE TABLE sm_order_log (
  seq              INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스(PK)',
  order_detail_seq INT UNSIGNED NOT NULL                 COMMENT '상품주문번호',
  contents         VARCHAR(500) NOT NULL                 COMMENT '변경 내용',
  login_seq        INT UNSIGNED                                   COMMENT '변경자',
  reg_date         DATETIME NOT NULL                     COMMENT '등록 일자',
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_order_log FOREIGN KEY (order_detail_seq) REFERENCES sm_order_detail (seq) ON DELETE CASCADE,
  INDEX idx1_sm_order_log (order_detail_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문 변경 이력';


-- Create table
CREATE TABLE sm_order_pay (
  seq                    INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스(PK)',
  order_seq              INT UNSIGNED NOT NULL        COMMENT '주문번호',
  tid                    VARCHAR(50)                  COMMENT 'PG 거래번호',
  oid                    VARCHAR(50)                  COMMENT '상점 주문번호',
  mid                    VARCHAR(20)                  COMMENT '상점 아이디',
  pg_code                VARCHAR(20)                  COMMENT 'PG사 구분 코드',
  pg_key                 VARCHAR(50)                  COMMENT 'PG 상점 키',
  tax_free_amount        INT                          COMMENT '면세대상금액',
  result_code            VARCHAR(50)                  COMMENT '처리결과 코드',
  result_msg             VARCHAR(200)                 COMMENT '처리결과 메세지',
  amount                 INT                          COMMENT '결제 금액',
  method_code            VARCHAR(12)                  COMMENT '결제 방법',
  org_code               VARCHAR(10)                  COMMENT '결제기관 코드',
  org_name               VARCHAR(50)                  COMMENT '결제기관 명',
  escrow_flag            CHAR(1)                      COMMENT '에스크로 적용 여부',
  approval_no            VARCHAR(20)                  COMMENT '승인 번호',
  card_month             VARCHAR(2)                   COMMENT '카드 할부 개월수',
  interest_flag          CHAR(1)                      COMMENT '무이자 할부 여부',
  cash_receipt_type_code CHAR(1)                      COMMENT '현금영수증 유형(0:소득공제,1:지출증빙)',
  cash_receipt_no        VARCHAR(20)                  COMMENT '현금영수증 번호',
  account_no             VARCHAR(20)                  COMMENT '(가상)계좌번호',
  trans_date             VARCHAR(14)                  COMMENT '거래일자(가상계좌일 경우 입금통보일자)',
  reg_date               DATETIME NOT NULL            COMMENT '등록일자',
  CONSTRAINT pk_sm_order_pay PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_order_pay FOREIGN KEY (order_seq) REFERENCES sm_order (seq) ON DELETE CASCADE,
  INDEX idx1_sm_order_pay (order_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제 내역 테이블';


CREATE TABLE sm_order_pay_cancel (
  seq              INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스(PK)',  
  order_pay_seq    INT UNSIGNED NOT NULL                 COMMENT '결제내역 시퀀스(FK)',  
  type_code        VARCHAR(10) NOT NULL         COMMENT '취소 유형(전체취소:ALL, 부분취소:PART)',  
  amount           INT NOT NULL                 COMMENT '취소금액',  
  order_detail_seq INT UNSIGNED                          COMMENT '부분취소시 해당 상품주문번호',  
  result_code      VARCHAR(10)                  COMMENT '결과 코드',  
  result_msg       VARCHAR(200)                 COMMENT '결과 메세지',  
  reg_date         DATETIME NOT NULL            COMMENT '등록 일자',  
  CONSTRAINT pk_sm_order_pay_cancel PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_order_pay_cancel FOREIGN KEY (order_pay_seq) REFERENCES sm_order_pay (seq) ON DELETE CASCADE,
  INDEX idx1_sm_order_pay_cancel (order_pay_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제 취소 내역 테이블';

CREATE TABLE `sm_order_tax_request` (
  `order_seq` int(11) unsigned NOT NULL COMMENT '주문 시퀀스',
  `business_num` varchar(15) DEFAULT NULL COMMENT '사업자 번호',
  `business_company` varchar(100) DEFAULT NULL COMMENT '상호(법인명)',
  `business_name` varchar(100) DEFAULT NULL COMMENT '대표자',
  `business_addr` varchar(600) DEFAULT NULL COMMENT '소재지',
  `business_cate` varchar(100) DEFAULT NULL COMMENT '업태',
  `business_item` varchar(100) DEFAULT NULL COMMENT '종목',
  `request_email` varchar(200) DEFAULT NULL COMMENT '수신 이메일',
  `request_name` varchar(100) DEFAULT NULL COMMENT '수신자명',
  `request_cell` varchar(200) DEFAULT NULL COMMENT '수신자 전화번호',
  `request_date` datetime NOT NULL COMMENT '수신요청 시각',
  `request_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '상태 (Y=완료, N=요청중)',
  `complete_date` datetime DEFAULT NULL COMMENT '완료처리 시각',
  PRIMARY KEY (`order_seq`),
  CONSTRAINT `sm_order_tax_request_ibfk_1` FOREIGN KEY (`order_seq`) REFERENCES `sm_order` (`seq`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='세금계산서 요청';