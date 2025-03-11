/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50739 (5.7.39-log)
 Source Host           : localhost:3306
 Source Schema         : hospital

 Target Server Type    : MySQL
 Target Server Version : 50739 (5.7.39-log)
 File Encoding         : 65001

 Date: 12/03/2025 14:03:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admini
-- ----------------------------
DROP TABLE IF EXISTS `admini`;
CREATE TABLE `admini`  (
  `a_id` int(11) NOT NULL,
  `a_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `a_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `a_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `a_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `a_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `a_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admini
-- ----------------------------
INSERT INTO `admini` VALUES (202501, 'admin', 'admin', '男', '440881199701203551', '18211272779', 'hins555ph@163.com');

-- ----------------------------
-- Table structure for announcements
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告文件名',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告内容',
  `time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '平台公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcements
-- ----------------------------
INSERT INTO `announcements` VALUES (1, '系统升级通知202311', '为提升服务质量，平台将于2023年12月1日00:00-06:00进行系统升级维护，期间可能短暂影响部分功能使用。', '2025-02-01 09:30:00');
INSERT INTO `announcements` VALUES (2, '用户健康指南V2', '新版电子健康卡使用指南已发布，包含在线问诊、报告查询、家庭账户管理等功能的详细操作说明。', '2024-11-18 14:15:00');
INSERT INTO `announcements` VALUES (3, '隐私政策更新通告', '根据最新法律法规要求，平台隐私保护条款已于2023年11月10日更新，请用户及时查阅。', '2024-11-10 10:00:00');
INSERT INTO `announcements` VALUES (4, '线上问诊功能上线', '即日起开通三甲医院专家在线问诊服务，支持图文/视频咨询，接诊时间8:00-22:00。', '2024-10-01 08:00:00');
INSERT INTO `announcements` VALUES (6, '2025本系统最新标准', '关于系统使用的各种规范', '2025-03-05 08:54:52');

-- ----------------------------
-- Table structure for arrange
-- ----------------------------
DROP TABLE IF EXISTS `arrange`;
CREATE TABLE `arrange`  (
  `ar_id` int(11) NOT NULL AUTO_INCREMENT,
  `ar_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `d_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ar_id`) USING BTREE,
  INDEX `arTOd`(`d_id`) USING BTREE,
  CONSTRAINT `arTOd` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of arrange
-- ----------------------------
INSERT INTO `arrange` VALUES (1, '2025-03-13', 1100038);
INSERT INTO `arrange` VALUES (2, '2025-03-13', 1100039);
INSERT INTO `arrange` VALUES (3, '2025-03-13', 1100040);
INSERT INTO `arrange` VALUES (4, '2025-03-14', 1100041);
INSERT INTO `arrange` VALUES (5, '2025-03-14', 1100042);
INSERT INTO `arrange` VALUES (6, '2025-03-14', 1100045);
INSERT INTO `arrange` VALUES (7, '2025-03-12', 1100001);
INSERT INTO `arrange` VALUES (8, '2025-03-12', 1100041);

-- ----------------------------
-- Table structure for bed
-- ----------------------------
DROP TABLE IF EXISTS `bed`;
CREATE TABLE `bed`  (
  `b_id` int(11) NOT NULL,
  `p_id` int(11) NULL DEFAULT NULL,
  `b_state` int(11) NULL DEFAULT NULL,
  `b_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `d_id` int(11) NULL DEFAULT NULL,
  `b_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`b_id`) USING BTREE,
  INDEX `bTOp`(`p_id`) USING BTREE,
  INDEX `bTOd`(`d_id`) USING BTREE,
  CONSTRAINT `bTOd` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bTOp` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of bed
-- ----------------------------
INSERT INTO `bed` VALUES (1, 100004, 1, '2023-09-08', 1100223, '身体很不好', 2);
INSERT INTO `bed` VALUES (3, 100010, 1, '2023-09-09', 1100010, '发烧', 1);
INSERT INTO `bed` VALUES (4, 100010, 1, '2023-09-11', 1100010, '发烧', 1);
INSERT INTO `bed` VALUES (6, 100021, 0, NULL, 1100000, NULL, 3);
INSERT INTO `bed` VALUES (7, 100021, 0, NULL, 1100000, NULL, 2);
INSERT INTO `bed` VALUES (8, 100021, 0, NULL, 1100000, NULL, 1);
INSERT INTO `bed` VALUES (9, 100021, 0, NULL, 1100000, NULL, 1);
INSERT INTO `bed` VALUES (10, 100012, 1, '2023-09-11', 1100008, '感冒2', 4);
INSERT INTO `bed` VALUES (11, 100010, 1, '2023-09-11', 1100010, '感冒1', 2);
INSERT INTO `bed` VALUES (12, 100010, 1, '2023-09-11', 1100010, '发烧1', 2);
INSERT INTO `bed` VALUES (13, 100010, 1, '2023-09-11', 1100005, '感冒，需入院观察', 2);
INSERT INTO `bed` VALUES (14, 100010, 1, '2023-09-17', 1100002, '感冒', 2);
INSERT INTO `bed` VALUES (15, 100010, 1, '2023-09-14', 1100002, '感冒', 2);

-- ----------------------------
-- Table structure for checks
-- ----------------------------
DROP TABLE IF EXISTS `checks`;
CREATE TABLE `checks`  (
  `ch_id` int(11) NOT NULL AUTO_INCREMENT,
  `ch_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ch_price` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`ch_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of checks
-- ----------------------------
INSERT INTO `checks` VALUES (1, 'B超', 201.00);
INSERT INTO `checks` VALUES (2, 'CT', 435.00);
INSERT INTO `checks` VALUES (3, '核磁共振', 653.00);
INSERT INTO `checks` VALUES (4, 'MRI', 534.00);
INSERT INTO `checks` VALUES (5, '心电图', 634.00);
INSERT INTO `checks` VALUES (6, '彩超', 213.00);
INSERT INTO `checks` VALUES (7, '血常规', 434.00);
INSERT INTO `checks` VALUES (8, '肝功能', 543.00);
INSERT INTO `checks` VALUES (9, '血糖', 434.00);
INSERT INTO `checks` VALUES (10, '甲状腺', 434.00);
INSERT INTO `checks` VALUES (11, '视力', 50.00);

-- ----------------------------
-- Table structure for doctor
-- ----------------------------
DROP TABLE IF EXISTS `doctor`;
CREATE TABLE `doctor`  (
  `d_id` int(11) NOT NULL COMMENT 'id',
  `d_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密密码',
  `d_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `d_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `d_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `d_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '卡号',
  `d_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电子邮件',
  `d_post` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `d_introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `d_section` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `d_state` int(11) NOT NULL,
  `d_price` decimal(10, 2) NULL DEFAULT NULL,
  `d_people` int(11) NULL DEFAULT NULL,
  `d_star` decimal(10, 2) NULL DEFAULT NULL,
  `d_avg_star` decimal(10, 2) NULL DEFAULT NULL COMMENT '评价',
  PRIMARY KEY (`d_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of doctor
-- ----------------------------
INSERT INTO `doctor` VALUES (1100000, '3d7dd7b26500bd0595573b651d0080fd', '林子轩', '男', '18211272734', '440881199701203551', '130794144@qq.com', '主任', '最牛', '发热门诊', 1, 12.00, 1, 15.00, 7.00);
INSERT INTO `doctor` VALUES (1100001, '3d7dd7b26500bd0595573b651d0080fd', '吴思琪', '女', '18211272779', '440881199701203551', '130794144@qq.com', '副主任医师', '很牛逼', '发热门诊', 1, 12.00, 7, 35.00, 5.00);
INSERT INTO `doctor` VALUES (1100002, '3d7dd7b26500bd0595573b651d0080fd', '李天佑', '男', '18211272779', '440881199701203551', 'hins555ph@163.com', '副主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 1, 32.00, 14, 7.00, 0.50);
INSERT INTO `doctor` VALUES (1100003, '3d7dd7b26500bd0595573b651d0080fd', '孙若曦', '女', '18211272779', '440881199701203551', '1092839910@qq.com', '主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '消化内科', 1, 12.00, 0, 0.00, NULL);
INSERT INTO `doctor` VALUES (1100004, '3d7dd7b26500bd0595573b651d0080fd', '许嘉豪', '男', '18211272779', '440881199701203551', '1309283910@qq.com', '副主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 1, 32.00, 2, 9.00, 4.50);
INSERT INTO `doctor` VALUES (1100005, '3d7dd7b26500bd0595573b651d0080fd', '唐语嫣', '女', '18211272779', '440881199701203551', '1123092839910@qq.com', '副主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 0, 12.00, 2, 10.00, 5.00);
INSERT INTO `doctor` VALUES (1100006, '3d7dd7b26500bd0595573b651d0080fd', '程一鸣', '男', '18211272779', '440881199701203551', '12313092839910@qq.com', '主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 1, 42.00, 2, 10.00, 5.00);
INSERT INTO `doctor` VALUES (1100007, '3d7dd7b26500bd0595573b651d0080fd', '苏雨薇', '女', '18211272779', '440881199701203551', '1233092839910@qq.com', '副主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 1, 5.00, 0, 0.00, NULL);
INSERT INTO `doctor` VALUES (1100008, '3d7dd7b26500bd0595573b651d0080fd', '韩明哲', '男', '18211272779', '440881199701203551', '4313092839910@qq.com', '主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 1, 32.00, 2, 9.00, 4.50);
INSERT INTO `doctor` VALUES (1100009, '3d7dd7b26500bd0595573b651d0080fd', '秦欣悦', '女', '18211272779', '440881199701203551', '43213092839910@qq.com', '主治医生', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 1, 43.00, 2, 10.00, 5.00);
INSERT INTO `doctor` VALUES (1100010, '3d7dd7b26500bd0595573b651d0080fd', '钟晨阳', '男', '18211272779', '440881199701203551', '64513092839910@qq.com', '副主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '妇科', 1, 54.00, 17, 10.00, 4.71);
INSERT INTO `doctor` VALUES (1100011, '3d7dd7b26500bd0595573b651d0080fd', '邓雨桐', '女', '18211272779', '440881199701203551', '674313092839910@qq.com', '副主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 1, 43.00, 0, 0.00, 6.12);
INSERT INTO `doctor` VALUES (1100012, '3d7dd7b26500bd0595573b651d0080fd', '段宇航', '男', '18211272779', '440881199701203551', '7563413092839910@qq.com', '副主任医师', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '妇科', 1, 32.00, 0, 0.00, 5.86);
INSERT INTO `doctor` VALUES (1100013, '3d7dd7b26500bd0595573b651d0080fd', '万可欣', '女', '18211272779', '440881199701203551', '745213092839910@qq.com', '主治医生', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '心血管内科', 1, 32.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100014, '3d7dd7b26500bd0595573b651d0080fd', '白子墨', '男', '18211272779', '440881199701203551', '2525213092839910@qq.com', '主治医生', '忠实践行中医诊疗术法三十多年，能熟练运用中医理论对常见病、疑难病、急慢性疾病施行救治，尤其对咳、喘、胃病、胸痹等有较深心得，调治经带有较好的效果，诊治未病深有体会。', '妇科', 1, 54.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100015, '3d7dd7b26500bd0595573b651d0080fd', '田静怡', '女', '18211272779', '550881199701203511', '130413434@qq.com', '主治医生', '医术高明', '妇科', 1, 13.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100016, '3d7dd7b26500bd0595573b651d0080fd', '夏宇航', '男', '18211272779', '550881199701203511', '1304134349@qq.com', '主治医生', '医术高明', '妇科', 1, 14.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100017, '3d7dd7b26500bd0595573b651d0080fd', '谭雨婷', '女', '18211272779', '550881199701203511', '1304134348@qq.com', '主治医生', '医术高明', '心血管内科', 1, 15.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100018, '3d7dd7b26500bd0595573b651d0080fd', '范俊杰', '男', '18211272779', '550881199701203511', '1304134347@qq.com', '主治医生', '医术高明', '心血管内科', 1, 16.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100019, '3d7dd7b26500bd0595573b651d0080fd', '郝梦瑶', '女', '18211272779', '550881199701203511', '1304134346@qq.com', '主治医生', '医术高明', '妇科', 1, 17.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100020, '3d7dd7b26500bd0595573b651d0080fd', '宋浩然', '男', '18211272779', '550881199701203511', '1304134345@qq.com', '副主任医师', '医术高明', '妇科', 1, 18.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100021, '3d7dd7b26500bd0595573b651d0080fd', '姚心怡', '女', '18211272779', '550881199701203511', '1304134344@qq.com', '副主任医师', '医术高明', '妇科', 1, 19.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100022, '3d7dd7b26500bd0595573b651d0080fd', '吕博文', '男', '18211272779', '550881199701203511', '1304134343@qq.com', '副主任医师', '医术高明', '妇科', 1, 20.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100023, '3d7dd7b26500bd0595573b651d0080fd', '任晓彤', '女', '18211272779', '550881199701203511', '1304134342@qq.com', '副主任医师', '医术高明', '妇科', 1, 21.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100024, '3d7dd7b26500bd0595573b651d0080fd', '康子豪', '男', '18211272779', '550881199701203511', '1304134341@qq.com', '副主任医师', '医术高明', '妇科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100025, '3d7dd7b26500bd0595573b651d0080fd', '季雪柔', '女', '18211272779', '550881199701203511', '1313123@qq.com', '主治医生', '医术高明', '妇科', 1, 13.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100026, '3d7dd7b26500bd0595573b651d0080fd', '常天宇', '男', '18211272779', '550881199701203511', '1313124@qq.com', '主治医生', '医术高明', '内分泌科', 1, 14.00, 1, 5.00, 5.00);
INSERT INTO `doctor` VALUES (1100027, '3d7dd7b26500bd0595573b651d0080fd', '石雅琴', '女', '18211272779', '550881199701203511', '1313125@qq.com', '主治医生', '医术高明', '内分泌科', 1, 15.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100028, '3d7dd7b26500bd0595573b651d0080fd', '钱俊杰', '男', '18211272779', '550881199701203511', '1321313@qq.com', '主治医生', '医术高明', '内分泌科', 1, 16.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100029, '3d7dd7b26500bd0595573b651d0080fd', '洪诗雨', '女', '18211272779', '550881199701203511', '1313127@qq.com', '主治医生', '医术高明', '内分泌科', 1, 17.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100030, '3d7dd7b26500bd0595573b651d0080fd', '骆天宇', '男', '18211272779', '550881199701203511', '1313128@qq.com', '主任医师', '医术高明', '消化内科', 1, 18.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100031, '3d7dd7b26500bd0595573b651d0080fd', '兰雨萱', '女', '18211272779', '550881199701203511', '1313129@qq.com', '主任医师', '医术高明', '消化内科', 1, 19.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100032, '3d7dd7b26500bd0595573b651d0080fd', '褚文博', '男', '18211272779', '550881199701203511', '1313130@qq.com', '主任医师', '医术高明', '消化内科', 1, 20.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100033, '3d7dd7b26500bd0595573b651d0080fd', '鲍欣怡', '女', '18211272779', '550881199701203511', '1313131@qq.com', '主任医师', '医术高明', '消化内科', 1, 21.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100034, '3d7dd7b26500bd0595573b651d0080fd', '魏浩宇', '男', '18211272779', '550881199701203511', '13131321@qq.com', '主任医师', '医术高明', '消化内科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100035, '3d7dd7b26500bd0595573b651d0080fd', '卢雅雯', '女', '18211272779', '550881199701203511', '13131332@qq.com', '主治医生', '医术高明', '心血管科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100036, '3d7dd7b26500bd0595573b651d0080fd', '侯宇航', '男', '18211272779', '550881199701203511', '131313422@qq.com', '主治医生', '医术高明', '心血管科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100037, '3d7dd7b26500bd0595573b651d0080fd', '秦雨欣', '女', '18211272779', '550881199701203511', '13131351@qq.com', '主治医生', '医术高明', '心血管科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100038, '3d7dd7b26500bd0595573b651d0080fd', '陆子涵', '男', '18211272779', '550881199701203511', '13131326@qq.com', '主治医生', '医术高明', '肾内科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100039, '3d7dd7b26500bd0595573b651d0080fd', '万诗涵', '女', '18211272779', '550881199701203511', '13133137@qq.com', '主治医生', '医术高明', '肾内科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100040, '3d7dd7b26500bd0595573b651d0080fd', '庄子轩', '男', '18211272779', '550881199701203511', '131341138@qq.com', '主治医生', '医术高明', '肾内科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100041, '3d7dd7b26500bd0595573b651d0080fd', '钟静怡', '女', '18211272779', '550881199701203511', '1313312139@qq.com', '主治医生', '医术高明', '发热门诊', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100042, '3d7dd7b26500bd0595573b651d0080fd', '吕文昊', '男', '18211272779', '550881199701203511', '131311240@qq.com', '主治医生', '医术高明', '发热门诊', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100043, '3d7dd7b26500bd0595573b651d0080fd', '龙梦洁', '女', '18211272779', '550881199701203511', '1313232141@qq.com', '副主任医师', '医术高明', '发热门诊', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100044, '3d7dd7b26500bd0595573b651d0080fd', '袁俊熙', '男', '18211272779', '550881199701203511', '1313233142@qq.com', '副主任医师', '医术高明', '发热门诊', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100045, '3d7dd7b26500bd0595573b651d0080fd', '沈晓芸', '女', '18211272779', '550881199701203511', '1313132343@qq.com', '副主任医师', '医术高明', '发热门诊', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100046, '3d7dd7b26500bd0595573b651d0080fd', '梁逸飞', '男', '18211272779', '550881199701203511', '1313132344@qq.com', '副主任医师', '医术高明', '手足外科', 1, 22.00, 1, 5.00, 5.00);
INSERT INTO `doctor` VALUES (1100047, '3d7dd7b26500bd0595573b651d0080fd', '文雨晴', '女', '18211272779', '550881199701203511', '131543145@qq.com', '副主任医师', '医术高明', '手足外科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100048, '3d7dd7b26500bd0595573b651d0080fd', '钟俊豪', '男', '18211272779', '550881199701203511', '1313453453146@qq.com', '副主任医师', '医术高明', '手足外科', 1, 22.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100049, '3d7dd7b26500bd0595573b651d0080fd', '邱若琳', '女', '18211272779', '550881199701203511', '1354513147@qq.com', '副主任医师', '医术高明', '手足外科', 1, 23.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100050, '3d7dd7b26500bd0595573b651d0080fd', '崔子轩', '男', '18211272779', '550881199701203511', '13153453148@qq.com', '副主任医师', '医术高明', '普通外科', 1, 24.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100051, '3d7dd7b26500bd0595573b651d0080fd', '万思琪', '女', '18211272779', '550881199701203511', '1313656149@qq.com', '副主任医师', '医术高明', '普通外科', 1, 25.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100052, '3d7dd7b26500bd0595573b651d0080fd', '龙天佑', '男', '18211272779', '550881199701203511', '1313132150@qq.com', '副主任医师', '医术高明', '普通外科', 1, 26.00, 0, 0.00, 5.50);
INSERT INTO `doctor` VALUES (1100053, '3d7dd7b26500bd0595573b651d0080fd', '林若曦', '女', '18211272779', '550881199701203511', '13137465151@qq.com', '副主任医师', '医术高明', '肛肠外科', 1, 27.00, 4, 16.00, 4.00);
INSERT INTO `doctor` VALUES (1100054, '3d7dd7b26500bd0595573b651d0080fd', '钟嘉豪', '男', '18211272779', '550881199701203511', '143313152@qq.com', '副主任医师', '医术高明', '肛肠外科', 1, 28.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100055, '3d7dd7b26500bd0595573b651d0080fd', '沈语嫣', '女', '18211272779', '550881199701203511', '1356413153@qq.com', '副主任医师', '医术高明', '肛肠外科', 1, 29.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100056, '3d7dd7b26500bd0595573b651d0080fd', '冯一鸣', '男', '18211272779', '550881199701203511', '13756413154@qq.com', '副主任医师', '医术高明', '神经外科', 1, 30.00, 1, 5.00, 5.00);
INSERT INTO `doctor` VALUES (1100057, '3d7dd7b26500bd0595573b651d0080fd', '袁雨薇', '女', '18211272779', '550881199701203511', '1334534513155@qq.com', '副主任医师', '医术高明', '神经外科', 1, 31.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100158, '3d7dd7b26500bd0595573b651d0080fd', '陆明哲', '男', '18211272779', '550881199701203511', '1312313156@qq.com', '副主任医师', '医术高明', '神经外科', 1, 32.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100159, '3d7dd7b26500bd0595573b651d0080fd', '邱欣悦', '女', '18211272779', '550881199701203511', '13231213157@qq.com', '副主任医师', '医术高明', '泌尿外科', 1, 33.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100160, '3d7dd7b26500bd0595573b651d0080fd', '崔晨阳', '男', '18211272779', '550881199701203511', '1313534158@qq.com', '副主任医师', '医术高明', '泌尿外科', 1, 34.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100161, '3d7dd7b26500bd0595573b651d0080fd', '石雨桐', '女', '18211272779', '550881199701203511', '13136456159@qq.com', '主任医师', '医术高明', '泌尿外科', 1, 35.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100162, '3d7dd7b26500bd0595573b651d0080fd', '夏宇航', '男', '18211272779', '550881199701203511', '13124313160@qq.com', '主任医师', '医术高明', '骨科', 1, 36.00, 1, 5.00, 5.00);
INSERT INTO `doctor` VALUES (1100163, '3d7dd7b26500bd0595573b651d0080fd', '钟可欣', '女', '18211272779', '550881199701203511', '1313867161@qq.com', '主任医师', '医术高明', '骨科', 1, 37.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100164, '3d7dd7b26500bd0595573b651d0080fd', '邹子墨', '男', '18211272779', '550881199701203511', '1313976678162@qq.com', '主任医师', '医术高明', '骨科', 1, 38.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100165, '3d7dd7b26500bd0595573b651d0080fd', '邱静怡', '女', '18211272779', '550881199701203511', '13131678163@qq.com', '主任医师', '医术高明', '烧伤整形外科', 1, 39.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100166, '3d7dd7b26500bd0595573b651d0080fd', '白宇航', '男', '18211272779', '550881199701203511', '1313821678164@qq.com', '主任医师', '医术高明', '烧伤整形外科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100167, '3d7dd7b26500bd0595573b651d0080fd', '田雨婷', '女', '18211272779', '550881199701203511', '131313165@qq.com', '主任医师', '医术高明', '烧伤整形外科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100168, '3d7dd7b26500bd0595573b651d0080fd', '龙俊杰', '男', '18211272779', '550881199701203511', '131313166@qq.com', '主任医师', '医术高明', '产科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100169, '3d7dd7b26500bd0595573b651d0080fd', '林梦瑶', '女', '18211272779', '550881199701203511', '131336167@qq.com', '主任医师', '医术高明', '产科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100170, '3d7dd7b26500bd0595573b651d0080fd', '卢浩然', '男', '18211272779', '550881199701203511', '1908313168@qq.com', '主任医师', '医术高明', '产科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100171, '3d7dd7b26500bd0595573b651d0080fd', '韩心怡', '女', '18211272779', '550881199701203511', '1908313169@qq.com', '主任医师', '医术高明', '儿科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100172, '3d7dd7b26500bd0595573b651d0080fd', '丁博文', '男', '18211272779', '550881199701203511', '10789313170@qq.com', '主任医师', '医术高明', '儿科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100173, '3d7dd7b26500bd0595573b651d0080fd', '范晓彤', '女', '18211272779', '550881199701203511', '13089013171@qq.com', '主任医师', '医术高明', '儿科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100174, '3d7dd7b26500bd0595573b651d0080fd', '吕子豪', '男', '18211272779', '550881199701203511', '113121@163.com', '副主任医师', '医术高明', '儿童保健科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100175, '3d7dd7b26500bd0595573b651d0080fd', '丁雪柔', '女', '18211272779', '550881199701203511', '113121@164.com', '副主任医师', '医术高明', '儿童保健科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100176, '3d7dd7b26500bd0595573b651d0080fd', '袁天宇', '男', '18211272779', '550881199701203511', 'dsd113121@165.com', '副主任医师', '医术高明', '耳鼻咽喉科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100177, '3d7dd7b26500bd0595573b651d0080fd', '林雅琴', '女', '18211272779', '550881199701203511', '121113121@166.com', '副主任医师', '医术高明', '耳鼻咽喉科', 1, 40.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100178, '3d7dd7b26500bd0595573b651d0080fd', '周雨婷', '女', '18211272779', '550881199701203511', '113121@167.com', '副主任医师', '医术高明', '眼科', 1, 12.00, 2, 10.00, 5.00);
INSERT INTO `doctor` VALUES (1100179, '3d7dd7b26500bd0595573b651d0080fd', '张俊杰', '男', '18211272779', '550881199701203511', '113121@168.com', '副主任医师', '医术高明', '神经内科', 1, 12.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100180, '3d7dd7b26500bd0595573b651d0080fd', '徐梦瑶', '女', '18211272779', '550881199701203511', '113121@169.com', '副主任医师', '医术高明', '口腔科', 1, 12.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100181, '3d7dd7b26500bd0595573b651d0080fd', '郑浩然', '男', '18211272779', '550881199701203511', '113121@170.com', '副主任医师', '医术高明', '口腔科', 1, 12.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100182, '3d7dd7b26500bd0595573b651d0080fd', '何心怡', '女', '18211272779', '550881199701203511', '113121@171.com', '主治医生', '医术高明', '中医科', 1, 12.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100183, '3d7dd7b26500bd0595573b651d0080fd', '罗博文', '男', '18211272779', '550881199701203511', '113121@172.com', '主治医生', '医术高明', '中医科', 1, 12.00, 0, 0.00, 3.00);
INSERT INTO `doctor` VALUES (1100184, '3d7dd7b26500bd0595573b651d0080fd', '曾晓彤', '女', '18211272779', '550881199701203511', '113121@173.com', '主治医生', '医术高明', '康复医学科', 1, 12.00, 2, 9.00, 4.60);
INSERT INTO `doctor` VALUES (1100185, '3d7dd7b26500bd0595573b651d0080fd', '蒋子豪', '男', '18211272779', '550881199701203511', '113121@174.com', '主治医生', '医术高明', '康复医学科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100186, '3d7dd7b26500bd0595573b651d0080fd', '杨雪柔', '女', '18211272779', '550881199701203511', '113121@175.com', '主治医生', '医术高明', '急诊科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100187, '3d7dd7b26500bd0595573b651d0080fd', '谢天宇', '男', '18211272779', '550881199701203511', '113121@176.com', '主治医生', '医术高明', '急诊科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100188, '3d7dd7b26500bd0595573b651d0080fd', '曹雅琴', '女', '18211272779', '550881199701203511', '113121@177.com', '主治医生', '医术高明', '急诊科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100189, '3d7dd7b26500bd0595573b651d0080fd', '丁俊杰', '男', '18211272779', '550881199701203511', '113121@178.com', '主治医生', '医术高明', '皮肤性病科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100190, '3d7dd7b26500bd0595573b651d0080fd', '侯诗雨', '女', '18211272779', '550881199701203511', '113121@179.com', '主治医生', '医术高明', '皮肤性病科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100191, '3d7dd7b26500bd0595573b651d0080fd', '叶天宇', '男', '18211272779', '550881199701203511', '113121@180.com', '主治医生', '医术高明', '皮肤性病科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100192, '3d7dd7b26500bd0595573b651d0080fd', '崔雨萱', '女', '18211272779', '550881199701203511', '113121@181.com', '主治医生', '医术高明', '功能科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100193, '3d7dd7b26500bd0595573b651d0080fd', '陆文博', '男', '18211272779', '550881199701203511', '113121@181.com', '主治医生', '医术高明', '功能科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100194, '3d7dd7b26500bd0595573b651d0080fd', '方欣怡', '女', '18211272779', '550881199701203511', '113121@181.com', '主治医生', NULL, '妇科', 1, 21.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100195, '3d7dd7b26500bd0595573b651d0080fd', '邱浩宇', '男', '18211272779', '550881199701203511', '11311121@181.com', '主治医生', NULL, '妇科', 1, 32.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100196, '3d7dd7b26500bd0595573b651d0080fd', '邹雅雯', '女', '18211272779', '550881199701203511', '11323121@181.com', '主治医生', NULL, '妇科', 1, 43.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100197, '3d7dd7b26500bd0595573b651d0080fd', '贾宇航', '男', '18211272779', '550881199701203511', '23113121@181.com', '主治医生', NULL, '妇科', 1, 23.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100198, '3d7dd7b26500bd0595573b651d0080fd', '杜雨欣', '女', '18211272779', '550881199701203511', '43113121@181.com', '主治医生', NULL, '妇科', 1, 22.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100199, '3d7dd7b26500bd0595573b651d0080fd', '汪子涵', '男', '18211272779', '550881199701203511', '53113121@181.com', '主治医生', NULL, '妇科', 1, 32.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100200, '3d7dd7b26500bd0595573b651d0080fd', '丁诗涵', '女', '18211272779', '550881199701203511', '65113121@181.com', '主治医生', NULL, '妇科', 1, 43.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100201, '3d7dd7b26500bd0595573b651d0080fd', '廖宇轩', '男', '18211272779', '550881199701203511', '131113121@181.com', '主治医生', NULL, '妇科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100202, '3d7dd7b26500bd0595573b651d0080fd', '文静怡', '女', '18211272779', '550881199701203511', '113654121@181.com', '主治医生', NULL, '妇科', 1, 43.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100203, '3d7dd7b26500bd0595573b651d0080fd', '孔文昊', '男', '18211272779', '550881199701203511', '7511343121@181.com', '主治医生', NULL, '妇科', 1, 54.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100204, '3d7dd7b26500bd0595573b651d0080fd', '薛梦洁', '女', '18211272779', '550881199701203511', '113125435241@181.com', '主治医生', '医术高明', '妇科', 1, 43.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100205, '3d7dd7b26500bd0595573b651d0080fd', '侯俊熙', '男', '18211272779', '550881199701203511', '113524524121@181.com', '主治医生', '医术高明', '妇科', 1, 54.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100206, '3d7dd7b26500bd0595573b651d0080fd', '赖晓芸', '女', '18211272779', '550881199701203511', '524524113121@181.com', '主治医生', '医术高明', '妇科', 1, 45.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100207, '3d7dd7b26500bd0595573b651d0080fd', '莫逸飞', '男', '18211272779', '550881199701203511', '323113121@181.com', '副主任医师', '医术高明', '妇科', 1, 21.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100208, '3d7dd7b26500bd0595573b651d0080fd', '辛雨晴', '女', '18211272779', '550881199701203511', '4343113121@181.com', '副主任医师', '医术高明', '妇科', 1, 43.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100209, '3d7dd7b26500bd0595573b651d0080fd', '岳俊豪', '男', '18211272779', '550881199701203511', '5345113121@181.com', '副主任医师', '医术高明', '妇科', 1, 65.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100210, '3d7dd7b26500bd0595573b651d0080fd', '卫若琳', '女', '18211272779', '550881199701203511', 'rwef113121@181.com', '副主任医师', '医术高明', '妇科', 1, 23.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100211, '3d7dd7b26500bd0595573b651d0080fd', '董子轩', '男', '18211272779', '550881199701203511', '113fadf121@181.com', '副主任医师', '医术高明', '妇科', 1, 54.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100212, '3d7dd7b26500bd0595573b651d0080fd', '程思琪', '女', '18211272779', '550881199701203511', 'fad113121@181.com', '副主任医师', '医术高明', '妇科', 1, 65.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100213, 'fa0dbf264c2f14f61e9273fbf2906fc9', '江天佑', '男', '18211272779', '550881199701203511', '1313123@qq.com', '主治医生', '医术高明', '产科', 1, 13.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100214, 'fa0dbf264c2f14f61e9273fbf2906fc9', '顾若曦', '女', '18211272779', '550881199701203511', '1313124@qq.com', '主治医生', '医术高明', '儿科', 1, 14.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100215, 'fa0dbf264c2f14f61e9273fbf2906fc9', '石嘉豪', '男', '18211272779', '550881199701203511', '1313125@qq.com', '主治医生', '医术高明', '儿科', 1, 15.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100216, 'fa0dbf264c2f14f61e9273fbf2906fc9', '白语嫣', '女', '18211272779', '550881199701203511', '1321313@qq.com', '主治医生', '医术高明', '产科', 1, 16.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100217, 'fa0dbf264c2f14f61e9273fbf2906fc9', '叶一鸣', '男', '18211272779', '550881199701203511', '1313127@qq.com', '主治医生', '医术高明', '内分泌科', 1, 17.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100218, 'fa0dbf264c2f14f61e9273fbf2906fc9', '田雨薇', '女', '18211272779', '550881199701203511', '131311123@qq.com', '主治医生', '医术高明', '产科', 1, 13.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100219, 'fa0dbf264c2f14f61e9273fbf2906fc9', '崔明哲', '男', '18211272779', '550881199701203511', '131313224@qq.com', '主治医生', '医术高明', '儿科', 1, 14.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100220, 'fa0dbf264c2f14f61e9273fbf2906fc9', '范欣悦', '女', '18211272779', '550881199701203511', '138811qa123@qq.com', '主治医生', '医术高明', '产科', 1, 13.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100221, 'fa0dbf264c2f14f61e9273fbf2906fc9', '石晨阳', '男', '18211272779', '550881199701203511', '131313hh224@qq.com', '主治医生', '医术高明', '儿科', 1, 14.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100222, 'fa0dbf264c2f14f61e9273fbf2906fc9', '韩雨桐', '女', '18211272779', '550881199701203511', '138811qa123@qq.com', '主治医生', '医术高明', '产科', 1, 13.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100223, '3d7dd7b26500bd0595573b651d0080fd', '卢宇航', '男', '15073171170', '550881199701203511', '3289948684@qq.com', '主任医师', '主任医生', '神经内科', 1, 200.00, 1, 5.00, 5.00);
INSERT INTO `doctor` VALUES (1100224, '3d7dd7b26500bd0595573b651d0080fd', '贺可欣', '女', '15615615611', '123456789012345678', '15615615611@qq.com', '主任医师', '小熊专注提供优质源码，访问地址http://code51.cn', '内分泌科', 1, 10.00, 1, 5.00, 5.00);
INSERT INTO `doctor` VALUES (1100225, 'fa0dbf264c2f14f61e9273fbf2906fc9', '薛子墨', '男', '18211272779', '550881199701203511', '1313123@qq.com', '主治医生', '医术高明', '产科', 1, 13.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100226, 'fa0dbf264c2f14f61e9273fbf2906fc9', '方静怡', '女', '18211272779', '550881199701203511', '1313124@qq.com', '主治医生', '医术高明', '儿科', 1, 14.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100227, 'fa0dbf264c2f14f61e9273fbf2906fc9', '郝宇航', '男', '18211272779', '550881199701203511', '1313125@qq.com', '主治医生', '医术高明', '儿科', 1, 15.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100228, 'fa0dbf264c2f14f61e9273fbf2906fc9', '丁雨婷', '女', '18211272779', '550881199701203511', '1321313@qq.com', '主治医生', '医术高明', '产科', 1, 16.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100229, 'fa0dbf264c2f14f61e9273fbf2906fc9', '白俊杰', '男', '18211272779', '550881199701203511', '1313127@qq.com', '主治医生', '医术高明', '内分泌科', 1, 17.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100230, '3d7dd7b26500bd0595573b651d0080fd', '石梦瑶', '女', '18231311332', '440891381238123', '3123134124@1213.com', '主任医师', '精通医术', '内分泌科', 1, 12.00, 0, 0.00, 4.50);
INSERT INTO `doctor` VALUES (1100231, 'fa0dbf264c2f14f61e9273fbf2906fc9', '黎浩然', '男', '18211272779', '550881199701203511', '138811qa123@qq.com', '主治医生', '医术高明', '产科', 1, 13.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100232, 'fa0dbf264c2f14f61e9273fbf2906fc9', '江心怡', '女', '18211272779', '550881199701203511', '138811qa123@qq.com', '主治医生', '医术高明', '产科', 1, 13.00, 0, 0.00, 5.00);
INSERT INTO `doctor` VALUES (1100233, 'fa0dbf264c2f14f61e9273fbf2906fc9', '卢博文', '男', '18211272779', '550881199701203511', '138811qa123@qq.com', '主治医生', '医术高明', '产科', 1, 13.00, 0, 0.00, 5.00);

-- ----------------------------
-- Table structure for drug
-- ----------------------------
DROP TABLE IF EXISTS `drug`;
CREATE TABLE `drug`  (
  `dr_id` int(11) NOT NULL AUTO_INCREMENT,
  `dr_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dr_price` decimal(10, 2) NULL DEFAULT NULL,
  `dr_number` int(11) NULL DEFAULT NULL,
  `dr_publisher` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dr_unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dr_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of drug
-- ----------------------------
INSERT INTO `drug` VALUES (1, '青霉素', 23.00, 16, '国家医药局', '袋');
INSERT INTO `drug` VALUES (2, '苯唑西林', 11.00, 31, '国家医药局', '盒');
INSERT INTO `drug` VALUES (3, '氨苄西林', 13.00, 48, '国家医药局', '盒');
INSERT INTO `drug` VALUES (4, '哌拉西林', 2.00, 5, '国家医药局', '盒');
INSERT INTO `drug` VALUES (5, '阿莫西林', 13.00, 20, '国家医药局', '盒');
INSERT INTO `drug` VALUES (6, '头孢唑林', 3.00, 32, '国家医药局', '盒');
INSERT INTO `drug` VALUES (7, '头孢氨苄', 4.00, 43, '国家医药局', '盒');
INSERT INTO `drug` VALUES (8, '头孢呋辛', 8.00, 54, '国家医药局', '盒');
INSERT INTO `drug` VALUES (9, '阿米卡星', 5.00, 54, '国家医药局', '袋');
INSERT INTO `drug` VALUES (10, '庆大霉素', 7.00, 64, '国家医药局', '袋');
INSERT INTO `drug` VALUES (11, '红霉素', 6.00, 76, '国家医药局', '袋');
INSERT INTO `drug` VALUES (12, '阿奇霉素', 54.00, 52, '国家医药局', '袋');
INSERT INTO `drug` VALUES (13, '克林霉素', 65.00, 21, '国家医药局', '袋');
INSERT INTO `drug` VALUES (14, '复方磺胺甲噁唑', 76.00, 54, '国家医药局', '袋');
INSERT INTO `drug` VALUES (15, '诺氟沙星', 65.00, 33, '国家医药局', '袋');
INSERT INTO `drug` VALUES (16, '左氧氟沙星', 76.00, 42, '国家医药局', '袋');
INSERT INTO `drug` VALUES (17, '感康', 15.00, 10, '感康集团', '盒');
INSERT INTO `drug` VALUES (18, '感冒药', 21.00, 2, '感冒集团', '袋');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `o_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) NULL DEFAULT NULL,
  `d_id` int(11) NULL DEFAULT NULL,
  `o_record` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `o_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `o_end` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `o_state` int(11) NULL DEFAULT NULL,
  `o_drug` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `o_check` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `o_total_price` decimal(10, 2) NULL DEFAULT NULL,
  `o_price_state` int(11) NULL DEFAULT NULL,
  `o_advice` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`o_id`) USING BTREE,
  INDEX `oTOp`(`p_id`) USING BTREE,
  INDEX `0TOd`(`d_id`) USING BTREE,
  CONSTRAINT `OTOP` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `OTOd` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 211226 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 100001, 1100186, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (2, 100010, 1100002, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元 // 青霉素*23(元)*1 苯唑西林*11(元)*1 氨苄西林*13(元)*1 哌拉西林*2(元)*1 药物总价49元', 'B超*201 CT*435 项目总价636元 // 项目总价0元', 49.00, 0, '');
INSERT INTO `orders` VALUES (3, 100010, 1100032, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (4, 100002, 1100032, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 54.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (5, 100014, 1100032, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2023-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (6, 100014, 1100016, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (7, 100014, 1100015, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (8, 100014, 1100015, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '两侧胸廓对称。气管居中。双肺门不大，位置及密度正常。双肺纹理分布、走行自然，未见增强、紊乱。双肺野清晰，肺实质内未见异常密度阴影。纵隔未见增宽、移位。心脏形态、大小正常。双膈位置、形态正常，膈面光整，双肋膈角锐利。胸膜无增厚及粘连，胸膜腔未见积液、积气。胸壁骨骼及软组织未见异常。初步确诊为甲状腺癌。多喝热水，多运动，定期检查');
INSERT INTO `orders` VALUES (9, 100014, 1100015, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, NULL, '两侧胸廓对称。气管居中。双肺门不大，位置及密度正常。双肺纹理分布、走行自然，未见增强、紊乱。双肺野清晰，肺实质内未见异常密度阴影。纵隔未见增宽、移位。心脏形态、大小正常。双膈位置、形态正常，膈面光整，双肋膈角锐利。胸膜无增厚及粘连，胸膜腔未见积液、积气。胸壁骨骼及软组织未见异常。初步确诊为甲状腺癌。多喝热水，多运动，定期检查');
INSERT INTO `orders` VALUES (11, 100014, 1100015, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (12, 100013, 1100015, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (13, 100013, 1100015, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-07 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (14, 100013, 1100186, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-08 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (15, 100013, 1100186, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-08 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (16, 100012, 1100186, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-08 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (17, 100012, 1100186, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-08 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (18, 100012, 1100186, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2024-09-08 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (19, 100012, 1100186, '感冒流鼻涕', '2024-09-08 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (21, 100012, 1100186, '感冒流鼻涕', '2024-09-08 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (22, 100012, 1100186, '感冒流鼻涕', '2024-09-08 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (23, 100012, 1100186, '感冒流鼻涕', '2024-09-08 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (24, 100016, 1100178, '感冒流鼻涕', '2024-09-09 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (25, 100016, 1100178, '感冒流鼻涕', '2024-09-09 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (26, 100016, 1100178, '感冒流鼻涕', '2024-09-09 08:30-09:30', '2024-09-10 10:38:3', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (27, 100016, 1100178, '感冒流鼻涕', '2024-09-09 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (28, 100016, 1100178, '感冒流鼻涕', '2024-09-09 08:30-09:30', '2023-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (29, 100016, 1100178, '感冒流鼻涕', '2024-09-09 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (30, 100016, 1100178, '   title: {\n        text: \'挂号人们性别比例\',\n        left: \'center\'\n    },', '2024-09-09 08:30-09:30', '2024-09-09 15:37:30', 1, '哌拉西林*2*1 氨苄西林*13*1 药物总价15元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (124923, 100004, 1100223, '身体不好', '2024-09-08 14:30-15:30', '2024-09-08 13:11:54', 1, '青霉素*23(元)*1 氨苄西林*13(元)*1  药物总价36元 ', 'B超*201(元) 肝功能*543(元)  项目总价744元 ', 0.00, 1, NULL);
INSERT INTO `orders` VALUES (128224, 100004, 1100179, NULL, '2024-09-08 08:30-09:30', '2024-09-08 13:11:54', 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO `orders` VALUES (209782, 100010, 1100001, '发烧', '2023-09-13 14:30-15:30', '2023-09-17 15:58:36', 1, '青霉素*23(元)*2 苯唑西林*11(元)*1  药物总价57元 ', 'B超*201(元) CT*435(元)  项目总价636元 ', 0.00, 1, NULL);
INSERT INTO `orders` VALUES (209887, 100010, 1100001, '感冒', '2023-09-13 14:30-15:30', '2023-09-06 8:45:52', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'B超*201 CT*435 项目总价636元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (209918, 100010, 1100002, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2023-09-14 10:30-11:30', '2023-09-14 23:24:46', 1, '青霉素*23(元)*2 苯唑西林*11(元)*1  药物总价57元 青霉素*23(元)*2 苯唑西林*11(元)*1 药物总价57元', 'B超*201(元) CT*435(元)  项目总价636元 项目总价0元', 0.00, 1, '两侧胸廓对称。气管居中。双肺门不大，位置及密度正常。双肺纹理分布、走行自然，未见增强、紊乱。双肺野清晰，肺实质内未见异常密度阴影。纵隔未见增宽、移位。心脏形态、大小正常。双膈位置、形态正常，膈面光整，双肋膈角锐利。胸膜无增厚及粘连，胸膜腔未见积液、积气。胸壁骨骼及软组织未见异常。初步确诊为甲状腺癌。');
INSERT INTO `orders` VALUES (210177, 100012, 1100001, '经常出现容易出汗，脾气暴躁，精神不振，乏力，心慌，手抖，脖子突出，眼睛突出等症状', '2023-09-13 14:30-15:30', '2023-09-10 17:3:56', 1, ' 药物总价0元 青霉素*23(元)*2 苯唑西林*11(元)*2 氨苄西林*13(元)*1 药物总价81元 // 药物总价0元', 'CT*435(元) 项目总价435元 // 项目总价0元', 0.00, 1, '');
INSERT INTO `orders` VALUES (210427, 100010, 1100001, '感冒流鼻涕', '2023-09-13 14:30-15:30', '2023-09-05 20:30:21', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'B超*201 CT*435 项目总价20436元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (210429, 100010, 1100162, '感冒流鼻涕', '2022-09-13 14:30-15:30', '2022-09-10 11:23:23', 1, '青霉素*23*1 苯唑西林*11*1 药物总价34元', 'CT*435(元) 项目总价435元', 0.00, 1, '报告显示并无大碍，建议多喝水');
INSERT INTO `orders` VALUES (211209, 100011, 1100162, '感冒', '2022-09-12 14:30-15:30', '2022-09-26 22:42:40', 1, '青霉素*23(元)*1 苯唑西林*11(元)*1  药物总价34元 ', 'B超*201(元)  项目总价201元 ', 0.00, 1, NULL);
INSERT INTO `orders` VALUES (211210, 100001, 1100179, NULL, '2025-03-10 08:30-09:30', NULL, 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO `orders` VALUES (211211, 100002, 1100001, '流行病毒因其发热炎症，先进行血检', '2025-03-09 14:30-15:30', '2025-03-09 14:42:43', 1, '青霉素*23(元)*1 氨苄西林*13(元)*1  药物总价36元  // 药物总价0元 // 青霉素*23(元)*1 苯唑西林*11(元)*1 药物总价34元', '血常规*434(元)  项目总价434元  // 项目总价0元 // 项目总价0元', 0.00, 1, '');
INSERT INTO `orders` VALUES (211212, 100001, 1100026, '正常感冒', '2025-03-10 16:30-17:30', '2025-03-10 17:28:33', 1, '青霉素*23(元)*1 苯唑西林*11(元)*1  药物总价34元 ', '核磁共振*653(元)  项目总价653元 ', 0.00, 1, NULL);
INSERT INTO `orders` VALUES (211213, 100001, 1100001, '', '2025-03-11 14:30-15:30', '2025-03-11 22:21:30', 1, ' 药物总价0元 ', ' 项目总价0元 ', 0.00, 1, NULL);
INSERT INTO `orders` VALUES (211214, 100001, 1100046, '', '2025-03-12 08:30-09:30', '2025-03-12 13:16:51', 1, '苯唑西林*11(元)*1  药物总价11元 ', ' 项目总价0元 ', 0.00, 1, NULL);
INSERT INTO `orders` VALUES (211215, 100001, 1100046, '', '2025-03-12 14:30-15:30', '2025-03-12 13:17:44', 1, ' 药物总价0元 ', ' 项目总价0元 ', 0.00, 0, NULL);
INSERT INTO `orders` VALUES (211216, 100001, 1100001, '', '2025-03-11 16:30-17:30', '2025-03-11 22:21:33', 1, ' 药物总价0元 ', ' 项目总价0元 ', 0.00, 1, NULL);
INSERT INTO `orders` VALUES (211217, 100002, 1100002, '因为下雨导致路滑引起了泊松定理造成小肠穿孔，进而引起大脑死机', '2025-03-11 16:30-17:30', '2025-03-11 15:8:58', 1, '青霉素*23(元)*1 苯唑西林*11(元)*1 氨苄西林*13(元)*1 哌拉西林*2(元)*1 左氧氟沙星*76(元)*1  药物总价125元  // 药物总价0元', 'CT*435(元) B超*201(元) 甲状腺*434(元) 视力*50(元) 心电图*634(元)  项目总价1754元  // 项目总价0元', 0.00, 1, '记住不闹不哭不打豆豆');
INSERT INTO `orders` VALUES (211218, 100001, 1100003, NULL, '2025-03-13 08:30-09:30', NULL, 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO `orders` VALUES (211219, 100001, 1100001, '', '2025-03-12 14:30-15:30', '2025-03-12 12:45:24', 1, ' 药物总价0元  // 青霉素*23(元)*1 药物总价23元', ' 项目总价0元  // 项目总价0元', 23.00, 0, '好好喝水\n');
INSERT INTO `orders` VALUES (211220, 100001, 1100001, NULL, ' 08:30-09:30     余号 40', NULL, 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO `orders` VALUES (211221, 100001, 1100001, NULL, ' 16:30-17:30     余号 40', NULL, 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO `orders` VALUES (211222, 100001, 1100000, NULL, ' 08:30-09:30     余号 40', NULL, 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO `orders` VALUES (211223, 100001, 1100046, NULL, ' 08:30-09:30     余号 40', NULL, 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO `orders` VALUES (211224, 100001, 1100179, NULL, ' 09:30-10:30     余号 40', NULL, 0, NULL, NULL, NULL, 0, NULL);
INSERT INTO `orders` VALUES (211225, 100001, 1100001, '感冒发烧', '2025-03-12 14:30-15:30', '2025-03-12 13:55:41', 1, '青霉素*23(元)*1  药物总价23元 ', 'CT*435(元)  项目总价435元 ', 0.00, 1, NULL);

-- ----------------------------
-- Table structure for patient
-- ----------------------------
DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient`  (
  `p_id` int(11) NOT NULL,
  `p_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_state` int(11) NULL DEFAULT NULL,
  `p_birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_age` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`p_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of patient
-- ----------------------------
INSERT INTO `patient` VALUES (100001, '3d7dd7b26500bd0595573b651d0080fd', '王亚军', '男', '18211272779', '440881199701203551', '130693116@qq.com', 1, '1997-01-20', 30);
INSERT INTO `patient` VALUES (100002, '3d7dd7b26500bd0595573b651d0080fd', '卡罗维', '男', '18666985547', '358900265987455', '2107163725@qq.com', 1, '2019-02-04', 6);
INSERT INTO `patient` VALUES (100003, '3d7dd7b26500bd0595573b651d0080fd', '邓学', '男', '18211272779', '440881199701203551', '1306931167@qq.com', 1, '1997-01-20', 77);
INSERT INTO `patient` VALUES (100004, '3d7dd7b26500bd0595573b651d0080fd', '黎欧', '女', '15073171170', '550881199701203511', '3289948684@qq.com', 0, '2012-03-06', 13);
INSERT INTO `patient` VALUES (100005, '3d7dd7b26500bd0595573b651d0080fd', '赵空明', '女', '18323131231', '312313123123123', 'hins55@163.com', 1, '1997-01-20', 24);
INSERT INTO `patient` VALUES (100006, '3d7dd7b26500bd0595573b651d0080fd', '陈小鹏', '男', '18231214134', '440881192183193102', '12039120@qq.com', 1, '1950-01-19', 75);
INSERT INTO `patient` VALUES (100007, '3d7dd7b26500bd0595573b651d0080fd', '陈大范', '男', '18127718312', '123123123123123', '131121@qq.com', 1, '1999-03-14', 26);
INSERT INTO `patient` VALUES (100008, '3d7dd7b26500bd0595573b651d0080fd', '刘晓倩', '女', '18273172121', '123123123123112', '12312312@qq.com', 1, '1998-02-18', 27);
INSERT INTO `patient` VALUES (100009, '0233515d88b1ffd5da10ea673f498096', '莜宝芙', '女', '15615615611', '123456789012345678', '15615615611@qq.com', 1, '2020-10-08', 5);
INSERT INTO `patient` VALUES (100010, '3d7dd7b26500bd0595573b651d0080fd', '萧峰', '男', '18211272779', '440881199701203551', 'hins555ph@163.com', 0, '1997-01-20', 29);
INSERT INTO `patient` VALUES (100011, '3d7dd7b26500bd0595573b651d0080fd', '刘北望', '女', '11213917127', '440881199701203551', '1306931161@qq.com', 1, '1997-01-20', 29);
INSERT INTO `patient` VALUES (100012, '3d7dd7b26500bd0595573b651d0080fd', '刘倩薇', '女', '18211272779', '440881199701203551', '1306931162@qq.com', 1, '1997-01-20', 29);
INSERT INTO `patient` VALUES (100013, '3d7dd7b26500bd0595573b651d0080fd', '刘晓庆', '女', '18211272779', '440881199701203551', '1306931163@qq.com', 1, '1997-01-20', 25);
INSERT INTO `patient` VALUES (100014, '3d7dd7b26500bd0595573b651d0080fd', '刘海', '女', '18211272779', '440881199701203551', '1306931164@qq.com', 1, '1997-01-20', 29);
INSERT INTO `patient` VALUES (100015, '3d7dd7b26500bd0595573b651d0080fd', '张粗', '男', '18211272779', '440881199701203551', '306931167@qq.com', 1, '1997-01-20', 29);
INSERT INTO `patient` VALUES (100016, '3d7dd7b26500bd0595573b651d0080fd', '张艳', '男', '18211272779', '440881199701203551', '130693167@qq.com', 0, '1997-01-20', 29);
INSERT INTO `patient` VALUES (100017, '3d7dd7b26500bd0595573b651d0080fd', '周杰', '男', '18211272779', '440881199701203551', '306931167@qq.com', 1, '1997-01-20', 25);
INSERT INTO `patient` VALUES (100018, '3d7dd7b26500bd0595573b651d0080fd', '周洁', '女', '18211272779', '440881199701203551', '130693167@qq.com', 0, '1997-01-20', 54);
INSERT INTO `patient` VALUES (100019, '3d7dd7b26500bd0595573b651d0080fd', '周鹏', '男', '18211272779', '440881199701203551', '06931167@qq.com', 1, '1997-01-20', 55);
INSERT INTO `patient` VALUES (100021, '3d7dd7b26500bd0595573b651d0080fd', '张旭', '男', '18666985567', '550881199701203147', '2107163729@qq.com', 1, '1997-01-20', 1);
INSERT INTO `patient` VALUES (100056, 'b6add5a4e3ce78f478e76a0cdb330dc6', '黄俊才', '男', '13713182332', '121231241243413443', '123ascqwe@123.com', 0, '2023-09-17', 2);

SET FOREIGN_KEY_CHECKS = 1;
