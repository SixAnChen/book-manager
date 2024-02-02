/*
 Navicat Premium Data Transfer

 Source Server         : MySQL - @localhost
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : 2024_bookstore

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 02/02/2024 08:56:11
*/

SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `author`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `publisher`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `isbn`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `price` double (10, 2) NULL DEFAULT NULL,
    `publishTime` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `summary`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `cover`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `typeId`      int(11) NULL DEFAULT NULL,
    `num`         int(10) NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book`
VALUES (1, 'Java面向对象编程', '张黎明', '中国人民教育出版社', '108274435454', 40.00, '2000',
        '关于JavaSE的相关基础知识', '1698912367144', 5, 98);
INSERT INTO `book`
VALUES (2, 'Python编程', '桂长新', '新华出版社', '858302532580', 56.00, '2025', 'Python基础语法', '1698912427268', 14,
        99);
INSERT INTO `book`
VALUES (4, '光明世界', '张德祥', '人民邮电出版社', '142891856343', 21.00, '2020', '光源如何产生', '1699201715343', 7,
        100);
INSERT INTO `book`
VALUES (5, '失语者', '路遥', '中国人民教育出版社', '100680562628', 34.00, '2021', '关于人生意义的追求', '1699201693922',
        1, 100);
INSERT INTO `book`
VALUES (6, '快乐世界之旅', '王子恩', '中国人民教育出版社', '227615803275', 53.00, '2029',
        '快乐世界之旅出自王子文的生活~', '1699201687040', 13, 100);
INSERT INTO `book`
VALUES (7, '有工作的穷人', '阿恩·卡勒伯格', '中国人民教育出版社', '706227987847', 69.00, '2022',
        '本书评估了全球和国内因素对日本、韩国和印度尼西亚的不稳定就业及其产生的影响。这三个国家是典型的亚洲资本主义经济体：日本和韩国现在是发达国家和成熟的经济体，而印度尼西亚仍然是一个中低收入国家。',
        '1699197460634', 7, 100);

-- ----------------------------
-- Table structure for reserve
-- ----------------------------
DROP TABLE IF EXISTS `reserve`;
CREATE TABLE `reserve`
(
    `id`     int(11) NOT NULL AUTO_INCREMENT,
    `bookId` int(11) NULL DEFAULT NULL,
    `userId` int(11) NULL DEFAULT NULL,
    `days`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `time`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reserve
-- ----------------------------
INSERT INTO `reserve`
VALUES (1, 1, 10, NULL, '2023-11-06 16:22:14', '审核通过', NULL);
INSERT INTO `reserve`
VALUES (2, 1, 10, NULL, '2023-11-13 18:35:06', '审核不通过', NULL);
INSERT INTO `reserve`
VALUES (3, 2, 10, NULL, '2023-11-13 18:35:08', '审核通过', NULL);

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`
(
    `id`          int(11) NOT NULL AUTO_INCREMENT,
    `name`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `icon`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    `url`         varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `type_name`(`name`) USING BTREE COMMENT '分类名称唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type`
VALUES (1, '马克思主义、列宁主义、毛泽东思想、邓小平理论',
        '马克思主义、列宁主义、毛泽东思想、邓小平理论 是一种涵盖了中国政治、经济和社会领域的重要图书分类。这个分类系统反映了中国历史上不同政治时期的思想和理论发展，以及中国共产党在不同时期的指导思想。',
        'icon icon-activity', 'https://www.clcindex.com/category/A/');
INSERT INTO `type`
VALUES (2, '哲学、宗教', '哲学和宗教是两个不同但密切相关的领域，它们都探讨了人类存在、价值观念和生命意义等重要问题。',
        'icon icon-thumbs-up', 'https://www.clcindex.com/category/B/');
INSERT INTO `type`
VALUES (3, '社会科学总论',
        '社会科学总论是一个涵盖广泛的学科领域，旨在研究和理解人类社会的各个方面，包括社会行为、社会结构、文化、历史、政治、经济、心理、教育、法律等。这些学科通过系统的研究方法，如调查、实验、观察、分析和理论建构，探讨了社会现象的原因、影响和解决方案。',
        'icon icon-battery-charging', 'https://www.clcindex.com/category/C/');
INSERT INTO `type`
VALUES (4, '政治、法律',
        '政治学和法律是社会科学领域中的两个重要分支，它们研究人类社会中的权力、法律、政府和社会组织等方面的问题',
        'icon icon-grid', 'https://www.clcindex.com/category/D/');
INSERT INTO `type`
VALUES (5, '军事',
        '军事是一门关于军队、武装力量、军事战略和军事技术的学科领域，它涵盖了广泛的主题，包括战争、军事战略、军事战术、武器装备、军队组织、国防政策以及国际军事关系等。军事领域的研究旨在理解和分析军事行动、冲突解决、国家安全和战略规划等方面的问题。',
        'icon icon-battery-charging', 'https://www.clcindex.com/category/E/');
INSERT INTO `type`
VALUES (6, '经济',
        '经济学是社会科学的一个分支，主要研究资源的分配、生产、分配和消费等与经济活动有关的问题。经济学提供了对市场、政府政策、企业决策以及人们的行为和选择进行理解和分析的框架。',
        'icon icon-bookmark', 'https://www.clcindex.com/category/F/');
INSERT INTO `type`
VALUES (7, '文化、科学、教育、体育', '文化、科学、教育和体育是社会生活中不可或缺的重要领域，它们各自涵盖了广泛的主题和概念。',
        'icon icon-bookmark', 'https://www.clcindex.com/category/G/');
INSERT INTO `type`
VALUES (8, '语言、文字', '语言和文字是人类沟通和传递信息的重要工具，它们在文化和社会中起到关键作用。', 'icon icon-award',
        'https://www.clcindex.com/category/H/');
INSERT INTO `type`
VALUES (9, '文学',
        '文学是一门艺术和人文科学领域，涵盖了各种文本和创作形式，包括小说、诗歌、戏剧、散文、故事、随笔等。文学作品通常以语言为媒介，通过文字表达作者的思想、情感和想法，以及塑造人物、情节和背景来创造虚构的故事或表达真实生活的经验。',
        'icon icon-battery-charging', 'https://www.clcindex.com/category/I/');
INSERT INTO `type`
VALUES (10, '艺术',
        '艺术是一种创造性的表达形式，通过各种媒介，如绘画、雕塑、音乐、舞蹈、戏剧、文学、电影、摄影等，来表达艺术家的思想、情感和想法。艺术作品通常旨在触发观众的感情、思考和审美体验，有时也具有社会和文化的意义。',
        'icon icon-bookmark', 'https://www.clcindex.com/category/J/');
INSERT INTO `type`
VALUES (11, '历史、地理', '历史和地理是两个重要的人文科学和社会科学领域，它们帮助我们理解人类社会和地球的发展和演变。',
        'icon icon-thumbs-up', 'https://www.clcindex.com/category/K/');
INSERT INTO `type`
VALUES (12, '自然科学总论',
        '自然科学总论是一个广泛的学科领域，涵盖了对自然界和自然现象的科学研究。这个领域通常包括物理学、化学、生物学、地球科学、天文学等学科，旨在理解自然世界的规律和现象。',
        'icon icon-bookmark', 'https://www.clcindex.com/category/N/');
INSERT INTO `type`
VALUES (13, '数理科学和化学',
        '数理科学和化学是自然科学领域的两个重要分支，它们分别涉及数学和物质世界的研究，具有各自独特的特点和应用领域。',
        'icon icon-bookmark', 'https://www.clcindex.com/category/O/');
INSERT INTO `type`
VALUES (14, '天文学、地球科学',
        '天文学和地球科学是自然科学领域的两个重要分支，它们分别研究宇宙中的天体和地球本身及其过程。',
        'icon icon-activity', 'https://www.clcindex.com/category/P/');
INSERT INTO `type`
VALUES (15, '生物科学',
        '生物科学是自然科学的一个分支，致力于研究生命和生命现象。它涵盖了广泛的主题，包括生物多样性、细胞生物学、遗传学、生态学、进化生物学、生物化学、生理学、分子生物学和生物技术等。',
        'icon icon-thumbs-up', 'https://www.clcindex.com/category/Q/');
INSERT INTO `type`
VALUES (16, '医药、卫生', '医药和卫生是关于人类健康和医疗护理的重要领域，它们旨在维护和改善个体和社会的健康。',
        'icon icon-award', 'https://www.clcindex.com/category/R/');
INSERT INTO `type`
VALUES (17, '农业科学',
        '农业科学是研究和发展农业领域的科学和技术，旨在提高农业生产、改善食品供应、保护自然资源并推动可持续农业实践。这个领域涵盖了广泛的主题，包括植物学、动物学、土壤科学、农业工程、作物学、畜牧学、农业经济学等。',
        'icon icon-award', 'https://www.clcindex.com/category/S/');
INSERT INTO `type`
VALUES (18, '工业技术',
        '工业技术是研究和应用各种工程和技术原理来改善和优化生产和制造过程的领域。它涵盖了广泛的主题，包括工程学、制造技术、自动化、材料科学、电子技术、信息技术、能源技术等。',
        'icon icon-thumbs-up', 'https://www.clcindex.com/category/T/');
INSERT INTO `type`
VALUES (19, '交通运输',
        '交通运输是指人和货物在地球表面上的移动和运送，以满足各种需求和连接各个地区。这是现代社会中不可或缺的基础设施之一，涵盖了多种交通工具和基础设施，包括道路、铁路、水路、航空、城市交通系统等。',
        'icon icon-thumbs-up', 'https://www.clcindex.com/category/U/');
INSERT INTO `type`
VALUES (20, '航空、航天', '航空和航天是两个涉及飞行和太空探索的重要领域，它们都与飞行器的设计、制造、运营以及空间探索有关。',
        'icon icon-award', 'https://www.clcindex.com/category/V/');
INSERT INTO `type`
VALUES (21, '环境科学、安全科学',
        '环境科学和安全科学是两个重要的学科领域，它们都涵盖了广泛的主题，旨在保护人类、环境和社会的健康与安全。',
        'icon icon-activity', 'https://www.clcindex.com/category/X/');
INSERT INTO `type`
VALUES (22, '综合性图书',
        '综合性图书通常是指那些涵盖多个学科或主题领域，提供广泛知识或全面信息的书籍。这些图书可能包括百科全书、参考书、综合性手册或大型文集等，旨在满足读者对各种不同主题的信息需求。',
        'icon icon-grid', 'https://www.clcindex.com/category/Z/');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `id`       int(11) NOT NULL AUTO_INCREMENT,
    `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
    `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '123456' COMMENT '密码',
    `name`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
    `phone`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
    `email`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
    `address`  varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
    `avatar`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
    `birthday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '出生日期',
    `status`   tinyint(1) NULL DEFAULT 1 COMMENT '状态',
    `role`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '用户' COMMENT '角色',
    `score`    int(11) NULL DEFAULT NULL COMMENT '评分',
    PRIMARY KEY (`id`) USING BTREE,
    UNIQUE INDEX `user_name`(`name`) USING BTREE COMMENT '用户名唯一'
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user`
VALUES (3, 'csukyee', '123456', '徐备喜', '13226152046', NULL, '山西省/阳泉市/郊区', '1698655454655', '2007-10-16', 1,
        '管理员', 5);
INSERT INTO `user`
VALUES (4, 'inoueakina', '123456', '陈喜英', '13226152046', NULL, '河北省/秦皇岛市/抚宁区', '1698490588957',
        '2023-10-10', 1, '用户', 5);
INSERT INTO `user`
VALUES (5, 'aynishimura55', '123456', '庄东升', '13226152046', NULL, '内蒙古自治区/呼和浩特市/土默特左旗',
        '1698490570297', '2023-10-26', 1, '职工', 5);
INSERT INTO `user`
VALUES (6, 'otayu', '123456', '关晓彤', '13226152046', NULL, '河北省/邯郸市/峰峰矿区', '1698490642801', '2023-10-11', 1,
        '用户', 4);
INSERT INTO `user`
VALUES (7, 'esthepatel', '123456', 'user', '13226152046', NULL, '天津市/市辖区/河西区', '1698829590593', '2023-10-03',
        1, '用户', 4);
INSERT INTO `user`
VALUES (8, 'wsng', '11', '111', '13226152046', NULL, '河北省/邯郸市/峰峰矿区', '1698947220304', '2023-10-05', 1, '用户',
        4);
INSERT INTO `user`
VALUES (9, 'cltsang', '123456', '1314', '13226152046', NULL, '河北省/邯郸市/峰峰矿区', '1698806473242', '2023-10-18', 1,
        '用户', 5);
INSERT INTO `user`
VALUES (10, 'sugts46', '123456', 'admin', '13226152046', NULL, '河北省/秦皇岛市/青龙满族自治县', '1699945871465',
        '2023-10-10', 1, '管理员', 4);
INSERT INTO `user`
VALUES (11, 'fong423', '123456', '1113', '13226152046', NULL, '天津市/市辖区/河北区', '1699185795440', '2023-11-07', 1,
        '用户', 4);
INSERT INTO `user`
VALUES (12, 'gibson323', '123456', '5666', '13226152046', NULL, '北京市/市辖区/朝阳区', '1699185806708', '2023-11-16',
        1, '用户', 5);
INSERT INTO `user`
VALUES (13, 'kwokwing6', '123456', '333', '13226152046', NULL, '天津市/市辖区/河东区', '1698829097776', NULL, 1, '用户',
        NULL);
INSERT INTO `user`
VALUES (14, 'mason411', '123456', '444', '13226152046', NULL, '河北省/秦皇岛市/北戴河区', '1699185778885', NULL, 1,
        '用户', 0);
INSERT INTO `user`
VALUES (15, NULL, '111111', 'sixan', NULL, NULL, NULL, '1706835147124', NULL, 1, '用户', NULL);

SET
FOREIGN_KEY_CHECKS = 1;
