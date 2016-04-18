-- Create table
CREATE TABLE sm_festival_seq (
  seq  INT UNSIGNED NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='행사 시퀀스 테이블';

--Create table
CREATE TABLE sm_festival (
  seq               INT UNSIGNED NOT NULL COMMENT '시퀀스 PK',
  title             VARCHAR(100) NOT NULL COMMENT '제목',
  content           TEXT         NOT NULL COMMENT '내용', 
  start_date        CHAR(10) NOT NULL      COMMENT '신청 기간(시작일자)',
  end_date          CHAR(10) NOT NULL      COMMENT '신청 기간(종료일자)',
  mod_date          DATETIME              COMMENT '최근 수정 일자',
  reg_date          DATETIME NOT NULL     COMMENT '등록 일자',
  CONSTRAINT pk_sm_festival PRIMARY KEY (seq),
  INDEX idx1_sm_festival (start_date,end_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='행사 테이블';

--Create table
CREATE TABLE sm_festival_seller (
  seq           INT UNSIGNED NOT NULL AUTO_INCREMENT   COMMENT '시퀀스 PK',
  festival_seq  INT UNSIGNED NOT NULL  COMMENT '행사 seq(FK)',
  seller_seq    INT UNSIGNED NOT NULL  COMMENT '입점업체 seq(FK)',
  content       VARCHAR(1000) COMMENT '신청 내용',
  mod_date      DATETIME COMMENT '최근 수정 일자',
  reg_date      DATETIME NOT NULL COMMENT '신청 일자',
  CONSTRAINT pk_sm_festival_seller PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_festival_seller FOREIGN KEY (festival_seq) REFERENCES sm_festival (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_festival_seller FOREIGN KEY (seller_seq) REFERENCES sm_seller (seq) ON DELETE CASCADE,
  UNIQUE KEY uk1_sm_festival_seller (festival_seq, seller_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='행사 참여 테이블';