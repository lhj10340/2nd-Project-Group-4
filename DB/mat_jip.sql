drop database if exists matjip;

create database if not exists matjip;

use matjip;


DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
	`us_id`	varchar(20) primary key	NOT NULL,
	`us_pw`	varchar(255)	NULL,
	`us_auth`	int	NULL,
	`us_name`	varchar(20)	NULL,
	`us_gender`	varchar(6)	NULL,
	`us_hbd`	date	NULL,
	`us_phone`	varchar(15)	NULL,
	`us_email`	varchar(30)	NULL,
	`us_failed`	int	NULL,
	`us_cookie`	varchar(255)	NULL,
	`us_limit`	datetime	NULL,
	`us_report`	int	NULL,
	`us_stop`	datetime	NULL,
	`us_icon`	longtext	NULL,
	`us_say`	varchar(150)	NULL
);

DROP TABLE IF EXISTS `restaurant`;

CREATE TABLE `restaurant` (
	`re_id`	int auto_increment primary key	NOT NULL,
	`re_us_id`	varchar(20)	NOT NULL,
	`re_name`	varchar(50)	NULL,
	`re_x`	varchar(30)	NULL,
	`re_y`	varchar(30)	NULL,
	`re_address`	varchar(50)	NULL,
	`re_phone`	varchar(15)	NULL,
	`re_state`	varchar(15)	NULL,
	`re_time`	datetime	NULL,
	`re_day`	text	NULL,
	`re_score`	int	NULL,
	`re_update`	datetime	NULL,
	`re_category`	varchar(30)	NULL,
	`re_views`	int	NULL,
	`re_content`	longtext	NULL,
	`re_tag`	text	NULL
);

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
	`rv_id`	int auto_increment primary key	NOT NULL,
	`rv_re_id`	int	NOT NULL,
	`rv_us_id`	varchar(20)	NOT NULL,
	`rv_title`	varchar(50)	NULL,
	`rv_score`	int	NULL,
	`rv_content`	longtext	NULL,
	`rv_tf`	varchar(5)	NULL,
	`rv_thumb`	longtext	NULL
);

DROP TABLE IF EXISTS `receipt`;

CREATE TABLE `receipt` (
	`rc_id`	int auto_increment primary key	NOT NULL,
	`rv_id2`	int	NOT NULL,
	`rc_date`	datetime	NULL,
	`rc_total`	int	NULL
);

DROP TABLE IF EXISTS `buy`;

CREATE TABLE `buy` (
	`bu_id`	int auto_increment primary key	NOT NULL,
	`bu_me_id`	int	NOT NULL,
	`bu_count`	int	NULL,
	`bu_rc_id`	int	NOT NULL,
	`rv_id2`	int	NOT NULL
);

DROP TABLE IF EXISTS `file`;

CREATE TABLE `file` (
	`fi_id`	varchar(255) primary key	NOT NULL,
	`fi_path`	varchar(255)	NULL,
	`fi_ori_id`	varchar(255)	NULL,
	`fi_re_id`	int	NOT NULL,
	`fi_rv_id`	int	NOT NULL,
	`me_id`	int	NOT NULL
);

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
	`me_id`	int auto_increment primary key	NOT NULL,
	`me_re_id`	int	NOT NULL,
	`me_title`	varchar(30)	NULL,
	`me_price`	int	NULL,
	`me_thumb`	longtext	NULL
);

DROP TABLE IF EXISTS `certification`;

CREATE TABLE `certification` (
	`ce_us_id`	varchar(20) primary key	NOT NULL,
	`ce_code`	varchar(6)	NULL,
	`ce_time`	datetime	NULL
);

DROP TABLE IF EXISTS `reservation`;

CREATE TABLE `reservation` (
	`ro_id`	int auto_increment primary key	NOT NULL,
	`ro_re_id`	int	NOT NULL,
	`ro_us_id`	varchar(20)	NOT NULL,
	`ro_time`	datetime	NULL,
	`ro_pp`	int	NULL
);

ALTER TABLE `restaurant` ADD CONSTRAINT `FK_user_TO_restaurant_1` FOREIGN KEY (
	`re_us_id`
)
REFERENCES `user` (
	`us_id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_restaurant_TO_review_1` FOREIGN KEY (
	`rv_re_id`
)
REFERENCES `restaurant` (
	`re_id`
);

ALTER TABLE `review` ADD CONSTRAINT `FK_user_TO_review_1` FOREIGN KEY (
	`rv_us_id`
)
REFERENCES `user` (
	`us_id`
);

ALTER TABLE `receipt` ADD CONSTRAINT `FK_review_TO_receipt_1` FOREIGN KEY (
	`rv_id2`
)
REFERENCES `review` (
	`rv_id`
);

ALTER TABLE `buy` ADD CONSTRAINT `FK_menu_TO_buy_1` FOREIGN KEY (
	`bu_me_id`
)
REFERENCES `menu` (
	`me_id`
);

ALTER TABLE `buy` ADD CONSTRAINT `FK_receipt_TO_buy_1` FOREIGN KEY (
	`bu_rc_id`
)
REFERENCES `receipt` (
	`rc_id`
);

ALTER TABLE `buy` ADD CONSTRAINT `FK_receipt_TO_buy_2` FOREIGN KEY (
	`rv_id2`
)
REFERENCES `receipt` (
	`rv_id2`
);

ALTER TABLE `file` ADD CONSTRAINT `FK_restaurant_TO_file_1` FOREIGN KEY (
	`fi_re_id`
)
REFERENCES `restaurant` (
	`re_id`
);

ALTER TABLE `file` ADD CONSTRAINT `FK_review_TO_file_1` FOREIGN KEY (
	`fi_rv_id`
)
REFERENCES `review` (
	`rv_id`
);

ALTER TABLE `file` ADD CONSTRAINT `FK_menu_TO_file_1` FOREIGN KEY (
	`me_id`
)
REFERENCES `menu` (
	`me_id`
);

ALTER TABLE `menu` ADD CONSTRAINT `FK_restaurant_TO_menu_1` FOREIGN KEY (
	`me_re_id`
)
REFERENCES `restaurant` (
	`re_id`
);

ALTER TABLE `certification` ADD CONSTRAINT `FK_user_TO_certification_1` FOREIGN KEY (
	`ce_us_id`
)
REFERENCES `user` (
	`us_id`
);

ALTER TABLE `reservation` ADD CONSTRAINT `FK_restaurant_TO_reservation_1` FOREIGN KEY (
	`ro_re_id`
)
REFERENCES `restaurant` (
	`re_id`
);

ALTER TABLE `reservation` ADD CONSTRAINT `FK_user_TO_reservation_1` FOREIGN KEY (
	`ro_us_id`
)
REFERENCES `user` (
	`us_id`
);


ALTER TABLE `matjip`.`restaurant` 
ADD COLUMN `re_zip` INT(11) NULL DEFAULT 0 AFTER `re_tag`,
ADD COLUMN `re_addr2` VARCHAR(255) NULL DEFAULT NULL AFTER `re_zip`,
CHANGE COLUMN `re_address` `re_address` VARCHAR(255) NULL DEFAULT NULL ;


ALTER TABLE `matjip`.`restaurant` 
CHANGE COLUMN `re_zip` `re_zip` INT NULL DEFAULT '0' AFTER `re_y`,
CHANGE COLUMN `re_addr2` `re_address2` VARCHAR(255) NULL DEFAULT NULL AFTER `re_address`;
