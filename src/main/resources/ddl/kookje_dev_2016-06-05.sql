# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.1.13-MariaDB)
# Database: kookje_dev
# Generation Time: 2016-06-05 08:40:14 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table mms_msg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `mms_msg`;

CREATE TABLE `mms_msg` (
  `MSGKEY` int(11) NOT NULL AUTO_INCREMENT,
  `SUBJECT` varchar(120) DEFAULT NULL,
  `PHONE` varchar(15) NOT NULL,
  `CALLBACK` varchar(15) NOT NULL,
  `STATUS` varchar(2) NOT NULL DEFAULT '0',
  `REQDATE` datetime NOT NULL,
  `MSG` varchar(4000) DEFAULT NULL,
  `FILE_CNT` int(5) NOT NULL DEFAULT '0',
  `FILE_CNT_REAL` int(5) DEFAULT NULL,
  `FILE_PATH1` varchar(512) DEFAULT NULL,
  `FILE_PATH1_SIZ` int(10) DEFAULT NULL,
  `FILE_PATH2` varchar(512) DEFAULT NULL,
  `FILE_PATH2_SIZ` int(10) DEFAULT NULL,
  `FILE_PATH3` varchar(512) DEFAULT NULL,
  `FILE_PATH3_SIZ` int(10) DEFAULT NULL,
  `FILE_PATH4` varchar(512) DEFAULT NULL,
  `FILE_PATH4_SIZ` int(10) DEFAULT NULL,
  `FILE_PATH5` varchar(512) DEFAULT NULL,
  `FILE_PATH5_SIZ` int(10) DEFAULT NULL,
  `EXPIRETIME` varchar(10) NOT NULL DEFAULT '43200',
  `SENTDATE` datetime DEFAULT NULL,
  `RSLTDATE` datetime DEFAULT NULL,
  `REPORTDATE` datetime DEFAULT NULL,
  `TERMINATEDDATE` datetime DEFAULT NULL,
  `RSLT` varchar(4) DEFAULT NULL,
  `TYPE` varchar(2) NOT NULL DEFAULT '0',
  `TELCOINFO` varchar(10) DEFAULT NULL,
  `ROUTE_ID` varchar(20) DEFAULT NULL,
  `ID` varchar(20) DEFAULT NULL,
  `POST` varchar(20) DEFAULT NULL,
  `ETC1` varchar(64) DEFAULT NULL,
  `ETC2` varchar(32) DEFAULT NULL,
  `ETC3` varchar(32) DEFAULT NULL,
  `ETC4` int(10) DEFAULT NULL,
  PRIMARY KEY (`MSGKEY`),
  KEY `MMS_MSG_IDX2` (`REQDATE`),
  KEY `MMS_MSG_IDX3` (`PHONE`),
  KEY `MMS_MSG_IDX4` (`STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table sc_tran
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sc_tran`;

CREATE TABLE `sc_tran` (
  `TR_NUM` int(11) NOT NULL AUTO_INCREMENT,
  `TR_SENDDATE` datetime DEFAULT NULL,
  `TR_ID` varchar(16) DEFAULT NULL,
  `TR_SENDSTAT` varchar(1) NOT NULL DEFAULT '0',
  `TR_RSLTSTAT` varchar(2) DEFAULT '00',
  `TR_MSGTYPE` varchar(1) NOT NULL DEFAULT '0',
  `TR_PHONE` varchar(20) NOT NULL DEFAULT '',
  `TR_CALLBACK` varchar(20) DEFAULT NULL,
  `TR_RSLTDATE` datetime DEFAULT NULL,
  `TR_MODIFIED` datetime DEFAULT NULL,
  `TR_MSG` varchar(160) DEFAULT NULL,
  `TR_NET` varchar(4) DEFAULT NULL,
  `TR_ETC1` varchar(160) DEFAULT NULL,
  `TR_ETC2` varchar(160) DEFAULT NULL,
  `TR_ETC3` varchar(160) DEFAULT NULL,
  `TR_ETC4` varchar(160) DEFAULT NULL,
  `TR_ETC5` varchar(160) DEFAULT NULL,
  `TR_ETC6` varchar(160) DEFAULT NULL,
  `TR_ROUTEID` varchar(20) DEFAULT NULL,
  `TR_REALSENDDATE` datetime DEFAULT NULL,
  PRIMARY KEY (`TR_NUM`),
  KEY `SC_TRAN_IDX1` (`TR_SENDDATE`,`TR_SENDSTAT`),
  KEY `SC_TRAN_IDX2` (`TR_PHONE`),
  KEY `SC_TRAN_IDX3` (`TR_SENDSTAT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sc_tran` WRITE;
/*!40000 ALTER TABLE `sc_tran` DISABLE KEYS */;

INSERT INTO `sc_tran` (`TR_NUM`, `TR_SENDDATE`, `TR_ID`, `TR_SENDSTAT`, `TR_RSLTSTAT`, `TR_MSGTYPE`, `TR_PHONE`, `TR_CALLBACK`, `TR_RSLTDATE`, `TR_MODIFIED`, `TR_MSG`, `TR_NET`, `TR_ETC1`, `TR_ETC2`, `TR_ETC3`, `TR_ETC4`, `TR_ETC5`, `TR_ETC6`, `TR_ROUTEID`, `TR_REALSENDDATE`)
VALUES
	(1,'2016-05-17 18:32:29',NULL,'0','00','0','01029050158','02-2222-3896',NULL,NULL,'되나요?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `sc_tran` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_adjust
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_adjust`;

CREATE TABLE `sm_adjust` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스 PK',
  `order_detail_seq` int(11) unsigned DEFAULT NULL COMMENT '상품 주문 번호',
  `mall_seq` int(11) unsigned NOT NULL COMMENT '몰 시퀀스',
  `cancel_flag` char(1) NOT NULL COMMENT '취소여부 (Y:취소, N:정상)',
  `complete_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '정산 상태(Y:완료, N:미완료)',
  `adjust_grade_code` char(1) NOT NULL COMMENT '정산등급',
  `sell_price` int(11) NOT NULL COMMENT '판매가',
  `supply_price` int(11) NOT NULL COMMENT '공급가',
  `order_cnt` int(11) NOT NULL COMMENT '주문 수량',
  `deli_cost` int(11) DEFAULT NULL COMMENT '선결제 배송비',
  `tax_code` char(1) DEFAULT NULL COMMENT '과세 여부(1:과세, 2:면세, 3:상품권(면세))',
  `seller_seq` int(11) unsigned NOT NULL COMMENT '판매자 시퀀스',
  `reason` varchar(300) DEFAULT NULL COMMENT '조정 사유',
  `order_ym` char(6) DEFAULT NULL COMMENT '주문년월',
  `adjust_date` varchar(8) NOT NULL COMMENT '정산 확정 일자',
  `complete_date` datetime DEFAULT NULL COMMENT '정산 완료 일자',
  `reg_date` datetime NOT NULL COMMENT '등록 일자',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_adjust` (`seller_seq`),
  CONSTRAINT `fk1_sm_adjust` FOREIGN KEY (`seller_seq`) REFERENCES `sm_seller` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='정산';



# Dump of table sm_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_admin`;

CREATE TABLE `sm_admin` (
  `seq` int(11) unsigned NOT NULL COMMENT '시퀀스(PK/FK)',
  `email` varchar(50) DEFAULT NULL COMMENT '이메일',
  `tel` varchar(20) DEFAULT NULL COMMENT '전화번호',
  `cell` varchar(20) DEFAULT NULL COMMENT '핸드폰번호',
  PRIMARY KEY (`seq`),
  CONSTRAINT `fk1_sm_admin` FOREIGN KEY (`seq`) REFERENCES `sm_user` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자 정보';

LOCK TABLES `sm_admin` WRITE;
/*!40000 ALTER TABLE `sm_admin` DISABLE KEYS */;

INSERT INTO `sm_admin` (`seq`, `email`, `tel`, `cell`)
VALUES
	(1,'test@test.com','02-0000-0000','010-0000-0000'),
	(2,'test@test.com','02-0000-0000','010-1234-5678');

/*!40000 ALTER TABLE `sm_admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_admin_access_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_admin_access_log`;

CREATE TABLE `sm_admin_access_log` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `admin_seq` int(11) unsigned NOT NULL COMMENT '어드민 시퀀스',
  `ip_addr` varchar(15) DEFAULT NULL COMMENT '접속지 IP주소',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_admin_access_log` (`admin_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='어드민 접속 로그';

LOCK TABLES `sm_admin_access_log` WRITE;
/*!40000 ALTER TABLE `sm_admin_access_log` DISABLE KEYS */;

INSERT INTO `sm_admin_access_log` (`seq`, `admin_seq`, `ip_addr`, `reg_date`)
VALUES
	(1,2,'220.118.129.95','2016-05-14 15:10:24'),
	(2,2,'220.118.129.95','2016-05-14 15:11:04'),
	(3,2,'220.118.129.95','2016-05-14 16:35:07'),
	(4,2,'220.118.129.95','2016-05-14 16:38:17'),
	(5,2,'220.118.129.95','2016-05-14 16:42:09'),
	(6,2,'220.118.129.95','2016-05-14 16:45:27'),
	(7,2,'220.118.129.95','2016-05-14 16:51:46'),
	(8,2,'220.118.129.95','2016-05-14 16:58:42'),
	(9,2,'220.118.129.95','2016-05-14 17:02:42'),
	(10,2,'220.118.129.95','2016-05-14 17:13:11'),
	(11,2,'220.118.129.95','2016-05-14 17:21:38'),
	(12,2,'220.118.129.95','2016-05-14 17:24:31'),
	(13,2,'220.118.129.95','2016-05-14 17:30:43'),
	(14,2,'220.118.129.95','2016-05-14 17:38:45'),
	(15,2,'220.118.129.95','2016-05-14 17:58:16'),
	(16,2,'220.118.129.95','2016-05-14 18:17:32'),
	(17,2,'66.249.82.192','2016-05-14 23:59:40'),
	(18,2,'66.249.82.250','2016-05-15 00:04:26'),
	(19,2,'66.249.82.253','2016-05-15 00:06:54'),
	(20,2,'66.249.82.192','2016-05-16 01:12:42'),
	(21,2,'66.249.82.250','2016-05-16 02:07:34'),
	(22,2,'66.249.82.250','2016-05-16 02:29:56'),
	(23,2,'66.249.82.192','2016-05-16 02:31:59'),
	(24,2,'115.95.30.70','2016-05-16 17:35:51'),
	(25,2,'115.95.30.70','2016-05-16 18:18:04'),
	(26,2,'211.42.242.179','2016-05-16 20:36:15'),
	(27,2,'66.249.82.250','2016-05-17 16:23:32'),
	(28,2,'66.249.82.192','2016-05-17 18:23:17'),
	(29,2,'66.249.82.253','2016-05-18 20:26:18'),
	(30,2,'66.249.82.253','2016-05-19 12:04:55'),
	(31,2,'66.249.82.192','2016-05-19 17:11:52'),
	(32,2,'211.42.242.179','2016-05-19 19:24:13'),
	(33,2,'211.42.242.179','2016-05-25 20:03:48'),
	(34,2,'218.38.86.28','2016-05-27 10:48:37'),
	(35,2,'218.38.86.28','2016-05-27 16:36:14'),
	(36,2,'218.38.86.28','2016-05-30 15:40:54'),
	(37,2,'39.7.46.79','2016-05-30 16:41:31'),
	(38,2,'39.7.46.79','2016-05-30 16:43:06'),
	(39,2,'218.38.86.28','2016-06-01 11:08:58'),
	(40,2,'218.38.86.28','2016-06-01 18:09:36'),
	(41,2,'218.38.86.28','2016-06-03 12:17:27');

/*!40000 ALTER TABLE `sm_admin_access_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_admin_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_admin_log`;

CREATE TABLE `sm_admin_log` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `admin_seq` int(11) unsigned NOT NULL COMMENT '어드민 시퀀스',
  `login_seq` int(11) unsigned NOT NULL COMMENT '로그인 시퀀스',
  `grade_code` int(11) NOT NULL COMMENT '변경된 권한',
  `reg_date` date NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='어드민 변경 로그';



# Dump of table sm_admin_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_admin_permission`;

CREATE TABLE `sm_admin_permission` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(PK)',
  `controller_name` varchar(30) NOT NULL COMMENT '컨트롤러 이름',
  `controller_method` varchar(30) NOT NULL COMMENT '메소드 이름',
  `controller_division` varchar(30) DEFAULT NULL COMMENT '구분 이름',
  `controller_description` varchar(150) DEFAULT NULL COMMENT '컨트롤러 설명',
  `admin0_flag` char(1) NOT NULL COMMENT '관리자 등급 (연구소)',
  `admin1_flag` char(1) NOT NULL COMMENT '관리자 등급 (최고관리자)',
  `admin2_flag` char(1) NOT NULL COMMENT '관리자 등급 (운영관리자)',
  `admin3_flag` char(1) NOT NULL COMMENT '관리자 등급 (디자이너)',
  `admin4_flag` char(1) NOT NULL COMMENT '관리자 등급 (정산관리자)',
  `admin5_flag` char(1) NOT NULL COMMENT '관리자 등급 (CS관리자)',
  `admin6_flag` char(1) NOT NULL COMMENT '관리자 등급 (임시)',
  `admin7_flag` char(1) NOT NULL COMMENT '관리자 등급 (임시)',
  `admin8_flag` char(1) NOT NULL COMMENT '관리자 등급 (임시)',
  `admin9_flag` char(1) NOT NULL COMMENT '관리자 등급 (일반관리자)',
  `seller_flag` char(1) NOT NULL COMMENT '관리자 등급 (판매자)',
  `distributor_flag` char(1) NOT NULL COMMENT '관리자 등급 (총판)',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='관리자 등급';

LOCK TABLES `sm_admin_permission` WRITE;
/*!40000 ALTER TABLE `sm_admin_permission` DISABLE KEYS */;

INSERT INTO `sm_admin_permission` (`seq`, `controller_name`, `controller_method`, `controller_division`, `controller_description`, `admin0_flag`, `admin1_flag`, `admin2_flag`, `admin3_flag`, `admin4_flag`, `admin5_flag`, `admin6_flag`, `admin7_flag`, `admin8_flag`, `admin9_flag`, `seller_flag`, `distributor_flag`)
VALUES
	(1,'mainController','main','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(2,'displayController','lv1','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(3,'systemController','getCommonList','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(4,'systemController','list','','','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(5,'systemController','view','','','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(6,'systemController','insertForm','','','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(7,'systemController','form','','','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(8,'categoryController','getList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(10,'memberController','getStats','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(11,'memberController','getList','','','Y','Y','Y','N','N','Y','N','N','N','N','N','N'),
	(12,'memberController','getView','','','Y','Y','Y','N','N','Y','N','N','N','N','Y','N'),
	(13,'memberController','getData','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(14,'memberController','writeExcelMemberList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(15,'sellerController','getList','','','Y','Y','Y','N','Y','Y','N','N','N','N','N','N'),
	(16,'sellerController','getRegForm','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(17,'sellerController','getModForm','','','Y','Y','Y','N','Y','N','N','N','N','N','Y','N'),
	(18,'itemController','list','','','Y','Y','Y','Y','Y','Y','N','N','N','Y','Y','Y'),
	(19,'itemController','batchUpdate','H','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(20,'itemController','batchCategoryUpdate','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(21,'itemController','view','','','Y','Y','Y','Y','N','Y','N','N','N','N','Y','Y'),
	(22,'itemController','updateForm','','','Y','Y','Y','Y','N','N','N','N','N','N','Y','N'),
	(23,'itemController','form','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(24,'itemExcelController','form','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(25,'couponController','couponList','','','Y','Y','Y','N','N','Y','N','N','N','N','N','N'),
	(26,'couponController','insertCouponIssueForm','','','Y','Y','Y','N','N','Y','N','N','N','N','N','N'),
	(27,'couponController','upload','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(28,'couponController','writeExcelCouponIssueList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(29,'couponController','insertCouponIssue','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(30,'couponController','issueDelete','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(31,'couponController','insertCouponForm','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(32,'couponController','updateCouponForm','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(33,'couponController','writeProc','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(34,'couponController','delLimitItemProc','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(35,'eventController','list','','','Y','Y','Y','Y','Y','Y','N','N','N','Y','N','N'),
	(36,'eventController','form','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(37,'eventController','edit','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(38,'eventController','itemEdit','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(39,'orderController','getList','','','Y','Y','Y','N','Y','Y','N','N','N','Y','Y','Y'),
	(40,'orderController','updateStatusBatch','','','Y','Y','Y','N','N','Y','N','N','N','N','Y','N'),
	(41,'orderController','getDeliveryUploadForm','','','Y','Y','Y','N','N','Y','N','N','N','N','Y','Y'),
	(44,'orderController','sellDaily','','','Y','Y','Y','N','Y','N','N','N','N','N','N','N'),
	(45,'adjustController','getList','','','Y','Y','Y','N','Y','N','N','N','N','N','Y','Y'),
	(46,'adjustController','getOrderList','','정산 주문 리스트','Y','Y','Y','N','Y','N','N','N','N','N','Y','N'),
	(47,'adjustController','updateStatusBatch','','','Y','Y','N','N','Y','N','N','N','N','N','N','N'),
	(48,'reviewController','reviewList','','','Y','Y','Y','N','N','Y','N','N','N','Y','Y','Y'),
	(49,'reviewController','view','','','Y','Y','Y','N','N','Y','N','N','N','Y','Y','Y'),
	(50,'reviewController','form','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(51,'reviewController','edit','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(52,'reviewController','delProc','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(53,'systemController','gradeList','','','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(54,'systemController','gradeForm','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(55,'systemController','gradeEdit','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(56,'systemController','delProc','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(57,'orderController','getData','','','Y','Y','Y','N','N','Y','N','N','N','N','Y','Y'),
	(58,'orderController','updateStatusOne','','','Y','Y','Y','N','N','Y','N','N','N','N','Y','N'),
	(59,'itemController','delete','','','Y','Y','N','N','N','N','N','N','N','N','Y','N'),
	(60,'eventController','delProc','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(61,'couponController','deleteCoupon','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(62,'systemController','getNoticePopupForm','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(63,'boardController','list','notice','','Y','Y','Y','N','N','Y','N','N','N','Y','Y','Y'),
	(64,'boardController','view','notice','','Y','Y','Y','N','N','Y','N','N','N','Y','Y','Y'),
	(65,'boardController','form','notice','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(66,'boardController','edit','notice','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(67,'boardController','delProc','notice','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(68,'boardController','list','faq','','Y','Y','Y','N','N','Y','N','N','N','Y','N','N'),
	(69,'boardController','view','faq','','Y','Y','Y','N','N','Y','N','N','N','Y','N','N'),
	(70,'boardController','form','faq','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(71,'boardController','edit','faq','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(72,'boardController','delProc','faq','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(73,'boardController','list','one','','Y','Y','Y','N','N','Y','N','N','N','Y','Y','N'),
	(74,'boardController','view','one','','Y','Y','Y','N','N','Y','N','N','N','Y','Y','N'),
	(75,'boardController','edit','one','','Y','Y','Y','N','N','Y','N','N','N','N','Y','N'),
	(76,'boardController','delProc','one','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(77,'boardController','list','qna','','Y','Y','Y','N','N','Y','N','N','N','Y','Y','Y'),
	(78,'boardController','view','qna','','Y','Y','Y','N','N','Y','N','N','N','Y','Y','Y'),
	(79,'boardController','edit','qna','','Y','Y','Y','N','N','Y','N','N','N','N','Y','Y'),
	(80,'boardController','delProc','qna','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(87,'orderController','getCsList','','','Y','Y','Y','N','Y','Y','N','N','N','Y','Y','N'),
	(91,'systemController','writeProc','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(93,'adjustController','writeExcelAdjustList','','','Y','Y','N','N','Y','N','N','N','N','N','Y','N'),
	(94,'pointController','pointList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(95,'pointController','pointDetailList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(98,'pointController','pointForm','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(99,'pointController','pointWriteProc','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(100,'systemController','getDeliveryList','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(101,'systemController','insertDelivery','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(102,'systemController','updateDelivery','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(103,'systemController','deleteDelivery','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(104,'orderController','orderDeliveryProcList','','자동 배송완료 처리 리스트','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(105,'orderController','getDeliveryProcResult','','배송 완료 처리 메소드','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(106,'pgController','list','','pg 관리 리스트','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(107,'pgController','form','','PG 등록 폼','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(108,'pgController','editForm','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(109,'mallController','getList','','쇼핑몰 리스트','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(110,'mallController','getForm','','쇼핑몰 등록/수정 폼','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(111,'mallController','regVo','','쇼핑몰 정보 등록','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(112,'mallController','modVo','','쇼핑몰 정보 수정','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(113,'pgController','writeProc','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(114,'pgController','editProc','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(115,'pgController','deleteProc','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(116,'mallItemController','getList','','쇼핑몰 등록 상품 리스트 가져오기','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(117,'mallItemController','regVo','','쇼핑몰별 상품 등록','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(118,'mallItemController','modStatus','','쇼핑몰별 등록 상품 삭제 및 판매상태 변경 처리','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(120,'itemController','batchDelete','','상품리스트에서 상품삭제 버튼 클릭 시','Y','Y','N','N','N','N','N','N','N','N','Y','N'),
	(121,'itemController','batchUpdate','Y','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(122,'itemController','batchUpdate','N','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(123,'orderController','updateStatusBatch','20','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(124,'orderController','updateStatusBatch','30','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(125,'orderController','cancelOrder','','주문 &#40;부분&#41; 취소 처리','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(126,'orderController','writeExcelOrderList','','주문리스트 엑셀 다운로드','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(127,'itemController','writeExcelItemList','','상품 리스트 엑셀 다운로드','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(128,'sabangController','form','','사방넷 주문 수집 폼','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(129,'sabangController','downloadProc','','사방넷 주문 수집 처리','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(130,'sabangController','getList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(131,'sabangController','batchInsertProc','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(132,'mallController','getOtherList','','외부 연동 쇼핑몰 리스트','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(133,'itemController','adminExcelItemList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(134,'mallController','delVo','','쇼핑몰 삭제','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(135,'itemController','getFilterList','','금지어 리스트','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(136,'itemController','regFilter','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(137,'itemController','deleteFilter','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(138,'sabangController','batchDeleteProc','','미처리 주문 삭제 기능','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(139,'sabangController','batchItemUpdateProc','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(140,'orderController','getCsLogList','','','Y','Y','Y','N','N','Y','N','N','N','N','N','N'),
	(141,'memberController','formExcel','','회원 엑셀 등록 폼','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(142,'systemController','getUrlMappingList','','','Y','N','N','N','N','N','N','N','N','N','N','N'),
	(143,'adjustController','getListByMall','','쇼핑몰&#40;고객사&#41;별 정산 리스트','Y','Y','Y','N','Y','N','N','N','N','N','N','N'),
	(144,'itemController','batchContentUpdate','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(145,'adjustController','adjustExcelDown','','','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(146,'sellerController','writeExcelSellerList','','판매자 엑셀다운로드','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(147,'itemController','batchDuplicate','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(148,'smsController','smsList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(149,'smsController','smsForm','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(150,'smsController','smsUpdateForm','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(151,'smsController','smsDelete','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(152,'smsController','smsLogList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(153,'couponController','couponMappingList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(154,'couponController','couponBatchMapping','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(155,'testController','getTestVo 데헷','','','Y','N','Y','Y','N','N','N','N','N','N','N','N'),
	(157,'orderController','updateStatusForConfirm','','입금확인','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(158,'orderController','getListByPayMethod','','방문결제 리스트','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(160,'orderController','updatePayFlagList','','방문결제 처리완료 일괄 업데이트','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(161,'orderStatsController','getListByCategory','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(162,'orderStatsController','getListByAuthCategory','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(163,'orderStatsController','getListByMember','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(164,'orderStatsController','getListByItem','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(165,'orderStatsController','getListByItemForJachigu','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(166,'estimateController','getList','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(167,'estimateController','modData','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(168,'estimateController','getListCompare','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(169,'estimateController','regDataCompare','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(170,'estimateController','download','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(171,'estimateController','delDataCompare','','','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(172,'commonBoardController','list','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(173,'commonBoardController','detailList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(174,'commonBoardController','view','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(175,'commonBoardController','form','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(176,'commonBoardController','edit','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(177,'systemController','getPaymethodFeeList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(178,'mainController','tmpl','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(179,'mainController','login','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(181,'itemController','best','','','Y','Y','Y','Y','N','N','N','N','N','N','N','N'),
	(182,'memberController','getCsList','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(183,'orderController','downloadExcelOrderListNP','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(184,'orderStatsController','getListByMemberPublic','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(185,'orderStatsController','getListByMemberPublicExcel','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(186,'festivalController','getList','','행사 리스트 조회','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(187,'festivalController','getRegForm','','행사 등록 폼','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(188,'orderStatsController','getListByCategoryDetail','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(189,'festivalController','regVo','','행사 등록 처리','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(190,'orderStatsController','getListByCategoryExcel','','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(191,'festivalController','getDetail','','행사 상세 정보','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(192,'festivalController','getModForm','','행사 정보 수정 폼','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(193,'festivalController','modVo','','행사 정보 수정','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(194,'festivalController','delVo','','행사 삭제','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(195,'festivalController','regSellerVo','','행사 참여 신청','N','N','N','N','N','N','N','N','N','N','Y','N'),
	(196,'festivalController','modSellerVo','','행사 참여 업체 정보 수정','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(197,'festivalController','delSellerVo','','행사 참여 업체 삭제','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(198,'itemController','batchUpdate','S','품절 상태로 변경 처리','Y','Y','Y','N','N','N','N','N','N','N','Y','N'),
	(199,'estimateController','delData','','견적 신청 내역 삭제','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(200,'memberController','getListNotAccess','','장기 미접속 회원 리스트','Y','Y','Y','N','N','Y','N','N','N','N','N','N'),
	(201,'adjustController','regVo','','정산 내역 수동 추가','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(202,'adjustController','delVo','','정산 내역 수동 등록 건 삭제','Y','Y','N','N','N','N','N','N','N','N','N','N'),
	(203,'orderController','updateStatusBatch','10','','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(204,'smsController','smsSend','','sms 발송','Y','Y','Y','N','N','N','N','N','N','N','N','N'),
	(205,'smsController','smsSendForm','','sms 발송 폼','Y','Y','Y','N','N','N','N','N','N','N','N','N');

/*!40000 ALTER TABLE `sm_admin_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_board
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_board`;

CREATE TABLE `sm_board` (
  `seq` int(10) unsigned NOT NULL,
  `mall_seq` int(11) unsigned DEFAULT NULL,
  `user_seq` int(11) unsigned NOT NULL COMMENT '작성자 시퀀스',
  `integration_seq` int(11) unsigned DEFAULT NULL COMMENT '통합(주문,아이템) 시퀀스',
  `group_code` char(1) NOT NULL COMMENT '게시판 분류 코드(N=공지, F=자주묻는질문, Q=상품QnA, O=1:1문의)',
  `cate_code` int(11) DEFAULT NULL COMMENT '카테고리 코드( 공지사항:1=공지사항 고객, 2=공지사항 판매자 ; 1:1문의:200=주문배송, 201=주문취소, 202=주문반품, 203=주문교환, 204=기타 ; FAQ:10=상품문의, 20=배송문의, 30=주문문의, 40=회원관련문의, 50=기타문의) ;)',
  `title` varchar(300) NOT NULL COMMENT '작성자 게시글 제목',
  `content` text COMMENT '작성자 게시글 내용',
  `answer` text COMMENT '관리자 답변',
  `view_cnt` int(11) DEFAULT '0' COMMENT '조회수',
  `answer_seq` int(11) unsigned DEFAULT NULL COMMENT '답변자 시퀀스',
  `answer_flag` int(11) DEFAULT '2' COMMENT '답변여부(1=답변, 2=미답변)',
  `answer_date` datetime DEFAULT NULL COMMENT '답변 등록 날짜',
  `mod_date` datetime DEFAULT NULL COMMENT '게시글 수정 날짜',
  `reg_date` datetime NOT NULL COMMENT '게시글 등록 날짜',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_board` (`user_seq`),
  CONSTRAINT `fk1_sm_board` FOREIGN KEY (`user_seq`) REFERENCES `sm_user` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판';



# Dump of table sm_board_seq
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_board_seq`;

CREATE TABLE `sm_board_seq` (
  `seq` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 시퀀스 테이블';

LOCK TABLES `sm_board_seq` WRITE;
/*!40000 ALTER TABLE `sm_board_seq` DISABLE KEYS */;

INSERT INTO `sm_board_seq` (`seq`)
VALUES
	(77);

/*!40000 ALTER TABLE `sm_board_seq` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_cart
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_cart`;

CREATE TABLE `sm_cart` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `member_seq` int(11) unsigned DEFAULT NULL COMMENT '회원 시퀀스(fk)',
  `option_value_seq` int(11) unsigned DEFAULT NULL COMMENT '옵션 하위 시퀀스(fk)',
  `order_cnt` int(11) NOT NULL COMMENT '주문수량',
  `direct_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '즉시구매 여부(Y=즉시구매, N=장바구니)',
  `item_seq` int(11) unsigned NOT NULL COMMENT '상품 시퀀스',
  `deli_prepaid_flag` char(1) DEFAULT NULL COMMENT '배송비 선결제 구분(Y:선결제, N:착불)',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `not_login_key` varchar(50) DEFAULT NULL COMMENT '비회원 구분 키값',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_cart` (`member_seq`),
  KEY `fk2_sm_cart` (`option_value_seq`),
  KEY `fk3_sm_cart` (`item_seq`),
  CONSTRAINT `fk1_sm_cart` FOREIGN KEY (`option_value_seq`) REFERENCES `sm_item_option_value` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_cart` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='장바구니';

LOCK TABLES `sm_cart` WRITE;
/*!40000 ALTER TABLE `sm_cart` DISABLE KEYS */;

INSERT INTO `sm_cart` (`seq`, `member_seq`, `option_value_seq`, `order_cnt`, `direct_flag`, `item_seq`, `deli_prepaid_flag`, `reg_date`, `not_login_key`)
VALUES
	(1,4,4,1,'N',2,'','2016-05-16 02:52:02',''),
	(2,4,2,1,'N',1,'','2016-05-16 02:52:11','');

/*!40000 ALTER TABLE `sm_cart` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_common
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_common`;

CREATE TABLE `sm_common` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `group_code` int(11) NOT NULL COMMENT '그룹코드',
  `group_name` varchar(100) NOT NULL COMMENT '그룹명',
  `name` varchar(100) NOT NULL COMMENT '코드명',
  `value` varchar(20) NOT NULL COMMENT '코드값',
  `note` varchar(300) DEFAULT NULL COMMENT '비고/설명',
  `mod_date` datetime DEFAULT NULL COMMENT '수정일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_common` (`group_code`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통 코드';

LOCK TABLES `sm_common` WRITE;
/*!40000 ALTER TABLE `sm_common` DISABLE KEYS */;

INSERT INTO `sm_common` (`seq`, `group_code`, `group_name`, `name`, `value`, `note`, `mod_date`, `reg_date`)
VALUES
	(1,1,'회원상태','승인대기','H',NULL,NULL,'2015-11-23 17:38:24'),
	(2,1,'회원상태','중지/보류','N',NULL,NULL,'2015-11-23 17:38:24'),
	(3,1,'회원상태','탈퇴/폐점','X',NULL,NULL,'2015-11-23 17:38:24'),
	(4,1,'회원상태','정상','Y',NULL,NULL,'2015-11-23 17:38:24'),
	(5,2,'로그인유형','관리자','A',NULL,NULL,'2015-11-23 17:38:24'),
	(6,2,'로그인유형','회원','C',NULL,NULL,'2015-11-23 17:38:24'),
	(7,2,'로그인유형','쇼핑몰','M',NULL,NULL,'2015-11-23 17:38:24'),
	(8,2,'로그인유형','판매자','S',NULL,NULL,'2015-11-23 17:38:24'),
	(9,3,'성별','여자','F',NULL,NULL,'2015-11-23 17:38:24'),
	(10,3,'성별','남자','M',NULL,NULL,'2015-11-23 17:38:24'),
	(11,4,'상품상태','대량등록','E',NULL,NULL,'2015-11-23 17:38:24'),
	(12,4,'상품상태','가승인','H',NULL,NULL,'2015-11-23 17:38:24'),
	(13,4,'상품상태','판매중지','N',NULL,NULL,'2015-11-23 17:38:24'),
	(14,4,'상품상태','품절','S',NULL,NULL,'2015-11-23 17:38:24'),
	(15,4,'상품상태','판매중','Y',NULL,NULL,'2015-11-23 17:38:24'),
	(16,5,'과세여부','과세','1',NULL,NULL,'2015-11-23 17:38:24'),
	(17,5,'과세여부','면세','2',NULL,NULL,'2015-11-23 17:38:24'),
	(19,6,'주문상태','입금대기','00',NULL,NULL,'2015-11-23 17:38:24'),
	(20,6,'주문상태','결제완료','10',NULL,NULL,'2015-11-23 17:38:24'),
	(21,6,'주문상태','주문확인','20',NULL,NULL,'2015-11-23 17:38:24'),
	(22,6,'주문상태','배송중','30',NULL,NULL,'2015-11-23 17:38:24'),
	(23,6,'주문상태','배송완료','50',NULL,NULL,'2015-11-23 17:38:24'),
	(24,6,'주문상태','구매확정','55',NULL,NULL,'2015-11-23 17:38:24'),
	(25,6,'주문상태','교환요청','60',NULL,NULL,'2015-11-23 17:38:24'),
	(26,6,'주문상태','교환 진행중','61',NULL,NULL,'2015-11-23 17:38:24'),
	(27,6,'주문상태','교환완료','69',NULL,NULL,'2015-11-23 17:38:24'),
	(28,6,'주문상태','반품요청','70',NULL,NULL,'2015-11-23 17:38:24'),
	(29,6,'주문상태','반품 진행중','71',NULL,NULL,'2015-11-23 17:38:24'),
	(30,6,'주문상태','반품완료','79',NULL,NULL,'2015-11-23 17:38:24'),
	(31,6,'주문상태','취소요청','90',NULL,NULL,'2015-11-23 17:38:24'),
	(32,6,'주문상태','취소완료','99',NULL,NULL,'2015-11-23 17:38:24'),
	(33,7,'배송비 선결제 여부','유료배송','N',NULL,NULL,'2015-11-23 17:38:24'),
	(34,7,'배송비 선결제 여부','무료','X',NULL,NULL,'2015-11-23 17:38:24'),
	(35,7,'배송비 선결제 여부','선결제','Y',NULL,NULL,'2015-11-23 17:38:24'),
	(36,10,'게시판 유형','자주묻는 질문','F',NULL,NULL,'2015-11-23 17:38:24'),
	(37,10,'게시판 유형','공지사항','N',NULL,NULL,'2015-11-23 17:38:24'),
	(38,10,'게시판 유형','1:1문의','O',NULL,NULL,'2015-11-23 17:38:24'),
	(39,10,'게시판 유형','상품QnA','Q',NULL,NULL,'2015-11-23 17:38:24'),
	(40,15,'관리자 등급','연구소','0',NULL,NULL,'2015-11-23 17:38:24'),
	(41,15,'관리자 등급','최고 관리자','1',NULL,NULL,'2015-11-23 17:38:24'),
	(42,15,'관리자 등급','운영 관리자','2',NULL,NULL,'2015-11-23 17:38:24'),
	(43,15,'관리자 등급','디자이너','3',NULL,NULL,'2015-11-23 17:38:24'),
	(44,15,'관리자 등급','정산 관리자','4',NULL,NULL,'2015-11-23 17:38:24'),
	(45,15,'관리자 등급','CS 관리자','5',NULL,NULL,'2015-11-23 17:38:24'),
	(46,15,'관리자 등급','일반 관리자','9',NULL,NULL,'2015-11-23 17:38:24'),
	(47,16,'포인트 적립 방식','일반','1',NULL,NULL,'2015-11-23 17:38:24'),
	(48,16,'포인트 적립 방식','취소/환불','2',NULL,NULL,'2015-11-23 17:38:24'),
	(49,16,'포인트 적립 방식','CS처리','3',NULL,NULL,'2015-11-23 17:38:24'),
	(50,16,'포인트 적립 방식','이벤트','4','일시적인 운영',NULL,'2015-11-23 17:38:24'),
	(51,18,'쇼핑몰 상태','대기','H',NULL,NULL,'2015-11-23 17:38:24'),
	(52,18,'쇼핑몰 상태','중지','N',NULL,NULL,'2015-11-23 17:38:24'),
	(53,18,'쇼핑몰 상태','폐쇄','X',NULL,NULL,'2015-11-23 17:38:24'),
	(54,18,'쇼핑몰 상태','오픈','Y',NULL,NULL,'2015-11-23 17:38:24'),
	(62,22,'탈퇴 사유','장기간 부재, 군입대, 유학 등','M',NULL,NULL,'2015-11-23 17:38:24'),
	(63,22,'탈퇴 사유','배송 불만','B',NULL,NULL,'2015-11-23 17:38:24'),
	(64,22,'탈퇴 사유','컨텐츠 등 이용할 만한 서비스 부족','C',NULL,NULL,'2015-11-23 17:38:24'),
	(65,22,'탈퇴 사유','상품의 다양성/품질 불만','D',NULL,NULL,'2015-11-23 17:38:24'),
	(66,22,'탈퇴 사유','실질적인 혜택 부족','G',NULL,NULL,'2015-11-23 17:38:24'),
	(67,22,'탈퇴 사유','상품 가격 불만','I',NULL,NULL,'2015-11-23 17:38:24'),
	(68,22,'탈퇴 사유','사후조치 불만','J',NULL,NULL,'2015-11-23 17:38:24'),
	(69,22,'탈퇴 사유','교환/환불/반품 불만','K',NULL,NULL,'2015-11-23 17:38:24'),
	(70,22,'탈퇴 사유','이용빈도 낮음','L',NULL,NULL,'2015-11-23 17:38:24'),
	(71,22,'탈퇴 사유','개인정보 누출 우려','P',NULL,NULL,'2015-11-23 17:38:24'),
	(72,22,'탈퇴 사유','아이디 변경을 위해 탈퇴 후 재가입','R',NULL,NULL,'2015-11-23 17:38:24'),
	(73,22,'탈퇴 사유','사이트 속도 및 안정성 불만','S',NULL,NULL,'2015-11-23 17:38:24'),
	(74,22,'탈퇴 사유','탈퇴사유 직접 입력&#40;기타&#41;','T',NULL,NULL,'2015-11-23 17:38:24'),
	(75,22,'탈퇴 사유','사이트 이용 불편','U',NULL,NULL,'2015-11-23 17:38:24'),
	(76,27,'포인트 상태 구분','취소적립','C',NULL,NULL,'2015-11-23 17:38:24'),
	(77,27,'포인트 상태 구분','소멸','D',NULL,NULL,'2015-11-23 17:38:24'),
	(78,27,'포인트 상태 구분','소진','E',NULL,NULL,'2015-11-23 17:38:24'),
	(79,27,'포인트 상태 구분','적립','S',NULL,NULL,'2015-11-23 17:38:24'),
	(80,27,'포인트 상태 구분','사용','U',NULL,NULL,'2015-11-23 17:38:24'),
	(81,28,'PG사 코드','이니시스','inicis',NULL,NULL,'2015-11-23 17:38:24'),
	(82,28,'PG사 코드','KCP','kcp',NULL,NULL,'2015-11-23 17:38:24'),
	(83,28,'PG사 코드','LG U+','lguplus',NULL,NULL,'2015-11-23 17:38:24'),
	(84,29,'서울시 자치구','강남구','01',NULL,NULL,'2015-11-23 17:38:24'),
	(85,29,'서울시 자치구','강동구','02',NULL,NULL,'2015-11-23 17:38:24'),
	(86,29,'서울시 자치구','강북구','03',NULL,NULL,'2015-11-23 17:38:24'),
	(87,29,'서울시 자치구','강서구','04',NULL,NULL,'2015-11-23 17:38:24'),
	(88,29,'서울시 자치구','관악구','05',NULL,NULL,'2015-11-23 17:38:24'),
	(89,29,'서울시 자치구','광진구','06',NULL,NULL,'2015-11-23 17:38:24'),
	(90,29,'서울시 자치구','구로구','07',NULL,NULL,'2015-11-23 17:38:24'),
	(91,29,'서울시 자치구','금천구','08',NULL,NULL,'2015-11-23 17:38:24'),
	(92,29,'서울시 자치구','노원구','09',NULL,NULL,'2015-11-23 17:38:24'),
	(93,29,'서울시 자치구','도봉구','10',NULL,NULL,'2015-11-23 17:38:24'),
	(94,29,'서울시 자치구','동대문구','11',NULL,NULL,'2015-11-23 17:38:24'),
	(95,29,'서울시 자치구','동작구','12',NULL,NULL,'2015-11-23 17:38:24'),
	(96,29,'서울시 자치구','마포구','13',NULL,NULL,'2015-11-23 17:38:24'),
	(97,29,'서울시 자치구','서대문구','14',NULL,NULL,'2015-11-23 17:38:24'),
	(98,29,'서울시 자치구','서초구','15',NULL,NULL,'2015-11-23 17:38:24'),
	(99,29,'서울시 자치구','성동구','16',NULL,NULL,'2015-11-23 17:38:24'),
	(100,29,'서울시 자치구','성북구','17',NULL,NULL,'2015-11-23 17:38:24'),
	(101,29,'서울시 자치구','송파구','18',NULL,NULL,'2015-11-23 17:38:24'),
	(102,29,'서울시 자치구','양천구','19',NULL,NULL,'2015-11-23 17:38:24'),
	(103,29,'서울시 자치구','영등포구','20',NULL,NULL,'2015-11-23 17:38:24'),
	(104,29,'서울시 자치구','용산구','21',NULL,NULL,'2015-11-23 17:38:24'),
	(105,29,'서울시 자치구','은평구','22',NULL,NULL,'2015-11-23 17:38:24'),
	(106,29,'서울시 자치구','종로구','23',NULL,NULL,'2015-11-23 17:38:24'),
	(107,29,'서울시 자치구','중구','24',NULL,NULL,'2015-11-23 17:38:24'),
	(108,29,'서울시 자치구','중랑구','25',NULL,NULL,'2015-11-23 17:38:24'),
	(109,29,'서울시 자치구','서울시청','26','',NULL,'2016-02-17 16:48:58'),
	(110,30,'회원 구분','개인','C',NULL,NULL,'2015-11-23 17:38:24'),
	(111,30,'회원 구분','기업/시설/단체','O',NULL,NULL,'2015-11-23 17:38:24'),
	(112,30,'회원 구분','공공기관','P',NULL,NULL,'2015-11-23 17:38:24'),
	(113,31,'가입 경로','인터넷','1',NULL,NULL,'2015-11-23 17:38:24'),
	(114,31,'가입 경로','전단지/카탈로그','2',NULL,NULL,'2015-11-23 17:38:24'),
	(115,31,'가입 경로','소개','3',NULL,NULL,'2015-11-23 17:38:24'),
	(116,31,'가입 경로','기타','9',NULL,NULL,'2015-11-23 17:38:24'),
	(117,32,'견적 상태','접수','1',NULL,NULL,'2015-11-23 17:38:24'),
	(118,32,'견적 상태','견적 완료','2',NULL,NULL,'2015-11-23 17:38:24'),
	(119,32,'견적 상태','주문 완료','3',NULL,NULL,'2015-11-23 17:38:24'),
	(120,33,'견적 구분','견적 요청','E',NULL,NULL,'2015-11-23 17:38:24'),
	(121,33,'견적 구분','대량 견적','N',NULL,NULL,'2015-11-23 17:38:24'),
	(122,34,'상품 구분','견적','E',NULL,NULL,'2015-11-23 17:38:24'),
	(123,34,'상품 구분','일반','N',NULL,NULL,'2015-11-23 17:38:24'),
	(124,35,'인증구분','사회적기업','01','','2016-03-11 11:10:26','2015-11-23 17:38:24'),
	(127,35,'인증구분','중증장애인생산품','04','','2016-03-11 11:10:48','2015-11-23 17:38:24'),
	(128,35,'인증구분','자활기업','05','','2016-03-11 11:10:54','2015-11-27 16:42:22'),
	(129,35,'인증구분','친환경인증기업','06','','2016-03-11 11:11:00','2015-11-27 16:42:37'),
	(130,35,'인증구분','협동조합','07','','2016-03-11 11:11:06','2015-11-27 16:42:46'),
	(131,36,'1:1문의 구분','주문배송','200','',NULL,'2015-11-27 17:13:17'),
	(132,36,'1:1문의 구분','주문취소','201','',NULL,'2015-11-27 17:13:43'),
	(133,36,'1:1문의 구분','주문반품','202','',NULL,'2015-11-27 17:13:53'),
	(134,36,'1:1문의 구분','주문교환','203','',NULL,'2015-11-27 17:14:03'),
	(135,36,'1:1문의 구분','입점관련','204','',NULL,'2015-11-27 17:14:15'),
	(136,36,'1:1문의 구분','상품문의','205','',NULL,'2015-11-27 17:14:26'),
	(137,36,'1:1문의 구분','세금계산서/영수증','206','',NULL,'2015-11-27 17:14:37'),
	(138,36,'1:1문의 구분','기타','207','',NULL,'2015-11-27 17:14:47'),
	(139,21,'결제 수단','신용카드','CARD1','ISP/안심클릭 인증','2016-04-12 16:28:48','2015-11-30 13:41:23'),
	(140,21,'결제 수단','신용카드','CARD2','카드 정보 입력','2016-04-12 16:29:27','2015-11-30 13:41:39'),
	(141,21,'결제 수단','무통장입금','CASH','','0000-00-00 00:00:00','2015-11-30 13:42:00'),
	(142,21,'결제 수단','방문결제','OFFLINE','','0000-00-00 00:00:00','2015-11-30 13:42:33'),
	(143,21,'결제 수단','포인트','POINT','','0000-00-00 00:00:00','2015-11-30 13:43:17'),
	(144,21,'결제 수단','신용카드+포인트','CARD1+POINT','주문내역 표기용','2015-11-30 13:47:11','2015-11-30 13:44:27'),
	(145,21,'결제 수단','신용카드+포인트','CARD2+POINT','주문내역 표기용','2015-11-30 13:47:16','2015-11-30 13:44:55'),
	(146,21,'결제 수단','무통장입금+포인트','CASH+POINT','주문내역 표기용','2015-11-30 13:47:20','2015-11-30 13:45:30'),
	(147,21,'결제 수단','방문결제+포인트','OFFLINE+POINT','주문내역 표기용','2015-11-30 13:47:25','2015-11-30 13:46:55'),
	(148,35,'인증구분','마을기업','08','','2016-03-11 11:11:14','2015-12-06 15:00:49'),
	(150,35,'인증구분','기타','99','',NULL,'2015-12-06 15:01:32'),
	(151,21,'결제 수단','ARS(신용카드)','ARS','','2015-12-29 14:36:56','2015-12-23 17:01:44'),
	(153,21,'결제 수단','후청구(신용카드)','NP_CARD2','카드 정보 입력','2016-04-12 16:29:43','2015-12-29 14:32:19'),
	(154,21,'결제 수단','무통장입금','NP_CASH','공공기관용','2016-01-12 09:58:36','2015-12-29 14:33:45'),
	(155,21,'결제 수단','ARS(신용카드)+포인트','ARS+POINT','주문내역표기용','2015-12-29 14:47:06','2015-12-29 14:46:55'),
	(156,21,'결제 수단','후청구(신용카드)+포인트','NP_CARD2+POINT','주문내역표기용','2015-12-29 14:57:39','2015-12-29 14:49:25'),
	(157,21,'결제 수단','무통장입금+포인트','NP_CASH+POINT','주문내역표기용','2016-01-12 09:58:53','2015-12-29 14:56:37'),
	(158,29,'서울시 자치구','기타','99',NULL,NULL,'2015-11-23 17:38:24'),
	(159,32,'견적 상태','견적 취소','9','',NULL,'2016-03-08 14:01:21'),
	(160,35,'인증구분','장애인기업','09','',NULL,'2016-03-11 11:26:35'),
	(161,35,'인증구분','공정무역','10','',NULL,'2016-03-11 11:27:37'),
	(162,35,'인증구분','여성기업','11','',NULL,'2016-03-11 11:27:54'),
	(163,21,'결제 수단','후청구(신용카드)','NP_CARD1','ISP/안심클릭 인증','2016-04-12 16:30:10','2016-04-11 17:10:49'),
	(164,21,'결제 수단','후청구(신용카드)+포인트','NP_CARD1+POINT','주문내역표기용',NULL,'2016-04-11 17:11:30');

/*!40000 ALTER TABLE `sm_common` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_common_board
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_common_board`;

CREATE TABLE `sm_common_board` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '게시판 시퀀스',
  `name` varchar(300) NOT NULL COMMENT '게시판 이름',
  `reg_date` datetime NOT NULL COMMENT '게시판 등록 날짜',
  `type_code` char(1) NOT NULL DEFAULT 'N' COMMENT '게시판 종류 코드 (N=일반게시판, B=보도자료게시판, G=갤거리게시판,Y=유투브게시판)',
  `comment_use_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '코멘트 기능 사용 여부',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 관리';

LOCK TABLES `sm_common_board` WRITE;
/*!40000 ALTER TABLE `sm_common_board` DISABLE KEYS */;

INSERT INTO `sm_common_board` (`seq`, `name`, `reg_date`, `type_code`, `comment_use_flag`)
VALUES
	(1,'판매요청','2015-10-29 16:04:28','N','N'),
	(2,'제휴문의','2015-10-29 16:04:28','N','N'),
	(3,'사회적 기업 소식','2015-10-29 16:04:28','N','N'),
	(6,'보도자료','2016-02-24 18:06:15','B','N'),
	(7,'유투브 게시판','2016-02-25 13:44:59','Y','N'),
	(8,'갤러리 게시판','2016-02-25 16:00:04','G','N'),
	(9,'댓글 테스트','2016-02-26 10:42:06','N','Y');

/*!40000 ALTER TABLE `sm_common_board` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_common_board_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_common_board_comment`;

CREATE TABLE `sm_common_board_comment` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `board_seq` int(11) unsigned NOT NULL COMMENT '게시글 시퀀스',
  `user_seq` int(11) unsigned NOT NULL COMMENT '작성자 시퀀스',
  `content` mediumtext NOT NULL COMMENT '글 내용',
  `reg_date` datetime NOT NULL COMMENT '등록 일자',
  PRIMARY KEY (`seq`),
  KEY `sm_board_comment_ibfk_1` (`board_seq`),
  KEY `sm_board_comment_ibfk_2` (`user_seq`),
  CONSTRAINT `sm_board_comment_ibfk_1` FOREIGN KEY (`board_seq`) REFERENCES `sm_common_board_detail` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sm_board_comment_ibfk_2` FOREIGN KEY (`user_seq`) REFERENCES `sm_user` (`seq`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 코멘트 테이블';



# Dump of table sm_common_board_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_common_board_detail`;

CREATE TABLE `sm_common_board_detail` (
  `seq` int(10) unsigned NOT NULL,
  `common_board_seq` int(11) unsigned NOT NULL COMMENT '게시판 관리 시퀀스(FK)',
  `user_seq` int(11) unsigned DEFAULT NULL COMMENT '작성자 시퀀스(비회원:null)',
  `user_name` varchar(20) DEFAULT NULL COMMENT '작성자 이름(비회원)',
  `user_password` varchar(65) DEFAULT NULL COMMENT '작성자 비밀번호(비회원)',
  `title` varchar(500) NOT NULL COMMENT '작성자 게시글 제목',
  `content` text NOT NULL COMMENT '작성자 게시글 내용',
  `answer` text COMMENT '관리자 답변',
  `answer_seq` int(11) unsigned DEFAULT NULL COMMENT '답변자 시퀀스',
  `answer_flag` char(1) DEFAULT 'N' COMMENT '답변여부(Y=답변, N=미답변)',
  `notice_flag` char(1) DEFAULT 'N' COMMENT '게시판 최상단 공지사항 글 여부(Y=공지글, N=일반글 )',
  `secret_flag` char(1) DEFAULT 'N' COMMENT '비밀글(Y=비밀글, N=일반글)',
  `view_cnt` int(11) DEFAULT '0' COMMENT '조회수',
  `recommend_cnt` int(11) DEFAULT '0' COMMENT '추천수',
  `answer_date` datetime DEFAULT NULL COMMENT '답변 등록 날짜',
  `mod_date` datetime DEFAULT NULL COMMENT '게시글 수정 날짜',
  `reg_date` datetime NOT NULL COMMENT '게시글 등록 날짜',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_common_board_detail` (`common_board_seq`),
  KEY `fk2_sm_common_board_detail` (`user_seq`),
  CONSTRAINT `fk1_sm_common_board_detail` FOREIGN KEY (`common_board_seq`) REFERENCES `sm_common_board` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_common_board_detail` FOREIGN KEY (`user_seq`) REFERENCES `sm_user` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 내용';

LOCK TABLES `sm_common_board_detail` WRITE;
/*!40000 ALTER TABLE `sm_common_board_detail` DISABLE KEYS */;

INSERT INTO `sm_common_board_detail` (`seq`, `common_board_seq`, `user_seq`, `user_name`, `user_password`, `title`, `content`, `answer`, `answer_seq`, `answer_flag`, `notice_flag`, `secret_flag`, `view_cnt`, `recommend_cnt`, `answer_date`, `mod_date`, `reg_date`)
VALUES
	(28,2,NULL,'test','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','입점 및 제휴 관련 문의 드립니다.','&lt;p&gt;&lt;img alt=&quot;&quot; src=&quot;http://localhost/upload/editor/common_board/1000/28_1.png&quot; style=&quot;width: 1920px; height: 1080px;&quot; /&gt;&lt;/p&gt;','&lt;p&gt;동해물과 백두산이&lt;/p&gt;\r\n\r\n&lt;p&gt;abcdefg&lt;/p&gt;\r\n\r\n&lt;p&gt;&lt;span style=&quot;color: rgb&#40;238, 130, 238&#41;;&quot;&gt;&lt;em&gt;&lt;strong&gt;&lt;span style=&quot;font-size: 28px;&quot;&gt;&lt;span style=&quot;font-family: times new roman,times,serif;&quot;&gt;동해물과 백두산이&lt;/span&gt;&lt;/span&gt;&lt;/strong&gt;&lt;/em&gt;&lt;/span&gt;&lt;br /&gt;\r\n&lt;span style=&quot;font-size: 48px;&quot;&gt;&lt;span style=&quot;font-family: comic sans ms,cursive;&quot;&gt;&lt;span style=&quot;color: rgb&#40;255, 0, 0&#41;;&quot;&gt;abcdefg&lt;/span&gt;&lt;/span&gt;&lt;/span&gt;&lt;br /&gt;\r\n&nbsp;&lt;/p&gt;',8,'Y','N','Y',4,0,'2016-02-23 16:03:49','2016-02-23 16:03:49','2015-12-04 16:39:56');

/*!40000 ALTER TABLE `sm_common_board_detail` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_common_board_detail_seq
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_common_board_detail_seq`;

CREATE TABLE `sm_common_board_detail_seq` (
  `seq` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공통게시판 시퀀스 테이블';

LOCK TABLES `sm_common_board_detail_seq` WRITE;
/*!40000 ALTER TABLE `sm_common_board_detail_seq` DISABLE KEYS */;

INSERT INTO `sm_common_board_detail_seq` (`seq`)
VALUES
	(50);

/*!40000 ALTER TABLE `sm_common_board_detail_seq` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_deli_company
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_deli_company`;

CREATE TABLE `sm_deli_company` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `company_name` varchar(60) NOT NULL COMMENT '택배사 회사명',
  `company_tel` varchar(20) DEFAULT NULL COMMENT '택배사 연락처',
  `track_url` varchar(200) DEFAULT NULL COMMENT '배송추적 URL',
  `complete_msg` varchar(150) DEFAULT NULL COMMENT '배송완료 메시지',
  `use_flag` char(1) NOT NULL DEFAULT 'Y' COMMENT '배송업체 사용여부(사용:Y, 사용안함:N)',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='국내 배송 택배사 테이블';

LOCK TABLES `sm_deli_company` WRITE;
/*!40000 ALTER TABLE `sm_deli_company` DISABLE KEYS */;

INSERT INTO `sm_deli_company` (`seq`, `company_name`, `company_tel`, `track_url`, `complete_msg`, `use_flag`)
VALUES
	(1,'CJ-GLS택배','1588-5353','https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&amp;fsp_cmd=retrieveInvNoACT&amp;invc_no=','배달완료 되었습니다|가족에게 전달하였습니다|경비실에 보관하였습니다|동료에게 전달하였습니다','N'),
	(2,'현대택배','1588-2121','http://www.hlc.co.kr/personalService/tracking/06/tracking_goods_result.jsp?sflag=01&InvNo=','배달 완료하였습니다|물품을 받으셨습니다.','Y'),
	(3,'한진택배','1588-0011','http://www.hanjin.co.kr/Delivery_html/inquiry/result_waybill.jsp?wbl_num=','<strong>배송완료</strong>','Y'),
	(4,'KGB택배','1577-4577','http://www.kgbls.co.kr/sub5/trace.asp?f_slipno=','배송완료. 이용해주셔서 감사합니다.','Y'),
	(5,'고려택배','0000-0000','http://www.klogis.kr/03_business/01_tracking_detail_bcno.asp?bcno=','배송이 완료되었습니다','Y'),
	(6,'CJ대한통운','1588-1255','https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&amp;fsp_cmd=retrieveInvNoACT&amp;invc_no=','배달완료 되었습니다|가족에게 전달하였습니다|경비실에 보관하였습니다|동료에게 전달하였습니다','Y'),
	(7,'로젠택배','1588-9988','http://www.ilogen.com/iLOGEN.Web.New/TRACE/TraceView.aspx?gubun=slipno&amp;slipno=','전달하였습니다','Y'),
	(8,'옐로우캡','1588-0123','https://www.kgyellowcap.co.kr/delivery/waybill.html?delivery=','받으셨습니다','N'),
	(9,'우체국택배','1588-1300','https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?displayHeader=N&amp;sid1=','배달완료 되었습니다','Y'),
	(10,'동부익스프레스','1588-8848','http://www.dongbups.com/newHtml/delivery/dvsearch_View.jsp?item_no=','물품전달','N'),
	(11,'경동택배','080-873-2178','http://www.kdexp.com/sub3_shipping.asp?stype=1&p_item=','서명처리가 완료되었습니다.','Y'),
	(12,'천일택배','031-462-1101','http://www.cyber1001.co.kr/HTrace/HTrace.jsp?transNo=','배송완료','Y'),
	(13,'대신택배','043-222-4582','http://home.daesinlogistics.co.kr/daesin/jsp/d_freight_chase/d_general_process2.jsp?billno1=&billno2=&billno3=','배송완료','Y'),
	(14,'일양로지스','1588-0002','http://www.ilyanglogis.com/functionality/tracking_result.asp?hawb_no=','배달완료','Y'),
	(15,'건영택배','053-354-3001','http://www.kunyoung.com/goods/goods_01.php?mulno=','배달완료','Y'),
	(16,'편의점택배','1566-1025','http://www.doortodoor.co.kr/jsp/cmn/TrackingCVS.jsp?pTdNo=','배달이 완료되었습니다','Y'),
	(17,'합동택배','080-873-2178','http://www.hdexp.co.kr/parcel/order_result_t.asp?stype=1&p_item=','배달완료','Y'),
	(18,'GTX로지스','1588-1756','http://www.gtxlogis.co.kr/tracking/default.asp?awblno=','','Y'),
	(19,'직접배송','','','','Y'),
	(20,'KG로지스','1588-0123','http://www.kglogis.co.kr/delivery/delivery_result.jsp?item_no=','','Y');

/*!40000 ALTER TABLE `sm_deli_company` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_display
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_display`;

CREATE TABLE `sm_display` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `member_type_code` char(1) NOT NULL COMMENT '회원구분(C:일반회원, P:공공기관, O:기업/시설/단체)',
  `cate_seq` int(11) unsigned DEFAULT NULL COMMENT '대분류 카테고리에서 사용 할때 카테고리 시퀀스(FK)',
  `location` varchar(10) DEFAULT NULL COMMENT '메인/서브구분(main / sub)',
  `title` varchar(100) DEFAULT NULL COMMENT '배너종류  (Main Type : mainBanner , item1, item2, subBanner1, subBanner2, fashion, fashionlongBanner, accessory, accessorylongBanner, beauty, beautylongBanner, child, childlongBanner, living, livinglongBanner, digital, digitallongBanner)',
  `content` text COMMENT 'HTML내용',
  `order_no` int(11) DEFAULT NULL COMMENT '정렬순서',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_display` (`cate_seq`),
  CONSTRAINT `fk1_sm_display` FOREIGN KEY (`cate_seq`) REFERENCES `sm_item_category` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='템플릿';

LOCK TABLES `sm_display` WRITE;
/*!40000 ALTER TABLE `sm_display` DISABLE KEYS */;

INSERT INTO `sm_display` (`seq`, `member_type_code`, `cate_seq`, `location`, `title`, `content`, `order_no`, `mod_date`, `reg_date`)
VALUES
	(1,'C',NULL,'main','mainHeroBanner','<div class=\"promotion_banner\">\r\n    <div class=\"promotion_list\">\r\n        <ul>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n        </ul>\r\n    </div>\r\n    <ul class=\"slider_control\">\r\n        <li><a href=\"#\" class=\"on\"><span>한가위 할인 이벤트</span></a></li>\r\n        <li><a href=\"#\"><span>영우메디컬</span></a></li>\r\n        <li><a href=\"#\"><span>에이원메디컬</span></a></li>\r\n        <li><a href=\"#\"><span>제이웰팜</span></a></li>\r\n        <li><a href=\"#\"><span>한국메디텍</span></a></li>\r\n        <li><a href=\"#\"><span>이지메디컴</span></a></li>\r\n    </ul>\r\n</div>',NULL,'2016-05-08 17:48:22','2015-10-27 19:28:19'),
	(2,'C',NULL,'main','mainBannerA','<div class=\"ch-long\">\r\n  <div class=\"nav-wrap\">\r\n    <div class=\"ch-long-banner\">\r\n      <img src=\"/upload/banner/main/abanner/a_01.png\" data-color=\"#e4e3ad\" alt=\"Long Banner\"/>\r\n    </div>\r\n\r\n    <ul class=\"ch-long-list\">\r\n      <li class=\"carrot carrot-bottom-back li-hover\">\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"/upload/banner/main/abanner/a_01.png\" data-color=\"#e4e3ad\"></span>\r\n        </a>\r\n      </li>\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-href=\"/shop/detail/1896\" data-src=\"/upload/banner/main/abanner/a_02.jpg\" data-color=\"#e9e2d2\"></span>\r\n        </a>\r\n      </li>\r\n    </ul>\r\n  </div>\r\n</div>',NULL,'2015-11-26 20:42:04','2015-10-27 19:57:31'),
	(3,'C',NULL,'main','mainBannerB','<div class=\"ch-1col\" style=\"margin-right:11px;\">\r\n  <a href=\"/shop/detail/281\"><img src=\"/upload/banner/main/bbanner/b_01.jpg\" alt=\"food banner\" /></a>\r\n</div>',NULL,'2015-11-26 20:40:47','2015-10-27 20:08:43'),
	(4,'C',NULL,'main','mainBannerC','<div class=\"ch-1col\" style=\"float:right\">\r\n  <img src=\"/upload/banner/main/cbanner/c_01.jpg\" alt=\"life banner\" />\r\n</div>',NULL,'2015-11-26 19:32:43','2015-10-27 20:27:08'),
	(5,'C',NULL,'main','mainBannerF','<div class=\"ch-container video-banner-wrap\">\r\n  <div class=\"content-wrap\">\r\n    <div class=\"video\">\r\n      <iframe width=\"854\" height=\"480\" src=\"//www.youtube.com/embed/tAZAAUlg9Xw\" allowfullscreen style=\"border: 0;\"></iframe>\r\n    </div>\r\n    <div class=\"video-description\">\r\n      <div class=\"title\">\r\n        <div class=\"text1\">책농장 북텐트 홈앤쇼핑TV</div>\r\n        <div class=\"hr\"></div>\r\n        <div class=\"text2\">\r\n          책농장 북텐트 홈앤쇼핑 광고 영상입니다.<br/>\r\n          북텐트의 취지와 특징들을 쉽게 잘 설명해주셨네요.\r\n        </div>\r\n      </div>\r\n      <div class=\"item\">\r\n        <ul id=\"VideoBoardTarget\" class=\"item-list\">\r\n          <li><img src=\"${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif\" style=\"margin:40px 0 0 240px;\" alt=\"loading\" /></li>\r\n        </ul>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>',NULL,'2015-11-24 04:41:46','2015-10-28 10:19:15'),
	(6,'C',NULL,'login','loginBanner','',NULL,'2016-05-17 18:23:43','2015-10-28 18:06:15'),
	(8,'O',NULL,'main','mainHeroBanner','<div class=\"promotion_banner\">\r\n    <div class=\"promotion_list\">\r\n        <ul>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n        </ul>\r\n    </div>\r\n    <ul class=\"slider_control\">\r\n        <li><a href=\"#\" class=\"on\"><span>한가위 할인 이벤트</span></a></li>\r\n        <li><a href=\"#\"><span>영우메디컬</span></a></li>\r\n        <li><a href=\"#\"><span>에이원메디컬</span></a></li>\r\n        <li><a href=\"#\"><span>제이웰팜</span></a></li>\r\n        <li><a href=\"#\"><span>한국메디텍</span></a></li>\r\n        <li><a href=\"#\"><span>이지메디컴</span></a></li>\r\n    </ul>\r\n</div>',NULL,'2016-05-08 17:49:04','2015-10-27 19:28:19'),
	(9,'O',NULL,'main','mainBannerA','<div class=\"ch-long\">\r\n  <div class=\"nav-wrap\">\r\n    <div class=\"ch-long-banner\">\r\n      <img src=\"/upload/banner/main/abanner/a_01.png\" data-color=\"#e4e3ad\" alt=\"Long Banner\"/>\r\n    </div>\r\n\r\n    <ul class=\"ch-long-list\">\r\n      <li class=\"carrot carrot-bottom-back li-hover\">\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"/upload/banner/main/abanner/a_01.png\" data-color=\"#e4e3ad\"></span>\r\n        </a>\r\n      </li>\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-href=\"/shop/detail/1896\" data-src=\"/upload/banner/main/abanner/a_02.jpg\" data-color=\"#e9e2d2\"></span>\r\n        </a>\r\n      </li>\r\n    </ul>\r\n  </div>\r\n</div>',NULL,'2015-11-26 20:41:57','2015-10-27 19:57:31'),
	(10,'O',NULL,'main','mainBannerB','<div class=\"ch-1col\" style=\"margin-right:11px;\">\r\n  <a href=\"/shop/detail/281\"><img src=\"/upload/banner/main/bbanner/b_01.jpg\" alt=\"food banner\" /></a>\r\n</div>',NULL,'2015-11-26 20:40:54','2015-10-27 20:08:43'),
	(11,'O',NULL,'main','mainBannerC','<div class=\"ch-1col\" style=\"float:right\">\r\n  <img src=\"/upload/banner/main/cbanner/c_01.jpg\" alt=\"life banner\" />\r\n</div>',NULL,'2015-11-26 19:35:21','2015-10-27 20:27:08'),
	(12,'O',NULL,'main','mainBannerF','<div class=\"ch-container video-banner-wrap\">\r\n  <div class=\"content-wrap\">\r\n    <div class=\"video\">\r\n      <iframe width=\"854\" height=\"480\" src=\"//www.youtube.com/embed/tAZAAUlg9Xw\" allowfullscreen style=\"border: 0;\"></iframe>\r\n    </div>\r\n    <div class=\"video-description\">\r\n      <div class=\"title\">\r\n        <div class=\"text1\">책농장 북텐트 홈앤쇼핑TV</div>\r\n        <div class=\"hr\"></div>\r\n        <div class=\"text2\">\r\n          책농장 북텐트 홈앤쇼핑 광고 영상입니다.<br/>\r\n          북텐트의 취지와 특징들을 쉽게 잘 설명해주셨네요.\r\n        </div>\r\n      </div>\r\n      <div class=\"item\">\r\n        <ul id=\"VideoBoardTarget\" class=\"item-list\">\r\n          <li><img src=\"${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif\" style=\"margin:40px 0 0 240px;\" alt=\"loading\" /></li>\r\n        </ul>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>',NULL,'2015-11-26 19:36:41','2015-10-28 10:19:15'),
	(13,'O',NULL,'login','loginBanner','<div class=\"ch-long\" style=\"margin:35px 0 0 0;\">\r\n  <div class=\"nav-wrap\">\r\n    <div class=\"ch-long-banner\">\r\n      <img src=\"${const.ASSETS_PATH}/front-assets/images/main/long_banner.png\" data-color=\"#e4e3ad\" alt=\"A Type Banner\"/>\r\n    </div>\r\n\r\n    <ul class=\"ch-long-list\">\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"${const.ASSETS_PATH}/front-assets/images/main/long_banner.png\" data-color=\"#e4e3ad\" alt=\"A Type Banner\"/>\r\n        </a>\r\n      </li>\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"${const.ASSETS_PATH}/front-assets/images/main/login_banner2.png\" data-color=\"#adaee4\" alt=\"A Type Banner\"/>\r\n        </a>\r\n      </li>\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"${const.ASSETS_PATH}/front-assets/images/main/login_banner3.png\" data-color=\"#ade1e4\" alt=\"A Type Banner\"/>\r\n        </a>\r\n      </li>\r\n      </ul>\r\n  </div>\r\n</div>',NULL,'2015-11-10 13:49:16','2015-10-28 18:06:15'),
	(14,'P',NULL,'main','mainHeroBanner','<div class=\"promotion_banner\">\r\n    <div class=\"promotion_list\">\r\n        <ul>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n            <li><a href=\"#\"><img src=\"/images/thumb/thumb_promotion.jpg\" alt=\"한가위 이지메티컴 할인이벤트\" /></a></li>\r\n        </ul>\r\n    </div>\r\n    <ul class=\"slider_control\">\r\n        <li><a href=\"#\" class=\"on\"><span>한가위 할인 이벤트</span></a></li>\r\n        <li><a href=\"#\"><span>영우메디컬</span></a></li>\r\n        <li><a href=\"#\"><span>에이원메디컬</span></a></li>\r\n        <li><a href=\"#\"><span>제이웰팜</span></a></li>\r\n        <li><a href=\"#\"><span>한국메디텍</span></a></li>\r\n        <li><a href=\"#\"><span>이지메디컴</span></a></li>\r\n    </ul>\r\n</div>',NULL,'2016-05-08 17:49:12','2015-10-27 19:28:19'),
	(15,'P',NULL,'main','mainBannerA','<div class=\"ch-long\">\r\n  <div class=\"nav-wrap\">\r\n    <div class=\"ch-long-banner\">\r\n      <img src=\"/upload/banner/main/abanner/a_01.png\" data-color=\"#e4e3ad\" alt=\"Long Banner\"/>\r\n    </div>\r\n\r\n    <ul class=\"ch-long-list\">\r\n      <li class=\"carrot carrot-bottom-back li-hover\">\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"/upload/banner/main/abanner/a_01.png\" data-color=\"#e4e3ad\"></span>\r\n        </a>\r\n      </li>\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-href=\"/shop/detail/1896\" data-src=\"/upload/banner/main/abanner/a_02.jpg\" data-color=\"#e9e2d2\"></span>\r\n        </a>\r\n      </li>\r\n    </ul>\r\n  </div>\r\n</div>',NULL,'2015-11-26 20:41:49','2015-10-27 19:57:31'),
	(16,'P',NULL,'main','mainBannerB','<div class=\"ch-1col\" style=\"margin-right:11px;\">\r\n  <a href=\"/shop/detail/281\"><img src=\"/upload/banner/main/bbanner/b_01.jpg\" alt=\"food banner\" /></a>\r\n</div>',NULL,'2015-11-26 20:41:00','2015-10-27 20:08:43'),
	(17,'P',NULL,'main','mainBannerC','<div class=\"ch-1col\" style=\"float:right\">\r\n  <img src=\"/upload/banner/main/cbanner/c_01.jpg\" alt=\"life banner\" />\r\n</div>',NULL,'2015-11-26 19:36:14','2015-10-27 20:27:08'),
	(18,'P',NULL,'main','mainBannerF','<div class=\"ch-container video-banner-wrap\">\r\n  <div class=\"content-wrap\">\r\n    <div class=\"video\">\r\n      <iframe width=\"854\" height=\"480\" src=\"//www.youtube.com/embed/tAZAAUlg9Xw\" allowfullscreen style=\"border: 0;\"></iframe>\r\n    </div>\r\n    <div class=\"video-description\">\r\n      <div class=\"title\">\r\n        <div class=\"text1\">책농장 북텐트 홈앤쇼핑TV</div>\r\n        <div class=\"hr\"></div>\r\n        <div class=\"text2\">\r\n          책농장 북텐트 홈앤쇼핑 광고 영상입니다.<br/>\r\n          북텐트의 취지와 특징들을 쉽게 잘 설명해주셨네요.\r\n        </div>\r\n      </div>\r\n      <div class=\"item\">\r\n        <ul id=\"VideoBoardTarget\" class=\"item-list\">\r\n          <li><img src=\"${const.ASSETS_PATH}/front-assets/images/common/ajaxloader.gif\" style=\"margin:40px 0 0 240px;\" alt=\"loading\" /></li>\r\n        </ul>\r\n      </div>\r\n    </div>\r\n  </div>\r\n</div>',NULL,'2015-11-26 19:36:35','2015-10-28 10:19:15'),
	(19,'P',NULL,'login','loginBanner','<div class=\"ch-long\" style=\"margin:35px 0 0 0;\">\r\n  <div class=\"nav-wrap\">\r\n    <div class=\"ch-long-banner\">\r\n      <img src=\"${const.ASSETS_PATH}/front-assets/images/main/long_banner.png\" data-color=\"#e4e3ad\" alt=\"A Type Banner\"/>\r\n    </div>\r\n\r\n    <ul class=\"ch-long-list\">\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"${const.ASSETS_PATH}/front-assets/images/main/long_banner.png\" data-color=\"#e4e3ad\" alt=\"A Type Banner\"/>\r\n        </a>\r\n      </li>\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"${const.ASSETS_PATH}/front-assets/images/main/login_banner2.png\" data-color=\"#adaee4\" alt=\"A Type Banner\"/>\r\n        </a>\r\n      </li>\r\n      <li>\r\n        <a href=\"#\">\r\n          <span class=\"circle\" data-src=\"${const.ASSETS_PATH}/front-assets/images/main/login_banner3.png\" data-color=\"#ade1e4\" alt=\"A Type Banner\"/>\r\n        </a>\r\n      </li>\r\n      </ul>\r\n  </div>\r\n</div>',NULL,'2015-11-10 13:49:16','2015-10-28 18:06:15');

/*!40000 ALTER TABLE `sm_display` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_display_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_display_item`;

CREATE TABLE `sm_display_item` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `member_type_code` char(1) NOT NULL COMMENT '회원구분(C:일반회원, P:공공기관, O:기업/시설/단체)',
  `cate_seq` int(11) unsigned DEFAULT NULL COMMENT '대분류 카테고리 시퀀스, 메인 페이지 관리에서 사용할때는 null (FK)',
  `style_code` int(11) NOT NULL COMMENT '메뉴 코드 1~10(상품꼽는 배너의 순서를 나타낸다)',
  `order_no` int(11) DEFAULT NULL COMMENT '정렬순서',
  `title` varchar(100) DEFAULT NULL COMMENT '제목',
  `limit_cnt` int(11) DEFAULT NULL COMMENT '최대 전시 개수',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_display_item` (`cate_seq`),
  CONSTRAINT `fk1_sm_display_item` FOREIGN KEY (`cate_seq`) REFERENCES `sm_item_category` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='템플릿 상품';

LOCK TABLES `sm_display_item` WRITE;
/*!40000 ALTER TABLE `sm_display_item` DISABLE KEYS */;

INSERT INTO `sm_display_item` (`seq`, `member_type_code`, `cate_seq`, `style_code`, `order_no`, `title`, `limit_cnt`)
VALUES
	(1,'C',NULL,2,1,'장애인기업상품',4),
	(2,'C',NULL,1,0,'사회적기업상품',4),
	(3,'C',NULL,3,2,'MD추천상품',4),
	(4,'C',NULL,4,3,'B-ItemList',3),
	(5,'C',NULL,5,4,'C-ItemList',3),
	(6,'C',NULL,6,5,'D-ItemList',4),
	(7,'C',NULL,7,6,'E-ItemList',4),
	(8,'C',NULL,8,7,'F-ItemList',2),
	(38,'O',NULL,4,3,'B-ItemList',3),
	(39,'O',NULL,5,4,'C-ItemList',3),
	(40,'O',NULL,6,5,'D-ItemList',4),
	(41,'O',NULL,7,6,'E-ItemList',4),
	(42,'O',NULL,8,7,'F-ItemList',2),
	(43,'O',NULL,3,2,'MD추천상품',4),
	(44,'O',NULL,1,0,'사회적기업상품1',4),
	(45,'O',NULL,2,1,'장애인기업상품',4),
	(73,'P',NULL,4,3,'B-ItemList',3),
	(74,'P',NULL,5,4,'C-ItemList',3),
	(75,'P',NULL,6,5,'D-ItemList',4),
	(76,'P',NULL,7,6,'E-ItemList',4),
	(77,'P',NULL,8,7,'F-ItemList',2),
	(78,'P',NULL,3,2,'MD추천상품',4),
	(79,'P',NULL,1,0,'사회적기업상품 공공기관',4),
	(80,'P',NULL,2,1,'장애인기업상품',4),
	(165,'B',NULL,1,0,'베스트 상품',38),
	(198,'C',NULL,9,8,'공정무역상품',4),
	(199,'C',NULL,10,9,'마을기업상품',4),
	(200,'O',NULL,9,8,'공정무역상품',4),
	(201,'O',NULL,10,9,'마을기업상품',4),
	(202,'P',NULL,9,8,'공정무역상품',4),
	(203,'P',NULL,10,9,'마을기업상품',4);

/*!40000 ALTER TABLE `sm_display_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_display_item_list
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_display_item_list`;

CREATE TABLE `sm_display_item_list` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `display_seq` int(11) unsigned DEFAULT NULL COMMENT '대분류 스타일 시퀀스 (FK)',
  `item_seq` int(11) unsigned DEFAULT NULL COMMENT '상품 시퀀스 (FK)',
  `order_no` int(11) DEFAULT NULL COMMENT '정렬순서',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_display_item_iist` (`display_seq`),
  KEY `fk2_sm_display_item_list` (`item_seq`),
  CONSTRAINT `fk1_sm_display_item_list` FOREIGN KEY (`display_seq`) REFERENCES `sm_display_item` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk2_sm_display_item_list` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='템플릿 상품 리스트';



# Dump of table sm_estimate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_estimate`;

CREATE TABLE `sm_estimate` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(고유번호)',
  `member_seq` int(11) unsigned DEFAULT NULL COMMENT '회원 시퀀스',
  `item_seq` int(11) unsigned DEFAULT NULL COMMENT '상품 시퀀스',
  `option_value_seq` int(11) unsigned DEFAULT NULL COMMENT '옵션 값 시퀀스',
  `order_detail_seq` int(11) unsigned DEFAULT NULL COMMENT '상품주문번호 시퀀스(FK)',
  `amount` int(10) unsigned DEFAULT NULL COMMENT '견적 금액',
  `qty` int(10) DEFAULT NULL COMMENT '견적 수량',
  `type_code` char(1) DEFAULT NULL COMMENT 'N:대량견적(일반상품), E:견적요청(견적상품)',
  `status_code` char(1) DEFAULT NULL COMMENT '1:요청 접수, 2:견적 완료, 3:주문 완료',
  `request` varchar(300) DEFAULT NULL COMMENT '기타 요청사항',
  `mod_date` datetime DEFAULT NULL COMMENT '수정일자',
  `reg_date` datetime NOT NULL COMMENT '등록일자',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_estimate` (`member_seq`),
  KEY `fk2_sm_estimate` (`item_seq`),
  KEY `fk3_sm_estimate` (`option_value_seq`),
  KEY `fk4_sm_estimate` (`order_detail_seq`),
  CONSTRAINT `fk1_sm_estimate` FOREIGN KEY (`member_seq`) REFERENCES `sm_member` (`seq`) ON DELETE SET NULL,
  CONSTRAINT `fk2_sm_estimate` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE SET NULL,
  CONSTRAINT `fk3_sm_estimate` FOREIGN KEY (`option_value_seq`) REFERENCES `sm_item_option_value` (`seq`) ON DELETE SET NULL,
  CONSTRAINT `fk4_sm_estimate` FOREIGN KEY (`order_detail_seq`) REFERENCES `sm_order_detail` (`seq`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='견적';

LOCK TABLES `sm_estimate` WRITE;
/*!40000 ALTER TABLE `sm_estimate` DISABLE KEYS */;

INSERT INTO `sm_estimate` (`seq`, `member_seq`, `item_seq`, `option_value_seq`, `order_detail_seq`, `amount`, `qty`, `type_code`, `status_code`, `request`, `mod_date`, `reg_date`)
VALUES
	(5,NULL,NULL,NULL,NULL,NULL,1000,'N','1','견적요청 테스트',NULL,'2015-12-05 11:06:57'),
	(6,NULL,NULL,NULL,NULL,5000,10,'N','3','테스트 견적요청',NULL,'2015-12-06 12:14:06'),
	(7,NULL,NULL,NULL,NULL,6000,10,'N','2','테스트 주문',NULL,'2015-12-06 12:18:30'),
	(8,NULL,NULL,NULL,NULL,1000,10,'E','3','견적테스트입니다',NULL,'2015-12-06 12:23:29'),
	(9,NULL,NULL,NULL,NULL,15000,13,'E','2','테스트','2016-03-25 17:40:17','2015-12-06 12:28:22'),
	(10,NULL,NULL,NULL,NULL,5000,10,'E','3','테스트',NULL,'2015-12-06 12:29:30'),
	(11,NULL,NULL,NULL,NULL,100000,1200,'N','3','test',NULL,'2016-01-18 16:53:02'),
	(12,NULL,NULL,NULL,NULL,10000,5,'E','3','테스트','2016-03-09 17:17:06','2016-02-03 11:30:25'),
	(14,NULL,NULL,NULL,NULL,NULL,74,'E','9','','2016-03-14 17:48:28','2016-02-17 13:38:25'),
	(16,NULL,NULL,NULL,NULL,100000,1000,'N','2','안ㄴㄴㄴ','2016-03-28 17:56:23','2016-02-19 17:53:51'),
	(17,NULL,NULL,NULL,NULL,20000,10,'N','3','테스트 입니다.',NULL,'2016-03-08 13:55:51'),
	(20,NULL,NULL,NULL,NULL,20000,10,'E','3','얼마에요? 네?\r\n\r\n네?','2016-03-28 17:21:04','2016-03-09 17:27:16'),
	(23,NULL,NULL,NULL,NULL,NULL,10,'N','1','테스트',NULL,'2016-04-12 17:14:12'),
	(24,NULL,NULL,NULL,NULL,NULL,20,'N','1','테스트',NULL,'2016-04-12 17:15:21'),
	(25,NULL,NULL,NULL,NULL,NULL,30,'N','1','테스트',NULL,'2016-04-12 17:15:51'),
	(26,NULL,NULL,NULL,NULL,NULL,40,'N','1','얼마에요? 네?',NULL,'2016-04-12 17:17:07'),
	(27,NULL,NULL,NULL,NULL,NULL,40,'N','1','테스트',NULL,'2016-04-12 17:18:10'),
	(28,NULL,NULL,NULL,NULL,NULL,50,'N','1','테스트',NULL,'2016-04-12 17:18:30');

/*!40000 ALTER TABLE `sm_estimate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_estimate_compare
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_estimate_compare`;

CREATE TABLE `sm_estimate_compare` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(고유번호)',
  `order_seq` int(10) unsigned DEFAULT NULL COMMENT '상품주문번호 시퀀스(FK)',
  `seller_seq` int(11) unsigned DEFAULT NULL COMMENT '판매자시퀀스(FK)',
  `file` varchar(100) DEFAULT NULL COMMENT '첨부 파일_URL',
  `file_name` varchar(300) DEFAULT NULL COMMENT '파일명',
  `mod_date` datetime DEFAULT NULL COMMENT '수정(업로드)일자',
  `reg_date` datetime NOT NULL COMMENT '등록(신청)일자',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_estimate_compare` (`order_seq`),
  KEY `fk2_sm_estimate_compare` (`seller_seq`),
  CONSTRAINT `fk1_sm_estimate_compare` FOREIGN KEY (`order_seq`) REFERENCES `sm_order` (`seq`) ON DELETE SET NULL,
  CONSTRAINT `fk2_sm_estimate_compare` FOREIGN KEY (`seller_seq`) REFERENCES `sm_seller` (`seq`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='비교 견적';

LOCK TABLES `sm_estimate_compare` WRITE;
/*!40000 ALTER TABLE `sm_estimate_compare` DISABLE KEYS */;

INSERT INTO `sm_estimate_compare` (`seq`, `order_seq`, `seller_seq`, `file`, `file_name`, `mod_date`, `reg_date`)
VALUES
	(34,NULL,NULL,'/estimate/compare/34.jpg',NULL,NULL,'2015-12-05 11:26:38'),
	(37,NULL,NULL,'/estimate/compare/37.jpg',NULL,NULL,'2015-12-10 10:32:36'),
	(38,NULL,NULL,'/estimate/compare/38.jpg',NULL,NULL,'2016-01-13 10:13:17'),
	(39,NULL,NULL,'/estimate/compare/39.jpg',NULL,NULL,'2016-01-19 14:03:33'),
	(50,NULL,NULL,'/estimate/compare/1000/50.jpg','Chrysanthemum.jpg',NULL,'2016-04-18 10:18:02');

/*!40000 ALTER TABLE `sm_estimate_compare` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_estimate_compare_seq
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_estimate_compare_seq`;

CREATE TABLE `sm_estimate_compare_seq` (
  `seq` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='비교 견적 시퀀스 테이블';

LOCK TABLES `sm_estimate_compare_seq` WRITE;
/*!40000 ALTER TABLE `sm_estimate_compare_seq` DISABLE KEYS */;

INSERT INTO `sm_estimate_compare_seq` (`seq`)
VALUES
	(51);

/*!40000 ALTER TABLE `sm_estimate_compare_seq` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_event`;

CREATE TABLE `sm_event` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `mall_seq` int(11) unsigned NOT NULL COMMENT '몰시퀀스',
  `type_code` char(1) NOT NULL COMMENT '구분 (1:기획전, 2:이벤트)',
  `status_code` char(1) NOT NULL COMMENT '상태코드 (H:대기, Y:진행, N:종료)',
  `title` varchar(200) DEFAULT NULL COMMENT '기획전/이벤트 명',
  `html` text COMMENT '상단 배너영역 HTML',
  `thumb_img` varchar(200) DEFAULT NULL COMMENT '리스트페이지용 배너 URL',
  `lv1_seq` int(11) unsigned DEFAULT NULL COMMENT '대분류 카테고리 시퀀스',
  `coupon_seq` int(11) unsigned DEFAULT NULL COMMENT '자동발행 쿠폰 번호',
  `show_flag` char(1) DEFAULT 'N' COMMENT '노출 여부 (Y:노출, N:노출안함)',
  `main_section` char(1) DEFAULT NULL COMMENT '배너영역 구분코드(메인 A,B,C,D,E,F,G,H 영역별로 구별)',
  `end_date` varchar(10) DEFAULT NULL COMMENT '기획전 종료예정일',
  `reg_date` datetime DEFAULT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_event` (`mall_seq`),
  CONSTRAINT `fk1_sm_event` FOREIGN KEY (`mall_seq`) REFERENCES `sm_event` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기획전/이벤트 메인';

LOCK TABLES `sm_event` WRITE;
/*!40000 ALTER TABLE `sm_event` DISABLE KEYS */;

INSERT INTO `sm_event` (`seq`, `mall_seq`, `type_code`, `status_code`, `title`, `html`, `thumb_img`, `lv1_seq`, `coupon_seq`, `show_flag`, `main_section`, `end_date`, `reg_date`)
VALUES
	(1,1,'1','Y','오늘만 이가격','<p>111내용이 들어갑니다!!!111</p>\r\n\r\n<p>1111</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>내용을 이렇게 넣었습니다.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img alt=\"\" src=\"http://kookje.gogosoft.kr/upload/editor/event/1000/1_1.jpg\" style=\"width: 607px; height: 810px;\" /></p>\r\n\r\n<p>포스란 이런 것이다.</p>\r\n','',3,NULL,'Y','','20170101','2015-11-24 17:15:17');

/*!40000 ALTER TABLE `sm_event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_event_comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_event_comment`;

CREATE TABLE `sm_event_comment` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '게시글 시퀀스',
  `user_seq` int(11) unsigned NOT NULL COMMENT '작성자 시퀀스',
  `event_seq` int(11) unsigned NOT NULL COMMENT '기획전 시퀀스',
  `content` text COMMENT '답글 내용',
  `mod_date` datetime DEFAULT NULL COMMENT '답글 수정 날짜',
  `reg_date` datetime NOT NULL COMMENT '답글 등록 날짜',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_event_comment` (`user_seq`),
  KEY `fk2_sm_event_comment` (`event_seq`),
  CONSTRAINT `fk1_sm_event_comment` FOREIGN KEY (`user_seq`) REFERENCES `sm_user` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_event_comment` FOREIGN KEY (`event_seq`) REFERENCES `sm_event` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기획전 답글';



# Dump of table sm_event_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_event_group`;

CREATE TABLE `sm_event_group` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `mall_seq` int(11) unsigned NOT NULL COMMENT '몰시퀀스',
  `event_seq` int(11) unsigned NOT NULL COMMENT '기획전 시퀀스 (FK:sm_event)',
  `group_name` varchar(200) NOT NULL COMMENT '상품 그룹명',
  `order_no` int(11) NOT NULL COMMENT '정렬 순서',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_event_parent` (`event_seq`),
  CONSTRAINT `fk1_sm_event_parent` FOREIGN KEY (`event_seq`) REFERENCES `sm_event` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기획전 상품 그룹';

LOCK TABLES `sm_event_group` WRITE;
/*!40000 ALTER TABLE `sm_event_group` DISABLE KEYS */;

INSERT INTO `sm_event_group` (`seq`, `mall_seq`, `event_seq`, `group_name`, `order_no`)
VALUES
	(17,1,1,'테스트1',1),
	(18,1,1,'테스트2',2);

/*!40000 ALTER TABLE `sm_event_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_event_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_event_item`;

CREATE TABLE `sm_event_item` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `group_seq` int(11) unsigned NOT NULL COMMENT '기획전 그룹 시퀀스 (FK:sm_event_group)',
  `item_seq` int(11) unsigned NOT NULL COMMENT '상품 시퀀스 (FK:sm_item)',
  `order_no` int(11) NOT NULL COMMENT '정렬 순서',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_event_item` (`group_seq`),
  KEY `fk2_sm_event_item` (`item_seq`),
  CONSTRAINT `fk1_sm_event_item` FOREIGN KEY (`group_seq`) REFERENCES `sm_event_group` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_event_item` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기획전 상품 리스트';

LOCK TABLES `sm_event_item` WRITE;
/*!40000 ALTER TABLE `sm_event_item` DISABLE KEYS */;

INSERT INTO `sm_event_item` (`seq`, `group_seq`, `item_seq`, `order_no`)
VALUES
	(1,17,1,1);

/*!40000 ALTER TABLE `sm_event_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_event_seq
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_event_seq`;

CREATE TABLE `sm_event_seq` (
  `seq` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='게시판 시퀀스 테이블';

LOCK TABLES `sm_event_seq` WRITE;
/*!40000 ALTER TABLE `sm_event_seq` DISABLE KEYS */;

INSERT INTO `sm_event_seq` (`seq`)
VALUES
	(8);

/*!40000 ALTER TABLE `sm_event_seq` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_festival
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_festival`;

CREATE TABLE `sm_festival` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스 PK',
  `title` varchar(100) NOT NULL COMMENT '제목',
  `content` text NOT NULL COMMENT '내용',
  `start_date` char(10) NOT NULL COMMENT '신청 기간(시작일자)',
  `end_date` char(10) NOT NULL COMMENT '신청 기간(종료일자)',
  `mod_date` datetime DEFAULT NULL COMMENT '최근 수정 일자',
  `reg_date` datetime NOT NULL COMMENT '등록 일자',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_festival` (`start_date`,`end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='행사 테이블';

LOCK TABLES `sm_festival` WRITE;
/*!40000 ALTER TABLE `sm_festival` DISABLE KEYS */;

INSERT INTO `sm_festival` (`seq`, `title`, `content`, `start_date`, `end_date`, `mod_date`, `reg_date`)
VALUES
	(19,'행사 등록 테스트','&lt;p&gt;테스트&lt;/p&gt;','2016-03-01','2016-03-31',NULL,'2016-03-08 17:52:29');

/*!40000 ALTER TABLE `sm_festival` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_festival_seller
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_festival_seller`;

CREATE TABLE `sm_festival_seller` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스 PK',
  `festival_seq` int(10) unsigned NOT NULL COMMENT '행사 seq(FK)',
  `seller_seq` int(10) unsigned NOT NULL COMMENT '입점업체 seq(FK)',
  `content` varchar(1000) DEFAULT NULL COMMENT '신청 내용',
  `mod_date` datetime DEFAULT NULL COMMENT '최근 수정 일자',
  `reg_date` datetime NOT NULL COMMENT '신청 일자',
  PRIMARY KEY (`seq`),
  UNIQUE KEY `uk1_sm_festival_seller` (`festival_seq`,`seller_seq`),
  KEY `fk2_sm_festival_seller` (`seller_seq`),
  CONSTRAINT `fk1_sm_festival_seller` FOREIGN KEY (`festival_seq`) REFERENCES `sm_festival` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_festival_seller` FOREIGN KEY (`seller_seq`) REFERENCES `sm_seller` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='행사 참여 테이블';



# Dump of table sm_festival_seq
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_festival_seq`;

CREATE TABLE `sm_festival_seq` (
  `seq` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='행사 시퀀스 테이블';

LOCK TABLES `sm_festival_seq` WRITE;
/*!40000 ALTER TABLE `sm_festival_seq` DISABLE KEYS */;

INSERT INTO `sm_festival_seq` (`seq`)
VALUES
	(20);

/*!40000 ALTER TABLE `sm_festival_seq` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_filename
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_filename`;

CREATE TABLE `sm_filename` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `parent_code` varchar(20) NOT NULL COMMENT '유형코드 (itemRequest=상품등록요청, seller=입점신청(판매자등록))',
  `parent_seq` int(11) unsigned NOT NULL COMMENT '부모 시퀀스',
  `num` int(11) NOT NULL COMMENT '파일 번호',
  `filename` varchar(250) NOT NULL DEFAULT '' COMMENT '첨부 파일명 (논리)',
  `real_filename` varchar(250) NOT NULL DEFAULT '' COMMENT '첨부 파일명 (물리)',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  UNIQUE KEY `code` (`parent_code`,`parent_seq`,`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='첨부파일 (itemRequest, seller)';



# Dump of table sm_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item`;

CREATE TABLE `sm_item` (
  `seq` int(11) unsigned NOT NULL COMMENT '시퀀스',
  `cate_lv1_seq` int(11) unsigned DEFAULT NULL COMMENT '대분류카테고리 시퀀스',
  `cate_lv2_seq` int(11) unsigned DEFAULT NULL COMMENT '중분류카테고리 시퀀스',
  `cate_lv3_seq` int(11) unsigned DEFAULT NULL COMMENT '소분류카테고리 시퀀스',
  `cate_lv4_seq` int(11) unsigned DEFAULT NULL COMMENT '세분류카테고리 시퀀스',
  `name` varchar(300) NOT NULL COMMENT '상품명',
  `type_code` char(1) NOT NULL DEFAULT 'N' COMMENT '상품타입(N:일반상품, C:쿠폰상품, E:견적상품)',
  `status_code` char(1) NOT NULL DEFAULT 'H' COMMENT '상태플래그(H=가승인, Y=판매중, N=판매중지)',
  `sell_price` int(11) NOT NULL COMMENT '판매가',
  `supply_master_price` int(11) DEFAULT NULL COMMENT '총판 공급가',
  `supply_price` int(11) DEFAULT NULL COMMENT '판매자 공급가',
  `market_price` int(11) DEFAULT NULL COMMENT '시중가',
  `maker` varchar(100) DEFAULT NULL COMMENT '제조사',
  `origin_country` varchar(100) DEFAULT NULL COMMENT '원산지',
  `seller_seq` int(11) unsigned DEFAULT NULL COMMENT '판매자 시퀀스',
  `seller_item_code` varchar(20) DEFAULT NULL COMMENT '판매자 상품 코드',
  `brand` varchar(150) DEFAULT NULL COMMENT '브랜드',
  `model_name` varchar(200) DEFAULT NULL COMMENT '모델명',
  `make_date` char(8) DEFAULT NULL COMMENT '제조일자',
  `expire_date` char(8) DEFAULT NULL COMMENT '유효일자',
  `adult_flag` char(1) NOT NULL COMMENT '성인 여부 (Y=성인만이용가능, N=모두이용가능)',
  `img1` varchar(100) DEFAULT NULL COMMENT '대표이미지',
  `img2` varchar(100) DEFAULT NULL COMMENT '서브이미지',
  `img3` varchar(100) DEFAULT NULL COMMENT '서브이미지',
  `img4` varchar(100) DEFAULT NULL COMMENT '서브이미지',
  `tax_code` char(1) NOT NULL COMMENT '과세여부 (1=과세, 2=면세, 3=영세)',
  `deli_type_code` char(2) NOT NULL COMMENT '배송비 구분(00:무료배송, 10:착불)',
  `deli_cost` int(11) NOT NULL DEFAULT '0' COMMENT '배송비',
  `deli_free_amount` int(11) NOT NULL DEFAULT '0' COMMENT '무료배송 조건부 금액',
  `deli_prepaid_flag` char(1) DEFAULT NULL COMMENT '선결제 구분(null:착불/선결제 선택가능, Y:선결제 필수, N:선결제 불가)',
  `deli_package_flag` char(1) NOT NULL COMMENT '상품 묶음배송 가능 여부 플래그(Y=가능, N=불가능)',
  `type_cd` int(11) DEFAULT NULL COMMENT '상품 부가정보 분류 코드',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `min_cnt` int(11) DEFAULT '1' COMMENT '최소구매수량',
  `max_cnt` int(11) DEFAULT NULL COMMENT '최대구매수량',
  `auth_category` varchar(50) DEFAULT NULL,
  `old_deli_cost` int(11) NOT NULL DEFAULT '0' COMMENT '국제몰 배송비 백업',
  `img_banner_code` varchar(20) DEFAULT NULL COMMENT '상품이미지내 이벤트 배너 전시 코드값(01:세일,02:특가,03:한정수량,04:행사)',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_item` (`cate_lv1_seq`,`cate_lv2_seq`,`cate_lv3_seq`,`cate_lv4_seq`),
  KEY `idx2_sm_item` (`status_code`),
  KEY `idx3_sm_item` (`seller_seq`),
  KEY `fk2_sm_item` (`cate_lv2_seq`),
  KEY `fk3_sm_item` (`cate_lv3_seq`),
  KEY `fk4_sm_item` (`cate_lv4_seq`),
  CONSTRAINT `fk1_sm_item` FOREIGN KEY (`cate_lv1_seq`) REFERENCES `sm_item_category` (`seq`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk2_sm_item` FOREIGN KEY (`cate_lv2_seq`) REFERENCES `sm_item_category` (`seq`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk3_sm_item` FOREIGN KEY (`cate_lv3_seq`) REFERENCES `sm_item_category` (`seq`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk4_sm_item` FOREIGN KEY (`cate_lv4_seq`) REFERENCES `sm_item_category` (`seq`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk5_sm_item` FOREIGN KEY (`seller_seq`) REFERENCES `sm_seller` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품';

LOCK TABLES `sm_item` WRITE;
/*!40000 ALTER TABLE `sm_item` DISABLE KEYS */;

INSERT INTO `sm_item` (`seq`, `cate_lv1_seq`, `cate_lv2_seq`, `cate_lv3_seq`, `cate_lv4_seq`, `name`, `type_code`, `status_code`, `sell_price`, `supply_master_price`, `supply_price`, `market_price`, `maker`, `origin_country`, `seller_seq`, `seller_item_code`, `brand`, `model_name`, `make_date`, `expire_date`, `adult_flag`, `img1`, `img2`, `img3`, `img4`, `tax_code`, `deli_type_code`, `deli_cost`, `deli_free_amount`, `deli_prepaid_flag`, `deli_package_flag`, `type_cd`, `mod_date`, `reg_date`, `min_cnt`, `max_cnt`, `auth_category`, `old_deli_cost`, `img_banner_code`)
VALUES
	(1,1,9,NULL,NULL,'테스트상품','N','Y',50000,NULL,0,60000,'제조사','원산지',3,'','브랜드','모델명','20160514','20160515','N','/item/origin/1000/1/1.jpg','','','','2','00',0,0,'','Y',1,'2016-05-14 17:39:09','2016-05-14 17:38:07',1,NULL,'99',0,'01'),
	(2,1,10,NULL,NULL,'두번째상품 테스트','N','Y',10000,0,0,0,'테스트판매자','',3,'123','','','','','N','/item/origin/1000/1/2.jpg','/item/origin/1000/2/2.jpg','','','1','00',0,0,'','Y',1,'2016-05-16 02:30:24','2016-05-16 02:28:49',0,NULL,'99',0,'02');

/*!40000 ALTER TABLE `sm_item` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_add_info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_add_info`;

CREATE TABLE `sm_item_add_info` (
  `item_seq` int(11) unsigned NOT NULL COMMENT '아이템 시퀀스(fk)',
  `prop_val1` varchar(255) DEFAULT NULL COMMENT '속성값1',
  `prop_val2` varchar(255) DEFAULT NULL COMMENT '속성값2',
  `prop_val3` varchar(255) DEFAULT NULL COMMENT '속성값3',
  `prop_val4` varchar(255) DEFAULT NULL COMMENT '속성값4',
  `prop_val5` varchar(255) DEFAULT NULL COMMENT '속성값5',
  `prop_val6` varchar(255) DEFAULT NULL COMMENT '속성값6',
  `prop_val7` varchar(255) DEFAULT NULL COMMENT '속성값7',
  `prop_val8` varchar(255) DEFAULT NULL COMMENT '속성값8',
  `prop_val9` varchar(255) DEFAULT NULL COMMENT '속성값9',
  `prop_val10` varchar(255) DEFAULT NULL COMMENT '속성값10',
  `prop_val11` varchar(255) DEFAULT NULL COMMENT '속성값11',
  `prop_val12` varchar(255) DEFAULT NULL COMMENT '속성값12',
  `prop_val13` varchar(255) DEFAULT NULL COMMENT '속성값13',
  `prop_val14` varchar(255) DEFAULT NULL COMMENT '속성값14',
  `prop_val15` varchar(255) DEFAULT NULL COMMENT '속성값15',
  `prop_val16` varchar(255) DEFAULT NULL COMMENT '속성값16',
  `prop_val17` varchar(255) DEFAULT NULL COMMENT '속성값17',
  `prop_val18` varchar(255) DEFAULT NULL COMMENT '속성값18',
  `prop_val19` varchar(255) DEFAULT NULL COMMENT '속성값19',
  `prop_val20` varchar(255) DEFAULT NULL COMMENT '속성값20',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`item_seq`),
  CONSTRAINT `fk1_sm_item_add_item` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 고시 추가 정보';

LOCK TABLES `sm_item_add_info` WRITE;
/*!40000 ALTER TABLE `sm_item_add_info` DISABLE KEYS */;

INSERT INTO `sm_item_add_info` (`item_seq`, `prop_val1`, `prop_val2`, `prop_val3`, `prop_val4`, `prop_val5`, `prop_val6`, `prop_val7`, `prop_val8`, `prop_val9`, `prop_val10`, `prop_val11`, `prop_val12`, `prop_val13`, `prop_val14`, `prop_val15`, `prop_val16`, `prop_val17`, `prop_val18`, `prop_val19`, `prop_val20`, `reg_date`)
VALUES
	(1,'상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','제품 상세 설명내 표기 ','N','N','','','','','','','','','','2016-05-14 17:38:08'),
	(2,'상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','상세정보 별도표기','제품 상세 설명내 표기 ','N','N','','','','','','','','','','2016-05-16 02:28:49');

/*!40000 ALTER TABLE `sm_item_add_info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_category`;

CREATE TABLE `sm_item_category` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `parent_seq` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '부모 시퀀스(없으면 0)',
  `depth` int(11) NOT NULL DEFAULT '0' COMMENT '깊이(0부터 시작함)',
  `cate_name` varchar(50) NOT NULL COMMENT '카테고리명',
  `show_flag` char(1) NOT NULL DEFAULT 'Y' COMMENT '노출 플래그(Y=보기 N=비노출)',
  `order_no` int(11) DEFAULT '0' COMMENT '정렬순서',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='카테고리';

LOCK TABLES `sm_item_category` WRITE;
/*!40000 ALTER TABLE `sm_item_category` DISABLE KEYS */;

INSERT INTO `sm_item_category` (`seq`, `parent_seq`, `depth`, `cate_name`, `show_flag`, `order_no`, `mod_date`, `reg_date`)
VALUES
	(1,0,1,'의료소모품','Y',0,'2016-04-28 22:47:20','2016-04-28 22:47:10'),
	(2,0,1,'의료기기','Y',1,'2016-04-28 22:47:20','2016-04-28 22:47:17'),
	(3,0,1,'수술기구','Y',2,'2016-04-28 22:47:39','2016-04-28 22:47:39'),
	(4,0,1,'전산소모품','Y',3,'2016-04-28 22:47:45','2016-04-28 22:47:45'),
	(5,0,1,'건강기능식품','Y',4,'2016-04-28 22:47:54','2016-04-28 22:47:54'),
	(6,0,1,'생활가전','Y',5,'2016-04-28 22:48:02','2016-04-28 22:48:02'),
	(7,0,1,'사무용품','Y',6,'2016-04-28 22:48:16','2016-04-28 22:48:16'),
	(8,0,1,'진료과별','Y',7,'2016-04-28 22:48:21','2016-04-28 22:48:21'),
	(9,1,2,'의료기기1','Y',0,'2016-04-28 22:50:46','2016-04-28 22:50:43'),
	(10,1,2,'의료기기2','Y',1,'2016-04-28 22:50:50','2016-04-28 22:50:50'),
	(11,2,2,'가정용의료기','Y',0,'2016-04-28 22:51:03','2016-04-28 22:51:03'),
	(12,2,2,'실버보조기','Y',1,'2016-04-28 22:51:08','2016-04-28 22:51:08'),
	(13,2,2,'의료장비','Y',2,'2016-04-28 22:52:11','2016-04-28 22:52:11'),
	(14,2,2,'철재/운반기구','Y',3,'2016-04-28 22:52:16','2016-04-28 22:52:16'),
	(15,2,2,'소독제','Y',4,'2016-04-28 22:52:20','2016-04-28 22:52:20'),
	(16,2,2,'기타','Y',5,'2016-04-28 22:52:22','2016-04-28 22:52:22'),
	(17,3,2,'ENT기구류','Y',0,'2016-04-28 22:52:31','2016-04-28 22:52:31'),
	(18,3,2,'Handle','Y',1,'2016-04-28 22:52:38','2016-04-28 22:52:38'),
	(19,3,2,'Hooks','Y',2,'2016-04-28 22:52:43','2016-04-28 22:52:43'),
	(20,3,2,'Retractors','Y',3,'2016-04-28 22:52:49','2016-04-28 22:52:49'),
	(21,3,2,'Scissors','Y',4,'2016-04-28 22:52:55','2016-04-28 22:52:55'),
	(22,3,2,'산부인과기구류','Y',5,'2016-04-28 22:53:03','2016-04-28 22:53:03'),
	(23,3,2,'안과기구류','Y',6,'2016-04-28 22:53:09','2016-04-28 22:53:09'),
	(24,3,2,'외과기구류','Y',7,'2016-04-28 22:53:14','2016-04-28 22:53:14'),
	(25,3,2,'이비인후과기구류','Y',8,'2016-04-28 22:53:20','2016-04-28 22:53:20'),
	(26,3,2,'치과기구류','Y',9,'2016-04-28 22:53:26','2016-04-28 22:53:26'),
	(27,3,2,'피부과기구류','Y',10,'2016-04-28 22:53:32','2016-04-28 22:53:32'),
	(28,4,2,'전산용지','Y',0,'2016-04-28 22:53:39','2016-04-28 22:53:39'),
	(29,4,2,'카트리지','Y',1,'2016-04-28 22:53:46','2016-04-28 22:53:46'),
	(30,4,2,'프린터 토너','Y',2,'2016-04-28 22:53:51','2016-04-28 22:53:51'),
	(31,4,2,'전자/사무/생활','Y',3,'2016-04-28 22:53:56','2016-04-28 22:53:56'),
	(32,4,2,'판촉물','Y',4,'2016-04-28 22:53:58','2016-04-28 22:53:58'),
	(33,4,2,'세트/번들상품','Y',5,'2016-04-28 22:54:03','2016-04-28 22:54:03'),
	(34,4,2,'컴퓨터/주변기기','Y',6,'2016-04-28 22:54:09','2016-04-28 22:54:09'),
	(35,4,2,'카렌다','Y',7,'2016-04-28 22:54:11','2016-04-28 22:54:11'),
	(36,4,2,'기획상품','Y',8,'2016-04-28 22:54:15','2016-04-28 22:54:15'),
	(37,4,2,'처방전','Y',9,'2016-04-28 22:54:19','2016-04-28 22:54:19'),
	(38,4,2,'소프트웨어','Y',10,'2016-04-28 22:54:22','2016-04-28 22:54:22'),
	(39,4,2,'노트북','Y',11,'2016-04-28 22:54:25','2016-04-28 22:54:25'),
	(40,5,2,'건강식품1','Y',0,'2016-04-28 22:54:31','2016-04-28 22:54:31'),
	(41,5,2,'건강식품2','Y',1,'2016-04-28 22:54:35','2016-04-28 22:54:35'),
	(42,6,2,'생활가전1','Y',0,'2016-04-28 22:54:42','2016-04-28 22:54:42'),
	(43,6,2,'생활가전2','Y',1,'2016-04-28 22:54:46','2016-04-28 22:54:46'),
	(44,7,2,'사무기기','Y',0,'2016-04-28 22:54:59','2016-04-28 22:54:59'),
	(45,7,2,'사무용품','Y',1,'2016-04-28 22:55:02','2016-04-28 22:55:02'),
	(46,7,2,'생활가전','Y',2,'2016-04-28 22:55:05','2016-04-28 22:55:05'),
	(47,7,2,'생활용품','Y',3,'2016-04-28 22:55:09','2016-04-28 22:55:09'),
	(48,7,2,'지류/용지','Y',4,'2016-04-28 22:55:12','2016-04-28 22:55:12'),
	(49,7,2,'PC주변기기','Y',5,'2016-04-28 22:55:16','2016-04-28 22:55:16'),
	(50,7,2,'파일/바인더','Y',6,'2016-04-28 22:55:20','2016-04-28 22:55:20'),
	(51,7,2,'필기류','Y',7,'2016-04-28 22:55:22','2016-04-28 22:55:22'),
	(52,7,2,'식음료','Y',8,'2016-04-28 22:55:26','2016-04-28 22:55:26'),
	(53,7,2,'여가용품','Y',9,'2016-04-28 22:55:29','2016-04-28 22:55:29'),
	(54,8,2,'내과','Y',0,'2016-04-28 22:55:34','2016-04-28 22:55:34'),
	(55,8,2,'외과','Y',1,'2016-04-28 22:55:36','2016-04-28 22:55:36'),
	(56,8,2,'산부인과','Y',2,'2016-04-28 22:55:39','2016-04-28 22:55:39'),
	(57,8,2,'재활병원','Y',3,'2016-04-28 22:55:42','2016-04-28 22:55:42'),
	(58,8,2,'피부과','Y',4,'2016-04-28 22:55:44','2016-04-28 22:55:44'),
	(59,8,2,'한방병원','Y',5,'2016-04-28 22:55:47','2016-04-28 22:55:47'),
	(60,8,2,'동물병원','Y',6,'2016-04-28 22:55:52','2016-04-28 22:55:52'),
	(61,8,2,'기타','Y',7,'2016-04-28 22:55:54','2016-04-28 22:55:54');

/*!40000 ALTER TABLE `sm_item_category` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_detail`;

CREATE TABLE `sm_item_detail` (
  `item_seq` int(11) unsigned NOT NULL COMMENT '상품 시퀀스(pk/fk)',
  `content` text COMMENT '내용',
  `as_flag` char(1) NOT NULL COMMENT 'A/S 가능여부(Y=가능 N=불가능)',
  `as_tel` varchar(100) DEFAULT NULL COMMENT 'A/S 전화번호',
  `as_content` text COMMENT 'A/S 내용',
  `detail1_img` varchar(120) DEFAULT NULL COMMENT '상세 이미지1',
  `detail2_img` varchar(120) DEFAULT NULL COMMENT '상세 이미지2',
  `detail3_img` varchar(120) DEFAULT NULL COMMENT '상세 이미지3',
  `use_code` char(1) NOT NULL DEFAULT 'C' COMMENT '사용 코드(C=컨텐츠 I=이미지)',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `detail1_alt` varchar(120) DEFAULT NULL,
  `detail2_alt` varchar(120) DEFAULT NULL,
  `detail3_alt` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`item_seq`),
  CONSTRAINT `fk1_sm_item_detail` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 상세';

LOCK TABLES `sm_item_detail` WRITE;
/*!40000 ALTER TABLE `sm_item_detail` DISABLE KEYS */;

INSERT INTO `sm_item_detail` (`item_seq`, `content`, `as_flag`, `as_tel`, `as_content`, `detail1_img`, `detail2_img`, `detail3_img`, `use_code`, `mod_date`, `reg_date`, `detail1_alt`, `detail2_alt`, `detail3_alt`)
VALUES
	(1,'<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n','Y','','','','','','C','2016-05-14 17:38:07','2016-05-14 17:38:07','','',''),
	(2,'<p>상품 등록 하는 테스트 화면 입니다.</p>','N','--','','','','','C','2016-05-16 02:30:24','2016-05-16 02:28:49','','','');

/*!40000 ALTER TABLE `sm_item_detail` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_filter_word
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_filter_word`;

CREATE TABLE `sm_item_filter_word` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `filter_word` varchar(100) NOT NULL COMMENT '금지어',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 금지어';

LOCK TABLES `sm_item_filter_word` WRITE;
/*!40000 ALTER TABLE `sm_item_filter_word` DISABLE KEYS */;

INSERT INTO `sm_item_filter_word` (`seq`, `filter_word`, `reg_date`)
VALUES
	(1,'script','2015-11-23 15:21:40');

/*!40000 ALTER TABLE `sm_item_filter_word` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_log`;

CREATE TABLE `sm_item_log` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `item_seq` int(11) unsigned NOT NULL COMMENT '상품 시퀀스',
  `action` varchar(800) DEFAULT NULL COMMENT '액션 (등록/수정/삭제)',
  `content` text COMMENT '내용',
  `login_seq` int(11) unsigned NOT NULL COMMENT '로그인 시퀀스',
  `login_type` char(1) NOT NULL COMMENT '로그인 타입 (A/S/D)',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `mod_content` text COMMENT '수정내용',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 로그';

LOCK TABLES `sm_item_log` WRITE;
/*!40000 ALTER TABLE `sm_item_log` DISABLE KEYS */;

INSERT INTO `sm_item_log` (`seq`, `item_seq`, `action`, `content`, `login_seq`, `login_type`, `reg_date`, `mod_content`)
VALUES
	(1,1,'등록','ItemVo [rankNumber=0, seq=1, name=테스트상품, nickname=, statusCode=H, statusName=, sellPrice=50000, tempSellPrice=0, supplyMasterPrice=0, supplyPrice=0, salesTel=, marketPrice=60000, maker=제조사, originCountry=원산지, sellerSeq=3, sellerId=, sellerItemCode=, cateLv1Seq=1, cateLv2Seq=9, cateLv3Seq=null, cateLv4Seq=null, brand=브랜드, modelName=모델명, makeDate=20160514, expireDate=20160515, adultFlag=N, img1=/item/origin/1000/1/1.jpg, img2=, img3=, img4=, taxCode=2, modDate=, regDate=, minCnt=0, maxCnt=0, showFlag=, itemSeq=null, content=<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n\r\n<p>상세정보가 들어갑니다</p>\r\n, asFlag=Y, asTel=, asTel1=, asTel2=, asTel3=, asContent=, detailImg1=, detailImg2=, detailImg3=, detailAlt1=, detailAlt2=, detailAlt3=, useCode=C, memberSeq=null, wishSeq=0, optionSeq=null, optionValueSeq=null, optionName=, valueName=, optionValues=, optionPrice=0, optionPrices=, count=0, optionCount=null, directFlag=, stockCount=0, stockCounts=, reviewGrade=0, reviewCount=0, itemGrade=0, deliveryGrade=0, sellerName=, jachiguCode=, masterSeq=null, masterName=, cateLv1Name=, cateLv2Name=, cateLv3Name=, cateLv4Name=, soldOutFlag=, optionList=null, updateType=, cartSeqs=, notLoginKey=, startPrice=0, endPrice=0, deliTypeCode=00, deliCost=0, deliFreeAmount=0, deliPrepaidFlag=, deliPackageFlag=Y, packageDeliCost=0, typeCode=N, returnName=, returnCell=, modContent=, column=, typeCd=1, typeNm=, itemSearchType=, itemSearchValue=, sellerSearchType=, sellerSearchValue=, orderType=, authCategory=99imgBannerCode=01]',2,'A','2016-05-14 17:38:07',''),
	(2,1,'옵션등록','ItemOptionVo [seq=1, itemSeq=1, optionName=옵션, showFlag=Y, modDate=, regDate=, optionSeq=null, valueName=, stockCount=0, stockFlag=Y, optionPrice=0, valueList=null, count=0, modContent=, column=]',2,'A','2016-05-14 17:38:08',''),
	(3,1,'옵션항목등록','ItemOptionVo [seq=0, itemSeq=0, optionName=, showFlag=, modDate=, regDate=, optionSeq=1, valueName=기본1, stockCount=999, stockFlag=Y, optionPrice=0, valueList=null, count=0, modContent=, column=]',2,'A','2016-05-14 17:38:08',''),
	(4,1,'옵션항목등록','ItemOptionVo [seq=0, itemSeq=0, optionName=, showFlag=, modDate=, regDate=, optionSeq=1, valueName=기본2, stockCount=999, stockFlag=Y, optionPrice=500, valueList=null, count=0, modContent=, column=]',2,'A','2016-05-14 17:38:08',''),
	(5,1,'옵션항목등록','ItemOptionVo [seq=0, itemSeq=0, optionName=, showFlag=, modDate=, regDate=, optionSeq=1, valueName=기본3, stockCount=999, stockFlag=Y, optionPrice=1000, valueList=null, count=0, modContent=, column=]',2,'A','2016-05-14 17:38:08',''),
	(6,1,'일괄수정','ItemVo [rankNumber=0, seq=1, name=, nickname=, statusCode=Y, statusName=, sellPrice=0, tempSellPrice=0, supplyMasterPrice=0, supplyPrice=0, salesTel=, marketPrice=0, maker=, originCountry=, sellerSeq=null, sellerId=, sellerItemCode=, cateLv1Seq=null, cateLv2Seq=null, cateLv3Seq=null, cateLv4Seq=null, brand=, modelName=, makeDate=, expireDate=, adultFlag=, img1=, img2=, img3=, img4=, taxCode=, modDate=, regDate=, minCnt=0, maxCnt=0, showFlag=, itemSeq=null, content=, asFlag=, asTel=, asTel1=, asTel2=, asTel3=, asContent=, detailImg1=, detailImg2=, detailImg3=, detailAlt1=, detailAlt2=, detailAlt3=, useCode=, memberSeq=null, wishSeq=0, optionSeq=null, optionValueSeq=null, optionName=, valueName=, optionValues=, optionPrice=0, optionPrices=, count=0, optionCount=null, directFlag=, stockCount=0, stockCounts=, reviewGrade=0, reviewCount=0, itemGrade=0, deliveryGrade=0, sellerName=, jachiguCode=, masterSeq=null, masterName=, cateLv1Name=, cateLv2Name=, cateLv3Name=, cateLv4Name=, soldOutFlag=, optionList=null, updateType=, cartSeqs=, notLoginKey=, startPrice=0, endPrice=0, deliTypeCode=, deliCost=0, deliFreeAmount=0, deliPrepaidFlag=, deliPackageFlag=, packageDeliCost=0, typeCode=, returnName=, returnCell=, modContent=, column=, typeCd=null, typeNm=, itemSearchType=, itemSearchValue=, sellerSearchType=, sellerSearchValue=, orderType=, authCategory=imgBannerCode=]',2,'A','2016-05-14 17:39:09','상품명=, 상품상태=Y, 최소구매수량=0, 브랜드='),
	(7,2,'등록','ItemVo [rankNumber=0, seq=2, name=두번째상품 테스트, nickname=, statusCode=H, statusName=, sellPrice=10000, tempSellPrice=0, supplyMasterPrice=0, supplyPrice=0, salesTel=, marketPrice=0, maker=테스트판매자, originCountry=, sellerSeq=3, sellerId=, sellerItemCode=123, cateLv1Seq=1, cateLv2Seq=10, cateLv3Seq=null, cateLv4Seq=null, brand=, modelName=, makeDate=, expireDate=, adultFlag=N, img1=/item/origin/1000/1/2.jpg, img2=/item/origin/1000/2/2.jpg, img3=, img4=, taxCode=1, modDate=, regDate=, minCnt=0, maxCnt=0, showFlag=, itemSeq=null, content=<p>상품 등록 하는 테스트 화면 입니다.</p>\r\n, asFlag=N, asTel=, asTel1=, asTel2=, asTel3=, asContent=, detailImg1=, detailImg2=, detailImg3=, detailAlt1=, detailAlt2=, detailAlt3=, useCode=C, memberSeq=null, wishSeq=0, optionSeq=null, optionValueSeq=null, optionName=, valueName=, optionValues=, optionPrice=0, optionPrices=, count=0, optionCount=null, directFlag=, stockCount=0, stockCounts=, reviewGrade=0, reviewCount=0, itemGrade=0, deliveryGrade=0, sellerName=, jachiguCode=, masterSeq=null, masterName=, cateLv1Name=, cateLv2Name=, cateLv3Name=, cateLv4Name=, soldOutFlag=, optionList=null, updateType=, cartSeqs=, notLoginKey=, startPrice=0, endPrice=0, deliTypeCode=00, deliCost=0, deliFreeAmount=0, deliPrepaidFlag=, deliPackageFlag=Y, packageDeliCost=0, typeCode=N, returnName=, returnCell=, modContent=, column=, typeCd=1, typeNm=, itemSearchType=, itemSearchValue=, sellerSearchType=, sellerSearchValue=, orderType=, authCategory=99imgBannerCode=02]',2,'A','2016-05-16 02:28:49',''),
	(8,2,'옵션등록','ItemOptionVo [seq=2, itemSeq=2, optionName=옵션, showFlag=Y, modDate=, regDate=, optionSeq=null, valueName=, stockCount=0, stockFlag=Y, optionPrice=0, valueList=null, count=0, modContent=, column=]',2,'A','2016-05-16 02:28:49',''),
	(9,2,'옵션항목등록','ItemOptionVo [seq=0, itemSeq=0, optionName=, showFlag=, modDate=, regDate=, optionSeq=2, valueName=기본, stockCount=9999, stockFlag=N, optionPrice=0, valueList=null, count=0, modContent=, column=]',2,'A','2016-05-16 02:28:50',''),
	(10,2,'수정','ItemVo [rankNumber=0, seq=2, name=두번째상품 테스트, nickname=, statusCode=Y, statusName=, sellPrice=10000, tempSellPrice=10000, supplyMasterPrice=0, supplyPrice=0, salesTel=, marketPrice=0, maker=테스트판매자, originCountry=, sellerSeq=3, sellerId=, sellerItemCode=123, cateLv1Seq=1, cateLv2Seq=10, cateLv3Seq=null, cateLv4Seq=null, brand=, modelName=, makeDate=, expireDate=, adultFlag=N, img1=, img2=, img3=, img4=, taxCode=1, modDate=, regDate=, minCnt=0, maxCnt=0, showFlag=, itemSeq=null, content=<p>상품 등록 하는 테스트 화면 입니다.</p>, asFlag=N, asTel=--, asTel1=, asTel2=, asTel3=, asContent=, detailImg1=, detailImg2=, detailImg3=, detailAlt1=, detailAlt2=, detailAlt3=, useCode=C, memberSeq=null, wishSeq=0, optionSeq=null, optionValueSeq=null, optionName=, valueName=, optionValues=, optionPrice=0, optionPrices=, count=0, optionCount=null, directFlag=, stockCount=0, stockCounts=, reviewGrade=0, reviewCount=0, itemGrade=0, deliveryGrade=0, sellerName=, jachiguCode=, masterSeq=null, masterName=, cateLv1Name=, cateLv2Name=, cateLv3Name=, cateLv4Name=, soldOutFlag=, optionList=null, updateType=, cartSeqs=, notLoginKey=, startPrice=0, endPrice=0, deliTypeCode=00, deliCost=0, deliFreeAmount=0, deliPrepaidFlag=, deliPackageFlag=Y, packageDeliCost=0, typeCode=N, returnName=, returnCell=, modContent=, column=, typeCd=1, typeNm=, itemSearchType=, itemSearchValue=, sellerSearchType=, sellerSearchValue=, orderType=, authCategory=99imgBannerCode=02]',2,'A','2016-05-16 02:30:24',' 상품상태=Y, 최소구매수량=0, 상세정보=<p>상품 등록 하는 테스트 화면 입니다.</p>\r\n');

/*!40000 ALTER TABLE `sm_item_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_option
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_option`;

CREATE TABLE `sm_item_option` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `item_seq` int(11) unsigned NOT NULL COMMENT '상품 시퀀스(fk)',
  `option_name` varchar(300) NOT NULL COMMENT '옵션명',
  `show_flag` char(1) NOT NULL DEFAULT 'Y' COMMENT '노출여부(Y:판매 N:비노출)',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_item_option` (`item_seq`),
  CONSTRAINT `fk1_sm_item_option` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 옵션';

LOCK TABLES `sm_item_option` WRITE;
/*!40000 ALTER TABLE `sm_item_option` DISABLE KEYS */;

INSERT INTO `sm_item_option` (`seq`, `item_seq`, `option_name`, `show_flag`, `mod_date`, `reg_date`)
VALUES
	(1,1,'옵션','Y','2016-05-14 17:38:08','2016-05-14 17:38:08'),
	(2,2,'옵션','Y','2016-05-16 02:28:49','2016-05-16 02:28:49');

/*!40000 ALTER TABLE `sm_item_option` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_option_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_option_value`;

CREATE TABLE `sm_item_option_value` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `option_seq` int(11) unsigned DEFAULT NULL COMMENT '옵션 시퀀스(fk)',
  `value_name` varchar(150) NOT NULL COMMENT '옵션상품명',
  `stock_flag` char(1) NOT NULL DEFAULT 'Y' COMMENT '재고관리여부(Y:재고관리 N:관리안함)',
  `stock_cnt` int(11) NOT NULL DEFAULT '0' COMMENT '재고수량',
  `option_price` int(11) NOT NULL DEFAULT '0' COMMENT '옵션 추가금액',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_item_option_value` (`option_seq`),
  CONSTRAINT `fk1_sm_item_option_value` FOREIGN KEY (`option_seq`) REFERENCES `sm_item_option` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 옵션 상세';

LOCK TABLES `sm_item_option_value` WRITE;
/*!40000 ALTER TABLE `sm_item_option_value` DISABLE KEYS */;

INSERT INTO `sm_item_option_value` (`seq`, `option_seq`, `value_name`, `stock_flag`, `stock_cnt`, `option_price`, `mod_date`, `reg_date`)
VALUES
	(1,1,'기본1','Y',999,0,'2016-05-14 17:38:08','2016-05-14 17:38:08'),
	(2,1,'기본2','Y',999,500,'2016-05-14 17:38:08','2016-05-14 17:38:08'),
	(3,1,'기본3','Y',999,1000,'2016-05-14 17:38:08','2016-05-14 17:38:08'),
	(4,2,'기본','N',9999,0,'2016-05-16 02:28:50','2016-05-16 02:28:50');

/*!40000 ALTER TABLE `sm_item_option_value` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_prop
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_prop`;

CREATE TABLE `sm_item_prop` (
  `prop_cd` int(11) unsigned NOT NULL COMMENT '속성 코드',
  `prop_nm` varchar(100) NOT NULL COMMENT '속성명',
  `prop_type` varchar(2) NOT NULL COMMENT '속성타입(T:텍스트 R:라디오 TR:텍스트/라디오)',
  `prop_note` varchar(200) DEFAULT NULL COMMENT '설명(예제)',
  `default_val` varchar(200) NOT NULL COMMENT '기본값',
  `ext_prop_cd1` char(3) DEFAULT NULL COMMENT '외부 연동 속성 코드',
  `radio_list` varchar(200) DEFAULT NULL COMMENT '라디오 버튼 옵션값',
  PRIMARY KEY (`prop_cd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 고시 속성';

LOCK TABLES `sm_item_prop` WRITE;
/*!40000 ALTER TABLE `sm_item_prop` DISABLE KEYS */;

INSERT INTO `sm_item_prop` (`prop_cd`, `prop_nm`, `prop_type`, `prop_note`, `default_val`, `ext_prop_cd1`, `radio_list`)
VALUES
	(1,'A/S 전화번호','T','20자까지 숫자| - 만 입력 가능 (기본 정보로 세팅되어 있습니다.  A/S연락처로 변경)','제품 상세 설명내 표기 ','',''),
	(2,'KC안전인증 대상 유무','R','KC안전인증 대상 유(Y)| 무(N)| (인증 대상상품은 Y로 변경해 주세요)','N','','인증대상[Y]|해당없음[N]'),
	(3,'가입절차','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(4,'관련법상 표시사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(5,'광고사전심의 번호 유무','R','광고 사전 심의번호가 있는 경우만 별도 입력| 기본 N 세팅','N','','있음[Y]|없음[N]'),
	(6,'국가 또는 지역명','T','','상세정보 별도표기','',''),
	(7,'기능성 여부','R','기능성 화장품은 화장품법에 따른 식품의약품안전청 심사 필 유(Y)| 무(N)(미백| 주름개선| 자외선 차단 등)','N','','해당[Y]|해당없음[N]'),
	(8,'기능정보','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(9,'냉난방면적','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(10,'도서명','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','제품 상세 설명내 표기 ','',''),
	(11,'동일모델 출시년월','T','동일 모델 출신년월을 YYYY-MM(2012-10) 형태로 입력| 기본 상품 등록일자로 세팅','제품 상세 설명내 표기 ','',''),
	(12,'등급| 객실타입','T','','제품 상세 설명내 표기 ','',''),
	(13,'맵 업데이트 비용 및 무상기간','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(14,'목차 또는 책소개','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(15,'발행자','T','','제품 상세 설명내 표기 ','',''),
	(16,'배송설치비용','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(17,'법에 의한 인증 허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(18,'보관방법 또는 취급방법','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(19,'부대시설| 제공서비스(조식등)','T','','제품 상세 설명내 표기 ','',''),
	(20,'사용가능 인원(추가시 비용)','T','','제품 상세 설명내 표기 ','',''),
	(21,'사용기한 또는 개봉 후 사용기간','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(22,'사용방법','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(23,'사용연령','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(24,'사용할 때 주의사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(25,'상품 제공 방식','T','','제품 상세 설명내 표기 ','',''),
	(26,'상품(차량)의 고장/훼손 시 소비자 책임','T','','제품 상세 설명내 표기 ','',''),
	(27,'상품별 세부 사양','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(28,'색상','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(29,'생산자 및 소재지','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(30,'섭취량|섭취방법 및 섭취시 주의사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(31,'세탁방법 및 취급시 주의사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(32,'소비자상담 관련 전화번호','T','20자까지 숫자| - 만 입력 가능 (기본 정보로 세팅되어 있습니다.  A/S연락처로 변경)','상세정보 별도표기','',''),
	(33,'소비자의 추가적인 부담사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(34,'소유권 이전 가능 여부','T','','제품 상세 설명내 표기 ','',''),
	(35,'소유권 이전 조건','T','','제품 상세 설명내 표기 ','',''),
	(36,'수입식품 여부','R','\"수입식품(Y)| 국내제조(N) 입력| 기본 \"\"N\"\" 세팅\"','N','','수입식품[Y]|국내제조[N]'),
	(37,'수입 여부','R','\"수입식품(Y)| 국내제조(N) 입력| 기본 \"\"N\"\" 세팅\"','N','','수입제품[Y]|국내제조[N]'),
	(38,'숙박정보','T','','제품 상세 설명내 표기 ','',''),
	(39,'숙소형태','T','','제품 상세 설명내 표기 ','',''),
	(40,'식품위생법에 따른 수입기구/용기 여부','R','\"식품위생법에 따른 수입기구/용기의 경우(Y)| 아닌경우(N) 표기| 기본 \"\"N\"\" 세팅\"','N','','식품위생법에 따른 수입기구/용기의 경우[Y]|해당사항 없음[N]'),
	(41,'식품의 유형','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(42,'식품의약품안전청 심사 내용','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(43,'안전인증번호','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(44,'안전인증 여부','R','인증(Y)| 미인증(N) 기본 N 셋팅','N','','인증[Y]|미인증[N]'),
	(45,'여행기간 및 일정','T','','제품 상세 설명내 표기 ','',''),
	(46,'여행사','T','','제품 상세 설명내 표기 ','',''),
	(47,'영양성분 표시 대상 여부','R','\"영양성분 표시 대상(Y)| 아닌경우(N)| 기본 \"\"N\"\" 세팅\"','N','','영양성분 표시 대상[Y]|해당사항 없음[N]'),
	(48,'영양정보','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(49,'예약 취소 또는 중도 해약 시 환불기준','T','','제품 상세 설명내 표기 ','',''),
	(50,'예약담당 연락처','T','','제품 상세 설명내 표기 ','',''),
	(51,'요금조건| 왕복 편도 여부','T','','제품 상세 설명내 표기 ','',''),
	(52,'용량 또는 중량','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(53,'용량(중량)| 수량| 크기','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(54,'원료원산지','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(55,'유전자 재조합 식품 여부','R','\"유전자 재조합 식품 여(Y)| 부(N)| 기본 \"\"N\"\"세팅\"','N','','유전자 재조합 식품[Y]|해당사항 없음[N]'),
	(56,'유지보수 조건','T','','제품 상세 설명내 표기 ','',''),
	(57,'유효기간','T','','제품 상세 설명내 표기 ','',''),
	(58,'의료기기 허가 대상여부','R','\"의료기기 허가 대상 여(Y)| 부(N)| 기본 \"\"N\"\"세팅\"','N','','의료기기 허가 대상[Y]|해당사항 없음[N]'),
	(59,'이동통신 가입조건','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(60,'이동통신사','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(61,'이용가능매장','T','','제품 상세 설명내 표기 ','',''),
	(62,'이용조건|이용기간 (유효기간)','T','','제품 상세 설명내 표기 ','',''),
	(63,'이용항공편','T','','제품 상세 설명내 표기 ','',''),
	(64,'자동차부품 자가인증대상여부','R','\"자동차부품 자가인증대상여(Y)| 부(N)| 기본 \"\"N\"\" 세팅\"','N','','자동차부품 자가인증대상[Y]|해당사항 없음[N]'),
	(65,'잔액환급조건','T','','제품 상세 설명내 표기 ','',''),
	(66,'재질','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(67,'저자| 출판사','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(68,'적용차종','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(69,'전기용품 여부','R','\"전기용품 여(Y)| 부(N)| 기본 \"\"N\"\" 세팅\"','N','','전기용품[Y]|해당사항 없음[N]'),
	(70,'전파인증대상 여부','R','\"전파인증대상 여(Y)| 부(N)| 기본 \"\"N\"\" 세팅\"','N','','전파인증대상[Y]|해당사항 없음[N]'),
	(71,'정격전압|소비전력|에너지소비효율등급','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(72,'제작자 또는 공급자','T','','제품 상세 설명내 표기 ','',''),
	(73,'제조국','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(74,'제조사(수입자/병행수입)','T','\"텍스트 입력| 특수문자 입력시 에러| 수입사 파악이 어려운 수입상품은 \"\"병행수입\"\" 표기| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(75,'제조연월','T',' YYYY-MM(2012-10) 형태로 입력| 기본 상품 등록일자로 세팅','상세정보 별도표기','',''),
	(76,'제조연월일(포장일 또는 생산연도) / 유통기한','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(77,'제조자 및 제조판매업자','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(78,'제품 구성','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(79,'제품 소재','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(80,'제품 주요 사양','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(81,'제품의 사용목적 및 사용방법','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(82,'제한사항','T','','제품 상세 설명내 표기 ','',''),
	(83,'종류','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(84,'좌석종류','T','','제품 상세 설명내 표기 ','',''),
	(85,'주요 소재/순도/밴드재질(시계의경우)','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(86,'주요성분','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(87,'주원료명','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(88,'질병예방|치료 의약품 아님 명시','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(89,'쪽수','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(90,'차량 반환시 연료대금정산 방법','T','','제품 상세 설명내 표기 ','',''),
	(91,'착용 시 주의사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(92,'청약철회 또는 계약의 해제에 따른 효과','T','','제품 상세 설명내 표기 ','',''),
	(93,'총 예정인원| 출발가능 인원','T','','제품 상세 설명내 표기 ','',''),
	(94,'최소 시스템사양| 필수 소프트웨어','T','','제품 상세 설명내 표기 ','',''),
	(95,'추가 경비 항목과 금액','T','','제품 상세 설명내 표기 ','',''),
	(96,'추가 비용','T','','제품 상세 설명내 표기 ','',''),
	(97,'추가설치비용','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(98,'출간일','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(99,'취급방법 및 주의사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(100,'취급시 주의사항','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(101,'취소규정(환불| 위약금 등)','T','','제품 상세 설명내 표기 ','',''),
	(102,'치수','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(103,'치수(발길이|굽높이 정보등등)','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(104,'크기|무게','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(105,'특수용도식품 여부','R','\"특수용도식품 여(Y)| 부(N)| 기본 \"\"N\"\" 세팅\"','N','','특수용도식품[Y]|해당사항 없음[N]'),
	(106,'티켓수령방법','T','','제품 상세 설명내 표기 ','',''),
	(107,'포장단위별 용량(중량)| 수량','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(108,'포함내역(식사| 인솔자 등)','T','','제품 상세 설명내 표기 ','',''),
	(109,'표시광고 사전심의필 여부','R','\"표시광고 사전심의필(Y)| 아닌경우(N)| 기본 \"\"N\"\" 세팅\"','N','','표시광고 사전심의필[Y]|해당사항 없음[N]'),
	(110,'품명 및 모델명','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(111,'품질보증기준','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(112,'품질보증서 제공 유무','R','\"품질보증서 제공 유(Y)| 무(N)| 기본 \"\"N\"\" 세팅| 품질 보증서가 있는 경우 반드시 Y로 변경해 주세요\"','N','','품질보증서 제공[Y]|제공하지 않음[N]'),
	(113,'함량','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(114,'해외여행의 경우 외교통상부가 지정하는 여행 경','T','','제품 상세 설명내 표기 ','',''),
	(115,'화면사양','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(116,'사은품 구성','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(117,'교환/반품비용','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(118,'유아동침대/매트리스/식탁의자 해당 여부','R','\"유아동 침대/매트리스/식탁의자 해당(Y)| 아닌경우(N) 표기| 기본 \"\"N\"\"세팅\"','N','','유아동 침대/매트리스/식탁의자 해당[Y]|해당사항 없음[N]'),
	(119,'전기용품 안전인증 대상 유무','T','','제품 상세 설명내 표기','',''),
	(120,'전기용품 안전인증번호','T','','제품 상세 설명내 표기','',''),
	(121,'전기용품 안전인증 여부','R','인증(Y)| 미인증(N)| 기본 N 셋팅','N','','인증[Y]|미인증[N]'),
	(122,'노트북 여부','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(123,'의료기기 허가 신고번호','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(124,'세제여부','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(125,'표준 사용량','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(126,'사용 용도','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(127,'수입자','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(128,'유기농 화장품에 해당 여부','R','\"유기농 화장품(Y)| 아닌경우(N) 표기| 기본 \"\"N\"\" 세팅\"','N','','유기농 화장품[Y]|해당사항 없음[N]'),
	(129,'유기농 원료 함량','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(130,'식약청 허가번호','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(131,'농산물|축산물|수산물 구분 입력','T','\"식품군에 따라 농산물| 축산물| 수산물 로 구분해서 입력| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(132,'영유아식 또는 체중조절식품 해당 여부','R','\"영유아식 또는 체중조절식품 해당(Y)| 아닌경우(N)|  기본 \"\"N\"\" 세팅\"','N','','영유아식 또는 체중조절식품[Y]|해당사항 없음[N]'),
	(133,'사은품 제조사','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(134,'사은품 원산지','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(135,'제조연월일','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','',''),
	(136,'자동차부품 자가 인증번호','T','\"텍스트 입력| 특수문자 입력시 에러| 기본 \"\"상세정보 별도표기\"\" 세팅\"','상세정보 별도표기','','');

/*!40000 ALTER TABLE `sm_item_prop` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_review
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_review`;

CREATE TABLE `sm_item_review` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '상품평 시퀀스',
  `detail_seq` int(11) unsigned DEFAULT NULL COMMENT '주문상세 시퀀스',
  `member_seq` int(11) unsigned NOT NULL COMMENT '회원 시퀀스(fk)',
  `item_seq` int(11) unsigned NOT NULL COMMENT '상품 시퀀스',
  `review` varchar(300) DEFAULT NULL COMMENT '상품평',
  `good_grade` int(1) DEFAULT '1' COMMENT '제품 만족도',
  `deli_grade` int(1) DEFAULT '1' COMMENT '배송 만족도',
  `reg_date` datetime NOT NULL COMMENT '등록 일자',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_item_review` (`member_seq`),
  KEY `fk2_sm_item_review` (`item_seq`),
  CONSTRAINT `fk1_sm_item_review` FOREIGN KEY (`member_seq`) REFERENCES `sm_member` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_item_review` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품평';



# Dump of table sm_item_seq
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_seq`;

CREATE TABLE `sm_item_seq` (
  `seq` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 시퀀스 테이블';

LOCK TABLES `sm_item_seq` WRITE;
/*!40000 ALTER TABLE `sm_item_seq` DISABLE KEYS */;

INSERT INTO `sm_item_seq` (`seq`)
VALUES
	(3);

/*!40000 ALTER TABLE `sm_item_seq` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_type`;

CREATE TABLE `sm_item_type` (
  `type_cd` int(11) unsigned NOT NULL COMMENT '분류 코드',
  `type_nm` varchar(100) DEFAULT NULL COMMENT '분류명',
  PRIMARY KEY (`type_cd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 고시 분류';

LOCK TABLES `sm_item_type` WRITE;
/*!40000 ALTER TABLE `sm_item_type` DISABLE KEYS */;

INSERT INTO `sm_item_type` (`type_cd`, `type_nm`)
VALUES
	(1,'의류'),
	(2,'구두/신발'),
	(3,'가방'),
	(4,'패션잡화(모자/벨트/액세서리)'),
	(5,'침구류/커튼'),
	(6,'가구(침대/소파/싱크대/DIY제품'),
	(7,'영상가전(TV류)'),
	(8,'가정용 전기제품(냉장고/세탁기/식기세척기/전자'),
	(9,'계절가전(에어컨/온풍기)'),
	(10,'사무용기기(컴퓨터/노트북/프린터)'),
	(11,'광학기기(디지털카메라/캠코더)'),
	(12,'소형전자(MP3/전자사전 등)'),
	(13,'휴대폰'),
	(14,'내비게이션'),
	(15,'자동차용품(자동차부품/기타 자동차용품)'),
	(16,'의료기기'),
	(17,'주방용품'),
	(18,'화장품'),
	(19,'귀금속/보석/시계류'),
	(20,'식품(농수산물)'),
	(21,'가공식품'),
	(22,'건강기능식품'),
	(23,'영유아용품'),
	(24,'악기'),
	(25,'스포츠용품'),
	(26,'서적'),
	(27,'호텔/펜션 예약'),
	(28,'여행패키지'),
	(29,'항공권'),
	(30,'자동차 대여 서비스(렌터카)'),
	(31,'물품대여 서비스(정수기/비데/공기청정기 등)'),
	(32,'물품대여 서비스(서적/유아용품/행사용품 등)'),
	(33,'디지털 콘텐츠(음원/게임/인터넷 강의 등)'),
	(34,'상품권/쿠폰'),
	(35,'기타');

/*!40000 ALTER TABLE `sm_item_type` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_item_type_prop
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_item_type_prop`;

CREATE TABLE `sm_item_type_prop` (
  `type_prop_id` int(11) unsigned NOT NULL COMMENT '매칭 코드',
  `type_cd` int(11) unsigned NOT NULL COMMENT '분류 코드',
  `prop_cd` int(11) unsigned NOT NULL COMMENT '속성 코드',
  `seq_no` int(11) NOT NULL COMMENT '순번',
  `prop_note` varchar(200) DEFAULT NULL COMMENT '분류 속성 예제',
  PRIMARY KEY (`type_prop_id`),
  KEY `idx1_sm_item_type_prop` (`type_cd`),
  KEY `idx2_sm_item_type_prop` (`prop_cd`),
  CONSTRAINT `fk1_sm_item_type_prop` FOREIGN KEY (`prop_cd`) REFERENCES `sm_item_prop` (`prop_cd`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_item_type_prop` FOREIGN KEY (`type_cd`) REFERENCES `sm_item_type` (`type_cd`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='상품 정보 고시 분류 속성 매칭';

LOCK TABLES `sm_item_type_prop` WRITE;
/*!40000 ALTER TABLE `sm_item_type_prop` DISABLE KEYS */;

INSERT INTO `sm_item_type_prop` (`type_prop_id`, `type_cd`, `prop_cd`, `seq_no`, `prop_note`)
VALUES
	(1,1,79,1,''),
	(2,1,28,2,''),
	(3,1,102,3,''),
	(4,1,74,4,''),
	(5,1,73,5,''),
	(6,1,31,6,''),
	(7,1,75,7,''),
	(8,1,111,8,''),
	(9,1,1,9,''),
	(10,1,37,10,''),
	(11,2,79,1,''),
	(12,2,28,2,''),
	(13,2,103,3,''),
	(14,2,74,4,''),
	(15,2,73,5,''),
	(16,2,100,6,''),
	(17,2,111,7,''),
	(18,2,1,8,''),
	(19,2,37,9,''),
	(20,3,79,1,''),
	(21,3,28,2,''),
	(22,3,74,3,''),
	(23,3,73,4,''),
	(24,3,100,5,''),
	(25,3,111,6,''),
	(26,3,1,7,''),
	(27,3,104,8,''),
	(28,3,37,9,''),
	(29,3,83,10,''),
	(30,4,79,1,''),
	(31,4,102,2,''),
	(32,4,74,3,''),
	(33,4,73,4,''),
	(34,4,100,5,''),
	(35,4,111,6,''),
	(36,4,1,7,''),
	(37,4,37,8,''),
	(38,4,83,9,''),
	(39,5,79,1,''),
	(40,5,28,2,''),
	(41,5,102,3,''),
	(42,5,74,4,''),
	(43,5,73,5,''),
	(44,5,31,6,''),
	(45,5,100,7,''),
	(46,5,111,8,''),
	(47,5,1,9,''),
	(48,5,78,10,''),
	(49,5,37,11,''),
	(50,6,110,1,''),
	(51,6,28,2,''),
	(52,6,74,3,''),
	(53,6,73,4,''),
	(54,6,111,5,''),
	(55,6,1,6,''),
	(56,6,78,7,''),
	(57,6,2,8,''),
	(58,6,104,9,''),
	(59,6,16,10,''),
	(60,6,43,11,''),
	(61,6,37,12,''),
	(62,6,85,13,''),
	(63,7,110,1,''),
	(64,7,74,2,''),
	(65,7,73,3,''),
	(66,7,111,4,''),
	(67,7,1,5,''),
	(68,7,2,6,''),
	(69,7,71,7,''),
	(70,7,104,8,''),
	(71,7,11,9,''),
	(72,7,115,10,''),
	(73,7,43,11,''),
	(74,7,37,12,''),
	(75,8,110,1,''),
	(76,8,74,2,''),
	(77,8,73,3,''),
	(78,8,111,4,''),
	(79,8,1,5,''),
	(80,8,2,6,''),
	(81,8,71,7,''),
	(82,8,104,8,''),
	(83,8,11,9,''),
	(84,8,43,10,''),
	(85,8,37,11,''),
	(86,9,110,1,''),
	(87,9,74,2,''),
	(88,9,73,3,''),
	(89,9,111,4,''),
	(90,9,1,5,''),
	(91,9,2,6,''),
	(92,9,71,7,''),
	(93,9,104,8,''),
	(94,9,11,9,''),
	(95,9,43,10,''),
	(96,9,9,11,''),
	(97,9,97,12,''),
	(98,9,37,13,''),
	(99,10,110,1,''),
	(100,10,74,2,''),
	(101,10,73,3,''),
	(102,10,111,4,''),
	(103,10,1,5,''),
	(104,10,71,6,''),
	(105,10,80,7,''),
	(106,10,104,8,''),
	(107,10,11,9,''),
	(108,10,70,10,''),
	(109,10,37,11,''),
	(110,11,110,1,''),
	(111,11,74,2,''),
	(112,11,73,3,''),
	(113,11,111,4,''),
	(114,11,1,5,''),
	(115,11,80,6,''),
	(116,11,104,7,''),
	(117,11,11,8,''),
	(118,11,70,9,''),
	(119,11,37,10,''),
	(120,12,110,1,''),
	(121,12,74,2,''),
	(122,12,73,3,''),
	(123,12,111,4,''),
	(124,12,1,5,''),
	(125,12,71,6,''),
	(126,12,80,7,''),
	(127,12,104,8,''),
	(128,12,11,9,''),
	(129,12,70,10,''),
	(130,12,37,11,''),
	(131,13,110,1,''),
	(132,13,74,2,''),
	(133,13,73,3,''),
	(134,13,111,4,''),
	(135,13,1,5,''),
	(136,13,80,6,''),
	(137,13,104,7,''),
	(138,13,11,8,''),
	(139,13,70,9,''),
	(140,13,59,10,''),
	(141,13,37,11,''),
	(142,13,60,12,''),
	(143,13,3,13,''),
	(144,13,33,14,''),
	(145,14,110,1,''),
	(146,14,74,2,''),
	(147,14,73,3,''),
	(148,14,111,4,''),
	(149,14,1,5,''),
	(150,14,71,6,''),
	(151,14,80,7,''),
	(152,14,104,8,''),
	(153,14,11,9,''),
	(154,14,70,10,''),
	(155,14,13,11,''),
	(156,14,37,12,''),
	(157,15,110,1,''),
	(158,15,74,2,''),
	(159,15,73,3,''),
	(160,15,111,4,''),
	(161,15,1,5,''),
	(162,15,104,6,''),
	(163,15,11,7,''),
	(164,15,68,8,''),
	(165,15,64,9,''),
	(166,15,37,10,''),
	(167,16,110,1,''),
	(168,16,74,2,''),
	(169,16,73,3,''),
	(170,16,100,4,''),
	(171,16,111,5,''),
	(172,16,1,6,''),
	(173,16,2,7,''),
	(174,16,71,8,''),
	(175,16,11,9,''),
	(176,16,43,10,''),
	(177,16,37,11,''),
	(178,16,58,12,''),
	(179,16,69,13,''),
	(180,16,81,14,''),
	(181,16,5,15,''),
	(182,17,110,1,''),
	(183,17,74,2,''),
	(184,17,73,3,''),
	(185,17,111,4,''),
	(186,17,1,5,''),
	(187,17,78,6,''),
	(188,17,104,7,''),
	(189,17,11,8,''),
	(190,17,66,9,''),
	(191,17,37,10,''),
	(192,17,40,11,''),
	(193,18,73,1,''),
	(194,18,111,2,''),
	(195,18,80,3,''),
	(196,18,22,4,''),
	(197,18,86,5,''),
	(198,18,52,6,''),
	(199,18,32,7,''),
	(200,18,21,8,''),
	(201,18,77,9,''),
	(202,18,42,10,''),
	(203,18,24,11,''),
	(204,18,7,12,''),
	(205,19,102,1,''),
	(206,19,74,2,''),
	(207,19,73,3,''),
	(208,19,111,4,''),
	(209,19,1,5,''),
	(210,19,80,6,''),
	(211,19,112,7,''),
	(212,19,52,8,''),
	(213,19,37,9,''),
	(214,19,85,10,''),
	(215,19,91,11,''),
	(216,20,78,1,''),
	(217,20,53,2,''),
	(218,20,4,3,''),
	(219,20,18,4,''),
	(220,20,32,5,''),
	(221,20,87,6,''),
	(222,20,29,7,''),
	(223,20,76,8,''),
	(224,20,113,9,''),
	(225,20,54,10,''),
	(226,20,37,11,''),
	(227,21,53,1,''),
	(228,21,32,2,''),
	(229,21,87,3,''),
	(230,21,41,4,''),
	(231,21,29,5,''),
	(232,21,47,6,''),
	(233,21,55,7,''),
	(234,21,105,8,''),
	(235,21,36,9,''),
	(236,21,76,10,''),
	(237,21,113,11,''),
	(238,21,54,12,''),
	(239,21,109,13,''),
	(240,22,32,1,''),
	(241,22,87,2,''),
	(242,22,41,3,''),
	(243,22,29,4,''),
	(244,22,55,5,''),
	(245,22,36,6,''),
	(246,22,48,7,''),
	(247,22,8,8,''),
	(248,22,30,9,''),
	(249,22,88,10,''),
	(250,22,109,11,''),
	(251,22,76,12,''),
	(252,22,113,13,''),
	(253,22,54,14,''),
	(254,22,107,15,''),
	(255,23,110,1,''),
	(256,23,28,2,''),
	(257,23,74,3,''),
	(258,23,73,4,''),
	(259,23,111,5,''),
	(260,23,1,6,''),
	(261,23,2,7,''),
	(262,23,11,8,''),
	(263,23,43,9,''),
	(264,23,53,10,''),
	(265,23,66,11,''),
	(266,23,23,12,''),
	(267,23,37,13,''),
	(268,23,99,14,''),
	(269,24,110,1,''),
	(270,24,28,2,''),
	(271,24,74,3,''),
	(272,24,73,4,''),
	(273,24,111,5,''),
	(274,24,1,6,''),
	(275,24,78,7,''),
	(276,24,104,8,''),
	(277,24,11,9,''),
	(278,24,66,10,''),
	(279,24,37,11,''),
	(280,24,27,12,''),
	(281,25,110,1,''),
	(282,25,28,2,''),
	(283,25,74,3,''),
	(284,25,73,4,''),
	(285,25,111,5,''),
	(286,25,1,6,''),
	(287,25,78,7,''),
	(288,25,11,8,''),
	(289,25,53,9,''),
	(290,25,66,10,''),
	(291,25,37,11,''),
	(292,25,27,12,''),
	(293,26,78,1,''),
	(294,26,104,2,''),
	(295,26,10,3,''),
	(296,26,67,4,''),
	(297,26,89,5,''),
	(298,26,98,6,''),
	(299,26,14,7,''),
	(300,26,74,8,''),
	(301,26,73,9,''),
	(302,27,6,1,''),
	(303,27,39,2,''),
	(304,27,12,3,''),
	(305,27,20,4,''),
	(306,27,19,5,''),
	(307,27,101,6,''),
	(308,27,50,7,''),
	(309,28,101,1,''),
	(310,28,50,2,''),
	(311,28,46,3,''),
	(312,28,63,4,''),
	(313,28,45,5,''),
	(314,28,93,6,''),
	(315,28,38,7,''),
	(316,28,108,8,''),
	(317,28,95,9,''),
	(318,28,114,10,''),
	(319,29,101,1,''),
	(320,29,50,2,''),
	(321,29,95,3,''),
	(322,29,51,4,''),
	(323,29,57,5,''),
	(324,29,82,6,''),
	(325,29,106,7,''),
	(326,29,84,8,''),
	(327,30,68,1,''),
	(328,30,32,2,''),
	(329,30,35,3,''),
	(330,30,96,4,''),
	(331,30,90,5,''),
	(332,30,26,6,''),
	(333,30,49,7,''),
	(334,30,34,8,''),
	(335,31,110,1,''),
	(336,31,80,2,''),
	(337,31,32,3,''),
	(338,31,35,4,''),
	(339,31,26,5,''),
	(340,31,49,6,''),
	(341,31,56,7,''),
	(342,31,34,8,''),
	(343,32,110,1,''),
	(344,32,32,2,''),
	(345,32,35,3,''),
	(346,32,26,4,''),
	(347,32,49,5,''),
	(348,32,34,6,''),
	(349,33,32,1,''),
	(350,33,72,2,''),
	(351,33,62,3,''),
	(352,33,25,4,''),
	(353,33,94,5,''),
	(354,33,92,6,''),
	(355,33,74,7,''),
	(356,33,73,8,''),
	(357,34,32,1,''),
	(358,34,62,2,''),
	(359,34,15,3,''),
	(360,34,61,4,''),
	(361,34,65,5,''),
	(362,35,110,1,''),
	(363,35,74,2,''),
	(364,35,73,3,''),
	(365,35,1,4,''),
	(366,35,17,5,''),
	(367,35,44,6,''),
	(368,1,2,11,''),
	(369,4,28,10,''),
	(370,5,110,12,''),
	(371,5,2,13,''),
	(372,5,52,14,''),
	(373,5,16,15,''),
	(374,5,43,16,''),
	(375,5,116,17,''),
	(376,6,100,14,''),
	(377,6,11,15,''),
	(378,6,117,16,''),
	(379,6,118,17,''),
	(380,6,119,18,''),
	(381,6,120,19,''),
	(382,8,121,12,''),
	(383,9,121,14,''),
	(384,10,115,12,''),
	(385,10,43,13,''),
	(386,10,122,14,''),
	(387,11,43,11,''),
	(388,12,43,12,''),
	(389,14,43,13,''),
	(390,15,79,11,''),
	(391,15,28,12,''),
	(392,15,31,13,''),
	(393,15,78,14,''),
	(394,15,2,15,''),
	(395,15,52,16,''),
	(396,15,16,17,''),
	(397,15,43,18,''),
	(398,15,136,19,''),
	(399,16,121,16,''),
	(400,16,123,17,''),
	(401,17,100,12,''),
	(402,17,2,13,''),
	(403,17,43,14,''),
	(404,17,18,15,''),
	(405,17,76,16,''),
	(406,17,124,17,''),
	(407,17,125,18,''),
	(408,17,126,19,''),
	(409,18,37,13,''),
	(410,18,127,14,''),
	(411,18,128,15,''),
	(412,18,129,16,''),
	(413,18,130,17,''),
	(414,20,131,12,''),
	(415,20,127,13,''),
	(416,21,4,14,''),
	(417,21,127,15,''),
	(418,21,132,16,''),
	(419,22,127,16,''),
	(420,23,126,15,''),
	(421,23,116,16,''),
	(422,23,133,17,''),
	(423,23,134,18,''),
	(424,23,135,19,''),
	(425,25,100,13,''),
	(426,25,83,14,''),
	(427,35,37,7,''),
	(428,35,111,8,'');

/*!40000 ALTER TABLE `sm_item_type_prop` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_mall
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_mall`;

CREATE TABLE `sm_mall` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(PK/FK)',
  `url` varchar(100) DEFAULT NULL COMMENT '쇼핑몰 URL',
  `pay_method` varchar(100) DEFAULT NULL COMMENT '사용 가능 결제 수단(공통코드 참조-구분자 ,)',
  `pg_code` varchar(10) DEFAULT NULL COMMENT 'PG사 코드',
  `pg_id` varchar(50) DEFAULT NULL COMMENT 'PG 아이디(상점아이디 or kcp사이트코드)',
  `pg_key` varchar(100) DEFAULT NULL COMMENT 'PG 키(상점키)',
  `open_date` datetime DEFAULT NULL COMMENT '오픈 일자',
  `close_date` datetime DEFAULT NULL COMMENT '폐쇄 일자',
  PRIMARY KEY (`seq`),
  CONSTRAINT `fk1_sm_mall` FOREIGN KEY (`seq`) REFERENCES `sm_user` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='쇼핑몰 정보 테이블';

LOCK TABLES `sm_mall` WRITE;
/*!40000 ALTER TABLE `sm_mall` DISABLE KEYS */;

INSERT INTO `sm_mall` (`seq`, `url`, `pay_method`, `pg_code`, `pg_id`, `pg_key`, `open_date`, `close_date`)
VALUES
	(1,'','CARD1,CARD2,CASH,OFFLINE,POINT,ARS,NP_CARD2,NP_CASH,NP_CARD1','inicis','test','1234567890abcdef','2016-05-14 17:24:46',NULL);

/*!40000 ALTER TABLE `sm_mall` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_member`;

CREATE TABLE `sm_member` (
  `seq` int(11) unsigned NOT NULL COMMENT '시퀀스(PK/FK)',
  `mall_seq` int(11) unsigned NOT NULL COMMENT '쇼핑몰 시퀀스(FK)',
  `member_type_code` char(1) NOT NULL COMMENT '회원 구분(C:개인, P:공공기관, O:기업/시설/단체)',
  `email` varchar(100) DEFAULT NULL COMMENT '이메일',
  `sex_code` char(1) DEFAULT NULL COMMENT '성별(M:남, F:여)',
  `birthdate` char(8) DEFAULT NULL COMMENT '생년월일 8자리(yyyymmdd)',
  `tel` varchar(50) DEFAULT NULL COMMENT '전화 번호',
  `cell` varchar(50) DEFAULT NULL COMMENT '휴대폰 번호',
  `postcode` varchar(10) DEFAULT NULL COMMENT '우편번호',
  `addr1` varchar(300) DEFAULT NULL COMMENT '주소',
  `addr2` varchar(300) DEFAULT NULL COMMENT '주소 상세',
  `email_flag` char(1) NOT NULL COMMENT '이메일 수신동의 여부',
  `email_flag_date` datetime DEFAULT NULL COMMENT '이메일 수신동의 여부 변경일자',
  `sms_flag` char(1) NOT NULL COMMENT 'SMS 수신동의 여부',
  `sms_flag_date` datetime DEFAULT NULL COMMENT 'SMS 수신동의 여부 변경일자',
  `join_path_code` char(1) DEFAULT NULL COMMENT '가입 경로',
  `interest_category_code` varchar(10) DEFAULT NULL COMMENT '관심 카테고리',
  `close_code` char(1) DEFAULT NULL COMMENT '탈퇴사유 코드',
  `close_text` varchar(300) DEFAULT NULL COMMENT '탈퇴사유 내용',
  `cert_key` varchar(100) DEFAULT NULL COMMENT '본인확인 인증키(아이핀, 휴대폰등)',
  `dept_name` varchar(50) DEFAULT NULL COMMENT '부서명',
  `pos_name` varchar(50) DEFAULT NULL COMMENT '직책',
  `group_seq` int(10) unsigned DEFAULT NULL COMMENT '기관,기업/시설/단체 회원 부가 정보 시퀀스(FK)',
  `old_seq` int(10) unsigned DEFAULT NULL COMMENT '국제몰 PK',
  `encrypt_flag` char(1) NOT NULL DEFAULT 'Y' COMMENT '국제몰 개인정보 암호화 처리 여부',
  PRIMARY KEY (`seq`),
  KEY `fk2_sm_member` (`mall_seq`),
  KEY `fk3_sm_member` (`group_seq`),
  CONSTRAINT `fk1_sm_member` FOREIGN KEY (`seq`) REFERENCES `sm_user` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_member` FOREIGN KEY (`group_seq`) REFERENCES `sm_member_group` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원';

LOCK TABLES `sm_member` WRITE;
/*!40000 ALTER TABLE `sm_member` DISABLE KEYS */;

INSERT INTO `sm_member` (`seq`, `mall_seq`, `member_type_code`, `email`, `sex_code`, `birthdate`, `tel`, `cell`, `postcode`, `addr1`, `addr2`, `email_flag`, `email_flag_date`, `sms_flag`, `sms_flag_date`, `join_path_code`, `interest_category_code`, `close_code`, `close_text`, `cert_key`, `dept_name`, `pos_name`, `group_seq`, `old_seq`, `encrypt_flag`)
VALUES
	(4,1,'O','HOots/+Bu0y/b6a3iqMYSQ==','','','soMBAYMdAgiNmf4idjgVSw==','soMBAYMdAgiNmf4idjgVSw==','06937','서울특별시 동작구 노량진동  315-82','ZUzxgUKOQwXcTmSbFcAMsw==','N',NULL,'N',NULL,'',NULL,NULL,NULL,'','간호','구매',1,NULL,'Y');

/*!40000 ALTER TABLE `sm_member` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_member_delivery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_member_delivery`;

CREATE TABLE `sm_member_delivery` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(고유번호)',
  `member_seq` int(11) unsigned NOT NULL COMMENT '회원 시퀀스(FK)',
  `title` varchar(50) DEFAULT NULL COMMENT '배송지 명',
  `name` varchar(50) DEFAULT NULL COMMENT '수취인 명',
  `tel` varchar(50) DEFAULT NULL COMMENT '전화번호',
  `cell` varchar(50) DEFAULT NULL COMMENT '휴대폰번호',
  `postcode` varchar(10) DEFAULT NULL COMMENT '우편번호',
  `addr1` varchar(300) DEFAULT NULL COMMENT '주소',
  `addr2` varchar(300) DEFAULT NULL COMMENT '주소 상세',
  `default_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '기본 배송지 여부',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_member_delivery` (`member_seq`),
  CONSTRAINT `fk1_sm_member_delivery` FOREIGN KEY (`member_seq`) REFERENCES `sm_member` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='회원 배송지';

LOCK TABLES `sm_member_delivery` WRITE;
/*!40000 ALTER TABLE `sm_member_delivery` DISABLE KEYS */;

INSERT INTO `sm_member_delivery` (`seq`, `member_seq`, `title`, `name`, `tel`, `cell`, `postcode`, `addr1`, `addr2`, `default_flag`, `mod_date`, `reg_date`)
VALUES
	(1,4,'기본','김갑환','soMBAYMdAgiNmf4idjgVSw==','soMBAYMdAgiNmf4idjgVSw==','06937','서울특별시 동작구 노량진동  315-82','ZUzxgUKOQwXcTmSbFcAMsw==','Y',NULL,'2016-05-15 00:03:47');

/*!40000 ALTER TABLE `sm_member_delivery` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_member_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_member_group`;

CREATE TABLE `sm_member_group` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(PK)',
  `name` varchar(100) DEFAULT NULL COMMENT '기관명',
  `biz_no` char(10) DEFAULT NULL COMMENT '사업자등록번호',
  `biz_type` varchar(100) DEFAULT NULL COMMENT '업태',
  `biz_kind` varchar(100) DEFAULT NULL COMMENT '업종',
  `ceo_name` varchar(30) DEFAULT NULL COMMENT '대표자',
  `jachigu_code` varchar(3) DEFAULT NULL COMMENT '자치구 코드',
  `invest_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '투자출연기관 여부',
  `fax` varchar(15) DEFAULT NULL COMMENT '팩스번호',
  `tax_name` varchar(50) DEFAULT NULL COMMENT '세금계산서 담당자',
  `tax_email` varchar(100) DEFAULT NULL COMMENT '세금계산서 수신 이메일',
  `tax_tel` varchar(15) DEFAULT NULL COMMENT '세금계산서 담당자 전화번호',
  `old_seq` int(10) unsigned DEFAULT NULL COMMENT '국제몰 고유키값(삭제예정)',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='기관(기업/시설/단체) 회원 부가 정보';

LOCK TABLES `sm_member_group` WRITE;
/*!40000 ALTER TABLE `sm_member_group` DISABLE KEYS */;

INSERT INTO `sm_member_group` (`seq`, `name`, `biz_no`, `biz_type`, `biz_kind`, `ceo_name`, `jachigu_code`, `invest_flag`, `fax`, `tax_name`, `tax_email`, `tax_tel`, `old_seq`)
VALUES
	(1,'강동병원','1234567890','','','김갑환','','N','','김갑환','o15bba@naver.com','010-2905-0158',NULL);

/*!40000 ALTER TABLE `sm_member_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_menu`;

CREATE TABLE `sm_menu` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `sort` int(2) unsigned NOT NULL DEFAULT '1' COMMENT '정렬순서',
  `name` varchar(50) NOT NULL COMMENT '메뉴명',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴 테이블';

LOCK TABLES `sm_menu` WRITE;
/*!40000 ALTER TABLE `sm_menu` DISABLE KEYS */;

INSERT INTO `sm_menu` (`seq`, `sort`, `name`)
VALUES
	(1,3,'사회적경제'),
	(2,1,'게시판'),
	(4,2,'국제'),
	(6,0,'기타');

/*!40000 ALTER TABLE `sm_menu` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_menu_sub
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_menu_sub`;

CREATE TABLE `sm_menu_sub` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `main_seq` int(11) unsigned NOT NULL COMMENT '메인 메뉴 시퀀스',
  `sort` int(2) unsigned NOT NULL DEFAULT '1' COMMENT '정렬 순서',
  `name` varchar(50) NOT NULL COMMENT '메뉴명',
  `link_url` varchar(500) DEFAULT NULL COMMENT '연결 링크 주소',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_menu_sub` (`main_seq`),
  CONSTRAINT `fk1_sm_menu_sub` FOREIGN KEY (`main_seq`) REFERENCES `sm_menu` (`seq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='메뉴 서브 테이블';

LOCK TABLES `sm_menu_sub` WRITE;
/*!40000 ALTER TABLE `sm_menu_sub` DISABLE KEYS */;

INSERT INTO `sm_menu_sub` (`seq`, `main_seq`, `sort`, `name`, `link_url`)
VALUES
	(1,1,0,'사회적경제','http://hknuri.co.kr/upload/hknuri/html/social_economy.html'),
	(3,2,0,'사회적 기업 소식','/shop/about/board/detail/list/3'),
	(4,1,2,'협동조합','http://hknuri.co.kr/upload/hknuri/html/cooperation.html'),
	(5,1,3,'자활기업','http://hknuri.co.kr/upload/hknuri/html/self_support.html'),
	(6,1,4,'마을기업','http://hknuri.co.kr/upload/hknuri/html/town.html'),
	(7,1,5,'사회적기업','http://hknuri.co.kr/upload/hknuri/html/company.html'),
	(9,4,0,'국제몰','http://www.kukjemall.com'),
	(10,2,0,'보도자료','/shop/about/board/detail/list/6'),
	(12,2,0,'유투브 게시판','/shop/about/board/detail/list/7'),
	(13,2,0,'정보공개','/shop/about/board/detail/list/9');

/*!40000 ALTER TABLE `sm_menu_sub` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_notice_popup
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_notice_popup`;

CREATE TABLE `sm_notice_popup` (
  `seq` int(10) unsigned NOT NULL,
  `mall_seq` int(11) unsigned DEFAULT NULL COMMENT '쇼핑몰 시퀀스',
  `title` varchar(100) NOT NULL COMMENT '팝업 제목',
  `width` int(11) NOT NULL COMMENT '팝업 가로 크기',
  `height` int(11) NOT NULL COMMENT '팝업 세로 크기',
  `top_margin` int(11) NOT NULL COMMENT '팝업 상단여백',
  `left_margin` int(11) NOT NULL COMMENT '팝업 왼쪽여백',
  `status_code` char(1) NOT NULL COMMENT '팝업 상태 코드(Y:진행, N:종료)',
  `content_html` text NOT NULL COMMENT '팝업 HTML 코드',
  `type_code` char(1) NOT NULL DEFAULT 'C' COMMENT '타입 (C:고객, S:판매자)',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공지 팝업창';

LOCK TABLES `sm_notice_popup` WRITE;
/*!40000 ALTER TABLE `sm_notice_popup` DISABLE KEYS */;

INSERT INTO `sm_notice_popup` (`seq`, `mall_seq`, `title`, `width`, `height`, `top_margin`, `left_margin`, `status_code`, `content_html`, `type_code`)
VALUES
	(1,NULL,'국제몰 새단장 오픈 안내',464,560,50,50,'N','&lt;p&gt;&lt;img alt=&quot;&quot; src=&quot;http://localhost/upload/editor/temp/e60bea64-52b4-4102-a359-297b1dce1295.jpg&quot; style=&quot;height:756px; width:540px&quot; /&gt;&lt;/p&gt;','C'),
	(2,NULL,'에디터 이미지 업로드 테스트',5,5,5,5,'N','..','C'),
	(3,NULL,'에디터 이미지 업로드 테스트',3,3,3,3,'N','&lt;p&gt;&lt;img alt=&quot;&quot; src=&quot;http://localhost/upload/editor/notice_popup/1000/3_1.jpg&quot; style=&quot;height:381px; width:540px&quot; /&gt;&lt;img alt=&quot;&quot; src=&quot;http://localhost/upload/editor/notice/1000/3_2.jpg&quot; style=&quot;height:381px; width:540px&quot; /&gt;&lt;/p&gt;','C'),
	(4,NULL,'이미지 업로드 테스트 4',550,470,3,4,'N','<p>...</p>\r\n','C'),
	(5,NULL,'웹에디터 이미지 업로드 테스트2',554,999,100,100,'N','<p>sdaf</p>\r\n','C'),
	(6,NULL,'테스트 10',200,200,11,11,'N','<p>abcdefg</p>\r\n','S'),
	(7,NULL,'입점업체 테스트',200,200,500,600,'Y','<p>테스트테스트테스트</p>\r\n\r\n<p>ㅁㄴ라ㅣㅁㄴㄹ</p>\r\n','S'),
	(8,NULL,'공지테스트',465,300,3,3,'Y','<p><img alt=\"\" src=\"http://kookje.gogosoft.kr/upload/editor/notice_popup/1000/8_1.jpg\" style=\"float: left; width: 465px; height: 265px;\" /></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>봉산 탈춤입니다.</p>\r\n','C');

/*!40000 ALTER TABLE `sm_notice_popup` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_notice_popup_seq
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_notice_popup_seq`;

CREATE TABLE `sm_notice_popup_seq` (
  `seq` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='공지 팝업창 시퀀스 테이블';

LOCK TABLES `sm_notice_popup_seq` WRITE;
/*!40000 ALTER TABLE `sm_notice_popup_seq` DISABLE KEYS */;

INSERT INTO `sm_notice_popup_seq` (`seq`)
VALUES
	(9);

/*!40000 ALTER TABLE `sm_notice_popup_seq` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_order`;

CREATE TABLE `sm_order` (
  `seq` int(10) unsigned NOT NULL DEFAULT '0',
  `mall_seq` int(11) unsigned NOT NULL COMMENT '몰 시퀀스',
  `device_type` char(1) DEFAULT NULL COMMENT '결제장비 구분(N:PC, M:모바일)',
  `pay_method` varchar(20) DEFAULT NULL COMMENT '결제수단 구분(CARD:카드, POINT:포인트, CARD+POINT:카드+포인트, CASH:무통장입금, CASH+POINT:무통장입금+포인트, OFFLINE:방문결제)',
  `total_price` int(11) NOT NULL COMMENT '총 주문 금액',
  `pay_price` int(11) NOT NULL COMMENT '실 결제 금액',
  `member_seq` int(11) unsigned DEFAULT NULL COMMENT '회원 시퀀스',
  `member_name` varchar(50) NOT NULL COMMENT '회원 명',
  `member_email` varchar(100) NOT NULL COMMENT '회원 이메일',
  `member_cell` varchar(50) NOT NULL COMMENT '회원 휴대폰 번호',
  `receiver_name` varchar(50) NOT NULL COMMENT '수취인명',
  `receiver_tel` varchar(50) DEFAULT NULL COMMENT '수취인 전화번호',
  `receiver_cell` varchar(50) DEFAULT NULL COMMENT '수취인 휴대폰번호',
  `receiver_postcode` varchar(20) DEFAULT NULL COMMENT '수취인 우편번호',
  `receiver_addr1` varchar(300) DEFAULT NULL COMMENT '수취인 주소',
  `receiver_addr2` varchar(300) DEFAULT NULL COMMENT '수취인 주소 상세',
  `receiver_email` varchar(100) DEFAULT NULL COMMENT '수취인 이메일',
  `request` varchar(2000) DEFAULT NULL COMMENT '요청사항',
  `point` int(11) DEFAULT '0' COMMENT '포인트 사용금액',
  `estimate_compare_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '비교 견적 신청 여부(Y/N)',
  `account_info` varchar(100) DEFAULT NULL COMMENT '무통장 입금 계좌 정보',
  `np_pay_flag` char(1) DEFAULT NULL COMMENT '후청구 건 결제 여부 Y/N',
  `np_pay_date` datetime DEFAULT NULL COMMENT '후청구 건 결제 일자',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `old_order_id` varchar(50) DEFAULT NULL COMMENT '국제몰 기주문아이디(sm_order_detail.order_seq 매칭용)',
  `old_member_id` varchar(20) DEFAULT NULL COMMENT '국제몰 기주문자 아이디(member_seq 매칭용)',
  `encrypt_flag` char(1) NOT NULL DEFAULT 'Y' COMMENT '국제몰 개인정보 암호화 처리 여부',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_order` (`mall_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문';



# Dump of table sm_order_cs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_order_cs`;

CREATE TABLE `sm_order_cs` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'seq(PK)',
  `order_detail_seq` int(11) unsigned NOT NULL COMMENT '상품주문번호(FK)',
  `contents` varchar(500) NOT NULL COMMENT 'CS내용',
  `login_seq` int(11) unsigned NOT NULL COMMENT '처리자',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_order_cs` (`order_detail_seq`),
  CONSTRAINT `fk1_sm_order_cs` FOREIGN KEY (`order_detail_seq`) REFERENCES `sm_order_detail` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문CS로그';



# Dump of table sm_order_detail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_order_detail`;

CREATE TABLE `sm_order_detail` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(PK)',
  `order_seq` int(11) unsigned NOT NULL COMMENT '주문 시퀀스(FK)',
  `item_seq` int(11) unsigned DEFAULT NULL COMMENT '상품 시퀀스',
  `option_value_seq` int(11) unsigned DEFAULT NULL COMMENT '옵션값 시퀀스(FK)',
  `item_name` varchar(300) NOT NULL COMMENT '상품명',
  `option_value` varchar(300) DEFAULT NULL COMMENT '옵션값',
  `status_code` char(2) NOT NULL COMMENT '주문상태(00:입금대기, 10:결제왼료, 20:주문확인, 30:배송중, 50:배송완료, 55:구매확정, 90:취소요청, 99:취소완료)',
  `sell_price` int(11) NOT NULL COMMENT '판매가',
  `option_price` int(11) DEFAULT '0' COMMENT '옵션 추가 금액',
  `supply_price` int(11) NOT NULL COMMENT '공급가',
  `supply_master_price` int(11) DEFAULT '0' COMMENT '총판 공급가',
  `coupon_price` int(11) DEFAULT '0' COMMENT '쿠폰 할인 금액',
  `order_cnt` int(11) NOT NULL COMMENT '주문 수량',
  `deli_cost` int(11) DEFAULT '0' COMMENT '배송비',
  `deli_prepaid_flag` char(1) DEFAULT NULL COMMENT '배송비 선결제 여부(선결제필수:Y,착불:N)',
  `deli_seq` int(11) unsigned DEFAULT NULL COMMENT '택배사 시퀀스',
  `deli_no` varchar(30) DEFAULT NULL COMMENT '택배 송장 번호',
  `tax_code` char(1) NOT NULL DEFAULT '1' COMMENT '과세여부 (1=과세, 2=면세, 3=영세)',
  `seller_seq` int(11) unsigned NOT NULL COMMENT '판매자 시퀀스',
  `seller_master_seq` int(11) unsigned DEFAULT NULL COMMENT '총판 시퀀스',
  `seller_name` varchar(100) NOT NULL COMMENT '판매자명',
  `seller_master_name` varchar(100) DEFAULT NULL COMMENT '총판명',
  `reason` varchar(500) DEFAULT NULL COMMENT '교환/반품/취소 사유',
  `package_deli_cost` int(11) DEFAULT '0' COMMENT '묶음 배송비',
  `adjust_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '기정산 여부',
  `offline_pay_flag` char(1) DEFAULT NULL COMMENT '방문결제 처리 여부 Y/N',
  `offline_pay_date` datetime DEFAULT NULL COMMENT '방문결제 일자',
  `c10_date` datetime DEFAULT NULL COMMENT '결제일',
  `c20_date` datetime DEFAULT NULL COMMENT '주문확인일',
  `c30_date` datetime DEFAULT NULL COMMENT '발송완료일',
  `c50_date` datetime DEFAULT NULL COMMENT '배송완료일',
  `c55_date` datetime DEFAULT NULL COMMENT '구매확정일',
  `c60_date` datetime DEFAULT NULL COMMENT '교환요청일',
  `c61_date` datetime DEFAULT NULL COMMENT '교환요청 접수일',
  `c69_date` datetime DEFAULT NULL COMMENT '교환완료일',
  `c70_date` datetime DEFAULT NULL COMMENT '반품요청일',
  `c71_date` datetime DEFAULT NULL COMMENT '반품요청 접수일',
  `c79_date` datetime DEFAULT NULL COMMENT '반품완료',
  `c90_date` datetime DEFAULT NULL COMMENT '취소요청일',
  `c99_date` datetime DEFAULT NULL COMMENT '취소완료일',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `old_item_seq` varchar(10) DEFAULT NULL COMMENT ' 기상품번호(item_seq,seller_seq 매칭용)',
  `old_order_id` varchar(10) DEFAULT NULL COMMENT ' 기주분번호(order_seq 매칭용)',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_order_detail` (`item_seq`),
  KEY `idx2_sm_order_detail` (`status_code`),
  KEY `idx3_sm_order_detail` (`seller_seq`),
  KEY `idx4_sm_order_detail` (`seller_master_seq`),
  KEY `idx5_sm_order_detail` (`c10_date`),
  KEY `idx6_sm_order_detail` (`order_seq`),
  KEY `idx7_sm_order_detail` (`reg_date`),
  KEY `fk3_sm_order_detail` (`option_value_seq`),
  CONSTRAINT `fk1_sm_order_detail` FOREIGN KEY (`order_seq`) REFERENCES `sm_order` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_order_detail` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE SET NULL,
  CONSTRAINT `fk3_sm_order_detail` FOREIGN KEY (`option_value_seq`) REFERENCES `sm_item_option_value` (`seq`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문 상세';



# Dump of table sm_order_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_order_log`;

CREATE TABLE `sm_order_log` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(PK)',
  `order_detail_seq` int(11) unsigned NOT NULL COMMENT '상품주문번호',
  `contents` varchar(500) NOT NULL COMMENT '변경 내용',
  `login_seq` int(11) unsigned DEFAULT NULL COMMENT '변경자',
  `reg_date` datetime NOT NULL COMMENT '등록 일자',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문 변경 이력';



# Dump of table sm_order_pay
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_order_pay`;

CREATE TABLE `sm_order_pay` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(PK)',
  `order_seq` int(11) unsigned NOT NULL COMMENT '주문번호',
  `tid` varchar(50) DEFAULT NULL COMMENT 'PG 거래번호',
  `oid` varchar(50) DEFAULT NULL COMMENT '상점 주문번호',
  `mid` varchar(20) DEFAULT NULL COMMENT '상점 아이디',
  `pg_code` varchar(20) DEFAULT NULL COMMENT 'PG사 구분 코드',
  `pg_key` varchar(50) DEFAULT NULL COMMENT 'PG 상점 키',
  `tax_free_amount` int(11) DEFAULT NULL COMMENT '면세대상금액',
  `result_code` varchar(50) DEFAULT NULL COMMENT '처리결과 코드',
  `result_msg` varchar(200) DEFAULT NULL COMMENT '처리결과 메세지',
  `amount` int(11) DEFAULT NULL COMMENT '결제 금액',
  `method_code` varchar(12) DEFAULT NULL COMMENT '결제 방법',
  `org_code` varchar(10) DEFAULT NULL COMMENT '결제기관 코드',
  `org_name` varchar(50) DEFAULT NULL COMMENT '결제기관 명',
  `escrow_flag` char(1) DEFAULT NULL COMMENT '에스크로 적용 여부',
  `approval_no` varchar(20) DEFAULT NULL COMMENT '승인 번호',
  `card_month` varchar(2) DEFAULT NULL COMMENT '카드 할부 개월수',
  `interest_flag` char(1) DEFAULT NULL COMMENT '무이자 할부 여부',
  `cash_receipt_type_code` char(1) DEFAULT NULL COMMENT '현금영수증 유형(0:소득공제,1:지출증빙)',
  `cash_receipt_no` varchar(20) DEFAULT NULL COMMENT '현금영수증 번호',
  `account_no` varchar(20) DEFAULT NULL COMMENT '(가상)계좌번호',
  `trans_date` varchar(14) DEFAULT NULL COMMENT '거래일자(가상계좌일 경우 입금통보일자)',
  `reg_date` datetime NOT NULL COMMENT '등록일자',
  `old_order_id` varchar(10) DEFAULT NULL COMMENT ' 기주문아이디(order_seq매칭용)',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_order_pay` (`order_seq`),
  CONSTRAINT `fk1_sm_order_pay` FOREIGN KEY (`order_seq`) REFERENCES `sm_order` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제 내역 테이블';



# Dump of table sm_order_pay_cancel
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_order_pay_cancel`;

CREATE TABLE `sm_order_pay_cancel` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(PK)',
  `order_pay_seq` int(11) unsigned NOT NULL COMMENT '결제내역 시퀀스(FK)',
  `type_code` varchar(10) NOT NULL COMMENT '취소 유형(전체취소:ALL, 부분취소:PART)',
  `amount` int(11) NOT NULL COMMENT '취소금액',
  `order_detail_seq` int(11) unsigned DEFAULT NULL COMMENT '부분취소시 해당 상품주문번호',
  `result_code` varchar(10) DEFAULT NULL COMMENT '결과 코드',
  `result_msg` varchar(200) DEFAULT NULL COMMENT '결과 메세지',
  `reg_date` datetime NOT NULL COMMENT '등록 일자',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_order_pay_cancel` (`order_pay_seq`),
  CONSTRAINT `fk1_sm_order_pay_cancel` FOREIGN KEY (`order_pay_seq`) REFERENCES `sm_order_pay` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제 취소 내역 테이블';



# Dump of table sm_order_seq
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_order_seq`;

CREATE TABLE `sm_order_seq` (
  `seq` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='주문 시퀀스 테이블';

LOCK TABLES `sm_order_seq` WRITE;
/*!40000 ALTER TABLE `sm_order_seq` DISABLE KEYS */;

INSERT INTO `sm_order_seq` (`seq`)
VALUES
	(2);

/*!40000 ALTER TABLE `sm_order_seq` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_order_tax_request
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_order_tax_request`;

CREATE TABLE `sm_order_tax_request` (
  `order_seq` int(11) unsigned NOT NULL COMMENT '주문 시퀀스',
  `business_num` varchar(15) DEFAULT NULL COMMENT '사업자 번호',
  `business_company` varchar(100) DEFAULT NULL COMMENT '상호(법인명)',
  `business_name` varchar(100) DEFAULT NULL COMMENT '대표자',
  `business_addr` varchar(600) DEFAULT NULL COMMENT '소재지',
  `business_cate` varchar(100) DEFAULT NULL COMMENT '업태',
  `business_item` varchar(100) DEFAULT NULL COMMENT '종목',
  `request_email` varchar(200) DEFAULT NULL COMMENT '수신 이메일',
  `request_name` varchar(100) DEFAULT NULL COMMENT '수신자명',
  `request_cell` varchar(200) DEFAULT NULL COMMENT '수신자 전화번호',
  `request_date` datetime NOT NULL COMMENT '수신요청 시각',
  `request_flag` char(1) NOT NULL DEFAULT 'N' COMMENT '상태 (Y=완료, N=요청중)',
  `complete_date` datetime DEFAULT NULL COMMENT '완료처리 시각',
  PRIMARY KEY (`order_seq`),
  CONSTRAINT `sm_order_tax_request_ibfk_1` FOREIGN KEY (`order_seq`) REFERENCES `sm_order` (`seq`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='세금계산서 요청';



# Dump of table sm_pay_method
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_pay_method`;

CREATE TABLE `sm_pay_method` (
  `seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `name` varchar(50) NOT NULL COMMENT '결제 수단명',
  `value` varchar(50) NOT NULL COMMENT '결제 수단 코드',
  `fee_rate1` float DEFAULT NULL COMMENT '수수료(서울)',
  `fee_rate2` float DEFAULT NULL COMMENT '수수료(지방)',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결제 수단 정보';

LOCK TABLES `sm_pay_method` WRITE;
/*!40000 ALTER TABLE `sm_pay_method` DISABLE KEYS */;

INSERT INTO `sm_pay_method` (`seq`, `name`, `value`, `fee_rate1`, `fee_rate2`)
VALUES
	(1,'신용카드(ISP/안심클릭)','CARD1',3.3,8.3),
	(2,'신용카드','CARD2',3.3,8.3),
	(3,'ARS(신용카드)','ARS',3.3,8.3),
	(4,'무통장 입금','CASH',0,5),
	(5,'방문결제','OFFLINE',3.3,8.3),
	(6,'후청구(신용카드)','NP_CARD2',3.3,8.3),
	(7,'후청구(무통장입금)','NP_CASH',0,5),
	(8,'후청구(신용카드-ISP/안심클릭)','NP_CARD1',3.3,8.3);

/*!40000 ALTER TABLE `sm_pay_method` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_point
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_point`;

CREATE TABLE `sm_point` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '포인트 시퀀스',
  `member_seq` int(11) unsigned NOT NULL COMMENT '멤버 시퀀스',
  `admin_seq` int(11) unsigned DEFAULT NULL COMMENT '포인트 지급자 시퀀스(관리자)',
  `point` int(11) NOT NULL COMMENT '포인트',
  `useable_point` int(11) NOT NULL COMMENT '사용가능 포인트',
  `valid_flag` char(1) NOT NULL COMMENT '유효플래그(Y:사용 가능, N:사용 불가)',
  `reserve_code` char(1) DEFAULT NULL COMMENT '포인트 적립방식 코드',
  `reserve_comment` varchar(200) DEFAULT NULL COMMENT '포인트 적립방식 코멘트',
  `end_date` varchar(10) NOT NULL COMMENT '포인트 유효기간',
  `reg_date` datetime NOT NULL COMMENT '포인트 발생/등록일',
  PRIMARY KEY (`seq`),
  KEY `fk2_sm_point` (`admin_seq`),
  KEY `fk1_sm_point` (`member_seq`),
  CONSTRAINT `fk1_sm_point` FOREIGN KEY (`member_seq`) REFERENCES `sm_member` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_point` FOREIGN KEY (`admin_seq`) REFERENCES `sm_admin` (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='포인트 적립내역';



# Dump of table sm_point_history
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_point_history`;

CREATE TABLE `sm_point_history` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '포인트 히스토리 시퀀스',
  `member_seq` int(11) unsigned NOT NULL COMMENT '멤버 시퀀스',
  `order_seq` int(11) unsigned DEFAULT NULL COMMENT '취소/환불 주문번호',
  `admin_seq` int(11) unsigned DEFAULT NULL COMMENT '포인트 지급자 시퀀스(관리자)',
  `point` int(11) DEFAULT NULL COMMENT '포인트',
  `status_code` char(1) NOT NULL COMMENT '상태 코드(S:적립, U:사용, D:소멸,C:취소적립)',
  `order_detail_seq` int(11) DEFAULT NULL COMMENT '부분취소 상세주문번호',
  `note` varchar(300) DEFAULT NULL COMMENT '비고',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_point_history` (`member_seq`),
  KEY `idx2_sm_point_history` (`order_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='포인트 히스토리';



# Dump of table sm_point_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_point_log`;

CREATE TABLE `sm_point_log` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '포인트 로그 시퀀스',
  `point_seq` int(11) unsigned NOT NULL COMMENT 'sm_point 시퀀스(fk)',
  `member_seq` int(11) unsigned NOT NULL COMMENT '멤버 시퀀스',
  `point` int(11) DEFAULT NULL COMMENT '포인트',
  `status_code` char(1) NOT NULL COMMENT '상태 코드(S:적립, U:사용, D:소멸, E:소진,C:취소적립)',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_point_log` (`point_seq`),
  KEY `fk2_sm_point_log` (`member_seq`),
  CONSTRAINT `fk1_sm_point_log` FOREIGN KEY (`point_seq`) REFERENCES `sm_point` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_point_log` FOREIGN KEY (`member_seq`) REFERENCES `sm_member` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='포인트 로그';



# Dump of table sm_seller
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_seller`;

CREATE TABLE `sm_seller` (
  `seq` int(11) unsigned NOT NULL COMMENT '시퀀스(PK/FK)',
  `adjust_grade_code` char(1) NOT NULL DEFAULT 'C' COMMENT '정산등급(A:월3회,B:월2회,C:월1회)',
  `ceo_name` varchar(50) NOT NULL COMMENT '대표자명',
  `biz_no` char(10) NOT NULL COMMENT '사업자번호 10자리',
  `biz_type` varchar(100) NOT NULL COMMENT '업태',
  `biz_kind` varchar(100) NOT NULL COMMENT '업종',
  `tel` varchar(30) NOT NULL COMMENT '대표 전화번호',
  `fax` varchar(30) DEFAULT NULL COMMENT '팩스 번호',
  `postcode` varchar(10) NOT NULL COMMENT '우편번호',
  `addr1` varchar(200) NOT NULL COMMENT '주소',
  `addr2` varchar(200) NOT NULL COMMENT '주소 상세',
  `sales_name` varchar(100) NOT NULL COMMENT '담당자명',
  `sales_tel` varchar(30) NOT NULL COMMENT '담당자 전화번호',
  `sales_cell` varchar(30) NOT NULL COMMENT '담당자 휴대폰번호',
  `sales_email` varchar(100) NOT NULL COMMENT '담당자 이메일',
  `account_bank` varchar(50) DEFAULT NULL COMMENT '입금 계좌 은행명',
  `account_no` varchar(50) DEFAULT NULL COMMENT '입금 계좌 번호',
  `account_owner` varchar(50) DEFAULT NULL COMMENT '입금 계좌 예금주',
  `master_seq` int(11) unsigned DEFAULT NULL COMMENT '총판 시퀀스',
  `approval_date` datetime DEFAULT NULL COMMENT '승인 일자',
  `stop_date` datetime DEFAULT NULL COMMENT '중지 일자',
  `close_date` datetime DEFAULT NULL COMMENT '폐점 일자',
  `default_deli_company` int(11) unsigned DEFAULT NULL COMMENT '기본택배사',
  `return_name` varchar(100) DEFAULT NULL COMMENT '반품담당자',
  `comment` text COMMENT '업체 코멘트',
  `return_cell` varchar(30) DEFAULT NULL COMMENT '반품담당자 연락처',
  `return_postcode` varchar(10) DEFAULT NULL COMMENT '반품주소지 우편번호',
  `return_addr1` varchar(200) DEFAULT NULL COMMENT '반품 주소',
  `return_addr2` varchar(200) DEFAULT NULL COMMENT '반품 상세주소',
  `intro` text COMMENT '공급사소개',
  `main_item` text COMMENT '주요취급상품',
  `adjust_name` varchar(50) DEFAULT NULL COMMENT '정산 담당자명',
  `adjust_email` varchar(100) DEFAULT NULL COMMENT '정산 담당자 이메일',
  `adjust_tel` varchar(30) DEFAULT NULL COMMENT '정산 담당자 연락처',
  `jachigu_code` varchar(3) DEFAULT NULL COMMENT '자치구 코드',
  `old_seq` int(10) unsigned DEFAULT NULL COMMENT '국제몰 DB이관용(작업 완료 후 삭제)',
  `auth_category` varchar(50) DEFAULT NULL COMMENT '인증구분',
  `total_sales` varchar(100) DEFAULT NULL COMMENT '매출액',
  `amount_of_worker` varchar(100) DEFAULT NULL COMMENT '종업원수',
  `tax_type_flag` char(1) DEFAULT NULL COMMENT '면세기업 여부 (Y:과세, N:면세)',
  `social_activity` text COMMENT '사회적 경제활동',
  PRIMARY KEY (`seq`),
  CONSTRAINT `fk1_sm_seller` FOREIGN KEY (`seq`) REFERENCES `sm_user` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='판매자/총판';

LOCK TABLES `sm_seller` WRITE;
/*!40000 ALTER TABLE `sm_seller` DISABLE KEYS */;

INSERT INTO `sm_seller` (`seq`, `adjust_grade_code`, `ceo_name`, `biz_no`, `biz_type`, `biz_kind`, `tel`, `fax`, `postcode`, `addr1`, `addr2`, `sales_name`, `sales_tel`, `sales_cell`, `sales_email`, `account_bank`, `account_no`, `account_owner`, `master_seq`, `approval_date`, `stop_date`, `close_date`, `default_deli_company`, `return_name`, `comment`, `return_cell`, `return_postcode`, `return_addr1`, `return_addr2`, `intro`, `main_item`, `adjust_name`, `adjust_email`, `adjust_tel`, `jachigu_code`, `old_seq`, `auth_category`, `total_sales`, `amount_of_worker`, `tax_type_flag`, `social_activity`)
VALUES
	(3,'C','홍길동','0123456789','소프트웨어','테스트','02-555-5555','02-333-3333','06159','서울특별시 강남구 테헤란로 427 (삼성동)','테스트 주소','김테스트','02-1111-2222','010-1111-2222','test@test.com','테스트은행','I9SRcERfhi9AVq7wJy9GkA==','송테스트',NULL,'2016-05-15 00:08:08','2016-05-15 00:08:02',NULL,19,'김테스트',NULL,'010-1234-5678','06159','서울특별시 강남구 테헤란로 427 (삼성동)','테스트 주소222','&lt;p&gt;공급사 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;공급사 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;공급사 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;공급사 내용이 들어갑니다&lt;/p&gt;','&lt;p&gt;주요 취급상품 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;주요 취급상품 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;주요 취급상품 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;주요 취급상품 내용이 들어갑니다&lt;/p&gt;','김정산','test2@test.com','02-888-8888','01',NULL,'99','5억원','50명','Y','&lt;p&gt;사회적 경제활동 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;사회적 경제활동 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;사회적 경제활동 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;사회적 경제활동 내용이 들어갑니다&lt;/p&gt;\r\n\r\n&lt;p&gt;사회적 경제활동 내용이 들어갑니다&lt;/p&gt;');

/*!40000 ALTER TABLE `sm_seller` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_sms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_sms`;

CREATE TABLE `sm_sms` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `title` varchar(100) NOT NULL COMMENT '제목',
  `type_code` char(1) NOT NULL COMMENT '발송대상(C:고객, S:판매자)',
  `status_type` char(1) NOT NULL COMMENT '발송상태타입(O:주문, S:판매자, C:회원)',
  `status_code` varchar(2) NOT NULL COMMENT '발송상태코드',
  `content` varchar(160) NOT NULL COMMENT '발송내용',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `mall_seq` int(11) DEFAULT NULL COMMENT '몰시퀀스',
  PRIMARY KEY (`seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='SMS 메세지 관리';

LOCK TABLES `sm_sms` WRITE;
/*!40000 ALTER TABLE `sm_sms` DISABLE KEYS */;

INSERT INTO `sm_sms` (`seq`, `title`, `type_code`, `status_type`, `status_code`, `content`, `reg_date`, `mall_seq`)
VALUES
	(1,'주문완료 알림','C','O','10','[국제몰] 주문이 완료되었습니다. 주문NO: [orderSeq]','2015-11-12 20:31:47',NULL),
	(2,'주문 배송중 변경시  발송 알림','C','O','30','[국제몰] 상품출고. deliCompanyName:deliNo','2015-11-12 20:42:06',NULL),
	(3,'견적요청 접수 알림','S','E','1','[국제몰] 견적요청 접수 알림.\r\n어드민 견적관리에서 확인 후 등록 요망!','2016-03-17 18:06:20',NULL);

/*!40000 ALTER TABLE `sm_sms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_user`;

CREATE TABLE `sm_user` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(고유번호)',
  `id` varchar(50) NOT NULL COMMENT '이메일/아이디',
  `password` varchar(65) NOT NULL COMMENT '패스워드',
  `name` varchar(50) NOT NULL COMMENT '이름/판매자명(법인명)/쇼핑몰명',
  `nickname` varchar(100) DEFAULT NULL COMMENT '닉네임',
  `type_code` char(1) NOT NULL COMMENT '유형 (A:관리자,S:판매자,D:총판,C:회원,M:쇼핑몰)',
  `status_code` char(1) NOT NULL COMMENT '상태(H:승인대기, Y:정상, N:중지, X:폐점/탈퇴)',
  `grade_code` int(1) NOT NULL DEFAULT '9' COMMENT '등급',
  `login_token` varchar(50) DEFAULT NULL COMMENT '로그인 토큰(세션 유지)',
  `last_ip` varchar(15) DEFAULT NULL COMMENT '마지막 접속 아이피',
  `last_date` datetime DEFAULT NULL COMMENT '마지막 접속일',
  `temp_password` varchar(32) DEFAULT NULL COMMENT '임시비밀번호',
  `temp_password_date` datetime DEFAULT NULL COMMENT '임시 비밀번호 발급일',
  `mod_password_date` datetime DEFAULT NULL COMMENT '비밀번호 변경일',
  `mod_date` datetime DEFAULT NULL COMMENT '변경일',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  `old_seq` int(10) unsigned DEFAULT NULL COMMENT '국제몰 PK',
  `encrypt_flag` char(1) NOT NULL DEFAULT 'Y' COMMENT '국제몰 패스워드 암호화 처리 여부',
  PRIMARY KEY (`seq`),
  KEY `idx1_sm_user` (`type_code`),
  KEY `idx2_sm_user` (`status_code`),
  KEY `idx3_sm_user` (`login_token`),
  KEY `idx4_sm_user` (`reg_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='유저 공통';

LOCK TABLES `sm_user` WRITE;
/*!40000 ALTER TABLE `sm_user` DISABLE KEYS */;

INSERT INTO `sm_user` (`seq`, `id`, `password`, `name`, `nickname`, `type_code`, `status_code`, `grade_code`, `login_token`, `last_ip`, `last_date`, `temp_password`, `temp_password_date`, `mod_password_date`, `mod_date`, `reg_date`, `old_seq`, `encrypt_flag`)
VALUES
	(1,'kookje','x','국제몰','국제몰','M','Y',0,NULL,NULL,NULL,NULL,NULL,NULL,'2016-05-14 17:24:46','2016-05-14 13:20:56',NULL,'Y'),
	(2,'kookje','37268335dd6931045bdcdf92623ff819a64244b53d0e746d438797349d4da578','관리자','국제몰','A','Y',0,'3e3dae1e-aff4-40f2-bb8e-8537ad5e13ab','218.38.86.28','2016-06-03 12:17:27',NULL,NULL,NULL,NULL,'2016-05-14 15:02:32',NULL,'Y'),
	(3,'testseller','52cafaabb32a7dbe91ff896e55c27b63221a23e267c85a5055cde267acd67b1c','테스트판매자','','S','Y',9,'e266a5b1-9dc6-465e-b213-bdbe04f8b301','218.38.86.28','2016-06-03 12:21:09',NULL,NULL,NULL,'2016-06-03 12:20:34','2016-05-14 17:34:58',NULL,'Y'),
	(4,'tttt','7d34c544b346a597281e628d2eb0447c8a115eb282a0ca4e710c209382873ccd','김갑환',NULL,'C','Y',9,'f8d4d1a4-8031-4888-ab44-0f6594b68527','218.38.86.28','2016-05-19 12:08:29',NULL,NULL,NULL,NULL,'2016-05-15 00:03:47',NULL,'Y');

/*!40000 ALTER TABLE `sm_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sm_wish
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sm_wish`;

CREATE TABLE `sm_wish` (
  `seq` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스(pk)',
  `member_seq` int(11) unsigned NOT NULL COMMENT '회원 시퀀스(fk)',
  `item_seq` int(11) unsigned NOT NULL COMMENT '상품 시퀀스(fk)',
  `option_value_seq` int(11) unsigned DEFAULT NULL COMMENT '옵션 시퀀스(fk)',
  `deli_prepaid_flag` char(1) DEFAULT NULL COMMENT '배송비 선결제여부(Y:선결제,N:착불)',
  `reg_date` datetime NOT NULL COMMENT '등록일',
  PRIMARY KEY (`seq`),
  KEY `fk1_sm_wish` (`option_value_seq`),
  KEY `fk2_sm_wish` (`item_seq`),
  CONSTRAINT `fk1_sm_wish` FOREIGN KEY (`option_value_seq`) REFERENCES `sm_item_option_value` (`seq`) ON DELETE CASCADE,
  CONSTRAINT `fk2_sm_wish` FOREIGN KEY (`item_seq`) REFERENCES `sm_item` (`seq`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='위시리스트';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
