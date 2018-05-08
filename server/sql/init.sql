-- MySQL Script generated by MySQL Workbench
-- Tue May  8 17:07:31 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tobee
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tobee
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tobee` DEFAULT CHARACTER SET utf8 ;
USE `tobee` ;

-- -----------------------------------------------------
-- Table `tobee`.`provinces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`provinces` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`cities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `province_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_cities_province_id_idx` (`province_id` ASC),
  CONSTRAINT `fk_cities_province_id`
    FOREIGN KEY (`province_id`)
    REFERENCES `tobee`.`provinces` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(20) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `nickname` VARCHAR(20) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `avatar_url` VARCHAR(50) NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `city_id` INT NOT NULL,
  `vip` INT NOT NULL,
  `camera` VARCHAR(50) NULL,
  `description` VARCHAR(200) NULL,
  `college` VARCHAR(50) NOT NULL,
  `college_district` VARCHAR(20) NOT NULL,
  `enroll_time` INT NULL,
  `institute` VARCHAR(50) NULL,
  `astrology` VARCHAR(10) NULL,
  `qq` VARCHAR(10) NULL,
  `background_url` VARCHAR(50) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_users_city_id_idx` (`city_id` ASC),
  CONSTRAINT `fk_users_city_id`
    FOREIGN KEY (`city_id`)
    REFERENCES `tobee`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `tobee`.`organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`organizations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `college` VARCHAR(20) NOT NULL,
  `college_district` VARCHAR(20) NOT NULL,
  `logo_url` VARCHAR(50) NULL,
  `description` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`photos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(50) NOT NULL,
  `took_time` DATETIME NOT NULL,
  `took_location` VARCHAR(50) NOT NULL,
  `release_time` DATETIME NULL,
  `category` VARCHAR(20) NOT NULL,
  `likes` INT NOT NULL,
  `reject_reason` VARCHAR(200) NULL,
  `user_id` INT NOT NULL,
  `organization_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `photographer_id_idx` (`user_id` ASC),
  INDEX `fk_photos_organization_id_idx` (`organization_id` ASC),
  CONSTRAINT `fk_photos_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_photos_organization_id`
    FOREIGN KEY (`organization_id`)
    REFERENCES `tobee`.`organizations` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`organization_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`organization_departments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `organization_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `organization_id_idx` (`organization_id` ASC),
  CONSTRAINT `fk_organization_departments_organization_id`
    FOREIGN KEY (`organization_id`)
    REFERENCES `tobee`.`organizations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`activities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `short_name` VARCHAR(20) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `category` VARCHAR(10) NOT NULL,
  `poster_url` VARCHAR(50) NULL,
  `logo_url` VARCHAR(50) NULL,
  `wechat_url` VARCHAR(50) NULL,
  `live_url` VARCHAR(50) NULL,
  `sports_medals` VARCHAR(50) NULL,
  `public_service_hours` VARCHAR(50) NULL,
  `prize` VARCHAR(100) NULL,
  `range` VARCHAR(45) NULL,
  `type` VARCHAR(45) NULL,
  `other_prize` VARCHAR(100) NULL,
  `organization_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `organization_id_idx` (`organization_id` ASC),
  CONSTRAINT `fk_activities_organization_id`
    FOREIGN KEY (`organization_id`)
    REFERENCES `tobee`.`organizations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`activity_stages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`activity_stages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `stage_num` INT NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `location` VARCHAR(50) NOT NULL,
  `content` VARCHAR(400) NOT NULL,
  `wechat_url` VARCHAR(50) NULL,
  `activity_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `activity_id_idx` (`activity_id` ASC),
  CONSTRAINT `fk_activity_stages_activity_id`
    FOREIGN KEY (`activity_id`)
    REFERENCES `tobee`.`activities` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = '社团活动阶段';


-- -----------------------------------------------------
-- Table `tobee`.`photo_lives`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`photo_lives` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `expect_members` INT NOT NULL,
  `ad_progress` VARCHAR(200) NOT NULL,
  `activity_stage_id` INT NULL,
  `manager_id` INT NULL,
  `photographer_manager_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `activity_stage_id_idx` (`activity_stage_id` ASC),
  INDEX `manager_id_idx` (`manager_id` ASC),
  INDEX `photographer_manager_id_idx` (`photographer_manager_id` ASC),
  CONSTRAINT `activity_stage_id_1`
    FOREIGN KEY (`activity_stage_id`)
    REFERENCES `tobee`.`activity_stages` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `manager_id_1`
    FOREIGN KEY (`manager_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `photographer_manager_id_1`
    FOREIGN KEY (`photographer_manager_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`administrators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`administrators` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `level` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`users_follow_organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`users_follow_organizations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `organization_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `organization_id_idx` (`organization_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `fk_users_focus_organizations_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_focus_organizations_organization_id`
    FOREIGN KEY (`organization_id`)
    REFERENCES `tobee`.`organizations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`users_follow_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`users_follow_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `followed_user_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `liked_user_id_idx` (`followed_user_id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  CONSTRAINT `fk_users_focus_users_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_focus_users_focused_user_id`
    FOREIGN KEY (`followed_user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`users_follow_activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`users_follow_activities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `activity_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `user_id_idx` (`user_id` ASC),
  INDEX `activity_id_idx` (`activity_id` ASC),
  CONSTRAINT `fk_users_focus_activities_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_focus_activities_activity_id`
    FOREIGN KEY (`activity_id`)
    REFERENCES `tobee`.`activities` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`users_participate_organizations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`users_participate_organizations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `organization_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `privilege` INT NOT NULL,
  `appling` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `organization_id_idx` (`organization_id` ASC),
  INDEX `contact_id_idx` (`user_id` ASC),
  CONSTRAINT `fk_users_participate_organizations_organization_id`
    FOREIGN KEY (`organization_id`)
    REFERENCES `tobee`.`organizations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_participate_organizations_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`photo_lives_supervisors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`photo_lives_supervisors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `photo_live_id` INT NOT NULL,
  `supervisor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `photo_live_id_idx` (`photo_live_id` ASC),
  INDEX `supervisor_id_idx` (`supervisor_id` ASC),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `photo_live_id_1`
    FOREIGN KEY (`photo_live_id`)
    REFERENCES `tobee`.`photo_lives` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `supervisor_id_1`
    FOREIGN KEY (`supervisor_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`users_sign_activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`users_sign_activities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `activity_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_users_sign_activities_user_id_idx` (`user_id` ASC),
  INDEX `fk_users_sign_activities_activity_id_idx` (`activity_id` ASC),
  CONSTRAINT `fk_users_sign_activities_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_sign_activities_activity_id`
    FOREIGN KEY (`activity_id`)
    REFERENCES `tobee`.`activities` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`moments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`moments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `organization_id` INT NULL,
  `timestamp` DATETIME NOT NULL,
  `content` VARCHAR(400) NOT NULL,
  `photo_1_id` INT NOT NULL,
  `photo_2_id` INT NULL,
  `photo_3_id` INT NULL,
  `photo_4_id` INT NULL,
  `photo_5_id` INT NULL,
  `photo_6_id` INT NULL,
  `photo_7_id` INT NULL,
  `photo_8_id` INT NULL,
  `photo_9_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_moments_user_id_idx` (`user_id` ASC),
  INDEX `fk_moments_organization_id_idx` (`organization_id` ASC),
  INDEX `fk_moments_photo_1_id_idx` (`photo_1_id` ASC),
  INDEX `fk_moments_photo_2_id_idx` (`photo_2_id` ASC),
  INDEX `fk_moments_photo_3_id_idx` (`photo_3_id` ASC),
  INDEX `fk_moments_photo_4_id_idx` (`photo_4_id` ASC),
  INDEX `fk_moments_photo_5_id_idx` (`photo_5_id` ASC),
  INDEX `fk_moments_photo_6_id_idx` (`photo_6_id` ASC),
  INDEX `fk_moments_photo_7_id_idx` (`photo_7_id` ASC),
  INDEX `fk_moments_photo_8_id_idx` (`photo_8_id` ASC),
  INDEX `fk_moments_photo_9_id_idx` (`photo_9_id` ASC),
  CONSTRAINT `fk_moments_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_organization_id`
    FOREIGN KEY (`organization_id`)
    REFERENCES `tobee`.`organizations` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_1_id`
    FOREIGN KEY (`photo_1_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_2_id`
    FOREIGN KEY (`photo_2_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_3_id`
    FOREIGN KEY (`photo_3_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_4_id`
    FOREIGN KEY (`photo_4_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_5_id`
    FOREIGN KEY (`photo_5_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_6_id`
    FOREIGN KEY (`photo_6_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_7_id`
    FOREIGN KEY (`photo_7_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_8_id`
    FOREIGN KEY (`photo_8_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moments_photo_9_id`
    FOREIGN KEY (`photo_9_id`)
    REFERENCES `tobee`.`photos` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`moment_comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`moment_comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `moment_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `content` VARCHAR(200) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_moment_comments_moment_id_idx` (`moment_id` ASC),
  INDEX `fk_moment_comments_user_id_idx` (`user_id` ASC),
  CONSTRAINT `fk_moment_comments_moment_id`
    FOREIGN KEY (`moment_id`)
    REFERENCES `tobee`.`moments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_moment_comments_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`users_like_moments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`users_like_moments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `moment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_users_like_moments_user_id_idx` (`user_id` ASC),
  INDEX `fk_users_like_moments_moment_id_idx` (`moment_id` ASC),
  CONSTRAINT `fk_users_like_moments_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `tobee`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_users_like_moments_moment_id`
    FOREIGN KEY (`moment_id`)
    REFERENCES `tobee`.`moments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`organization_honors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`organization_honors` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `honor` VARCHAR(50) NOT NULL,
  `organization_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_organization_honors_organization_id_idx` (`organization_id` ASC),
  CONSTRAINT `fk_organization_honors_organization_id`
    FOREIGN KEY (`organization_id`)
    REFERENCES `tobee`.`organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`messages` (
  `id` INT NOT NULL,
  `sender` VARCHAR(45) NOT NULL,
  `receiver` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NULL,
  `content` VARCHAR(200) NULL,
  `sendtime` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobee`.`organization_albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tobee`.`organization_albums` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL DEFAULT '默认相册',
  `photos_id` VARCHAR(200) NULL,
  `organizations_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_organization_albums_organizations1_idx` (`organizations_id` ASC),
  CONSTRAINT `fk_organization_albums_organizations1`
    FOREIGN KEY (`organizations_id`)
    REFERENCES `tobee`.`organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
