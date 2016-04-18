--Create table
CREATE TABLE sm_event_seq (
  seq  INT UNSIGNED NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='이벤트 시퀀스 테이블';

--Modify
ALTER TABLE sm_event MODIFY seq INT UNSIGNED NOT NULL;

-- Create table
CREATE TABLE sm_event (
  seq          INT UNSIGNED NOT NULL        COMMENT '시퀀스',
  mall_seq     INT UNSIGNED NOT NULL        COMMENT '몰시퀀스',
  type_code    CHAR(1) NOT NULL             COMMENT '구분 (1:기획전, 2:이벤트)',
  status_code  CHAR(1) NOT NULL             COMMENT '상태코드 (H:대기, Y:진행, N:종료)',
  title        VARCHAR(200)                 COMMENT '기획전/이벤트 명',
  html         TEXT                         COMMENT '상단 배너영역 HTML',
  thumb_img    VARCHAR(200)                 COMMENT '리스트페이지용 배너 URL',
  lv1_seq      INT UNSIGNED                          COMMENT '대분류 카테고리 시퀀스',
  coupon_seq   INT UNSIGNED                          COMMENT '자동발행 쿠폰 번호',
  show_flag    CHAR(1) DEFAULT 'N'          COMMENT '노출 여부 (Y:노출, N:노출안함)',
  main_section CHAR(1)                      COMMENT '배너영역 구분코드(메인 A,B,C,D,E,F,G,H 영역별로 구별)',
  end_date     VARCHAR(10)                  COMMENT '기획전 종료예정일',
  reg_date     DATETIME                     COMMENT '등록일',
  CONSTRAINT pk_sm_event PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_event FOREIGN KEY (mall_seq) REFERENCES sm_mall (seq) ON DELETE CASCADE,
  INDEX idx1_sm_event (status_code),
  INDEX idx2_sm_event (show_flag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기획전/이벤트 메인';

-- Create table
CREATE TABLE sm_event_group (
  seq        INT UNSIGNED NOT NULL AUTO_INCREMENT  COMMENT '시퀀스',
  mall_seq   INT UNSIGNED NOT NULL                 COMMENT '몰시퀀스',
  event_seq  INT UNSIGNED NOT NULL                 COMMENT '기획전 시퀀스 (FK:sm_event)',
  group_name VARCHAR(200) NOT NULL        COMMENT '상품 그룹명',
  order_no   INT NOT NULL                 COMMENT '정렬 순서',
  CONSTRAINT pk_sm_event_group PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_event_parent FOREIGN KEY (event_seq) REFERENCES sm_event (seq) ON DELETE CASCADE,
  INDEX idx1_sm_event_group (event_seq),
  INDEX idx2_sm_event_group (order_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기획전 상품 그룹';
  
-- Create table
CREATE TABLE sm_event_item (
  seq       INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  group_seq INT UNSIGNED NOT NULL                COMMENT '기획전 그룹 시퀀스 (FK:sm_event_group)',
  item_seq  INT UNSIGNED NOT NULL                COMMENT '상품 시퀀스 (FK:sm_item)',
  order_no  INT NOT NULL                COMMENT '정렬 순서',
  CONSTRAINT pk_sm_event_item PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_event_item FOREIGN KEY (group_seq) REFERENCES sm_event_group (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_event_item FOREIGN KEY (item_seq) REFERENCES sm_item (seq) ON DELETE CASCADE,
  INDEX idx1_sm_event_item (group_seq),
  INDEX idx2_sm_event_item (order_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기획전 상품 리스트';

-- Create table
CREATE TABLE sm_event_comment (
  seq             INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '게시글 시퀀스',
  user_seq        INT UNSIGNED NOT NULL                COMMENT '작성자 시퀀스',
  event_seq       INT UNSIGNED NOT NULL                COMMENT '기획전 시퀀스',
  content         TEXT                        COMMENT '댓글 내용',
  mod_date        DATETIME                    COMMENT '댓글 수정 날짜',
  reg_date        DATETIME NOT NULL           COMMENT '댓글 등록 날짜',
  CONSTRAINT pk_sm_event_comment PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_event_comment FOREIGN KEY (user_seq) REFERENCES sm_user (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_event_comment FOREIGN KEY (event_seq) REFERENCES sm_event (seq) ON DELETE CASCADE,
  INDEX idx1_sm_event_comment (event_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기획전 댓글';