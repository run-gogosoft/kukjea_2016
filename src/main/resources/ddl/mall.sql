CREATE TABLE sm_mall (
  seq                  INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스(PK/FK)',
  url                  VARCHAR(100)                 COMMENT '쇼핑몰 URL',
  pay_method           VARCHAR(50)                  COMMENT '사용 가능 결제 수단(공통코드 참조-구분자 ,)',
  pg_code              VARCHAR(10)                  COMMENT 'PG사 코드',
  pg_id                VARCHAR(50)                  COMMENT 'PG 아이디(상점아이디 or kcp사이트코드)',
  pg_key               VARCHAR(100)                 COMMENT 'PG 키(상점키)',
  open_date            DATETIME                     COMMENT '오픈 일자',
  close_date           DATETIME                     COMMENT '폐쇄 일자',
  CONSTRAINT pk_sm_mall PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_mall FOREIGN KEY (seq) REFERENCES sm_user (seq) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='쇼핑몰 정보 테이블';