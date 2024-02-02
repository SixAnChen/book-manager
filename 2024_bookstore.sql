/*
 Navicat Premium Data Transfer

 Source Server         : Mysql
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : 2024_bookstore

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 01/11/2023 21:33:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '123456' COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `birthday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出生日期',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '用户' COMMENT '角色',
  `score` int(11) NULL DEFAULT NULL COMMENT '评分',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活动时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (3, NULL, '123456', '徐备喜', '13226152046', NULL, '河北省/石家庄市/井陉矿区', '1698655454655', '2007-10-16', 1, '管理员', 4, '17:16');
INSERT INTO `user` VALUES (4, NULL, '123456', '陈喜英', '13226152046', NULL, '河北省/秦皇岛市/抚宁区', '1698490588957', '2023-10-10', 1, '用户', 5, '17:06');
INSERT INTO `user` VALUES (5, NULL, '123456', '庄东升', '13226152046', NULL, '内蒙古自治区/呼和浩特市/土默特左旗', '1698490570297', '2023-10-26', 1, '职工', 5, '17:00');
INSERT INTO `user` VALUES (6, NULL, '123456', '关晓彤', '13226152046', NULL, '河北省/邯郸市/峰峰矿区', '1698490642801', '2023-10-11', 1, '用户', 4, '17:08');
INSERT INTO `user` VALUES (7, NULL, '123456', 'user', '13226152046', NULL, '天津市/市辖区/河西区', '1698829590593', '2023-10-03', 1, '用户', 4, '21:07');
INSERT INTO `user` VALUES (8, NULL, '123456', '111', '13226152046', NULL, '河北省/邯郸市/峰峰矿区', '1698801943180', '2023-10-05', 1, '用户', 4, '21:09');
INSERT INTO `user` VALUES (9, NULL, '123456', '1314', '13226152046', NULL, '河北省/邯郸市/峰峰矿区', '1698806473242', '2023-10-18', 1, '用户', 5, '12:25');
INSERT INTO `user` VALUES (10, NULL, '123456', '123', '13226152046', NULL, '河北省/秦皇岛市/青龙满族自治县', '1698806071457', '2023-10-10', 1, '管理员', 4, '12:25');
INSERT INTO `user` VALUES (11, NULL, '123456', '1113', '13226152046', NULL, '天津市/市辖区/河北区', NULL, '2023-11-07', 1, '用户', 4, '17:06');
INSERT INTO `user` VALUES (12, NULL, '123456', '5666', '13226152046', NULL, '北京市/市辖区/朝阳区', NULL, '2023-11-16', 1, '用户', 5, '17:04');
INSERT INTO `user` VALUES (13, NULL, '123456', '333', '13226152046', NULL, '天津市/市辖区/河东区', '1698829097776', NULL, 1, '用户', NULL, NULL);
INSERT INTO `user` VALUES (14, NULL, '123456', '444', '13226152046', NULL, NULL, NULL, NULL, 1, '用户', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
