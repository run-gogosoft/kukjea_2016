-- Create table
CREATE TABLE sm_display (
  seq      INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  member_type_code CHAR(1) NOT NULL     COMMENT '회원구분(C:일반회원, P:공공기관, O:기업/시설/단체)',
  cate_seq INT UNSIGNED                          COMMENT '대분류 카테고리에서 사용 할때 카테고리 시퀀스(FK)',
  location VARCHAR(10)                  COMMENT '메인/서브구분(main / sub)',
  title    VARCHAR(100)                 COMMENT '배너종류  (Main Type : mainBanner , item1, item2, subBanner1, subBanner2, fashion, fashionlongBanner, accessory, accessorylongBanner, beauty, beautylongBanner, child, childlongBanner, living, livinglongBanner, digital, digitallongBanner)',
  content  TEXT                         COMMENT 'HTML내용',
  order_no INT                          COMMENT '정렬순서',
  mod_date DATETIME                     COMMENT '변경일',
  reg_date DATETIME NOT NULL            COMMENT '등록일',
  CONSTRAINT pk_sm_display PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_display FOREIGN KEY (cate_seq) REFERENCES sm_item_category (seq) ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX idx1_sm_display (member_type_code),
  INDEX idx2_sm_display (cate_seq),
  INDEX idx3_sm_display (title),
  INDEX idx4_sm_display (order_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='템플릿';

 
-- Create table
CREATE TABLE sm_display_item (
  seq        INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  member_type_code CHAR(1) NOT NULL       COMMENT '회원구분(C:일반회원, P:공공기관, O:기업/시설/단체)',
  cate_seq   INT UNSIGNED                          COMMENT '대분류 카테고리 시퀀스, 메인 페이지 관리에서 사용할때는 null (FK)',
  style_code INT NOT NULL                 COMMENT '메뉴 코드 1~10(상품꼽는 배너의 순서를 나타낸다)',
  order_no   INT                          COMMENT '정렬순서',
  title      VARCHAR(100)                 COMMENT '제목',
  limit_cnt  INT                          COMMENT '최대 전시 개수',
  CONSTRAINT pk_sm_display_item PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_display_item FOREIGN KEY (cate_seq) REFERENCES sm_item_category (seq) ON DELETE CASCADE ON UPDATE CASCADE,
  INDEX idx1_sm_display_item (member_type_code),
  INDEX idx2_sm_display_item (cate_seq),
  INDEX idx3_sm_display_item (style_code),
  INDEX idx4_sm_display_item (order_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='템플릿 상품';
  
  
-- Create table
CREATE TABLE sm_display_item_list (
  seq         INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  display_seq INT UNSIGNED                         COMMENT '대분류 스타일 시퀀스 (FK)',
  item_seq    INT UNSIGNED                         COMMENT '상품 시퀀스 (FK)',
  order_no    INT                         COMMENT '정렬순서',
  CONSTRAINT pk_sm_display_item_list PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_display_item_iist FOREIGN KEY (display_seq) REFERENCES sm_display_item (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_display_item_list FOREIGN KEY (item_seq) REFERENCES sm_item (seq) ON DELETE CASCADE,
  INDEX idx1_sm_display_item_list (display_seq),
  INDEX idx2_sm_display_item_list (order_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='템플릿 상품 리스트';