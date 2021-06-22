-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema hotel_quickly
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hotel_quickly
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hotel_quickly` DEFAULT CHARACTER SET utf8 ;
USE `hotel_quickly` ;

-- -----------------------------------------------------
-- Table `hotel_quickly`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel_quickly`.`user` ;

CREATE TABLE IF NOT EXISTS `hotel_quickly`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_quickly`.`ref_currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel_quickly`.`ref_currency` ;

CREATE TABLE IF NOT EXISTS `hotel_quickly`.`ref_currency` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_quickly`.`ref_order_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel_quickly`.`ref_order_status` ;

CREATE TABLE IF NOT EXISTS `hotel_quickly`.`ref_order_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_quickly`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel_quickly`.`order` ;

CREATE TABLE IF NOT EXISTS `hotel_quickly`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `ref_currency_id` INT NOT NULL,
  `ref_order_status_id` INT NOT NULL,
  `selling_price` DECIMAL(10,2) NULL,
  `booking_dt` DATETIME NULL,
  `pos` VARCHAR(45) NULL,
  `reference_code` VARCHAR(10) NULL,
  PRIMARY KEY (`id`),
  INDEX `order_pos_idx` (`pos` ASC) INVISIBLE,
  INDEX `order_reference_code` (`reference_code` ASC) INVISIBLE,
  INDEX `fk_order_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_order_ref_currency_idx` (`ref_currency_id` ASC) VISIBLE,
  INDEX `fk_order_ref_order_status_idx` (`ref_order_status_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `hotel_quickly`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_ref_currency`
    FOREIGN KEY (`ref_currency_id`)
    REFERENCES `hotel_quickly`.`ref_currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_ref_order_status`
    FOREIGN KEY (`ref_order_status_id`)
    REFERENCES `hotel_quickly`.`ref_order_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotel_quickly`.`fx_rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotel_quickly`.`fx_rate` ;

CREATE TABLE IF NOT EXISTS `hotel_quickly`.`fx_rate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `rate` DECIMAL(10,5) NULL,
  `primary_ref_currency_id` INT NOT NULL,
  `secondary_ref_currency_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ak_fx_rate` (`rate` ASC) INVISIBLE,
  INDEX `fk_fx_rate_ref_currency1_idx` (`primary_ref_currency_id` ASC) VISIBLE,
  INDEX `fk_fx_rate_ref_currency2_idx` (`secondary_ref_currency_id` ASC) VISIBLE,
  CONSTRAINT `fk_fx_rate_ref_currency1`
    FOREIGN KEY (`primary_ref_currency_id`)
    REFERENCES `hotel_quickly`.`ref_currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fx_rate_ref_currency2`
    FOREIGN KEY (`secondary_ref_currency_id`)
    REFERENCES `hotel_quickly`.`ref_currency` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `hotel_quickly`.`ref_currency`
-- -----------------------------------------------------
START TRANSACTION;
USE `hotel_quickly`;
INSERT INTO `hotel_quickly`.`ref_currency` (`id`, `code`, `name`) VALUES (-1, 'N/A', 'N/A');
INSERT INTO `hotel_quickly`.`ref_currency` (`id`, `code`, `name`) VALUES (1, 'USD', 'United States Dollar');
INSERT INTO `hotel_quickly`.`ref_currency` (`id`, `code`, `name`) VALUES (2, 'EUR', 'Euro');

COMMIT;

