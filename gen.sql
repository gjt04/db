
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `username` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('root', '123456');
INSERT INTO `admin` VALUES ('wangwei', '123123');

-- ----------------------------
-- Table structure for research
-- ----------------------------
DROP TABLE IF EXISTS `research`;
CREATE TABLE `research`  (
  `tea_no` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `research_dir` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `research_sit` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `patent` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `paper_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `paper_level` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tea_no`, `research_dir`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of research
-- ----------------------------
INSERT INTO `research` VALUES ('212002', '2', '2', '论文', '大数据计算', 'sci');
INSERT INTO `research` VALUES ('212983', '2', '2', '论文', '数据安全', 'sci');

-- ----------------------------
-- Table structure for teacher_basic
-- ----------------------------
DROP TABLE IF EXISTS `teacher_basic`;
CREATE TABLE `teacher_basic`  (
  `tea_no` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tea_name` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `sex` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `degree` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `dept` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `graduate_sch` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `health` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `title` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `duty` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `award_or_punish` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tea_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher_basic
-- ----------------------------
INSERT INTO `teacher_basic` VALUES ('212001', '黄申为', '男', '博士', '网络空间安全学院', '南开大学', '良好', '讲师', '授课', '青年学者');
INSERT INTO `teacher_basic` VALUES ('212002', '贾岩', '男', '博士', '计算机学院', '南开大学', '良好', '教授', '授课', '青年学者');
INSERT INTO `teacher_basic` VALUES ('212983', '杨征路', '男', '博士后', '网络空间安全学院', '南开大学', '良好', '教授', '授课', '长江学者');
INSERT INTO `teacher_basic` VALUES ('212657', '李翔', '男', '博士', '药学院', '南开大学', '良好', '讲师', '授课', '青年学者');
INSERT INTO `teacher_basic` VALUES ('212653', '唐磊', '女', '博士', '外语学院', '南开大学', '良好', '副教授', '授课', '学者');
-- ----------------------------
-- Table structure for teaching
-- ----------------------------
DROP TABLE IF EXISTS `teaching`;
CREATE TABLE `teaching`  (
  `tea_no` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tea_name` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `cour_no` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `cour_name` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cour_hour` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `credit` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cour_type` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tea_no`, `cour_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teaching
-- ----------------------------
INSERT INTO `teaching` VALUES ('212001', '黄申为', '2024131', '计算理论', '42', '4', '专业必修');
INSERT INTO `teaching` VALUES ('212653', '唐磊', '2024002', '思辨能力与英语表达', '30', '1', '专业选修');
INSERT INTO `teaching` VALUES ('1710117', '刘哲理', '2026301', '数据安全', '50', '2.5', '专业必修课');

-- ----------------------------
-- View structure for searchview
-- ----------------------------
DROP VIEW IF EXISTS `searchview`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `searchview` AS select `teacher_basic`.`dept` AS `dept`,`teaching`.`cour_no` AS `cour_no`,`research`.`research_dir` AS `research_dir` from ((`teacher_basic` join `teaching` on((`teacher_basic`.`tea_no` = `teaching`.`tea_no`))) join `research` on((`teacher_basic`.`tea_no` = `research`.`tea_no`)));

-- ----------------------------
-- Procedure structure for teacherupdate
-- ----------------------------
DROP PROCEDURE IF EXISTS `teacherupdate`;
delimiter ;;
CREATE PROCEDURE `teacherupdate`(in `tea_no2` varchar(15),in `tea_name2` varchar(5),in `sex2` varchar(1),in `degree2`varchar(5),in `dept2`varchar(10),in `graduate_sch2`varchar (10) ,in `health2`varchar(3),in `title2`varchar(5),in `duty2`varchar(10),in `award_or_punish2` varchar(20))
IF tea_no2 NOT IN (SELECT tea_no FROM teacher_basic)
THEN signal sqlstate '22003' set message_text='更新信息不在教职工基本信息表中，更新失败！';
ELSE
UPDATE `teacher_basic` SET `tea_name`=tea_name2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
UPDATE `teacher_basic` SET `sex`=sex2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
UPDATE `teacher_basic` SET `degree`=degree2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
UPDATE `teacher_basic` SET `dept`=dept2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
UPDATE `teacher_basic` SET `graduate_sch`=graduate_sch2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
UPDATE `teacher_basic` SET `health`=health2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
UPDATE `teacher_basic` SET `title`=title2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
UPDATE `teacher_basic` SET `duty`=duty2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
UPDATE `teacher_basic` SET `award_or_punish`=award_or_punish2 WHERE `tea_no`=tea_no2  IN (SELECT tea_no FROM publish WHERE tea_no=tea_no2);
END IF
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table research
-- ----------------------------
DROP TRIGGER IF EXISTS `CUR`;
delimiter ;;
CREATE TRIGGER `CUR` BEFORE INSERT ON `research` FOR EACH ROW begin
if new.tea_no not in (select tea_no from teacher_basic) then
insert into teacher_basic values(null);
end if;
end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table teaching
-- ----------------------------
DROP TRIGGER IF EXISTS `CUR_NO`;
delimiter ;;
CREATE TRIGGER `CUR_NO` BEFORE INSERT ON `teaching` FOR EACH ROW begin
if new.tea_no not in (select tea_no from teacher_basic) then
insert into teacher_basic values(null);
end if;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
