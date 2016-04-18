-- Create table
-- 비회원처리를 위해 member_seq FK 삭제
CREATE TABLE sm_cart (
  seq               INT UNSIGNED NOT NULL AUTO_INCREMENT   COMMENT '시퀀스',
  member_seq        INT UNSIGNED                           COMMENT '회원 시퀀스(fk)',
  option_value_seq  INT UNSIGNED                           COMMENT '옵션 하위 시퀀스(fk)',
  order_cnt         INT NOT NULL                  COMMENT '주문수량',
  direct_flag       CHAR(1) DEFAULT 'N' NOT NULL  COMMENT '즉시구매 여부(Y=즉시구매, N=장바구니)',
  item_seq          INT UNSIGNED NOT NULL                  COMMENT '상품 시퀀스',
  deli_prepaid_flag CHAR(1)                       COMMENT '배송비 선결제 구분(Y:선결제, N:착불)',
  reg_date          DATETIME NOT NULL             COMMENT '등록일',
  CONSTRAINT pk_sm_wish PRIMARY KEY(seq),
  -- CONSTRAINT fk1_sm_cart FOREIGN KEY(member_seq) REFERENCES member_seq(seq) ON DELETE CASCADE,
  -- 비회원 허용을 위해 FK 삭제
  CONSTRAINT fk1_sm_cart FOREIGN KEY(option_value_seq) REFERENCES sm_item_option_value(seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_cart FOREIGN KEY(item_seq) REFERENCES sm_item(seq) ON DELETE CASCADE,
  INDEX idx1_sm_cart (member_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='장바구니';
  
-- Create table
-- 비회원처리를 위해 member_seq FK 삭제
CREATE TABLE sm_wish (
  seq               INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스(pk)',
  member_seq        INT UNSIGNED NOT NULL                COMMENT '회원 시퀀스(fk)',
  item_seq          INT UNSIGNED NOT NULL                COMMENT '상품 시퀀스(fk)',
  option_value_seq  INT UNSIGNED                         COMMENT '옵션 시퀀스(fk)',
  deli_prepaid_flag CHAR(1)                     COMMENT '배송비 선결제여부(Y:선결제,N:착불)',
  reg_date          DATETIME NOT NULL           COMMENT '등록일',
  CONSTRAINT pk_sm_wish PRIMARY KEY(seq),
  -- CONSTRAINT fk1_sm_wish FOREIGN KEY(member_seq) REFERENCES member_seq(seq) ON DELETE CASCADE,
  -- 비회원 허용을 위해 FK 삭제
  CONSTRAINT fk1_sm_wish FOREIGN KEY(option_value_seq) REFERENCES sm_item_option_value(seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_wish FOREIGN KEY(item_seq) REFERENCES sm_item(seq) ON DELETE CASCADE,
  INDEX idx1_sm_wish (member_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='위시리스트';