/* 첨부파일 (itemRequest, seller) */
CREATE TABLE sm_filename (
  seq             INT UNSIGNED NOT NULL AUTO_INCREMENT       COMMENT '시퀀스',
  parent_code     VARCHAR(20) NOT NULL              COMMENT '유형코드 (itemRequest=상품등록요청, seller=입점신청(판매자등록))',
  parent_seq      INT UNSIGNED NOT NULL                      COMMENT '부모 시퀀스',
  num             INT NOT NULL                      COMMENT '파일 번호',
  filename        VARCHAR(250) NOT NULL DEFAULT ''  COMMENT '첨부 파일명 (논리)',
  real_filename   VARCHAR(250) NOT NULL DEFAULT ''  COMMENT '첨부 파일명 (물리)',
  reg_date        DATETIME NOT NULL                 COMMENT '등록일',
  PRIMARY KEY (seq),
  UNIQUE KEY uk1_sm_filename (parent_code, parent_seq, num),
  INDEX idx1_sm_filename (parent_code),
  INDEX idx2_sm_filename (parent_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='첨부파일 (itemRequest, seller)';