-- Create table
CREATE TABLE sm_adjust (
  seq               INT UNSIGNED NOT NULL AUTO_INCREMENT   COMMENT '시퀀스 PK',
  order_detail_seq  INT UNSIGNED NOT NULL                  COMMENT '상품 주문 번호',
  mall_seq          INT UNSIGNED NOT NULL                  COMMENT '몰 시퀀스',
  cancel_flag       CHAR(1) NOT NULL              COMMENT '취소여부 (Y:취소, N:정상)',
  complete_flag     CHAR(1) DEFAULT 'N' NOT NULL  COMMENT '정산 상태(Y:완료, N:미완료)',
  adjust_grade_code CHAR(1) NOT NULL              COMMENT '정산등급',
  sell_price        INT NOT NULL                  COMMENT '판매가',
  supply_price      INT NOT NULL                  COMMENT '공급가',
  order_cnt         INT NOT NULL                  COMMENT '주문 수량',
  deli_cost         INT                           COMMENT '선결제 배송비',
  tax_code          CHAR(1) NOT NULL              COMMENT '과세 여부(1:과세, 2:면세, 3:상품권(면세))',
  seller_seq        INT UNSIGNED NOT NULL         COMMENT '판매자 시퀀스',
  reason            VARCHAR(300)                  COMMENT '조정 사유'
  order_ym          CHAR(6)                       COMMENT '주문년월',
  adjust_date       VARCHAR(8) NOT NULL           COMMENT '정산 확정 일자',
  complete_date     DATETIME                      COMMENT '정산 완료 일자',
  reg_date          DATETIME NOT NULL             COMMENT '등록 일자',
  CONSTRAINT pk_sm_adjust PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_adjust FOREIGN KEY (seller_seq) REFERENCES sm_seller (seq),
  INDEX idx1_sm_adjust (seller_seq),
  INDEX idx2_sm_adjust (adjust_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='정산';
