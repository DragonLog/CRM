/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 80025
Source Host           : 192.168.137.132:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 80025
File Encoding         : 65001

Date: 2021-08-17 15:14:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_activity`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('96ee81f9ecc44490a342b67e300f3462', '40f6cdea0bd34aceb77492a1656d9fb3', '招聘会', '2021-08-09', '2021-08-18', '48492', '这次招聘会是为了招聘大学生！', '2021-08-17 14:02:20', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('a3a2a5e54d4446d0b2d77d93279b2e2f', '40f6cdea0bd34aceb77492a1656d9fb3', '拍卖会', '2021-08-11', '2021-08-19', '89783', '这次拍卖会主要是一些明清瓷器的拍卖！', '2021-08-17 14:01:16', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('aa6c296eaca34d6995de0be78efe3e1a', '06f5fc056eac41558a964f96daa7f27c', '回收废品', '2021-08-03', '2021-08-18', '0', '主要是把公司的可回收废品做一次清仓处理', '2021-08-17 14:04:05', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('ab42aad9823e4e4ea38e8dcc6e795a2e', '40f6cdea0bd34aceb77492a1656d9fb3', '楼盘开市', '2021-08-17', '2021-08-18', '9999', '该楼盘封顶，第一次面向全体市民开市！', '2021-08-17 14:05:03', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('bd24647c349a461499dd785744f2affe', '40f6cdea0bd34aceb77492a1656d9fb3', '特产售卖', '2021-08-19', '2021-08-24', '97428', '乡村土特产的集中售卖！', '2021-08-17 14:05:43', '张三', '2021-08-17 14:06:20', '张三');
INSERT INTO `tbl_activity` VALUES ('c553b8d24f5346418381158e50fb256e', '06f5fc056eac41558a964f96daa7f27c', '展销会', '2021-08-08', '2021-08-18', '6371', '这次展销会主要是关于农产品的！', '2021-08-17 13:59:58', '张三', null, null);

-- ----------------------------
-- Table structure for `tbl_activity_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
INSERT INTO `tbl_activity_remark` VALUES ('039348d82dfc42dfa715e02a86338054', '此次活动现场有小礼物赠送', '2021-08-17 14:08:12', '张三', null, null, '0', 'ab42aad9823e4e4ea38e8dcc6e795a2e');
INSERT INTO `tbl_activity_remark` VALUES ('28acc6e5ee374a59a3ef053914403886', '对一些贫困户有重点帮扶', '2021-08-17 14:07:40', '张三', '2021-08-17 14:07:46', '张三', '1', 'bd24647c349a461499dd785744f2affe');
INSERT INTO `tbl_activity_remark` VALUES ('729062bac5b4494fad2e71fad89b8c01', '特产售卖不限种类，都可以售卖！', '2021-08-17 14:07:19', '张三', null, null, '0', 'bd24647c349a461499dd785744f2affe');
INSERT INTO `tbl_activity_remark` VALUES ('b93cdedf60b34fe8ac9da2f6c0eaa39b', '以即将毕业的大学生为主！', '2021-08-17 14:08:37', '张三', null, null, '0', '96ee81f9ecc44490a342b67e300f3462');

-- ----------------------------
-- Table structure for `tbl_clue`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_clue_activity_relation`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_clue_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_contacts`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
INSERT INTO `tbl_contacts` VALUES ('2f39df1c3aa949569ac53fa11ec4b2e4', '40f6cdea0bd34aceb77492a1656d9fb3', '聊天', '5bd42f6f659c473ead81582d9fbab8ab', '刘强东', '先生', 'lqd@jd.com', '8592940699', '董事长', null, '张三', '2021-08-17 15:08:39', null, null, '京东的物流和售后是蛮好的！', '很满意', '2021-08-27', '北京京东集团');
INSERT INTO `tbl_contacts` VALUES ('98b936197c854cab90388f4155c9aaee', '40f6cdea0bd34aceb77492a1656d9fb3', '公开媒介', 'a265eaf14b88449289a768ab151b2af7', '马云', '先生', 'mayun@alibaba.com', '84792074891', '董事长', null, '张三', '2021-08-17 14:14:35', null, null, '需要借助阿里巴巴的云平台！', '比较顺利！', '2021-08-31', '杭州阿里巴巴');
INSERT INTO `tbl_contacts` VALUES ('b83cf78846564187aeeee389534c503c', '06f5fc056eac41558a964f96daa7f27c', '交易会', 'a2e25b96284f40cda1a95dbed7315a74', '任正非', '先生', 'rzf@huawei.com', '74897389112', '董事长', null, '张三', '2021-08-17 14:18:41', null, null, '华为的5G领域是非常强的！', '希望深度合作', '2021-09-03', '深圳华为');

-- ----------------------------
-- Table structure for `tbl_contacts_activity_relation`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
INSERT INTO `tbl_contacts_activity_relation` VALUES ('0e728ed7fbbb42068159cbb61c6eb7d5', '2f39df1c3aa949569ac53fa11ec4b2e4', 'bd24647c349a461499dd785744f2affe');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('3a1d04c9b46c4244b0dca9fc02a548df', '2f39df1c3aa949569ac53fa11ec4b2e4', 'aa6c296eaca34d6995de0be78efe3e1a');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('4c378b426c7e46ee8254ca9876f6e838', '98b936197c854cab90388f4155c9aaee', 'c553b8d24f5346418381158e50fb256e');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('4e4634785ddc42fb9e825017f4bd0c70', 'b83cf78846564187aeeee389534c503c', 'bd24647c349a461499dd785744f2affe');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('a8bb5dcfbcd24311af7560bc8fc69ab3', '98b936197c854cab90388f4155c9aaee', '96ee81f9ecc44490a342b67e300f3462');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('f13989ae8a594b288ecf282fd475fb13', 'b83cf78846564187aeeee389534c503c', 'a3a2a5e54d4446d0b2d77d93279b2e2f');

-- ----------------------------
-- Table structure for `tbl_contacts_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
INSERT INTO `tbl_contacts_remark` VALUES ('20fc9fb6b3d54a8eb1f18ebde50bf781', '将和华为进行深度合作！', '张三', '2021-08-17 14:18:41', null, null, '0', 'b83cf78846564187aeeee389534c503c');
INSERT INTO `tbl_contacts_remark` VALUES ('449f13e3170c40c4979d22f0d82b89fa', '京东各地都有仓库！', '张三', '2021-08-17 15:08:39', null, null, '0', '2f39df1c3aa949569ac53fa11ec4b2e4');
INSERT INTO `tbl_contacts_remark` VALUES ('e377f69090004b3588dcb23dab9bf393', '阿里是很重要的客户', '张三', '2021-08-17 14:14:35', null, null, '0', '98b936197c854cab90388f4155c9aaee');

-- ----------------------------
-- Table structure for `tbl_customer`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('5bd42f6f659c473ead81582d9fbab8ab', '40f6cdea0bd34aceb77492a1656d9fb3', '京东', 'www.test.com', '10086', '张三', '2021-08-17 14:24:37', null, null, '差点超出预算！', '2021-09-04', null, null);
INSERT INTO `tbl_customer` VALUES ('a265eaf14b88449289a768ab151b2af7', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', 'www.alibaba.com', '84792074891', '张三', '2021-08-17 14:14:35', null, null, '比较顺利！', '2021-08-31', '需要借助阿里巴巴的云平台！', '杭州阿里巴巴');
INSERT INTO `tbl_customer` VALUES ('a2e25b96284f40cda1a95dbed7315a74', '06f5fc056eac41558a964f96daa7f27c', '华为', 'www.huawei.com', '74897389112', '张三', '2021-08-17 14:18:41', null, null, '希望深度合作', '2021-09-03', '华为的5G领域是非常强的！', '深圳华为');

-- ----------------------------
-- Table structure for `tbl_customer_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
INSERT INTO `tbl_customer_remark` VALUES ('2e1585b7d1c44b54be21da8e5a56d1ff', '京东各地都有仓库！', '张三', '2021-08-17 15:08:39', null, null, '0', '5bd42f6f659c473ead81582d9fbab8ab');
INSERT INTO `tbl_customer_remark` VALUES ('6e337818f604405d9afaf1c16f07261f', '将和华为进行深度合作！', '张三', '2021-08-17 14:18:41', null, null, '0', 'a2e25b96284f40cda1a95dbed7315a74');
INSERT INTO `tbl_customer_remark` VALUES ('76adfc71ff784ace98379f3c83775070', '阿里是很重要的客户', '张三', '2021-08-17 14:14:35', null, null, '0', 'a265eaf14b88449289a768ab151b2af7');

-- ----------------------------
-- Table structure for `tbl_dic_type`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for `tbl_dic_value`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for `tbl_tran`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
INSERT INTO `tbl_tran` VALUES ('342673e5918f4176951e0eb15273a0a7', '40f6cdea0bd34aceb77492a1656d9fb3', '96789', '云平台共建', '2021-09-04', 'a265eaf14b88449289a768ab151b2af7', '07成交', 'web调研', '新业务', '96ee81f9ecc44490a342b67e300f3462', '98b936197c854cab90388f4155c9aaee', '张三', '2021-08-17 14:22:29', '张三', '2021-08-17 14:22:49', '提升我司云实力的很好的机会！', '交谈融洽！', '2021-08-18');
INSERT INTO `tbl_tran` VALUES ('666a5c2a84ee478fa7f26acd30c66114', '06f5fc056eac41558a964f96daa7f27c', '7839423', '芯片采购', '2021-08-18', 'a2e25b96284f40cda1a95dbed7315a74', '07成交', null, '交易会', 'bd24647c349a461499dd785744f2affe', 'b83cf78846564187aeeee389534c503c', '张三', '2021-08-17 14:18:41', '张三', '2021-08-17 14:20:34', '华为的5G领域是非常强的！', '希望深度合作', '2021-09-03');
INSERT INTO `tbl_tran` VALUES ('975a2286d30547d2b039650ef574cae8', '40f6cdea0bd34aceb77492a1656d9fb3', '96789', '手机采购', '2021-08-29', '5bd42f6f659c473ead81582d9fbab8ab', '05提案/报价', '外部介绍', '新业务', 'bd24647c349a461499dd785744f2affe', 'b83cf78846564187aeeee389534c503c', '张三', '2021-08-17 14:24:37', '张三', '2021-08-17 14:24:50', '在京东上采购一批华为手机！', '差点超出预算！', '2021-09-04');
INSERT INTO `tbl_tran` VALUES ('eebacf556520423ebb82f42fcce7c5eb', '40f6cdea0bd34aceb77492a1656d9fb3', '8420342', '平台销售', '2021-09-04', '5bd42f6f659c473ead81582d9fbab8ab', '05提案/报价', null, '聊天', 'c553b8d24f5346418381158e50fb256e', '2f39df1c3aa949569ac53fa11ec4b2e4', '张三', '2021-08-17 15:08:39', null, null, '京东的物流和售后是蛮好的！', '很满意', '2021-08-27');

-- ----------------------------
-- Table structure for `tbl_tran_history`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
INSERT INTO `tbl_tran_history` VALUES ('74aade5014824b0ea3fa743e6628b1ce', '08丢失的线索', '7839423', '2021-08-18', '2021-08-17 14:20:20', '张三', '666a5c2a84ee478fa7f26acd30c66114');
INSERT INTO `tbl_tran_history` VALUES ('8156a419f33740edbc07a0ade08c7eae', '09因竞争丢失关闭', '96789', '2021-09-04', '2021-08-17 14:22:46', '张三', '342673e5918f4176951e0eb15273a0a7');
INSERT INTO `tbl_tran_history` VALUES ('8c00dda26de4422e858fd46ab092eac5', '05提案/报价', '8420342', '2021-09-04', '2021-08-17 15:08:39', '张三', 'eebacf556520423ebb82f42fcce7c5eb');
INSERT INTO `tbl_tran_history` VALUES ('9401b1e7efab4e4d892cfb2156f72e5b', '08丢失的线索', '96789', '2021-08-29', '2021-08-17 14:24:49', '张三', '975a2286d30547d2b039650ef574cae8');
INSERT INTO `tbl_tran_history` VALUES ('9add4c2c3060482c8bb2931e6d56ddb8', '07成交', '7839423', '2021-08-18', '2021-08-17 14:20:34', '张三', '666a5c2a84ee478fa7f26acd30c66114');
INSERT INTO `tbl_tran_history` VALUES ('9b547e32068f47f3b30475246beb5bed', '03价值建议', '7839423', '2021-08-18', '2021-08-17 14:18:41', '张三', '666a5c2a84ee478fa7f26acd30c66114');
INSERT INTO `tbl_tran_history` VALUES ('a61ab4e4f86648928317dcb0fc6aea14', '05提案/报价', '96789', '2021-08-29', '2021-08-17 14:24:50', '张三', '975a2286d30547d2b039650ef574cae8');
INSERT INTO `tbl_tran_history` VALUES ('c11d71fe98bf4e7188b6503ed9ba645f', '04确定决策者', '96789', '2021-08-29', '2021-08-17 14:24:37', '张三', '975a2286d30547d2b039650ef574cae8');
INSERT INTO `tbl_tran_history` VALUES ('cebcc05188eb435298f4409cb4526bcf', '07成交', '96789', '2021-09-04', '2021-08-17 14:22:49', '张三', '342673e5918f4176951e0eb15273a0a7');
INSERT INTO `tbl_tran_history` VALUES ('f6b651d0c992459fa585add7b0fbbe74', '02需求分析', '96789', '2021-09-04', '2021-08-17 14:22:29', '张三', '342673e5918f4176951e0eb15273a0a7');

-- ----------------------------
-- Table structure for `tbl_tran_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------

-- ----------------------------
-- Table structure for `tbl_user`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\r\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2021-11-27 21:50:05', '1', 'A001', null, '2018-11-22 12:11:40', '李四', null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2021-11-30 23:50:55', '1', 'A001', null, '2018-11-22 11:37:34', '张三', null, null);
