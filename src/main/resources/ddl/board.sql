--Create table
CREATE TABLE sm_board_seq (
  seq  INT UNSIGNED NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 시퀀스 테이블';

--Modify
ALTER TABLE sm_board MODIFY seq INT UNSIGNED NOT NULL;

-- Create table
CREATE TABLE sm_board (
  seq             INT UNSIGNED NOT NULL       COMMENT '게시글 시퀀스',
  /*writer_seq      INT NOT NULL                COMMENT '작성자 시퀀스',*/
  user_seq        INT UNSIGNED NOT NULL                COMMENT '작성자 시퀀스',
  mall_seq        INT UNSIGNED                         COMMENT '몰 시퀀스',
  integration_seq INT UNSIGNED                         COMMENT '통합(주문,아이템) 시퀀스',
  group_code      CHAR(1) NOT NULL            COMMENT '게시판 분류 코드(N=공지, F=자주묻는질문, Q=상품QnA, O=1:1문의)',
  cate_code       INT                         COMMENT '카테고리 코드( 공지사항:1=공지사항 고객, 2=공지사항 판매자 ; 1:1문의:200=주문배송, 201=주문취소, 202=주문반품, 203=주문교환, 204=기타 ; FAQ:10=상품문의, 20=배송문의, 30=주문문의, 40=회원관련문의, 50=기타문의) ;)',
  title           VARCHAR(300) NOT NULL       COMMENT '작성자 게시글 제목',
  content         TEXT                        COMMENT '작성자 게시글 내용',
  answer          TEXT                        COMMENT '관리자 답변',
  view_cnt        INT DEFAULT 0               COMMENT '조회수',
  answer_seq      INT UNSIGNED                         COMMENT '답변자 시퀀스',
  answer_flag     INT DEFAULT '2'             COMMENT '답변여부(1=답변, 2=미답변)',
  answer_date     DATETIME                    COMMENT '답변 등록 날짜',
  mod_date        DATETIME                    COMMENT '게시글 수정 날짜',
  reg_date        DATETIME NOT NULL           COMMENT '게시글 등록 날짜',
  CONSTRAINT pk_sm_board PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_board FOREIGN KEY (user_seq) REFERENCES sm_user (seq) ON DELETE CASCADE,
  INDEX idx1_sm_board (group_code),
  INDEX idx2_sm_board (cate_code),
  INDEX idx3_sm_board (user_seq),
  INDEX idx4_sm_board (integration_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판';

--Create table
CREATE TABLE sm_notice_popup_seq (
  seq  INT UNSIGNED NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공지 팝업창 시퀀스 테이블';

--Modify
ALTER TABLE sm_notice_popup MODIFY seq INT UNSIGNED NOT NULL;

-- Create table
CREATE TABLE sm_notice_popup (
  seq          INT UNSIGNED NOT NULL        COMMENT '팝업 시퀀스',
  mall_seq     INT UNSIGNED                 COMMENT '팝업 쇼핑몰 시퀀스',
  type_code    CHAR(1) NOT NULL DEFAULT 'C' COMMENT '타입 (C:고객, S:판매자)',
  title        VARCHAR(100) NOT NULL        COMMENT '팝업 제목',
  width        INT NOT NULL                 COMMENT '팝업 가로 크기',
  height       INT NOT NULL                 COMMENT '팝업 세로 크기',
  /*top          INT NOT NULL                 COMMENT '팝업 상단여백',*/
  top_margin   INT NOT NULL                 COMMENT '팝업 상단여백',
  /*left         INT NOT NULL                 COMMENT '팝업 왼쪽여백',*/
  left_margin  INT NOT NULL                 COMMENT '팝업 왼쪽여백',
  status_code  CHAR(1) NOT NULL             COMMENT '팝업 상태 코드(Y:진행, N:종료)',
  content_html TEXT NOT NULL                COMMENT '팝업 HTML 코드',
  CONSTRAINT pk_sm_notice_popup PRIMARY KEY (seq),
  INDEX idx1_sm_notice_popup (status_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8  COMMENT='공지 팝업창';

-- Create table
CREATE TABLE sm_common_board (
  seq              INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '게시판 시퀀스',
  name             VARCHAR(300) NOT NULL       COMMENT '게시판 이름',
  reg_date         DATETIME NOT NULL           COMMENT '게시판 등록 날짜',
  type_code        CHAR(1) NOT NULL DEFAULT 'N' COMMENT '게시판 종류 코드 (N=일반게시판, B=보도자료게시판, G=갤거리게시판,Y=유투브게시판)',
  comment_use_flag char(1) NOT NULL DEFAULT 'N' COMMENT '코멘트 기능 사용 여부',
  CONSTRAINT pk_sm_common_board PRIMARY KEY (seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 관리';

-- Insert Data
INSERT INTO sm_common_board(name, reg_date) VALUES('상품등록요청', now());
INSERT INTO sm_common_board(name, reg_date) VALUES('입점문의', now());
INSERT INTO sm_common_board(name, reg_date) VALUES('사회적 기업 소식', now());

--Create table
CREATE TABLE sm_common_board_detail_seq (
  seq  INT UNSIGNED NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통게시판 시퀀스 테이블';

--Modify
ALTER TABLE sm_common_board_detail MODIFY seq INT UNSIGNED NOT NULL;

-- Create table
CREATE TABLE sm_common_board_detail (
  seq              INT UNSIGNED NOT NULL      COMMENT '게시글 시퀀스',
  common_board_seq INT UNSIGNED NOT NULL                COMMENT '게시판 관리 시퀀스(FK)',
  user_seq         INT UNSIGNED                         COMMENT '작성자 시퀀스(비회원:null)',
  user_name       VARCHAR(20)                 COMMENT '작성자 이름(비회원)',       
  user_password   VARCHAR(65)                 COMMENT '작성자 비밀번호(비회원)',       
  title           VARCHAR(500) NOT NULL       COMMENT '작성자 게시글 제목',
  content         TEXT NOT NULL               COMMENT '작성자 게시글 내용',
  answer          TEXT                        COMMENT '관리자 답변',
  answer_seq      INT UNSIGNED                         COMMENT '답변자 시퀀스',
  answer_flag     CHAR(1) DEFAULT 'N'         COMMENT '답변여부(Y=답변, N=미답변)',
  notice_flag     CHAR(1) DEFAULT 'N'         COMMENT '게시판 최상단 공지사항 글 여부(Y=공지글, N=일반글 )',
  secret_flag     CHAR(1) 				      COMMENT '비밀글(Y=비밀글, N=공개글)',
  view_cnt        INT DEFAULT 0               COMMENT '조회수',
  recommend_cnt   INT DEFAULT 0               COMMENT '추천수',
  answer_date     DATETIME                    COMMENT '답변 등록 날짜',
  mod_date        DATETIME                    COMMENT '게시글 수정 날짜',
  reg_date        DATETIME NOT NULL           COMMENT '게시글 등록 날짜',
  CONSTRAINT pk_sm_common_board_detail PRIMARY KEY (seq),
  CONSTRAINT fk1_sm_common_board_detail FOREIGN KEY (common_board_seq) REFERENCES sm_common_board (seq) ON DELETE CASCADE,
  CONSTRAINT fk2_sm_common_board_detail FOREIGN KEY (user_seq) REFERENCES sm_user (seq) ON DELETE CASCADE,
  INDEX idx1_sm_common_board_detail (common_board_seq),
  INDEX idx2_sm_common_board_detail (notice_flag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 내용';

/* 게시판 코멘트 테이블 */
CREATE TABLE `sm_common_board_comment` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `board_seq` int(11) unsigned NOT NULL COMMENT '게시글 시퀀스',
  `member_seq` int(11) unsigned NOT NULL COMMENT '작성자 시퀀스',
  `content` mediumtext NOT NULL COMMENT '글 내용',
  `reg_date` datetime NOT NULL COMMENT '등록 일자',
  PRIMARY KEY (`seq`),
  CONSTRAINT `sm_board_comment_ibfk_1` FOREIGN KEY (`board_seq`) REFERENCES `sm_common_board_detail` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sm_board_comment_ibfk_2` FOREIGN KEY (`member_seq`) REFERENCES `sm_member` (`seq`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 코멘트 테이블';
