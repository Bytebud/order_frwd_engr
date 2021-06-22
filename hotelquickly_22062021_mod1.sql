-- MySQL Workbench Synchronization
-- Generated: 2021-06-22 22:45
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Sravan Kumar

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `hotel_quickly`.`order` 
DROP FOREIGN KEY `fk_order_ref_currency`,
DROP FOREIGN KEY `fk_order_ref_order_status`;

ALTER TABLE `hotel_quickly`.`fx_rate` 
DROP FOREIGN KEY `fk_fx_rate_ref_currency1`,
DROP FOREIGN KEY `fk_fx_rate_ref_currency2`;

ALTER TABLE `hotel_quickly`.`ref_currency` 
ADD COLUMN `description` VARCHAR(300) NULL DEFAULT NULL AFTER `name`;

ALTER TABLE `hotel_quickly`.`ref_order_status` 
ADD COLUMN `description` VARCHAR(300) NULL DEFAULT NULL AFTER `name`;

ALTER TABLE `hotel_quickly`.`order` 
DROP FOREIGN KEY `fk_order_user`;

ALTER TABLE `hotel_quickly`.`order` ADD CONSTRAINT `fk_order_user`
  FOREIGN KEY (`user_id`)
  REFERENCES `hotel_quickly`.`user` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_order_ref_currency`
  FOREIGN KEY (`ref_currency_id`)
  REFERENCES `hotel_quickly`.`ref_currency` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_order_ref_order_status`
  FOREIGN KEY (`ref_order_status_id`)
  REFERENCES `hotel_quickly`.`ref_order_status` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `hotel_quickly`.`fx_rate` 
ADD CONSTRAINT `fk_fx_rate_ref_currency1`
  FOREIGN KEY (`primary_ref_currency_id`)
  REFERENCES `hotel_quickly`.`ref_currency` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_fx_rate_ref_currency2`
  FOREIGN KEY (`secondary_ref_currency_id`)
  REFERENCES `hotel_quickly`.`ref_currency` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
