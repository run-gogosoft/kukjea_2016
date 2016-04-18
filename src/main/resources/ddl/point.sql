-- Create table
CREATE TABLE sm_point (
  seq             INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '포인트 시퀀스',
  member_seq      INT UNSIGNED NOT NULL                COMMENT '멤버 시퀀스',
  admin_seq       INT UNSIGNED                         COMMENT '포인트 지급자 시퀀스(관리자)',
  point           INT NOT NULL                COMMENT '포인트',
  useable_point   INT NOT NULL                COMMENT '사용가능 포인트',
  valid_flag      CHAR(1) NOT NULL            COMMENT '유효플래그(Y:사용 가능, N:사용 불가)',
  reserve_code    CHAR(1)                     COMMENT '포인트 적립방식 코드',
  reserve_comment VARCHAR(200)                COMMENT '포인트 적립방식 코멘트',
  end_date        VARCHAR(10) NOT NULL        COMMENT '포인트 유효기간',
  reg_date        DATETIME NOT NULL           COMMENT '포인트 발생/등록일',
  CONSTRAINT pk_sm_point PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_point FOREIGN KEY (member_seq) REFERENCES sm_member (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_point FOREIGN KEY (admin_seq) REFERENCES sm_admin (seq),
  INDEX idx1_sm_point (member_seq),
  INDEX idx2_sm_point (valid_flag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='포인트 적립내역';

-- Create table
CREATE TABLE sm_point_history (
  seq              INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '포인트 히스토리 시퀀스',
  member_seq       INT UNSIGNED NOT NULL                 COMMENT '멤버 시퀀스',
  order_seq        INT UNSIGNED                          COMMENT '취소/환불 주문번호',
  admin_seq        INT UNSIGNED                          COMMENT '포인트 지급자 시퀀스(관리자)',
  point            INT                          COMMENT '포인트',
  status_code      CHAR(1) NOT NULL             COMMENT '상태 코드(S:적립, U:사용, D:소멸,C:취소적립)',
  order_detail_seq INT                          COMMENT '부분취소 상세주문번호',
  note             VARCHAR(300)                 COMMENT '비고',
  reg_date         DATETIME NOT NULL            COMMENT '등록일',
  CONSTRAINT pk_sm_point_history PRIMARY KEY (seq),
  INDEX idx1_sm_point_history (member_seq),
  INDEX idx2_sm_point_history (order_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='포인트 히스토리';

-- Create table
CREATE TABLE sm_point_log (
  seq         INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '포인트 로그 시퀀스',
  point_seq   INT UNSIGNED NOT NULL                COMMENT 'sm_point 시퀀스(fk)',
  member_seq  INT UNSIGNED NOT NULL                COMMENT '멤버 시퀀스',
  point       INT                         COMMENT '포인트',
  status_code CHAR(1) NOT NULL            COMMENT '상태 코드(S:적립, U:사용, D:소멸, E:소진,C:취소적립)',
  reg_date    DATETIME NOT NULL           COMMENT '등록일',
  CONSTRAINT pk_sm_point_log PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_point_log FOREIGN KEY (point_seq) REFERENCES sm_point (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_point_log FOREIGN KEY (member_seq) REFERENCES sm_member (seq) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='포인트 로그';
