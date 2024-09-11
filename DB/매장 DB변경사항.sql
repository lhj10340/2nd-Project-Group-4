ALTER TABLE `matjip`.`restaurant` 
ADD COLUMN `re_zip` INT(11) NULL DEFAULT 0 AFTER `re_tag`,
ADD COLUMN `re_addr2` VARCHAR(255) NULL DEFAULT NULL AFTER `re_zip`,
CHANGE COLUMN `re_address` `re_address` VARCHAR(255) NULL DEFAULT NULL ;


ALTER TABLE `matjip`.`restaurant` 
CHANGE COLUMN `re_zip` `re_zip` INT NULL DEFAULT '0' AFTER `re_y`,
CHANGE COLUMN `re_addr2` `re_address2` VARCHAR(255) NULL DEFAULT NULL AFTER `re_address`;
