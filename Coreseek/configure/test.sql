/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : sphinx

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2014-07-01 07:19:42
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `posts`
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  KEY `title` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

INSERT INTO `posts` VALUES ('1', '我不想让你一个人', '我不想让你一个人孤单,来自心底的呐喊！');
INSERT INTO `posts` VALUES ('2', '昨日再现', '当我还是小孩子，田野上开满了野菊花');
INSERT INTO `posts` VALUES ('3', '菊与刀', '这就是小日本的文化,打倒小日本.');
INSERT INTO `posts` VALUES ('4', '明月清风', '当时明月在，曾照彩云归。也无风雨也无晴！');
INSERT INTO `posts` VALUES ('5', '爱要怎么说出口', '如题，爱要怎么说出口，说不出口，也得说出口');
INSERT INTO `posts` VALUES ('6', '无所谓', '我送你来到《非诚勿扰》，这个年代，是男是女都已不再重要');
INSERT INTO `posts` VALUES ('7', '轻轻的我走了', '好美的诗：轻轻的我走了，正如我轻轻的来，我挥一挥衣袖，不带走一片云彩.');
INSERT INTO `posts` VALUES ('8', '广告时间 ', '我们要去远方看看，看下还有什么是我们的，期密达 ');
INSERT INTO `posts` VALUES ('9', '万万没想到', '我的生涯一片无悔，我想起那天下午在夕阳下的奔跑，那是我逝去的青春。');
INSERT INTO `posts` VALUES ('10', '美丽国度', '儿时的上学路线，结婚时放鞭炮的巷口');
INSERT INTO `posts` VALUES ('11', '白日依山近', '世界杯的冠军，我看好何兰队。巴西队没戏，阿根廷也有点悬。德国队整体不错，可以是亚军');

-- ----------------------------
-- Table structure for `sphinx_counter`
-- ----------------------------
DROP TABLE IF EXISTS `sphinx_counter`;
CREATE TABLE `sphinx_counter` (
  `counter_id` int(9) NOT NULL,
  `post_id` int(9) NOT NULL,
  PRIMARY KEY (`counter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sphinx_counter` VALUES ('1', '1');
