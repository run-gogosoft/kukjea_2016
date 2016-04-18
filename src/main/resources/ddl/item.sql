--create table
CREATE TABLE sm_item_seq (
  seq  INT UNSIGNED NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 시퀀스 테이블';
--init
insert into sm_item_seq values(1);

-- Create table
CREATE TABLE sm_item (
  seq                 INT UNSIGNED NOT NULL AUTO_INCREMENT           COMMENT '시퀀스',
  cate_lv1_seq        INT UNSIGNED                                   COMMENT '대분류카테고리 시퀀스',
  cate_lv2_seq        INT UNSIGNED                                   COMMENT '중분류카테고리 시퀀스',
  cate_lv3_seq        INT UNSIGNED                                   COMMENT '소분류카테고리 시퀀스',
  cate_lv4_seq        INT UNSIGNED                                   COMMENT '세분류카테고리 시퀀스',
  name                VARCHAR(300) NOT NULL                 COMMENT '상품명',
  type_code           CHAR(1) DEFAULT 'N' NOT NULL          COMMENT '상품타입(C:일반상품, E:견적상품)',     
  status_code         CHAR(1) DEFAULT 'H' NOT NULL          COMMENT '상태플래그(H=가승인, Y=판매중, N=판매중지)',
  sell_price          INT NOT NULL                          COMMENT '판매가',
  supply_master_price INT                                   COMMENT '총판 공급가',
  supply_price        INT                                   COMMENT '판매자 공급가',
  market_price        INT                                   COMMENT '시중가',
  maker               VARCHAR(100)                          COMMENT '제조사',
  origin_country      VARCHAR(100)                          COMMENT '원산지',
  seller_seq          INT UNSIGNED                                   COMMENT '판매자 시퀀스',
  seller_item_code    VARCHAR(20)                           COMMENT '판매자 상품 코드',
  brand               VARCHAR(150)                          COMMENT '브랜드',
  model_name          VARCHAR(200)                          COMMENT '모델명',
  make_date           CHAR(8)                               COMMENT '제조일자',
  expire_date         CHAR(8)                               COMMENT '유효일자',
  adult_flag          CHAR(1) NOT NULL                      COMMENT '성인 여부 (Y=성인만이용가능, N=모두이용가능)',
  img1                VARCHAR(100)                          COMMENT '대표이미지',
  img2                VARCHAR(100)                          COMMENT '서브이미지',
  img3                VARCHAR(100)                          COMMENT '서브이미지',
  img4                VARCHAR(100)                          COMMENT '서브이미지',
  tax_code            CHAR(1) NOT NULL                      COMMENT '과세여부 (1=과세, 2=면세, 3=영세)',
  deli_type_code      CHAR(2) NOT NULL                      COMMENT '배송비 구분(00:무료배송, 10:착불)',
  deli_cost           INT DEFAULT 0 NOT NULL                COMMENT '배송비',
  deli_free_amount    INT DEFAULT 0 NOT NULL                COMMENT '무료배송 조건부 금액',
  deli_prepaid_flag   CHAR(1)                               COMMENT '선결제 구분(null:착불/선결제 선택가능, Y:선결제 필수, N:선결제 불가)',
  deli_package_flag   CHAR(1) NOT NULL                      COMMENT '상품 묶음배송 가능 여부 플래그(Y=가능, N=불가능)',
  type_cd             INT                                   COMMENT '상품 부가정보 분류 코드',
  auth_category       VARCHAR(50)                           COMMENT '인증구분(1:사회적기업제품, 2:사회적경제기업제품, 3:중증장애인생상품, 4:친환경상품)'
  img_banner_code     VARCHAR(20)                           COMMENT '상품이미지내 이벤트 배너 전시 코드값(01:세일,02:특가,03:한정수량,04:행사)'
  mod_date            DATETIME                              COMMENT '변경일',
  reg_date            DATETIME NOT NULL                     COMMENT '등록일',
  min_cnt             INT DEFAULT 1                         COMMENT '최소구매수량',
  max_cnt             INT                                   COMMENT '최대구매수량',
  CONSTRAINT pk_sm_item PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_item FOREIGN KEY (cate_lv1_seq) REFERENCES sm_item_category (seq) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk2_sm_item FOREIGN KEY (cate_lv2_seq) REFERENCES sm_item_category (seq) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk3_sm_item FOREIGN KEY (cate_lv3_seq) REFERENCES sm_item_category (seq) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk4_sm_item FOREIGN KEY (cate_lv4_seq) REFERENCES sm_item_category (seq) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT fk5_sm_item FOREIGN KEY (seller_seq) REFERENCES sm_seller (seq),
  INDEX idx1_sm_item (cate_lv1_seq),
  INDEX idx2_sm_item (cate_lv2_seq),
  INDEX idx3_sm_item (cate_lv3_seq),
  INDEX idx4_sm_item (cate_lv4_seq),
  INDEX idx5_sm_item (status_code),
  INDEX idx6_sm_item (seller_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품';

-- Create table
CREATE TABLE sm_item_add_info (
  item_seq   INT UNSIGNED NOT NULL       COMMENT '아이템 시퀀스(fk)',
  prop_val1  VARCHAR(255)       COMMENT '속성값1',
  prop_val2  VARCHAR(255)       COMMENT '속성값2',
  prop_val3  VARCHAR(255)       COMMENT '속성값3',
  prop_val4  VARCHAR(255)       COMMENT '속성값4',
  prop_val5  VARCHAR(255)       COMMENT '속성값5',
  prop_val6  VARCHAR(255)       COMMENT '속성값6',
  prop_val7  VARCHAR(255)       COMMENT '속성값7',
  prop_val8  VARCHAR(255)       COMMENT '속성값8',
  prop_val9  VARCHAR(255)       COMMENT '속성값9',
  prop_val10 VARCHAR(255)       COMMENT '속성값10',
  prop_val11 VARCHAR(255)       COMMENT '속성값11',
  prop_val12 VARCHAR(255)       COMMENT '속성값12',
  prop_val13 VARCHAR(255)       COMMENT '속성값13',
  prop_val14 VARCHAR(255)       COMMENT '속성값14',
  prop_val15 VARCHAR(255)       COMMENT '속성값15',
  prop_val16 VARCHAR(255)       COMMENT '속성값16',
  prop_val17 VARCHAR(255)       COMMENT '속성값17',
  prop_val18 VARCHAR(255)       COMMENT '속성값18',
  prop_val19 VARCHAR(255)       COMMENT '속성값19',
  prop_val20 VARCHAR(255)       COMMENT '속성값20',
  reg_date   DATETIME NOT NULL  COMMENT '등록일',
  CONSTRAINT pk_sm_item_add_item PRIMARY KEY (item_seq),
  CONSTRAINT fk1_sm_item_add_item FOREIGN KEY (item_seq) REFERENCES sm_item (seq) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 고시 추가 정보';

-- Create table
CREATE TABLE sm_item_category(
  seq        INT UNSIGNED NOT NULL AUTO_INCREMENT    COMMENT '시퀀스',
  parent_seq INT UNSIGNED DEFAULT 0 NOT NULL         COMMENT '부모 시퀀스(없으면 0)',
  depth      INT DEFAULT 0 NOT NULL         COMMENT '깊이(0부터 시작함)',
  cate_name  VARCHAR(50) NOT NULL           COMMENT '카테고리명',
  show_flag  CHAR(1) DEFAULT 'Y' NOT NULL   COMMENT '노출 플래그(Y=보기 N=비노출)',
  order_no   INT DEFAULT 0                  COMMENT '정렬순서',
  mod_date   DATETIME                       COMMENT '변경일',
  reg_date   DATETIME NOT NULL              COMMENT '등록일',
  CONSTRAINT pk_sm_item_category PRIMARY KEY (seq)
  /*CONSTRAINT fk1_sm_item_category FOREIGN KEY (mall_seq) REFERENCES sm_mall (seq) ON DELETE CASCADE*/
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='카테고리';
 
-- Create table
CREATE TABLE sm_item_detail (
  item_seq    INT UNSIGNED NOT NULL     COMMENT '상품 시퀀스(pk/fk)',
  content     TEXT                          COMMENT '내용',
  as_flag     CHAR(1) NOT NULL              COMMENT 'A/S 가능여부(Y=가능 N=불가능)',
  as_tel      VARCHAR(100)                  COMMENT 'A/S 전화번호',
  as_content  TEXT                          COMMENT 'A/S 내용',
  detail1_img VARCHAR(120)                  COMMENT '상세 이미지1',
  detail2_img VARCHAR(120)                  COMMENT '상세 이미지2',
  detail3_img VARCHAR(120)                  COMMENT '상세 이미지3',
  detail1_alt VARCHAR(120)					COMMENT '상세 이미지1 alt 값',
  detail2_alt VARCHAR(120)					COMMENT '상세 이미지2 alt 값',
  detail3_alt VARCHAR(120)					COMMENT '상세 이미지3 alt 값',
  use_code    CHAR(1) DEFAULT 'C' NOT NULL  COMMENT '사용 코드(C=컨텐츠 I=이미지)',
  mod_date    DATETIME                      COMMENT '변경일',
  reg_date    DATETIME NOT NULL             COMMENT '등록일',
  CONSTRAINT pk_sm_item_detail PRIMARY KEY (item_seq),
  CONSTRAINT fk1_sm_item_detail FOREIGN KEY (item_seq) REFERENCES sm_item (seq) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 상세';

-- Create table
CREATE TABLE sm_item_filter_word (
  seq         INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  filter_word VARCHAR(100) NOT NULL       COMMENT '금지어',
  reg_date    DATETIME NOT NULL           COMMENT '등록일',
  CONSTRAINT pk_sm_item_filter_word PRIMARY KEY (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 금지어';


-- Create table
CREATE TABLE sm_item_log (
  seq         INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  item_seq    INT UNSIGNED NOT NULL                COMMENT '상품 시퀀스',
  action      VARCHAR(800)                COMMENT '액션 (등록/수정/삭제)',
  content     TEXT                        COMMENT '내용',
  login_seq   INT UNSIGNED NOT NULL                COMMENT '로그인 시퀀스',
  login_type  CHAR(1) NOT NULL            COMMENT '로그인 타입 (A/S/D)',
  reg_date    DATETIME NOT NULL           COMMENT '등록일',
  mod_content TEXT                        COMMENT '수정내용',
  CONSTRAINT pk_sm_item_log PRIMARY KEY (seq),
  INDEX idx1_sm_item_log (item_seq),
  INDEX idx2_sm_item_log (reg_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 로그';

  
-- Create table
CREATE TABLE sm_item_option (
  seq         INT UNSIGNED NOT NULL AUTO_INCREMENT   COMMENT '시퀀스',
  item_seq    INT UNSIGNED NOT NULL                  COMMENT '상품 시퀀스(fk)',
  option_name VARCHAR(300) NOT NULL         COMMENT '옵션명',
  show_flag   CHAR(1) DEFAULT 'Y' NOT NULL  COMMENT '노출여부(Y:판매 N:비노출)',
  mod_date    DATETIME                      COMMENT '변경일',
  reg_date    DATETIME NOT NULL             COMMENT '등록일',
  CONSTRAINT pk_sm_item_option PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_item_option FOREIGN KEY (item_seq) REFERENCES sm_item (seq) ON DELETE CASCADE,
  INDEX idx1_sm_item_option (item_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 옵션';


-- Create table
CREATE TABLE sm_item_option_value (
  seq          INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  option_seq   INT UNSIGNED                          COMMENT '옵션 시퀀스(fk)',
  value_name   VARCHAR(150) NOT NULL        COMMENT '옵션상품명',
  stock_flag   CHAR(1) DEFAULT 'Y' NOT NULL COMMENT '재고관리여부(Y:재고관리 N:관리안함)',
  stock_cnt    INT DEFAULT 0 NOT NULL       COMMENT '재고수량',
  /*option_price INT                          COMMENT '옵션 추가금액',*/
  option_price INT DEFAULT 0 NOT NULL       COMMENT '옵션 추가금액',
  mod_date     DATETIME                     COMMENT '변경일',
  reg_date     DATETIME NOT NULL            COMMENT '등록일',
  CONSTRAINT pk_sm_item_option_value PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_item_option_value FOREIGN KEY (option_seq) REFERENCES sm_item_option (seq) ON DELETE CASCADE,
  INDEX idx1_sm_item_option_value (option_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 옵션 상세';

-- Create table
CREATE TABLE sm_item_review (
  seq        INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '상품평 시퀀스',
  detail_seq INT UNSIGNED                 COMMENT '주문상세 시퀀스',
  /*writer_seq INT NOT NULL                 COMMENT '회원 시퀀스(fk)',*/
  member_seq INT UNSIGNED NOT NULL                 COMMENT '회원 시퀀스(fk)',
  item_seq   INT UNSIGNED NOT NULL                 COMMENT '상품 시퀀스',
  review     VARCHAR(300)                 COMMENT '상품평',
  good_grade INT(1) DEFAULT 1             COMMENT '제품 만족도',
  deli_grade INT(1) DEFAULT 1             COMMENT '배송 만족도',
  reg_date   DATETIME NOT NULL            COMMENT '등록 일자',
  CONSTRAINT pk_sm_item_review PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_item_review FOREIGN KEY (member_seq) REFERENCES sm_member (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_item_review FOREIGN KEY (item_seq) REFERENCES sm_item (seq) ON DELETE CASCADE,
  INDEX idx1_sm_item_review (item_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품평';

-- Create table
CREATE TABLE sm_item_prop (
  prop_cd      INT UNSIGNED NOT NULL             COMMENT '속성 코드',    
  prop_nm      VARCHAR(100) NOT NULL    COMMENT '속성명',
  prop_type    VARCHAR(2) NOT NULL      COMMENT '속성타입(T:텍스트 R:라디오 TR:텍스트/라디오)',
  prop_note    VARCHAR(200)             COMMENT '설명(예제)',
  default_val  VARCHAR(200) NOT NULL    COMMENT '기본값',
  ext_prop_cd1 CHAR(3)                  COMMENT '외부 연동 속성 코드',
  radio_list   VARCHAR(200)             COMMENT '라디오 버튼 옵션값',
  CONSTRAINT pk_item_prop PRIMARY KEY (prop_cd)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 고시 속성';

 -- Create table
CREATE TABLE sm_item_type (
  type_cd      INT UNSIGNED NOT NULL     COMMENT '분류 코드',
  type_nm      VARCHAR(100)     COMMENT '분류명',
  CONSTRAINT pk_item_type PRIMARY KEY (type_cd)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 고시 분류';

 
-- Create table
CREATE TABLE sm_item_type_prop (
  type_prop_id INT UNSIGNED NOT NULL COMMENT '매칭 코드', 
  type_cd      INT UNSIGNED NOT NULL COMMENT '분류 코드',
  prop_cd      INT UNSIGNED NOT NULL COMMENT '속성 코드',
  seq_no       INT NOT NULL COMMENT '순번',
  prop_note    VARCHAR(200) COMMENT '분류 속성 예제',
  CONSTRAINT pk_sm_item_type_prop PRIMARY KEY (type_prop_id),
  CONSTRAINT fk1_sm_item_type_prop FOREIGN KEY (prop_cd) REFERENCES sm_item_prop (prop_cd) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_item_type_prop FOREIGN KEY (type_cd) REFERENCES sm_item_type (type_cd) ON DELETE CASCADE,
  INDEX idx1_sm_item_type_prop (type_cd),
  INDEX idx2_sm_item_type_prop (prop_cd)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 고시 분류 속성 매칭';
