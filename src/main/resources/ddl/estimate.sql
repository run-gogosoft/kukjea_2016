/*견적*/
CREATE TABLE sm_estimate (
  seq               INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스(고유번호)',
  member_seq        INT UNSIGNED                   COMMENT '회원 시퀀스',
  item_seq          INT UNSIGNED                   COMMENT '상품 시퀀스',
  option_value_seq  INT UNSIGNED                   COMMENT '옵션 값 시퀀스',
  order_detail_seq  INT UNSIGNED          COMMENT '상품주문번호 시퀀스(FK)',
  amount            INT UNSIGNED                   COMMENT '견적 금액',
  qty               INT                   COMMENT '견적 수량',
  type_code         CHAR(1)               COMMENT 'N:대량견적(일반상품), E:견적요청(견적상품)',
  status_code       CHAR(1)               COMMENT '1:요청 접수, 2:견적 완료, 3:주문 완료',
  request           VARCHAR(300)          COMMENT '기타 요청사항',
  mod_date          DATETIME              COMMENT '수정일자',
  reg_date          DATETIME NOT NULL     COMMENT '등록일자',
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_estimate FOREIGN KEY (member_seq) REFERENCES sm_member (seq) ON DELETE SET NULL,
  CONSTRAINT fk2_sm_estimate FOREIGN KEY (item_seq) REFERENCES sm_item (seq) ON DELETE SET NULL,
  CONSTRAINT fk3_sm_estimate FOREIGN KEY (option_value_seq) REFERENCES sm_item_option_value (seq) ON DELETE SET NULL,
  CONSTRAINT fk4_sm_estimate FOREIGN KEY (order_detail_seq) REFERENCES sm_order_detail (seq) ON DELETE SET NULL,
  INDEX idx1_sm_estimate (member_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='견적';

/*비교 견적*/
CREATE TABLE sm_estimate_compare (
  seq               INT UNSIGNED NOT NULL COMMENT '시퀀스(고유번호)',
  order_seq         INT UNSIGNED NOT NULL COMMENT '상품주문번호 시퀀스(FK)',
  seller_seq        INT UNSIGNED NOT NULL COMMENT '판매자 시퀀스(FK)',
  file              VARCHAR(100)          COMMENT '비교견적 첨부 파일_URL',
  mod_date          DATETIME             COMMENT '수정(업로드)일자',
  reg_date          DATETIME NOT NULL    COMMENT '등록(신청)일자',
  PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_estimate_compare FOREIGN KEY (order_seq) REFERENCES sm_order (seq) ON DELETE SET NULL,
  CONSTRAINT fk2_sm_estimate_compare FOREIGN KEY (seller_seq) REFERENCES sm_seller (seq) ON DELETE SET NULL,
  INDEX idx1_sm_estimate_compare (seller_seq),
  INDEX idx2_sm_estimate_compare (order_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='비교 견적';
-- Create sequence
CREATE TABLE sm_estimate_compare_seq (
  seq  INT UNSIGNED NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='비교 견적 시퀀스 테이블';
--init
INSERT INTO sm_estimate_compare_seq VALUES(1);
