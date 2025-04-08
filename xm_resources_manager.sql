/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : xm_resources_manager

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 19/11/2023 09:27:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员', 'http://localhost:9090/files/1697438073596-avatar.png', 'ADMIN', '13677889922', 'admin@xm.com');

-- ----------------------------
-- Table structure for askapply
-- ----------------------------
DROP TABLE IF EXISTS `askapply`;
CREATE TABLE `askapply`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '审批说明',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请假事由',
  `employee_id` int(10) NULL DEFAULT NULL COMMENT '员工ID',
  `department_id` int(10) NULL DEFAULT NULL COMMENT '部门ID',
  `start` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '开始日期',
  `end` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '结束日期',
  `process` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '当前进度',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审批状态',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审批说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '请假信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of askapply
-- ----------------------------
INSERT INTO `askapply` VALUES (2, '回老家详情', 1, 1, '2023-11-16', '2023-11-18', '审批结束', '管理员审批不通过', '工作这么忙，回家相什么亲？？');
INSERT INTO `askapply` VALUES (3, '回老家相亲，这次对我真的很重要', 1, 1, '2023-11-16', '2023-11-18', '审批结束', '主管审批不通过', '上次都给你毙掉了，还申请！！');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '部门名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '部门描述',
  `employee_id` int(10) NULL DEFAULT NULL COMMENT '主管ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '部门信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '技术部', '这是技术部', 4);
INSERT INTO `department` VALUES (2, '财务部', '这是财务部', 5);
INSERT INTO `department` VALUES (3, '运营部', '这是运营部', 6);
INSERT INTO `department` VALUES (4, '后勤部', '这是后勤部', NULL);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `level` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '身份',
  `department_id` int(10) NULL DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '员工信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, 'zhangsan', '123456', '张三', 'http://localhost:9090/files/1700032882233-柴犬.jpeg', 'USER', '18877776666', 'zhangsan@xm.com', '员工', 1);
INSERT INTO `employee` VALUES (3, 'lisi', '123456', '李四', 'http://localhost:9090/files/1700035824249-柯基.jpeg', 'USER', '18899990000', 'lisi@xm.com', '员工', 2);
INSERT INTO `employee` VALUES (4, 'libotao', '123456', '李波涛', 'http://localhost:9090/files/1700038468529-拉布拉多.jpeg', 'USER', '18877776666', 'libotao@xm.com', '主管', 1);
INSERT INTO `employee` VALUES (5, 'zhanghuahua', '123456', '张华华', 'http://localhost:9090/files/1700038508752-伯曼猫.jpg', 'USER', '18800009999', 'zhanghuahua@xm.com', '主管', 2);
INSERT INTO `employee` VALUES (6, 'wangwei', '123', '王维', 'http://localhost:9090/files/1700229997831-拉布拉多.jpeg', 'USER', '18899990000', 'wangwei@xm.com', '主管', 3);

-- ----------------------------
-- Table structure for financial
-- ----------------------------
DROP TABLE IF EXISTS `financial`;
CREATE TABLE `financial`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支出说明',
  `price` double(10, 2) NULL DEFAULT NULL COMMENT '支出金额',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支出时间',
  `department_id` int(10) NULL DEFAULT NULL COMMENT '支出部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '财务支出表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of financial
-- ----------------------------
INSERT INTO `financial` VALUES (1, '研发投入', 20000.00, '2023-05-25 10:00:00', 1);
INSERT INTO `financial` VALUES (2, '购买研发器材', 18000.00, '2023-06-22 10:00:00', 1);
INSERT INTO `financial` VALUES (3, '发工资', 100000.00, '2023-04-13 18:00:00', 2);
INSERT INTO `financial` VALUES (4, '发工资', 120000.00, '2023-02-18 17:00:00', 2);
INSERT INTO `financial` VALUES (5, '广告投放', 30000.00, '2023-01-11 00:00:00', 3);
INSERT INTO `financial` VALUES (6, '招聘新员工', 80000.00, '2023-03-16 00:00:00', 4);
INSERT INTO `financial` VALUES (7, '研发投入', 20000.00, '2023-01-09 00:00:00', 1);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '今天系统正式上线，开始内测', '今天系统正式上线，开始内测', '2023-09-05', 'admin');
INSERT INTO `notice` VALUES (2, '所有功能都已完成，可以正常使用', '所有功能都已完成，可以正常使用', '2023-09-05', 'admin');
INSERT INTO `notice` VALUES (3, '今天天气很不错，可以出去一起玩了', '今天天气很不错，可以出去一起玩了', '2023-09-05', 'admin');

-- ----------------------------
-- Table structure for resourceapply
-- ----------------------------
DROP TABLE IF EXISTS `resourceapply`;
CREATE TABLE `resourceapply`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `employee_id` int(10) NULL DEFAULT NULL COMMENT '员工ID',
  `department_id` int(10) NULL DEFAULT NULL COMMENT '部门ID',
  `resources_id` int(10) NULL DEFAULT NULL COMMENT '资产ID',
  `num` int(10) NULL DEFAULT NULL COMMENT '申请数量',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '申请时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审批状态',
  `process` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审批进度',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审批说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '资产申请审批表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resourceapply
-- ----------------------------
INSERT INTO `resourceapply` VALUES (4, 1, 1, 4, 2, '2023-11-17 17:18:07', '审批通过', '审批结束', NULL);
INSERT INTO `resourceapply` VALUES (5, 1, 1, 3, 1, '2023-11-17 17:18:22', '主管审批不通过', '审批结束', '你一次性还想搞两台电脑！！！');
INSERT INTO `resourceapply` VALUES (6, 1, 1, 1, 1, '2023-11-17 17:18:26', '审批通过', '审批结束', NULL);
INSERT INTO `resourceapply` VALUES (7, 3, 2, 4, 1, '2023-11-17 17:18:47', '主管审批不通过', '审批结束', '现在资源紧张，先坚持下');
INSERT INTO `resourceapply` VALUES (8, 3, 2, 1, 1, '2023-11-17 17:18:51', '审批通过', '审批结束', NULL);

-- ----------------------------
-- Table structure for resources
-- ----------------------------
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '资产名称',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '资产图片',
  `price` double(10, 2) NULL DEFAULT NULL COMMENT '资产价格',
  `num` int(10) NULL DEFAULT 0 COMMENT '剩余数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '资产信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of resources
-- ----------------------------
INSERT INTO `resources` VALUES (1, '办公电脑thinkpad', 'http://localhost:9090/files/1700204854858-thinkpad.jpg', 4999.00, 103);
INSERT INTO `resources` VALUES (3, '办公电脑联想小新', 'http://localhost:9090/files/1700204901305-联想小新air14.jpg', 4999.00, 97);
INSERT INTO `resources` VALUES (4, '华为P14测试机', 'http://localhost:9090/files/1700204944788-华为P14.jpg', 199.00, 95);

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `employee_id` int(10) NULL DEFAULT NULL COMMENT '员工ID',
  `department_id` int(10) NULL DEFAULT NULL COMMENT '部门ID',
  `year` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '年月',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '发放时间',
  `price` double(10, 2) NULL DEFAULT NULL COMMENT '发放薪资',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '薪资信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES (1, 1, 1, '2023-01', '2023-01-15 14:41:53', 10000.00, '无');
INSERT INTO `salary` VALUES (2, 1, 1, '2023-02', '2023-02-15 14:45:12', 10500.00, '奖金：500');
INSERT INTO `salary` VALUES (3, 3, 2, '2023-01', '2023-01-15 14:46:22', 7000.00, '无');
INSERT INTO `salary` VALUES (4, 3, 2, '2023-02', '2023-02-15 16:47:00', 7200.00, '奖金：200');
INSERT INTO `salary` VALUES (5, 6, 3, '2023-01', '2023-01-03 00:00:00', 6000.00, NULL);
INSERT INTO `salary` VALUES (6, 6, 3, '2023-02', '2023-02-14 00:00:00', 6500.00, NULL);

SET FOREIGN_KEY_CHECKS = 1;
